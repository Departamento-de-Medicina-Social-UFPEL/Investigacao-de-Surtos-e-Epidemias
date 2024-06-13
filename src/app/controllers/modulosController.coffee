fs = require('fs')
locomotive = require 'locomotive'
Controller = locomotive.Controller

ibge = require 'municipios-ibge'
ufMun = require '../lib/uf-mun.coffee'
_ = require 'lodash'

Modulos = require '../models/moduloModel.coffee'
Ofertas = require '../models/ofertas.coffee'

_ = require 'lodash'
async = require 'async'
PDFImage = require("pdf-image").PDFImage
zipFolder = require('zip-folder')
ZIP = new require('node-zip')()
path = require('path')
repo = path.resolve(__dirname,'../templates/')


_loadModule = (cb)->
  self = this
  q = if @moduloId.length is 24 then {'_id': @moduloId}
  else {'shortname': @moduloId}
  Modulos.findOne(q).lean().exec (err, modulo) ->
    if not modulo
      return self.render 'notfound'

    self.modulo = modulo
    Ofertas.find({modulo: modulo._id}).lean().exec (err, ofertas)->
      self.modulo['ofertas'] = ofertas
      cb.apply self if cb

_loadTempaltes = (cb)->
  self = this
  _loadModule _loadTempaltes unless @modulo
  Modulos.getTemplateFiles @modulo._id, (err, templates) ->
    for k, file of templates
      templates[k] = fs.readFileSync file, 'utf-8'
    self.templates = templates
    cb.apply self if cb

_hydrate = (cb)->
  self = this
  _loadModule.apply(this, [_hydrate]) unless @modulo
  Modulos.externalResources @modulo._id, (err, hidratedComponents) ->
    self.modulo.components = hidratedComponents
    cb.apply self if cb

class ModulosController extends Controller
  "index": ()->
    # console.log 'redir'
    @res.redirect '/'

  # "create": ()->
  #   # LTI handle
  #   # console.log @req.originalUrl
  #   @res.redirect @req.originalUrl

  "showBasicInfo": ->

  "show": ()->
    self = this
    @moduloId = @params 'id'
    @moduloId = '5474EB2F70BF95195804F780' unless @moduloId
    @estados = _.sortBy ufMun, (est)->
      do est.nome.toLowerCase if est.nome

    _loadModule.apply this, [
      ->
        @req.session.ltis ?= []
        @lti_tc = @req.lti?.body || false;
        tag = {modulo_id: @modulo._id}
        lti = _.find @req.session.ltis, tag
        self = this
        self.req.socket.on @moduloId, () ->
          console.log '-------------', arguments

        unless lti
          novo = @lti_tc
          if novo
            novo.modulo_id = @modulo._id
          @req.session.ltis.push novo
          @lti_tc = novo
        else
          @lti_tc = lti
        _loadTempaltes.apply this, [
          -> _hydrate.apply this, [
            -> @render 'show'
    ] ] ]

c = new ModulosController()

module.exports = c