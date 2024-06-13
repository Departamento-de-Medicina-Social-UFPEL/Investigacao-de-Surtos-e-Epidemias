_ = require 'lodash'
uf_faixa_sexo = require './datasus/uf-faixaEtaria-sexo'

db = uf_faixa_sexo

rs = _.findWhere db, sigla: 'RS'

faixaDos17 = _.findWhere(
  rs.faixas
  (f) ->
    f.intervalo[0] < 17 <  f.intervalo[1]
)
console.log faixaDos17