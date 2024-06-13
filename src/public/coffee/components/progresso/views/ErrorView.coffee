define [
  'backbone.modal'
], ()->

  class Modal extends Backbone.Modal
    submitEl: '.close-modal'
    template: _.template $('#progresso-error').html()
    initialize: (obj)->
      @model = new Backbone.Model obj

    onRender: ->
      b = $('body')
      do b.fadeIn unless b.is ':visible'
    onDestroy: ->
      $('body').css 'overflow': 'auto'
