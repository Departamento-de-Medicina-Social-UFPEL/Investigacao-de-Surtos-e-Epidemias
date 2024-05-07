define [
  'backbone.modal'
], (ModalView)->

  class Modal extends Backbone.Modal
    submitEl: '.bbm-button'
    onRender: ->
      b = $('body')
      do b.fadeIn unless b.is ':visible'
    onDestroy: ->
      $('body').css 'overflow': 'auto'
      return App.appRouter.previous() if App.main.currentView
      App.appRouter.navigate '/', 'trigger': yes

  return {
    "mostra": (ids) ->
      do App.modals.destroyAll
      idArr = ids.split ','
      collection = new Backbone.Collection App.badges.filter (i)-> i.get('_id') in idArr
      App.modals.destroyAll() if App.modals.currentView
      App.modals.show new (Modal.extend {
          template: _.template $('#badge-ganhou').html()
          onDestroy: ->
            $('body').css 'overflow': 'auto'
            return if App.main.currentView
            App.appRouter.navigate '/', 'trigger': yes
        })({collection})


    "lista": ->
      do App.modals.destroyAll
      App.progresso.badgesConcedidos = App.progresso.temNovosBadges true
      ListaModal = Modal.extend
        template: _.template $('#badge-all').html()
        onDestroy: ->
          $('body').css 'overflow': 'auto'
          return App.appRouter.navigate('/', 'trigger': yes) unless App.main.currentView
          App.appRouter.previous() if App.modals.currentView

      App.modals.show new ListaModal
  }