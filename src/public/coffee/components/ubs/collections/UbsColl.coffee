define [
  'backbone'
  '../models/UbsModel'
], (Backbone, UbsModel) ->
  class UbsColl extends Backbone.Collection
    'rootUrl': '/ubs'
    'model': UbsModel




