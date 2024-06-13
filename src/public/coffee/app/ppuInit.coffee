require [
  'casca'
  'router'
  'controller'
], (CascaApp, CascaAppRouter, CascaController)->

  router = new CascaAppRouter
    'controller': CascaController

  window.App = new CascaApp
    'appRouter': router

  do unasus.pack.inicializar
  unless unasus.pack.getStatus()
    status =
      'status': 'attended'
      'percentage': 0
      'LTIvalue': 0
    unasus.pack.setStatus status

  goInit = ->

    modularComponentsCasca = window.modulo.components.map (component)->
      "js/components/#{component.folder}/main"

    require modularComponentsCasca, ()->
      compArr = window.modulo.components
      for idx, component of arguments
        name = compArr[idx].folder
        window.App.module name, component
        # do window.App[name].start
      do window.App.start

  return do goInit if window.modulo

  require ['js/lib/bson'], ()->
    req = new XMLHttpRequest
    req.open "GET", "payload.bson", true
    req.responseType = "arraybuffer"
    req.onload = (ObjectEvent)->
      console.log ObjectEvent
      {BSON} = new bson
      window.modulo = BSON.deserialize new Uint8Array req.response
      do goInit
    do req.send