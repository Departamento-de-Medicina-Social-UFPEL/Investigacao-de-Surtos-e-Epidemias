rawUfs = _.map staticData.estados, (item) -> _.partial(_.pick, item).apply null, ['sigla','nome']
rawUfs = rawUfs.map (i)-> value: i.sigla, text: i.nome
dummy = (text)-> { value:'-1', text: text or 'Selecione...' }

class UbsFormLayout extends Marionette.LayoutView
  tagName: 'form'
  template: '#local-template'
  onRender: ->
    @addRegions 'ufBox': '.ufBox', 'muniBox': '.muniBox', 'ubsBox': '.ubsBox'
    @ufBox.show new EstadoSelectView collection: new Backbone.Collection [dummy 'UF'].concat rawUfs
    @muniBox.show new MunicipioSelectView collection: new Backbone.Collection [dummy 'Escolha um estado.']
    @ubsBox.show new UbsSelectView collection: new UbsCollection [dummy 'Escolha um estado e um município.']
  childEvents:
    'mostra:municipiosDeUf': (child, uf)->
      muniColl = @muniBox.currentView.collection
      ubsColl = @ubsBox.currentView.collection
      ubsColl.reset [dummy 'Escolha um estado e um município.']
      return muniColl.reset [dummy 'Escolha um estado.'] if uf is '-1'
      estado = _.findWhere staticData.estados, sigla: uf.toUpperCase()
      cidades = estado.cidades.map (i)-> value: i.ibge, text: i.nome
      muniColl.reset [ do dummy ].concat cidades
    'mostra:ubsDeMun': (child, ibge)->
      ubsColl = @ubsBox.currentView.collection
      return ubsColl.reset [dummy 'Escolha um estado e um município.'] if ibge is '-1'
      ubsColl.reset [dummy 'Carregando...']
      ubsColl.ibge = ibge
      do ubsColl.fetch

class SelectItemView extends Marionette.ItemView
  tagName: 'select'
  className: 'form-control input-lg'
  template: '#select-template'

class EstadoSelectView extends SelectItemView
  events: 'change': 'mostra'
  mostra: -> @triggerMethod 'mostra:municipiosDeUf', @$el.val()

class MunicipioSelectView extends SelectItemView
  events: 'change': 'mostra'
  initialize: -> @listenTo @collection, 'reset', @render
  mostra: ->  @triggerMethod 'mostra:ubsDeMun', @$el.val()
  onBeforeRender: -> @$el.empty().attr disabled: 'disabled'
  onRender: -> @$el.removeAttr 'disabled' unless @collection.length <= 1

class UbsCollection extends Backbone.Collection
  url: -> "//dms.ufpel.edu.br/casca/ubs/busca/codibge/#{@ibge}"
  parse: (ubss)->
    @reset [do dummy].concat ubss.map (i)-> value: i.cnes, text: i.nome

class UbsSelectView extends SelectItemView
  events: 'change': 'mostra'
  initialize: -> @listenTo @collection, 'reset', @render
  mostra: ->
  onBeforeRender: -> @$el.empty().attr disabled: 'disabled'
  onRender: ->
    @$el.removeAttr 'disabled' unless @collection.length <= 1

class DemoAppFormLocal extends Marionette.Application
  regions: container: '.local-form-container'
  initialize: -> @container.show new UbsFormLayout

new DemoAppFormLocal