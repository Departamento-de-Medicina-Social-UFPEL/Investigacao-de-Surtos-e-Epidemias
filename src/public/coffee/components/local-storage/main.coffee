define [
  './adapters/Cache'
], (Cache) ->

  local = new Cache
    namespace: window.modulo._id

  return (component, parentApp, Backbone, Marionette, $, _)->

    parentApp.local = local
