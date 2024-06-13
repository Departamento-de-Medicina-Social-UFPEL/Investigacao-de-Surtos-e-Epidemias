define [
  './views/MenuView'
  'backbone'
], (MenuView, Backbone)->

  cadernoController =

    'mostraMenuView': () ->
      console.log arguments, @
      App.main.show new MenuView
        'model': new Backbone.Model
          ubs:
            nome: 'Cadernos de Ações Programáticas da UBS [selecionada]'
        'collection': new Backbone.Collection [
          { 'nome': 'prenatal' }
          { 'nome': 'puerperio' }
          { 'nome': 'saudecrianca' }
          { 'nome': 'cacolo' }
          { 'nome': 'camama' }
          { 'nome': 'hipertenso' }
          { 'nome': 'diabetico' }
          { 'nome': 'idoso' }
          { 'nome': 'saudebucal' }
          { 'nome': 'sintese' }
        ]

    'mostraAcao': ()->
      console.log arguments

    'mostraUbs': ()->
      console.log arguments



  cadernoController



