'use strict'

path         = require 'path'
async        = require 'async'
finepack     = require 'finepack'
jsonFuture   = require 'json-future'
chalk        = require 'chalk'

printMessage = (logger, filename, type, messages) ->
  color = if type is 'warn' then 'yellow' else 'red'
  colorize = chalk[color]
  logger.transport logger.generateMessage type, "#{filename}: #{colorize(message)}" for message in messages

module.exports = (bumped, plugin, cb) ->

  options =
    lint: if plugin.lint? then plugin.lint else true
    validate: if plugin.validate? then plugin.validate else true

  globalError = false

  async.eachSeries bumped.config.rc.files, (filename, next) ->
    jsonFuture.loadAsync filename, (err, pkg) ->
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

        return next(true) if localError
        jsonFuture.saveAsync filename, newPkg, next
  , ->
    cb globalError
