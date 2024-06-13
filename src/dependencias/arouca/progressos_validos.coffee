_ = require 'lodash'
Progresso = require '../../app/models/progressos.coffee'
module.exports = (cpf, modulo_id, callback)->
  condAux = false

  query = $and: [
    { user: cpf }
    { ativo: {'$ne':false}}
    { modulo: modulo_id }
  ]

  Progresso.find(query).exec (err, progresso)->
    porAti = _.groupBy progresso, 'atividade'
    validas = []
    for ati, atividade of porAti
      atividade = _.sortBy atividade, 'seqid'

      redutor = (memo, item) ->
        existe = memo[item.seqid]
        antId = item.seqid-1
        ehVelha = false
        if existe
          if item.ts < memo[item.seqid].ts
            if item.escore < memo[item.seqid].escore
              ehVelha = true

        unless existe
          memo[item.seqid] = item unless ehVelha
          return memo

        return memo

      validas = validas.concat(atividade.reduce redutor, [])
    validas = validas.filter (i)-> Boolean i

    callback validas
