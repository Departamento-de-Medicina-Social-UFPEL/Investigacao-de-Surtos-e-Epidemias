define [
  'backbone.marionette'
], (Marionette)->

  class AppRouter extends Marionette.AppRouter

    initialize: (options) ->
      @on "all", @storeRoute
      @historico = []

    appRoutes:
      '': 'listaComponentesDoModelo'
      'comp/:name': 'mostraComponente'

    onRoute: ->
      $(window).scrollTop 0
      if window.ga then window.ga 'send', 'pageview'
      # if App.modals
        # App.modals.destroy if App.modals.currentView

    storeRoute: ->
      frag = Backbone.history.fragment
      last = @historico.slice(-1)[0]
      # console.log 'storeRoute', last
      $(".historyBarItem>a").parent().css({background: "inherit"})
      $(".historyBarItem>a[href='#"+last+"']").parent().css({background: "rgba(255, 255, 255, 0.7)"})
      unless frag is last
        @historico.push frag

    previous: ->
      pos = @historico.length - 2
      dest = @historico[pos]
      console.log dest, @historico
      if @historico.length > 1
        @navigate dest, true

  AppRouter