define ['./SlideItemView'], (SlideItemView) ->

  class SlidesCollView extends Marionette.CollectionView

    'tagName': 'div'

    'class': 'listaSlides'

    'childView': Backbone.View

    'buildChildView': (child, ChildViewClass, childViewOptions)->
      s = new SlideItemView
        model: child
        tagName: 'section'
        className: "slide slide-saiba-mais item hide item-"+@iterador
      @iterador++
      s

    'initialize': ()->
      @iterador = 0
      @listenTo @, 'childview:respondeu', (itemView, data) ->
        App.main.currentvi
        @showTillNext itemView, data

    'questaoDaVez': 0

    'onRender': ->
      console.log @model, @collection, 'teste colection'
      @children.each (view) ->
        imgs = view.$el.find('img')

        imgs.css('width','100%')
        imgs.each (k,v) ->
          src = $(v).attr('src')
          $(v).attr('src', "/static/#{src}");

        # table = view.$el.find('table')
        # table.prop('border','0')
        # table.addClass('table table-striped')
      @questoes = @children.filter (view) ->
        view.model.get('tipo').match(/questao.*/ig)
      @questoes.forEach (q, i)->
        q.$el.prop
          id: 'questao_' + i
        q.$el.attr 'data-seqid', i
      #console.log @questaoDaVez, 'davezz'
      #@questoes[@questaoDaVez].$el.find('section').hide()
      #@questoes[@questaoDaVez].$el.nextAll('section').hide()
      # @questoes[@questaoDaVez].$el.addClass 'daVez'

    'showTillNext': (view)->
      el = view.$el
      nextQuest = el.nextAll('section.slide[class*="quest"]')[0]
      qView.$el.removeClass('daVez') for qView in @questoes
      # if nextQuest
      #   $(nextQuest).prevAll('section').show()
      #   #$(nextQuest).addClass('daVez').show()
      # else
      #   @children.each (view) ->
      #     do view.$el.show


  SlidesCollView