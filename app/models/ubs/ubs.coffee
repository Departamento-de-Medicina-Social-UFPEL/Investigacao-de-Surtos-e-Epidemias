FastLegS = require 'FastLegS'
fast = new FastLegS 'pg'
config = require './config.coffee'

fast.connect config

Ubs = fast.Base.extend
  'tableName': 'locubs'
  'primaryKey': 'cnes'

module.exports = Ubs