define [
  './views/MainLayoutView'
], (MainView) ->

  "mostraDashboard": (callback) ->
    mainView = new MainView
    App.main.show mainView

    callback.apply @ if callback
