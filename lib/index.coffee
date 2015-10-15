'use strict'

fs           = require 'fs'
os           = require 'os'
async        = require 'async'
finepack     = require 'finepack'
JSON         = require 'json-future'
objectAssign = require 'object-assign'

defaultOptions =
  lint     : true
  validate : true

printMessage = (logger, filename, type, messages) ->
  logger.transport logger.generateMessage type, "#{filename}: #{message}" for message in messages

module.exports = (bumped, plugin, cb) ->

  options = objectAssign defaultOptions, plugin.options
  globalError = false
  globalMessage = undefined
  globalMessageType = undefined

  async.eachSeries bumped.config.rc.files, (filename, next) ->

    JSON.read filename, (err, pkg) ->
      return cb err if err

      finepack pkg, options, (err, newPkg, messages) ->
        return cb err if err
        localError = false

        if messages.error.length isnt 0
          printMessage plugin.logger, filename, 'error', messages.error
          globalError = true
          localError = true

        if messages.warn.length isnt 0
          printMessage plugin.logger, filename, 'warn', messages.warn

        if messages.success[0]
          globalMessage = messages.success[0]
          globalMessageType = 'success'
        else if messages.info[0]
          globalMessage = messages.info[0]
          globalMessageType = 'info'

        if localError then next true else JSON.save filename, newPkg, next
  , ->

    if globalError
      cb('Someting is wrong. Resolve red messages to continue.')
    else
      plugin.logger
      plugin.logger[globalMessageType] globalMessage
      cb()
