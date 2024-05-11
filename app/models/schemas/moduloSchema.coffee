mongoose = require "mongoose"
mongooseTimestamp = require 'mongoose-timestamp'
fs = require 'fs'
recursive = require 'recursive-readdir'
async = require 'async'
_ = require 'underscore'
Mixed = mongoose.Schema.Types.Mixed
Selecao = require '../selecao.coffee'
Bibliografia = require '../bibliografia.coffee'
Casos = require '../caso.coffee'
Materiais = require '../materiais.coffee'
ModuloSchema = new mongoose.Schema
  'name': String
  'area': String
  'navigateOnStart':
    'type': String
    'default': 'comp/sobre'
  'shortname':
    'type': String
    'default': null
  'showComponentMenu':
    'type': Boolean
    'default': yes
  'skipIntro':
    'type': Boolean
    'default': no
  'components': [ Mixed ]
  'url_facebook':String
  'id_facebook':String
  'fl_por_unidade':
    'type': Boolean
    'default':false

ModuloSchema.plugin mongooseTimestamp

ModuloSchema.statics.getCacheFiles = (id, cb)->
  self = @
  ignoreList = ['Gruntfile.js', 'node_modules', '*.coffee', '*.json', '*.sh']

  @findById id, (err, mod)->
    throw err if err
    iterator = (tmplBuff, component, next) ->

      dir = "#{__dirname}/../../../public/coffee/components/#{component.folder}"

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

ModuloSchema.statics.externalResources = (id, cb)->
  self = this
  @findById id, (err, mod)->
    throw err if err
    hasExternalResources = _.any mod.components, "externalResources": true

    return cb(null, mod.components) unless hasExternalResources

    iterator = (item, next) ->
      return next(null, item) unless item.externalResources is true
      # console.log item.ref
      DBModel = switch item.ref
        when 'selecoes'
          Selecao
        when 'bibliografias'
          Bibliografia
        when 'materiais'
          Materiais
        when 'casos'
          Casos

      query = {}
      query = '_id': item.oid if item.oid
      query = item.match if item.match
      Qry = DBModel.find query
      if item.ref is 'selecoes'
        Qry.populate path: 'casos', options: lean: true
      do Qry.lean
      Qry.exec (err, docs) ->
        throw err if err
        item.resource = docs
        item.resource = docs[0] if item.ref is 'selecoes'
        next(null, item)

    finalize = (err, comps) ->
      cb.apply self, [err, comps]

    async.map mod.components, iterator, finalize

ModuloSchema.statics.getTemplateFiles = (id, cb)->
  self = @
  ignoreList = ['Gruntfile.js', 'node_modules', '*.coffee', '*.json', '*.sh', '*.js']

  @findById id, (err, mod)->
    throw err if err
    console.log id, mod, 'modulo'

    iterator = (tmplBuff, component, next) ->
      dir = "#{__dirname}/../../../public/coffee/components/#{component.folder}"
      fs.stat dir, (err, stat) ->
        # console.log 'fs.stat dir, (err, stat) ->', arguments
        return next null, tmplBuff if err
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
      dir = "#{__dirname}/../../public/coffee/components/#{component}"
      definition = require "#{dir}/definition.json"
      # console.log definition
      routes[component] = definition.routes
      next null, routes

    finaliza = (err, routes) ->
      cb.apply self, [err, routes]

    async.reduce compFolders, {}, prepara, finaliza

module.exports = ModuloSchema