define ['./SlidesFactory'], (SlideFactory) ->

  class SlidesCollView extends Marionette.CollectionView

    'tagName': 'div'

    'class': 'listaSlides'

    'childView': Backbone.View

    'buildChildView': SlideFactory

    'initialize': ()->
      @listenTo @, 'childview:respondeu', (itemView, data) ->
        App.main.currentvi
        @showTillNext itemView, data
        #
        @trigger "filhoRespondeu"

    'questaoDaVez': 0

    'onRender': ->
      @children.each (view) ->
        imgs = view.$el.find('img')

        imgs.css('width','100%')
        imgs.each (k,v) ->
          src = $(v).attr('src')
          $(v).attr('src', "#{window.defaultStaticFileService}#{if src[0] isnt '/' then '/' else ''}#{src}");

        # table = view.$el.find('table')
        # table.prop('border','0')
        # table.addClass('table table-striped')
      @questoes = @children.filter (view) ->
        view.model.get('tipo').match(/questao.*/ig)
      @questoes.forEach (q, i)->
        q.$el.prop
          id: 'questao_' + i
        q.$el.attr 'data-seqid', i
      @questoes[@questaoDaVez].$el.nextAll('section').hide()
      @questoes[@questaoDaVez].$el.addClass 'daVez'

    'showTillNext': (view)->
      el = view.$el
      nextQuest = el.nextAll('section.slide[class*="quest"]')[0]
      qView.$el.removeClass('daVez') for qView in @questoes
      if nextQuest
        $(nextQuest).prevAll('section').show()
        $(nextQuest).addClass('daVez').show()
      else
        @children.each (view) ->
          do view.$el.show


  SlidesCollView