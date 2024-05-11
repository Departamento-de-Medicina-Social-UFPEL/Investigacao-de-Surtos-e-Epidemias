_ = require 'lodash'
locomotive = require 'locomotive'
fs = require 'fs'
ibge = require 'municipios-ibge'
ufMun = require('../lib/uf-mun.coffee').estados.map (est) ->
  est.cidades = est.cidades.map (mun) ->
    nome: mun
    ibge: ibge est.nome, mun
  est
Modulos = require '../models/moduloModel.coffee'
path = require 'path'

PagesController = new locomotive.Controller

PagesController.main = ()->
  dest = path.resolve "modulos/5474EB2F70BF95195804F780"
  @res.redirect dest

PagesController.biblio = ()->
  do @render

module.exports = PagesController


