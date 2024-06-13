define [
  'marionette'
], (Marionette) ->
  class VideoLayout extends Marionette.ItemView
    template: _.template $('#video-player-video').html()
    className: 'container-fluid'
    initialize: ->
      console.log @model, 'modelo video'
      # console.log @collection, 'coll video'
      # console.log @model, 'modelo unidade'
    events:
      'click .gotoReturn': 'gotoReturn'

    gotoReturn: ()->
        if App.appRouter.historico.length > 1
            App.appRouter.previous()
        else
            App.appRouter.navigate "comp/materiais", true

    onRender: ->
      posterName = @model.get('poster')
      console.log @model, 'modelo video'
      $el = $(@el)
      videoEl = $el.find('video')
      videoEl.prop 'volume', 0.5
      videoEl.on 'playing', () ->
        if App.user
          App.user.especifico ?= []
          jaAnotou = _.findWhere(App.user.especifico, {modulo:window.modulo._id, name:posterName})
          jaeh = null
          if jaAnotou
            jaeh = jaAnotou.value
          return jaeh if jaeh
          App.user.especifico.push
              modulo: window.modulo._id
              name: posterName
              value: yes

          App.local.set "user", App.user
          # App.execute 'storeUser', App.user

    onDestroy: ->
      $('body').removeAttr('style').css display: 'block'
      return App.appRouter.previous() if App.main.currentView
      App.appRouter.navigate '/', 'trigger': yes
