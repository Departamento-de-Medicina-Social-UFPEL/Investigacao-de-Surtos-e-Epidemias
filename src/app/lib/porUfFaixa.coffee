_ = require 'lodash'
uf_faixa_sexo = require './datasus/uf-faixaEtaria-sexo'

db = uf_faixa_sexo

rs = _.findWhere db, sigla: 'RS'

entre5e9anos = _.findWhere(
  rs.faixas
  intervalo: [5, 9]
)

console.log entre5e9anos