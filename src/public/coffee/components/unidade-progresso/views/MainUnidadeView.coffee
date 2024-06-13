define [
  './selecaoItemView'
  'marionette'
], (ItemView, Marionette) ->
  class MainUnidadeLayout extends Marionette.CompositeView
    template: '#unidade-progresso-main'
    childView: ItemView
    childViewContainer: '.listaCasos'
    className: 'container-fluid selecao-main unidade-main'
    events:
      'click .gotoFinalUnidade': 'gotoFinalUnidade'
      'click .gotoInicialUnidade': 'gotoInicialUnidade'
      'click .gotoVideo': 'gotoVideo'
    
    gotoInicialUnidade: (e) ->
      u = $(e.target).data('unidade')
      @gotoHome()
      inicialDaPro = (App.testes.filter (d)-> /inicial/img.test(d.get('titulo')) && d.get('unidade') == u )[0]
      unless inicialDaPro
        Backbone.history.navigate "comp/listatestes", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}
    
    gotoFinalUnidade: (e) ->
      u = $(e.target).data('unidade')
      @gotoHome()
      inicialDaPro = (App.testes.filter (d)-> /final/img.test(d.get('titulo')) && d.get('unidade') == u )[0]
      console.log 'inicialPro', inicialDaPro, u
      unless inicialDaPro
        Backbone.history.navigate "comp/listatestes", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}
    
    gotoHome: () ->
      unless App.user
        Backbone.history.navigate '#comp/home', {trigger: on}

    gotoVideo: () ->
      Backbone.history.navigate 'comp/video-player/'+@model.get('img_video_apresentacao')+'/'+@model.get('unidade'), {trigger: on}
    
    initialize: ->
      console.log @model, 'modelo unidade'
      # console.log @model, 'modelo unidade'

      if not @model.get('unidade')
        @model.set('unidade', false)
      if not @model.get('img_video_apresentacao')
        @model.set('img_video_apresentacao', "")
      if not @model.get('cor')
        @model.set('corFonte', '#'+window.modulo.corPadrao)
        @model.set('corIntro', 'eee')
        @model.set('corElementos', window.modulo.corPadrao)
      else
        @model.set('corFonte', 'white')
        @model.set('corIntro', @model.get('cor'))
        @model.set('corElementos', @model.get('cor'))

      nuc = App.progresso.user.get 'profissional'
      nucs = '1': 1, '2': 0, '3': 2
      @model.set('nr_casos', @collection.length)
      @model.set('nr_atividades', if @model.get('atividades') then @model.get('atividades').length else 0)
      @collection.comparator = (at1, at2)->
        pro1 = at1.get('pro')
        isPro1 = pro1[nucs[nuc]]
        nNucs1 = pro1.reduce (m, i)-> if i then m + 1 else m

        pro2 = at2.get('pro')
        isPro2 = at2.get('pro')[nucs[nuc]] 
        nNucs2 = pro2.reduce (m, i)-> if i then m + 1 else m

        if isPro1 and isPro2
          if nNucs1 < nNucs2
            return -1
          else if nNucs1 > nNucs2
            return 1
          return 0
        else if isPro1
          return -1
        else if isPro2
          return 1
        0
      @collection.sort()

    onRender:->
      console.log @model.attributes.categories, 'modelo do render'
