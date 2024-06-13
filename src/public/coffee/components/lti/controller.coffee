define [
  'backbone.modal'
  'marionette.modals'
], (ModalView, ModalsRegion, Template)->
  "describeInstance": () ->
    Modal = Backbone.Modal.extend
      template: _.template $('#lti-modal-info').html()
      submitEl: '.bbm-button'
      onRender: ->
        b = $('body')
        do b.fadeIn unless b.is ':visible'
      onDestroy: ->

        return do window.history.back if App.main.currentView
        App.appRouter.navigate '/', 'trigger': yes
    App.modals.show new Modal()
  "backToReturnUrl": ->
    window.location.href = window.lti.launch_presentation_return_url





