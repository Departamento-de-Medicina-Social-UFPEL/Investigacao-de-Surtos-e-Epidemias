define [
], () ->

  class NotFoundView extends Marionette.ItemView

    'tagName': 'div'

    'className': 'container-fluid introbox-container'

    'template': '#caso-progresso-notfound'

    initialize: (options)->
