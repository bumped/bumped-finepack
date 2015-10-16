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

  async.eachSeries bumped.config.rc.files, (filename, next) ->

    JSON.loadAsync filename, (err, pkg) ->
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

        if localError then next true else JSON.saveAsync filename, newPkg, next
  , ->
    cb('Someting is wrong. Resolve red messages to continue.' if globalError)
