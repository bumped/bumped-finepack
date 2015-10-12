'use strict'

fs           = require 'fs'
os           = require 'os'
Logger       = require 'acho'
async        = require 'async'
readPkg      = require 'read-pkg'
finepack     = require 'finepack'
objectAssign = require 'object-assign'

defaultOptions =
  lint     : true
  validate : true

readFile = (filename, cb) -> fs.readFile filename, encoding:'utf8', cb
saveFile = (filename, data, cb) ->
  stringify = (data) -> JSON.stringify(data, null, 2) + os.EOL
  fs.writeFile filename, stringify(data), encoding:'utf8', cb


module.exports = (bumped, plugin, cb) ->
  options = objectAssign defaultOptions, plugin.options

  async.eachSeries bumped.config.rc.files, (file, next) ->
    readFile file, (err, pkg) ->
      return cb err if err

      finepack pkg, options, (err, newPkg, messages) ->
        return cb err if err

        logger = new Logger
          color: bumped.logger.color
          types: bumped.logger.types
          messages: messages
          outputType: (type, filename) -> "#{type} (#{filename})\t: "
          print: (filename) ->
            for type of @types when type is ('warn' or 'error')
              @transport @generateMessage(type, filename, message) for message in @messages[type]
          generateMessage: (type, filename, message) ->
            return unless @isPrintable type
            colorType   = @types[type].color
            messageType = @outputType type, filename
            messageType = @colorize colorType, messageType
            message     = @outputMessage message
            message     = @colorize @types.line.color, message
            messageType + message

        logger.print file

        if logger.messages.error.length isnt 0
          next "An error founded linting your files. Fix it before continue."
        else
          saveFile file, newPkg, next
  , cb
