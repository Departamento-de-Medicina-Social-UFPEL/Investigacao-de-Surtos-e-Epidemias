define [
  'backbone.marionette'
], (Marionette) ->
  class MenuItemView extends Marionette.ItemView
    tagName: 'li'
    initialize: () ->
      @className = @model.get 'style' || ''
    template: _.template($('#item-menu-drop-template').html(), {
      interpolate: /\<\@\=(.+?)\@\>/gim
      evaluate: /\<\@([\s\S]+?)\@\>/gim
      escape: /\<\@\-(.+?)\@\>/gim
    })