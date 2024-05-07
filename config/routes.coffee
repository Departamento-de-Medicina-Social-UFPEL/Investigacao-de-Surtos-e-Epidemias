parser = require 'body-parser'
routes = ()->

  # Rota principal
  @root 'pages#main'

  console.log @match 'biblio', 'pages#biblio'

  # Rotas de UBS
  @match 'casos/', 'casos#index', via: 'GET'
  @match 'casos/getppu/:id', 'casos#show', via: 'GET'
  @match 'casos/makeppu/:id', 'casos#create', via: 'POST'

  @match 'modulos/getppu/:id', 'modulos#showPpu', via: 'GET'
  @match 'modulos/makeppu/:id', 'modulos#create', via: 'POST'

  @match 'ubs/busca/codibge/:codibge', 'ubs#codibge'
  @match 'ubs/busca/codibge/:codibge/:page', 'ubs#codibge'
  @match 'ubs/busca/query/:query/:options/:page', 'ubs#index'
  @match 'ubs/busca/query/:query/:options', 'ubs#index'
  @match 'ubs/busca/query/:query', 'ubs#index'
  @match 'ubs/busca/:uf/:codibge', 'ubs#codibge'
  @resources 'ubs'

  # Rotas de Municípios
  @match 'municipios/busca/:uf', 'municipios#index', via: 'GET'
  @resources 'municipios'

  # Rota dos Manifestos de Cache
  @match 'appCacheManifest/:id', 'manifest#show', via: 'GET'

  # Rotas da Demografia
  @resources 'demo'

  #
  @match 'modulo', 'modulos#show'
  @match 'modulo/:id', 'modulos#show'
  @match 'modulos/:id/info', 'modulos#showBasicInfo'
  @match 'modulos/:id', 'modulos#create', via: 'POST'
  @resources 'modulos'
  #
  @namespace 'admin', ->
    @resources 'bibliografia'


module.exports = routes


