locomotive = require 'locomotive'
Controller = locomotive.Controller

ibge = require 'municipios-ibge'
ufMun = require '../lib/uf-mun.coffee'
_ = require 'lodash'

MunicipiosController = new Controller

MunicipiosController.index = ()->
  self = @
  data = ufMun.estados
  ret = data.map (estado) ->
    estado.cidades = estado.cidades.map (municipio) ->
      nome: municipio
      ibge: ibge estado.nome, municipio
    estado

  self.res.json ret

MunicipiosController.show = (id)->
  self = @
  uf = id or @param 'id'
  data = ufMun.estados
  estado = _.findWhere data, sigla: uf.toUpperCase()
  unless _.isObject estado.cidades[0]
    estado.cidades = estado.cidades.map (municipio) ->
      nome: municipio
      ibge: ibge estado.nome, municipio

  self.res.json estado

module.exports = MunicipiosController
