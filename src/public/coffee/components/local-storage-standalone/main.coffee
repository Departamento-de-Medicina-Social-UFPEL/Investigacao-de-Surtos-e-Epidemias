define [
  './adapters/Cache'
], (Cache) ->

  opt = namespace: window.modulo._id
  if unasus?.pack
    do unasus.pack.inicianlizar unless unasus.pack._initialized
    opt.namespace = unasus.pack.getBasename().slice(0,-1)
    opt.separator = '_'

  local = new Cache opt

  return (component, parentApp, Backbone, Marionette, $, _)->

    parentApp.local = local
