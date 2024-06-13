define [
    'backbone.modal'
], (ModalView) ->
  class ModalElegivel extends Backbone.Modal
    template: _.template($('#modal-elegivel-conteudo-item').html(), {
      interpolate: /\<\@\=(.+?)\@\>/gim
      evaluate: /\<\@([\s\S]+?)\@\>/gim
      escape: /\<\@\-(.+?)\@\>/gim
    })
    submitEl: '.bbm-button'

    events:
      'click #link-meu-progresso': 'backToProgresso'
    
    backToProgresso: ->
      App.appRouter.navigate '#comp/progresso', 'trigger': yes
      @destroy()

    onRender: ->
      b = $('body')
      do b.fadeIn unless b.is ':visible'
    onDestroy: ->
      $('body').css 'overflow': 'auto'
    #   App.modals.destroyAll() if App.modals.currentView