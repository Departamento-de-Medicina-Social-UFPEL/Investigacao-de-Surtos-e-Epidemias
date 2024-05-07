define [
  'backbone.modal'
], ()->

  class Modal extends Backbone.Modal
    submitEl: '.bbm-button'
    template: _.template $('#logout-error').html()
    initialize: (obj)->
      @model = new Backbone.Model obj

    onRender: ->
      b = $('body')
      do b.fadeIn unless b.is ':visible'
    onDestroy: ->
      $('body').css 'overflow': 'auto'
      window.location.hash = ''