define [
  '../models/Badge'
], (Badge)->
  class Badges extends Backbone.Collection
    model: Badge

  Badges