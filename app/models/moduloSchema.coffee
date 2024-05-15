mongoose = require "mongoose"
mongooseTimestamp = require 'mongoose-timestamp'
fs = require 'fs'
recursive = require 'recursive-readdir'
async = require 'async'

Mixed = mongoose.Schema.Types.Mixed

ModuloSchema = new mongoose.Schema
  'name': String
  'components': [ Mixed ]

ModuloSchema.plugin mongooseTimestamp


ModuloSchema.statics.getCacheFiles = (id, cb)->
  self = @
  ignoreList = ['Gruntfile.js', 'node_modules', '*.coffee', '*.json', '*.sh']

  @findById id, (err, mod)->
    throw err if err
    iterator = (tmplBuff, component, next) ->

      dir = "#{__dirname}/../../public/js/components/#{component.folder}"

      recursive dir, ignoreList, (err, files)->
        throw err if err
        prefix = "#{component.folder}-"
        for file in files
          lastSlash = file.lastIndexOf '/'
          fim = file.substr lastSlash + 1
          firstPonto = fim.indexOf '.'
          name = fim.slice 0, firstPonto
          key = prefix + name
          tmplBuff[key] = file
        next null, tmplBuff

    finalize = (err, templates) ->
      cb.apply self, [err, templates]

    async.reduce mod.components, {}, iterator, finalize

ModuloSchema.statics.getTemplateFiles = (id, cb)->
  self = @
  ignoreList = ['Gruntfile.js', 'node_modules', '*.coffee', '*.json', '*.sh', '*.js']

  @findById id, (err, mod)->
    throw err if err
    iterator = (tmplBuff, component, next) ->

      dir = "#{__dirname}/../../public/js/components/#{component.folder}"

      recursive dir, ignoreList, (err, files)->
        throw err if err
        prefix = "#{component.folder}-"

        for file in files
          continue unless /templates/.test file
          tmlFold = file.lastIndexOf 'templates/'
          fim = file.substr tmlFold+('templates/'.length)
          fim = fim.replace '/', '-'
          firstPonto = fim.indexOf '.'
          name = fim.slice 0, firstPonto
          key = prefix + name
          tmplBuff[key] = file

        next null, tmplBuff

    finalize = (err, templates) ->
      cb.apply self, [err, templates]

    tmplBuff = {}
    async.reduce mod.components, tmplBuff, iterator, finalize

ModuloSchema.statics.getClientRoutes = (id, cb) ->
  self = @
  @findById id, (err, mod)->
    compFolders = mod.components.map (c) -> c.folder

    prepara = (routes, component, next) ->
      dir = "#{__dirname}/../../public/js/components/#{component}"
      definition = require "#{dir}/definition.json"
      #console.log definition
      routes[component] = definition.routes
      next null, routes

    finaliza = (err, routes) ->
      cb.apply self, [err, routes]

    async.reduce compFolders, {}, prepara, finaliza

module.exports = ModuloSchema