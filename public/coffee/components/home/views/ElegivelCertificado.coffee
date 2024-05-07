define [
  'backbone.modal'
], (ModalView) ->

  class Modal extends Backbone.Modal
    initialize: (@user) ->

    template: _.template($('#home-elegivel-certificacao').html())
    submitEl: '.submit-form'
    cancelEl: '.close-modal'

    beforeSubmit: (ev) ->
      App.modals.destroyAll()
      Backbone.history.navigate '#comp/progresso', {trigger: on}
      false

    onRender: ->
      b = $('body')
      @fillForm() if @user
      do b.fadeIn unless b.is ':visible'
      setTimeout (()-> do window.$.material.init), 10

    onDestroy: ->
      $('body').removeAttr('style').css display: 'block'
      $('body').css 'overflow': 'auto'
      # return do window.history.back if App.main.currentView
      return do App.appRouter.previous if App.main.currentView
      App.appRouter.navigate '/', 'trigger': yes


