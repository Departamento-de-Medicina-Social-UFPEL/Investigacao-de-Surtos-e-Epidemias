define [
  'backbone.marionette'
  './MenuItem'
], (Marionette, MenuItemView) ->
  class MenuView extends Marionette.CompositeView
    tagName: 'li'
    className: 'dropdown menu-top-right'
    template: _.template($('#user-drop-menu-template').html(), {
      interpolate: /\<\@\=(.+?)\@\>/gim
      evaluate: /\<\@([\s\S]+?)\@\>/gim
      escape: /\<\@\-(.+?)\@\>/gim
    })

    initialize: ->
      self = @

    templateHelpers: () ->
      nome = @model.get('ficha')?.pessoal.nome.primeiro
      nome = @model.get('nome').split(' ')[0] unless nome
      {
        label: nome
        statsIco: 'wifi'
      }

    childViewContainer: '.menu'
    childView: MenuItemView

    onRender: ->
      $('.lista-conteudos').css({display:'block'});
      console.log 'teste progres------------------------'