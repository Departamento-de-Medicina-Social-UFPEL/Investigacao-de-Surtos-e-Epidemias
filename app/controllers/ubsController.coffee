locomotive = require 'locomotive'
Controller = locomotive.Controller

Ubs = require '../models/ubs/ubs'
_ = require 'lodash'

UbsController = new Controller

UbsController.before '*', (next)->
  @itensPerPage = 10
  do next

UbsController.show = ->
  self = @
  query = cnes: @param 'id'
  opt = limit: 1
  Ubs.find query, opt, (err, doc) ->
    throw err if err
    doc = doc[0]
    unless doc
      return self.res.status(404).json erro: 'cnes não consta'
    self.res.json doc

UbsController.index = ()->
  self = @

  jsonQuery = @param('query')
  # console.log jsonQuery
  query = if @param 'query' then (JSON.parse jsonQuery) else {}
  options = @param 'options'
  page = @param 'page'
  pref = {}

  if options
    pref = JSON.parse @param 'options'
    if _.isNumber pref
      page = options
      pref = {}
  else
    pref = {}

  if page
    _.extend pref, offset: @itensPerPage * (page-1)

  _.extend pref, limit: @itensPerPage

  if query.codibge
    query.codibge = normIbge query.codibge

  Ubs.find query, pref, (err, docs) ->
    throw err if err
    self.res.json docs

UbsController.codibge = ->
  self = @

  if @param 'uf'
    uf = @param 'uf'
  codibge = @param 'codibge'
  query = codibge: normIbge codibge
  page = @param 'page'
  pref = {}
  _.extend pref, offset: @itensPerPage * (page-1) if page
  _.extend pref, uf: uf.toUpperCase() if uf
  fields = ['nome', 'tipo', 'municipio', 'bairro', 'cnes']
  _.extend pref, only: fields
  Ubs.find query, pref, (err, docs) ->
    throw err if err
    self.res.json docs

module.exports = UbsController

normIbge = (cod)-> String(cod).slice 0, 6