_ = require 'lodash'
db = require './datasus/uf-faixaEtaria-sexo'

rs = _.findWhere db, sigla: 'RS'

console.log rs