define [], ->

  class PilhaImagensChild extends Marionette.ItemView

    tagName: 'img'

    template: (a) ->
      _.template "", a

    className: () ->
      'imagem-orienta ' + @model.get 'url'

    onRender: (view) ->
      if view.model.get 'el'
        do @$el.hide
        return null

      pos = view.model.get 'pos'
      scale = view.model.get 'scale'
      ori = view.model.get 'ori'
      popPos = "#{view.model.get('popPos') ? 'auto right'}"

      @$el.attr
        src: view.model.get 'src'
        certo: view.model.get 'certo'
        ori: ori.nome
        tabindex: 2

      @$el.css
        top: pos[1]+'%'
        left: pos[0]+'%'
        width: scale+'%'

      @addPopOver @el, ori, popPos

    addPopOver: (el, ori, popPos) ->

      $(el).popover
        animation: true
        content: ori.orientacao
        title: ori.titulo
        trigger: 'maunal focus'
        container: 'body'
        html: true
        delay: show: 300, hide: 100
        placement: popPos

      $(el).on 'shown.bs.popover', () ->
        window.openPop = $ this

      $(el).on 'hidden.bs.popover', () ->
        window.openPop = null
