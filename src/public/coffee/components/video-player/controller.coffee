define [
  'backbone.modal'
  './views/Video'
], (ModalView, VideoView)->
  Modal = Backbone.Modal.extend
    template: _.template $('#video-player-tela').html()
    submitEl: '.bbm-button'
    className: 'container-fluid'
    onRender: ->
      b = $('body')
      do b.fadeIn unless b.is ':visible'
      $el = $(@el)
      $el.find('.bbm-modal').css {'max-width': '90%', 'margin-bottom': '235px'}
      videoEl = $el.find('video')
      videoEl.prop 'volume', 0.5
      videoEl.on 'playing', () ->
        if App.user
          App.user.especifico ?= []
          jaAnotou = _.findWhere(App.user.especifico, {modulo:window.modulo._id, name:'viuVideo'})
          jaeh = null
          if jaAnotou
            jaeh = jaAnotou.value
          return jaeh if jaeh
          App.user.especifico.push
              modulo: window.modulo._id
              name: 'viuVideo'
              value: yes
          App.local.set "user", App.user
          App.execute 'storeUser', App.user
    onDestroy: ->
      $('body').removeAttr('style').css display: 'block'
      return App.appRouter.previous() if App.main.currentView
      App.appRouter.navigate '/', 'trigger': yes
  "play": () ->
    console.log 'play'
    appComponent = _.findWhere window.modulo.components, {folder: 'video-player'}
    App.modals.show new Modal
      model: new Backbone.Model
        sources: appComponent.sources
        poster: appComponent.poster
        title: false
        fileapoio: false


  "playUnidade": ( posterName,uni) ->
    console.log 'playUnidade, uni', window.modulo.components, {unidade:uni, folder : 'unidade-progresso'}
    unidade = _.findWhere window.modulo.components, {unidade:parseInt(uni), folder : 'unidade-progresso'}
    console.log 'video apre',unidade, uni
    App.modals.show new Modal
      model: new Backbone.Model
        sources: unidade.video_apresentacao.sources
        poster: posterName
        title: false
        fileapoio: false

  "playByPosterNameView": ( posterName) ->
    console.log posterName, 'play name'
    unidades = _.where window.modulo.components, {folder : 'unidade-progresso'}
    unidade_video = false
    for u of unidades
      video = _.findWhere unidades[u].sources, { poster : posterName }
      if video
        unidade_video = unidades[u]
        break
    video = _.findWhere unidade_video.sources, { poster : posterName }
    App.modals.show new Modal
      model: new Backbone.Model video 
  
  "playByPosterName": (posterName) ->
    unidades = _.where window.modulo.components, {folder : 'unidade-progresso'}
    unidade_video = false
    for u of unidades
      video = _.findWhere unidades[u].sources, { poster : posterName }
      if video
        unidade_video = unidades[u]
        break
    if unidade_video
      video = _.findWhere unidade_video.sources, { poster : posterName }
      mainView = new VideoView
        model: new Backbone.Model(video)
      App.main.show mainView

    # Se não tiver, tentar achar por modulo.components.video-pĺayer.source.filename.
    else
      console.log posterName, 'play from home by ds'
      videos = _.where window.modulo.components, {folder : 'video-player'}
      
      video = false
      for idx, v of videos
        video = _.findWhere v.sources, { filename : posterName }
        if video
          video = v
          break

      App.modals.show new Modal
        model: new Backbone.Model
          sources: video.sources
          poster: video.poster
          title: video.title
          fileapoio: false
      $('body').css 'overflow': 'auto'

