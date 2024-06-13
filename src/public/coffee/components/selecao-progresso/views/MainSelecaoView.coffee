define [
  './selecaoItemView'
  'marionette'
], (ItemView, Marionette) ->
  class MainSelecaoLayout extends Marionette.CompositeView
    template: '#selecao-progresso-main'
    childView: ItemView
    childViewContainer: '.listaCasos'
    className: 'container selecao-main'
    initialize: ->
      nuc = App.progresso.user.get 'profissional'
      nucs = '1': 1, '2': 0, '3': 2
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
