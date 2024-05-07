define [], () ->

  return (component, parentApp, Backbone, Marionette, $, _)->

    IDLE_TIMEOUT = 60
    #seconds
    _idleSecondsCounter = 0
    _observerReference = null

    _checkIdleTime = ->
      _idleSecondsCounter++
      if _idleSecondsCounter >= IDLE_TIMEOUT
        console.log 'Estou away!'
        if App.userMenu.currentView
          el = $ '.drop-label'
          unless el.find('.inativo-tag').length > 0
            el.find('.main-net-stats-ico').before '<small class="inativo-tag"> (Inativo) </small>'
        _observerReference = window.clearInterval _observerReference

    _zeroCounter = ->
      _idleSecondsCounter = 0
      do _observe unless _observerReference
      if App.userMenu.currentView
        $('.drop-label .inativo-tag').remove()


    _observe = (now=off)->
      do _checkIdleTime if now
      _observerReference = window.setInterval _checkIdleTime, 1000

    document.onclick = document.onmousemove = document.onkeypress = _.throttle _zeroCounter, 700
    _observe on
