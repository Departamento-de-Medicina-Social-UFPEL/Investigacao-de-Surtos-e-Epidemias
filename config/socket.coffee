Usuarios = require '../app/models/usuarios.coffee'
Progressos = require '../app/models/progressos.coffee'
Monitoramentos = require '../app/models/monitoramentos.coffee'
Ofertas = require '../app/models/ofertas.coffee'
ofertasUsuarios = require '../app/models/ofertasUsuarios.coffee'
Arouca = require('/home/dev/casca/dependencias/arouca/index.js')
respostas_validas = require '/home/dev/casca/dependencias/arouca/progressos_validos.coffee'
MonitoraServico = require '../app/models/monitora_arouca.coffee'
Casos = require '../app/models/caso.coffee'
Modulo = require '../app/models/moduloModel.coffee'
bson = require 'bson'
async = require 'async'
_ = require 'underscore'

requisitar = require('request')
dd_mm_aaaa = (date) ->
  d = date.getDate(); m = date.getMonth(); a = date.getFullYear()
  "#{if d > 9 then d else '0'+d}/#{if m > 8 then m+1 else '0'+(m+1)}/#{a}"

routes = (socket)->

  socket.on 'connect', ->
    # console.log 'connected', arguments
    socket.emit 'hi'

  socket.on 'user', (param, callback)->
    # console.log 'salvando param',param
    self = @
    ok = false
    cpfInicio = param.cpf
    for campo in [
      {nome: 'cpf', msg: 'Cpf não informado'}
      {nome: 'nome', msg: 'Nome não informado'}
      {nome: 'sexo', msg: 'Sexo não informado'}
      {nome: 'profissional', msg: 'Núcleo profissional não informado'}
      {nome: 'dataNasc_dia', msg: 'Dia não informado'}
      {nome: 'dataNasc_mes', msg: 'Mês não informado'}
      {nome: 'dataNasc_ano', msg: 'Ano não informado'}
      {nome: 'nomeMae', msg: 'Nome da mãe não informado!'}
      {nome: 'email', msg: 'Email não informado!'}
      {nome: 'uf', msg: 'UF não informado'}
      {nome: 'municipio', msg: 'Município não informado'}
    ]
      unless param[campo.nome]
        ok = false
        msg = campo.msg

    ok = true
    msg = 'O cadastro foi atualizado com sucesso!'

    {cpf, nome, sexo, profissional, dataNasc_dia, dataNasc_mes, dataNasc_ano, nomeMae, email, uf, municipio, ibge, mala_direta,  modulo, especifico, enquetes} = param
    flag = 'pos-update-formulario-cadastro'
    # console.log param, 'param posted'

    especifico ?= []
    especifico = especifico.map((i)-> i.ts ?= Date.now(); i)
    especifico = _.map(((_.groupBy especifico, ((doc)-> doc.modulo + doc.name))), (grouped)-> _.sortBy(grouped, 'ts').reverse()[0] )
    # console.log especifico
    Usuarios.findOne({cpf:cpf}).exec (err, usuario)->
      if err
        ok = false
        msg = "Erro ao verificar existencia de usuario"
      if not usuario
        usuario = new Usuarios {cpf}
        msg = 'O cadastro foi salvo com sucesso!'
      usuario.set {nome: param.nome, sexo: param.sexo, profissional: param.profissional, dataNasc_dia: param.dataNasc_dia, dataNasc_mes: param.dataNasc_mes, dataNasc_ano: param.dataNasc_ano, nomeMae: param.nomeMae, email: param.email, ibge: param.ibge, mala_direta: param.mala_direta, especifico: param.especifico}
      usuario.set 'nucleo_profissional', profissional
      usuario.set {uf: param.uf, municipio: param.municipio}

      # Arrumar alguns erros de entrada de dado.
      dia = if usuario.dataNasc_dia.length == 2 then usuario.dataNasc_dia else "0" + usuario.dataNasc_dia
      mes = if usuario.dataNasc_mes.length == 2 then usuario.dataNasc_mes else "0" + usuario.dataNasc_mes
      ano = if usuario.dataNasc_ano.length == 4 then usuario.dataNasc_ano else "19" + usuario.dataNasc_ano
      usuario.set { dataNasc_dia: dia, dataNasc_mes: mes, dataNasc_ano: ano }
      # TODO: verificar se a data é válida.

      # Atualizar dados do formulário de curso com layout alternativo.
      if param.alt_raca_cor
        usuario.set {
          alt_anos_vigilancia_sus: param.alt_anos_vigilancia_sus
          alt_atua_ambulatorio_especializado: param.alt_atua_ambulatorio_especializado
          alt_atua_atencao_basica: param.alt_atua_atencao_basica
          alt_atua_filantropico: param.alt_atua_filantropico
          alt_atua_gestao_saude: param.alt_atua_gestao_saude
          alt_atua_hospital_emergencia: param.alt_atua_hospital_emergencia
          alt_atua_no_sus: param.alt_atua_no_sus
          alt_atua_pesquisa: param.alt_atua_pesquisa
          alt_atua_pronto_atendimento: param.alt_atua_pronto_atendimento
          alt_atua_saude_privada: param.alt_atua_saude_privada
          alt_atuou_vigilancia_sus: param.alt_atuou_vigilancia_sus
          alt_genero: param.alt_genero
          alt_nome_profissao: param.alt_nome_profissao
          alt_profissao: param.alt_profissao
          alt_qual_profissao: param.alt_qual_profissao
          alt_raca_cor: param.alt_raca_cor
          alt_tempo_profissao: param.alt_tempo_profissao
        }
      if param.enquetes
        usuario.set 'enquetes', enquetes
      if usuario.cpf isnt cpfInicio
        ok = false
        console.log err, 'erro'
        msg = 'Ocorreu um erro ao salvar o seu cadastro, cpf em conflito na transação'
        return callback {ok, msg, user: null}

      usuario.save (err)->
        console.log 'salvando usuario erro:', err
        if err
          ok = false
          console.log err, 'erro'
          msg = 'Ocorreu um erro ao salvar o seu cadastro'
          return callback {ok, msg, user: null}
        MonitoraServico.findOne({name:'arouca'}).exec (err, s)->
          if err
            throw err
          if not s.online
            return resolveOfertas(usuario, param, callback)
          else
            console.log 'sincronizando arouca'
            return syncUsuarioArouca usuario, param, (err, param, usuario)->
              if err
                return callback {ok:false, msg:err, user:null}
              if usuario.cpf isnt cpfInicio
                ok = false
                console.log err, 'erro', new Date(), usuario.cpf, cpfInicio
                msg = 'Ocorreu um erro ao salvar o seu cadastro, cpf em conflito na transação'
                return callback {ok, msg, user: null}
              console.log 'resolvendo ofertas'
              return resolveOfertas(usuario, param, callback)

  socket.on 'senderror', (msgError, callback)->
    console.log 'erro cliente:', msgError, 'recebido em:', new Date()
    return

  socket.on 'getuser', (user, callback)->
    cond = {cpf:user.cpf }
    cpfInicio = user.cpf
    ok = true
    msg = 'Usuario encontrado'
    Usuarios.findOne({cpf:user.cpf}).lean().exec (err, usuario)->
      if err
        ok = false
        msg = 'Ocorreu um erro ao consultar o usuário!'
        return callback {ok:ok, msg:msg, user:null}
      if not usuario
        ok = false
        msg = "usuario nao encontrado"
        return callback {ok:ok, msg:msg, user: null}
      if usuario.cpf isnt cpfInicio
        ok = false
        console.log err, 'erro', new Date(), usuario.cpf, cpfInicio
        msg = 'Ocorreu um erro ao salvar o seu cadastro, cpf em conflito na transação'
        return callback {ok:ok, msg:msg, user: null}
      obtemOfertasByUser usuario, msg, (objRetorno)->
        return callback objRetorno

  socket.on 'respondeu', (resposta, callback, callback2)->
    incluiResposta resposta, (err, respo)->
      if callback2 then callback2 respo else callback respo

  socket.on 'monitorou', (resposta, callback)->
    incluiRespostaMonitoramento resposta, (err, respo)->
      callback respo

  socket.on 'desmonitorou', (resposta, callback)->
    Monitoramentos.remove {id: resposta}, (err, respo)->
      callback {ok:!err}

  socket.on 'respostas', (query, callback)->
    # console.log query, 'respostas validas', query.modulo
    respostas_validas query.user, query.modulo, (validas)->
      callback
        ok: yes
        respostas: validas

  socket.on 'monitoramentos', (query, callback)->
    # console.log query, 'respostas validas', query.modulo
    Monitoramentos.find({'user': query.user}).exec (err, monitoramentos)->
      if err
        ok = false
        msg = "Erro ao consultar dados de monitoramentos!"
        return callback({ok:ok, msg:msg, user: null})
      callback
        ok: yes
        monitoramentos: monitoramentos

  socket.on 'respostas:rebuild', (respostas, callback)->
    # console.log respostas, 'respostas: rebuild', callback
    async.map respostas, incluiResposta, (err, data)->
      # console.log 'final das inclusoes de respostas', err, data
      callback({ok:!err, respostas:data})

  socket.on 'userEnquete', (param, callback)->
    self = @
    ok = false
    cpfInicio = param.cpf
    if not cpfInicio
      return callback {ok:false, msg: 'Cpf não informado', user: null}

    ok = true
    msg = 'O cadastro foi atualizado com sucesso!'

    flag = 'update-enquete'
    # console.log param, 'param posted'
    # console.log especifico
    Usuarios.findOne({cpf:cpfInicio}).exec (err, usuario)->
      if err
        ok = false
        msg = "Erro ao verificar existencia de usuario"
        return callback {ok:false, msg: msg, user: null}
      if not usuario
        ok = false
        msg = 'Somente usuarios dos módulos de autoaprendizagem podem responder as enquetes!'
        return callback {ok:false, msg: msg, user: null}
      usuario.set 'enquetes', param.enquetes
      Usuarios.update {cpf:usuario.cpf}, {$set:{enquetes:param.enquetes}}, (err, numRows)->
        if err
          ok = false
          console.log err, 'erro'
          msg = 'Ocorreu um erro ao salvar o seu cadastro'
          return callback {ok, msg, user: null}
        if numRows
          callback {ok, msg, user: usuario}
        else
          msg = 'usuario não foi atualizado!'
          console.log 'error', msg
          ok = false
          callback {ok, msg, user: null}

  socket.on 'dashboard.surtos.g1', (query, callback)->
    rodaQueryDashboardSurtos query, callback, [
        "$group":
          "_id": "$gt": ["$dt_conclusao", null]
          count: "$sum": 1
    ]

  socket.on 'dashboard.surtos.g2', (query, callback)->
    rodaQueryDashboardSurtos query, callback, [
        "$project": "age": "$subtract": [
          { "$subtract": [new Date().getFullYear(), { "$year": "$birthday" }] },
          { "$cond": [{ "$lt": [{ "$dayOfYear": "$birthday" }, { "$dayOfYear": new Date() }] }, 0, 1] }
        ]
      ,
        "$project": "age": "$switch":
            branches: [
              { case: { "$lt": [ "$age", 20 ] }, then: "<20 anos" },
              { case: { "$lt": [ "$age", 30 ] }, then: "20 - 29 anos" },
              { case: { "$lt": [ "$age", 40 ] }, then: "30 - 39 anos" },
              { case: { "$lt": [ "$age", 50 ] }, then: "40 - 49 anos" },
              { case: { "$lt": [ "$age", 60 ] }, then: "50 - 59 anos" }
            ],
            default: "60 anos ou mais"
      ,
        "$group":
          "_id": "$age"
          name: "$first": "$age"
          y: "$sum": 1
    ]

  socket.on 'dashboard.surtos.g3', (query, callback)->
    rodaQueryDashboardSurtos query, callback, [
        "$project": "nucleo_profissional": "$switch":
            branches: [
              { case: { "$eq": [ "$usuario.nucleo_profissional", 0 ] }, then: "Outro"},
              { case: { "$eq": [ "$usuario.nucleo_profissional", "0" ] }, then: "Outro"},
              { case: { "$eq": [ "$usuario.nucleo_profissional", 1 ] }, then: "Enfermagem" },
              { case: { "$eq": [ "$usuario.nucleo_profissional", "1" ] }, then: "Enfermagem" },
              { case: { "$eq": [ "$usuario.nucleo_profissional", 2 ] }, then: "Medicina" },
              { case: { "$eq": [ "$usuario.nucleo_profissional", "2" ] }, then: "Medicina" },
              { case: { "$eq": [ "$usuario.nucleo_profissional", 3 ] }, then: "Odontologia" },
              { case: { "$eq": [ "$usuario.nucleo_profissional", "3" ] }, then: "Odontologia" },
            ],
            default: "$usuario.nucleo_profissional"
      ,
        "$group":
          "_id": "$nucleo_profissional"
          name: "$first": "$nucleo_profissional"
          y: "$sum": 1
    ]

  socket.on 'dashboard.surtos.g4', (query, callback)->
    rodaQueryDashboardSurtos query, callback, [
          "$project": "uf": "$switch":
            branches: [
              { case: { "$eq": ["$usuario.uf", "AC"] }, then: "Acre"}
              { case: { "$eq": ["$usuario.uf", "AL"] }, then: "Alagoas"}
              { case: { "$eq": ["$usuario.uf", "AP"] }, then: "Amapá"}
              { case: { "$eq": ["$usuario.uf", "AM"] }, then: "Amazonas"}
              { case: { "$eq": ["$usuario.uf", "BA"] }, then: "Bahia"}
              { case: { "$eq": ["$usuario.uf", "CE"] }, then: "Ceará"}
              { case: { "$eq": ["$usuario.uf", "DF"] }, then: "Distrito Federal"}
              { case: { "$eq": ["$usuario.uf", "ES"] }, then: "Espírito Santo"}
              { case: { "$eq": ["$usuario.uf", "GO"] }, then: "Goiás"}
              { case: { "$eq": ["$usuario.uf", "MA"] }, then: "Maranhão"}
              { case: { "$eq": ["$usuario.uf", "MT"] }, then: "Mato Grosso"}
              { case: { "$eq": ["$usuario.uf", "MS"] }, then: "Mato Grosso do Sul"}
              { case: { "$eq": ["$usuario.uf", "MG"] }, then: "Minas Gerais"}
              { case: { "$eq": ["$usuario.uf", "PA"] }, then: "Pará"}
              { case: { "$eq": ["$usuario.uf", "PB"] }, then: "Paraíba"}
              { case: { "$eq": ["$usuario.uf", "PR"] }, then: "Paraná"}
              { case: { "$eq": ["$usuario.uf", "PE"] }, then: "Pernambuco"}
              { case: { "$eq": ["$usuario.uf", "PI"] }, then: "Piauí"}
              { case: { "$eq": ["$usuario.uf", "RJ"] }, then: "Rio de Janeiro"}
              { case: { "$eq": ["$usuario.uf", "RN"] }, then: "Rio Grande do Norte"}
              { case: { "$eq": ["$usuario.uf", "RS"] }, then: "Rio Grande do Sul"}
              { case: { "$eq": ["$usuario.uf", "RO"] }, then: "Rondônia"}
              { case: { "$eq": ["$usuario.uf", "RR"] }, then: "Roraima"}
              { case: { "$eq": ["$usuario.uf", "SC"] }, then: "Santa Catarina"}
              { case: { "$eq": ["$usuario.uf", "SP"] }, then: "São Paulo"}
              { case: { "$eq": ["$usuario.uf", "SE"] }, then: "Sergipe"}
              { case: { "$eq": ["$usuario.uf", "TO"] }, then: "Tocantins"}
            ],
            default: "Estado nao reconhecido"
        ,
          "$group":
            "_id": "$uf"
            name: "$first": "$uf"
            y: "$sum": 1
    ]

  socket.on 'dashboard.surtos.g5', (query, callback)->
    rodaQueryDashboardSurtos query, callback, [
        "$project": "raca_cor": "$switch":
            branches: [
              { case: { "$eq": [ "$usuario.alt_raca_cor", "Branco" ] }, then: "Branco"}
              { case: { "$eq": [ "$usuario.alt_raca_cor", "Preto" ] }, then: "Preto" },
              { case: { "$eq": [ "$usuario.alt_raca_cor", "Pardo" ] }, then: "Pardo" },
              { case: { "$eq": [ "$usuario.alt_raca_cor", "Amarelo" ] }, then: "Amarelo" },
              { case: { "$eq": [ "$usuario.alt_raca_cor", "Indígena" ] }, then: "Indígena" },
            ],
            default: "Não respondeu"
      ,
        "$group":
          "_id": "$raca_cor"
          name: "$first": "$raca_cor"
          y: "$sum": 1
    ]

  socket.on 'dashboard.surtos.g6', (query, callback)->
    rodaQueryDashboardSurtos query, callback, [
        "$project": "genero": "$switch":
            branches: [
              { case: { "$eq": [ "$usuario.alt_genero", "F" ] }, then: "Feminino"}
              { case: { "$eq": [ "$usuario.alt_genero", "M" ] }, then: "Masculino" },
              { case: { "$eq": [ "$usuario.alt_genero", "N" ] }, then: "Não-binário" },
              { case: { "$eq": [ "$usuario.alt_genero", "O" ] }, then: "Auto-identificado como outro gênero" },
              { case: { "$eq": [ "$usuario.alt_genero", "R" ] }, then: "Prefiro não responder" },
            ],
            default: "Prefiro não responder"
      ,
        "$group":
          "_id": "$genero"
          name: "$first": "$genero"
          y: "$sum": 1
    ]

  socket.on 'dashboard.surtos.g7', (query, callback)->
    rodaQueryDashboardSurtos query, callback, [
        "$project": "profissao": "$switch":
            branches: [
              { case: { "$eq": [ "$usuario.alt_profissao", "Profissional" ] }, then: "Trabalhador"},
              { case: { "$eq": [ "$usuario.alt_profissao", "Estudante" ] },    then: "Estudante"}
            ],
            default: "Não respondeu"
      ,
        "$group":
          "_id": "$profissao"
          name: "$first": "$profissao"
          y: "$sum": 1
    ]

  socket.on 'dashboard.surtos.g8', (query, callback)->
    rodaQueryDashboardSurtos query, callback, [
        "$match": "usuario.alt_profissao": "Profissional"
      ,
        "$project": "tempo_setor_saude": "$switch":
            branches: [
              { case: { "$lte": [ {"$toDouble": "$usuario.alt_tempo_profissao"}, 2] }, then: "<2 anos"},
              { case: { "$lte": [ {"$toDouble": "$usuario.alt_tempo_profissao"}, 4] }, then: "2 - 4 anos"},
              { case: { "$lte": [ {"$toDouble": "$usuario.alt_tempo_profissao"}, 9] }, then: "5 - 9 anos"},
              { case: { "$lte": [ {"$toDouble": "$usuario.alt_tempo_profissao"}, 19] }, then: "10 - 19 anos"},
              { case: { "$gt":  [ {"$toDouble": "$usuario.alt_tempo_profissao"}, 19] }, then: "20 anos ou mais"}
            ],
            default: "Problema convertendo para número"
      ,
        "$group":
          "_id": "$tempo_setor_saude"
          name: "$first": "$tempo_setor_saude"
          y: "$sum": 1
    ]

  socket.on 'dashboard.surtos.g9', (query, callback)->
    rodaQueryDashboardSurtos query, callback, [
        "$group":
          "_id": "$usuario.alt_qual_profissao"
          name: "$first": "$usuario.alt_qual_profissao"
          y: "$sum": 1
    ]

  socket.on 'dashboard.surtos.g10', (query, callback)->
    rodaQueryDashboardSurtos query, callback, [
         "$project": "values": [
            {"name": "Em ambulatório especializado", "value": "$usuario.alt_atua_ambulatorio_especializado"},
            {"name": "Na atenção básica", "value": "$usuario.alt_atua_atencao_basica"},
            {"name": "No setor de saúde filantrópico", "value": "$usuario.alt_atua_filantropico"},
            {"name": "Na gestão de saúde no SUS", "value": "$usuario.alt_atua_gestao_saude"},
            {"name": "Em Hospital/Serviço de Emergência", "value": "$usuario.alt_atua_hospital_emergencia"},
            {"name": "No SUS", "value": "$usuario.alt_atua_no_sus"},
            {"name": "Em pesquisa", "value": "$usuario.alt_atua_pesquisa"},
            {"name": "Em Unidade de Pronto Atendimento", "value": "$usuario.alt_atua_pronto_atendimento"},
            {"name": "No setor de saúde privado", "value": "$usuario.alt_atua_saude_privada"},
         ]
    ]

  socket.on 'dashboard.surtos.g11', (query, callback)->
    rodaQueryDashboardSurtos query, callback, [
        "$project": "atuou_vigilancia": "$switch":
            branches: [
              { case: { "$eq": [ "$usuario.alt_atuou_vigilancia_sus", "A"] }, then: "Sim, estou atuando"},
              { case: { "$eq": [ "$usuario.alt_atuou_vigilancia_sus", "S"] }, then: "Sim, atuei mas não atuo mais"},
              { case: { "$eq": [ "$usuario.alt_atuou_vigilancia_sus", "N"] }, then: "Não"},
            ],
            default: "Não respondeu"
      ,
        "$group":
          "_id": "$atuou_vigilancia"
          name: "$first": "$atuou_vigilancia"
          y: "$sum": 1
    ]

  socket.on 'dashboard.surtos.g12', (query, callback)->
    rodaQueryDashboardSurtos query, callback, [
        "$match": "usuario.alt_atuou_vigilancia_sus": "$in": ["S", "A"]
      ,
        "$project": "anos": "$switch":
            branches: [
              { case: { "$lte": [ {"$toDouble": "$usuario.alt_anos_vigilancia_sus"}, 2] }, then: "<2 anos"},
              { case: { "$lte": [ {"$toDouble": "$usuario.alt_anos_vigilancia_sus"}, 4] }, then: "2 - 4 anos"},
              { case: { "$lte": [ {"$toDouble": "$usuario.alt_anos_vigilancia_sus"}, 9] }, then: "5 - 9 anos"},
              { case: { "$lte": [ {"$toDouble": "$usuario.alt_anos_vigilancia_sus"}, 19] }, then: "10 - 19 anos"},
              { case: { "$gt":  [ {"$toDouble": "$usuario.alt_anos_vigilancia_sus"}, 19] }, then: "20 anos ou mais"}
            ],
            default: "Problema convertendo para número"
      ,
        "$group":
          "_id": "$anos"
          name: "$first": "$anos"
          y: "$sum": 1
    ]

  socket.on 'dashboard.surtos.g13', (query, callback)->
    rodaQueryDashboardSurtos query, callback, [
        "$project": "percent": "$switch":
            branches: [
              { case: { "$lt":  [ "$dashboard_percentProgresso", 10] }, then: "<10%"},
              { case: { "$lt":  [ "$dashboard_percentProgresso", 30] }, then: "10% - 29%"},
              { case: { "$lt":  [ "$dashboard_percentProgresso", 50] }, then: "30% - 49%"},
              { case: { "$lt":  [ "$dashboard_percentProgresso", 70] }, then: "50% - 69%"},
              { case: { "$gte": [ "$dashboard_percentProgresso", 70] }, then: "70% ou mais"}
            ],
            default: "$dashboard_percentProgresso"
      ,
        "$group":
          "_id": "$percent"
          name: "$first": "$percent"
          y: "$sum": 1
    ]

  socket.on 'dashboard.surtos.t1', (query, callback)->
    rodaQueryDashboardSurtos2 query, callback, [
      {"$project": {
          "profissional_de_enfermagem": {
              "$switch": {
                  branches: [
                      { case: { "$eq": [ "$usuario.nucleo_profissional", 1 ] }, then: 1 },
                      { case: { "$eq": [ "$usuario.nucleo_profissional", "1" ] }, then: 1 }
                  ],
                  default: 0
              }
          },
          "trabalha_ou_trabalhou_na_vigilancia_em_saude": {
              "$switch": {
                  branches: [
                      { case: { "$eq": [ "$usuario.alt_atuou_vigilancia_sus", "A" ] }, then: 1 },
                      { case: { "$eq": [ "$usuario.alt_atuou_vigilancia_sus", "S" ] }, then: 1 }
                  ],
                  default: 0
              }
          },
          "trabalha_atualmente_na_vigilancia_de_saude": {
              "$switch": {
                  branches: [{ case: { "$eq": [ "$usuario.alt_atuou_vigilancia_sus", "A" ] }, then: 1 }],
                  default: 0
              }
          },
          "trabalhou_no_passado_na_vigilancia_de_saude": {
              "$switch": {
                  branches: [{ case: { "$eq": [ "$usuario.alt_atuou_vigilancia_sus", "S" ] }, then: 1 }],
                  default: 0
              }
          },
          "agente_comunitario_da_area_de_saude": {
              "$switch": {
                  branches: [{ case: { "$eq": [ "$usuario.alt_qual_profissao", "Agente comunitário de saúde"] }, then: 1 }],
                  default: 0
              }
          },
          "agente_comunitario_de_endemia": {
              "$switch": {
                  branches: [{ case: { "$eq": [ "$usuario.alt_qual_profissao", "Agente comunitário de endemias"] }, then: 1 }],
                  default: 0
              }
          },
          "esta_certificado": {
              "$switch": {
                  branches: [{ case: { "$gt": ["$dt_conclusao", null] }, then: 1 }],
                  default: 0
              }
          },
      }}
    ]

  socket.on 'dashboard.calcProgresso', (cpf, idModulo, callback) ->
    dashboard_get_info_modulo idModulo, (modulo, casos, testes, atividades) ->
      todasQuestoes = _.map atividades, (a) ->
          _.filter a.slides, (s) -> /quest/img.test s.tipo
      escoreMaximo = (_.flatten todasQuestoes).length * 100

      Progressos.aggregate [
          "$match":
              ativo: true,
              user: cpf,
              modulo: new bson.ObjectId(idModulo)
        ,
          "$group":
              "_id": {atividade: "$atividade", seqid: "$seqid"},
              escore: {"$last": "$escore"} # Caso o db esteja inconsistente, pegar apenas o com ID maior.
        ,
          "$group":
              "_id": true,
              escore: {"$sum": "$escore"}
      ], (err, progressoUsuario) ->
        try
          percentConcluido = progressoUsuario[0].escore * 100 / escoreMaximo
        catch e
          percentConcluido = 0
        ofertasUsuarios.update {cpf: cpf, modulo: new bson.ObjectId(idModulo)}, {"$set": {dashboard_percentProgresso: percentConcluido}}, (err, progressos)->
          throw err if err
          callback(percentConcluido)

  socket.on 'temp.allUsers', (modulo, callback) ->
    ofertasUsuarios.find {modulo:modulo}, (err, usuarios) ->
      callback(usuarios)

dashboard_get_info_modulo = (idModulo, cb) ->
  Modulo.find {"_id": new bson.ObjectId(idModulo)}, (err, modulo) ->
    modulo = modulo[0]
    # Hidratando modulo.components (faz com que modulo.components.resource esteja setado).
    Modulo.externalResources idModulo, (err, hidratedComponents) ->
      modulo.components = hidratedComponents

      ret = dashboard_modulo_get_casos_e_testes modulo
      cb modulo, ret[0], ret[1], ret[2]

dashboard_modulo_get_casos_e_testes = (modulo) ->
  casos      = []
  testes     = []
  atividades = []
  components = []

  components = components.concat _.where(modulo.components, {folder: 'listatestes'})
  unidades   = modulo.components.filter (u)-> u.folder is 'unidade-progresso' and u.short isnt "Unidade extra"

  if unidades.length is 0
    components = components.concat _.where(modulo.components, {folder: 'selecao-progresso'})
    components = components.concat _.where(modulo.components, {folder: 'selecao-testes-progresso'})
    console.log 'unidades = 0, components = ', components
  else
    components = components.concat unidades

  for component in components
    if not component.resource
      break

    component.resource.casos.map (c)->
      if component.folder is 'listatestes'
        c.tipo = 'teste'
        c.posTeste = !(/inicial/img.test c.titulo)
        testes.push c
      if unidades.length > 0
        c.unidade = component.unidade if component.unidade
        if component.folder is 'unidade-progresso'
          c.tipo = if c.tipo then c.tipo else 'caso'
          casos.push c
      else
        if component.folder is 'selecao-progresso'
          c.tipo = 'caso'
          casos.push c
      atividades.push c
      c

  return [casos, testes, atividades]

rodaQueryDashboardSurtos2 = (query, callback, extra_aggregates) ->
  ofertasUsuarios.aggregate [
      "$lookup":
        from: "usuarios"
        localField: "cpf"
        foreignField: "cpf"
        as: "usuario"
    ,
      "$unwind": path: "$usuario"
    ,
      criaMatchDashboardSurtos(query)
    ,
      "$addFields": "birthday": "$convert":
        "input": "$concat": ["$usuario.dataNasc_ano", "-", "$usuario.dataNasc_mes", "-", "$usuario.dataNasc_dia"]
        "to": "date"
        "onError": null
    ,
      "$match": "birthday": "$ne": null
    ,
      extra_aggregates...
  ], (err, val)->
    callback { ok: true, msg: err, data: val }

rodaQueryDashboardSurtos = (query, callback, extra_aggregates) ->
  ofertasUsuarios.aggregate [
      "$lookup":
        from: "usuarios"
        localField: "cpf"
        foreignField: "cpf"
        as: "usuario"
    ,
      "$unwind": path: "$usuario"
    ,
      criaMatchDashboardSurtos(query)
    ,
      "$addFields": "birthday": "$convert":
        "input": "$concat": ["$usuario.dataNasc_ano", "-", "$usuario.dataNasc_mes", "-", "$usuario.dataNasc_dia"]
        "to": "date"
        "onError": null
    ,
      "$match": "birthday": "$ne": null
    ,
      extra_aggregates...
    ,
      "$sort": "y": -1
  ], (err, val)->
    callback { ok: true, msg: err, data: val }

criaMatchDashboardSurtos = (query) ->
  match = "$match": "$and": [
    {"modulo": new bson.ObjectId(query.modulo)},
    {"usuario.dataNasc_ano": /^[\s\S]{4,}$/},
    {"usuario.dataNasc_mes": {$in: ["1", "01", "2", "02", "3", "03", "4", "04", "5", "05", "6", "06", "7", "07", "8", "08", "9", "09", "10", "11", "12"]}},
    {"usuario.dataNasc_dia": {$in: [
        "1", "01", "2", "02", "3", "03", "4", "04", "5", "05", "6", "06", "7", "07", "8", "08", "9", "09",
        "10", "11", "12", "13", "14", "15", "16", "17", "18", "19",
        "20", "21", "22", "23", "24", "25", "26", "27", "28", "29",
        "30", "31",
    ]}}
  ]
  if query.id_arouca != ''
    match["$match"]["$and"].push id_arouca: query.id_arouca
  if query.inicio_inscricao != ''
    match["$match"]["$and"].push dt_cadastro: "$gte": new Date(query.inicio_inscricao)
  if query.fim_inscricao != ''
    match["$match"]["$and"].push dt_cadastro: "$lte": new Date(query.fim_inscricao)
  if query.inicio_certificacao != ''
    match["$match"]["$and"].push dt_conclusao: "$gte": new Date(query.inicio_certificacao)
  if query.fim_certificacao != ''
    match["$match"]["$and"].push dt_conclusao: "$lte": new Date(query.fim_certificacao)
  if query.inscritos == 'certificados'
    match["$match"]["$and"].push dt_conclusao: "$exists": true
  if query.profissao == 'estudante'
    match["$match"]["$and"].push "usuario.alt_profissao": "Estudante"
  if query.profissao == 'trabalhador'
    match["$match"]["$and"].push "usuario.alt_profissao": "Profissional"

  #if query.percent_min != '' and query.percent_max != ''
  #  match["$match"]["$and"].push "dashboard_percentProgresso": {"$gte": parseInt(query.percent_min), "$lte": parseInt(query.percent_max)}
  #else if query.percent_min != ''
  #  match["$match"]["$and"].push "dashboard_percentProgresso": {"$gte": parseInt(query.percent_min)}
  #else if query.percent_max != ''
  #  match["$match"]["$and"].push "dashboard_percentProgresso": {"$lte": parseInt(query.percent_max)}

  return match

incluiResposta = (resposta, next)->
  # console.log 'incluiResposta', resposta
  {_id} = resposta
  if _id
    return Progressos
    .findOne({$and:[{'_id': _id},{$or:[ {fl_certificado:{$exists:false} }, {fl_certificado:false}]}]})
    .exec (err, essa)->
      throw err if err
      if not essa
        return criaResposta(resposta, next)
      else
        delete resposta._id
        delete resposta.ativo
        if resposta.createdAt
          dt = new Date(resposta.createdAt)
          if isNaN(dt.getTime())
            resposta.createdAt = new Date(resposta.createdAt.split('.')[0])
        if resposta.updatedAt
          dt = new Date(resposta.updatedAt)
          if isNaN(dt.getTime())
            resposta.updatedAt = new Date(resposta.updatedAt.split('.')[0])
        Progressos.update {_id: _id}, {$set:resposta}, (err, progressos)->
          throw err if err
          next null, resposta
  else
    return criaResposta resposta, next

incluiRespostaMonitoramento = (resposta, next)->
  # console.log 'incluiResposta', resposta
  {_id} = resposta
  if _id
    return Monitoramentos
    .findOne({'_id': _id})
    .exec (err, essa)->
      throw err if err
      if not essa
        return criaRespostaMonitoramento(resposta, next)
      else
        delete resposta._id
        delete resposta.ativo
        if resposta.createdAt
          dt = new Date(resposta.createdAt)
          if isNaN(dt.getTime())
            resposta.createdAt = new Date(resposta.createdAt.split('.')[0])
        if resposta.updatedAt
          dt = new Date(resposta.updatedAt)
          if isNaN(dt.getTime())
            resposta.updatedAt = new Date(resposta.updatedAt.split('.')[0])
        Monitoramentos.update {_id: _id}, {$set:resposta}, (err, progressos)->
          throw err if err
          next null, resposta
  else
    return criaRespostaMonitoramento resposta, next

criaResposta = (resposta, cb)->
  q = atividade: resposta.atividade, user: resposta.user, ativo: true, seqid: resposta.seqid
  Progressos.update q, {$set:{'ativo': false}}, {multi:true}, (err, progressos)->
    throw err if err
    newProg = new Progressos resposta
    newProg.save (err)->
      ok = true
      throw err if err
      cb null, newProg

criaRespostaMonitoramento = (resposta, cb)->
  newProg = new Monitoramentos resposta
  newProg.save (err)->
    ok = true
    throw err if err
    cb null, newProg

getData = ()->
  dataIngresso = new Date()
  day = dataIngresso.getDate()
  if(day < 10)
    day = '0'+day
  month = dataIngresso.getMonth()+1
  month
  if(month < 10)
    month = '0'+month
  return day+'/'+month+'/'+dataIngresso.getFullYear()

obtemOfertasByUser = (usuario, msg, cb)->
  #console.log 'obtendo ofertas do usuario'
  ok = true
  ofertasUsuarios.find({cpf:usuario.cpf}).lean().exec (err, ofertasDoUser)->
    if err
      ok = false
      msg = "Erro ao recuperar as ofertas inscritas!"
      return cb({ok:ok, msg:msg, user: null})
    #console.log 'ofertas encontradas, verificando conclusoes', ofertasDoUser.length

    idsOfertas = ofertasDoUser.map (ou)-> ou.id_arouca
    Ofertas.find({id_arouca:{$in:idsOfertas}}).lean().exec (err, ofertas)->
      if err
        ok = false
        msg = "Erro ao recuperar as ofertas!"
        return cb({ok:ok, msg:msg, user: null})
      ofertasGroup = _.groupBy ofertas, 'id_arouca'
      #console.log 'verificando... mesclando ofertas', ofertasDoUser.length
      ofertasDoUser.map (ou)->
        if ofertasGroup[ou.id_arouca]
          og = ofertasGroup[ou.id_arouca][0]
        else
          return ou
        ou['conteudo'] = og['conteudo']
        ou['data_inicio'] = og['data_inicio']
        ou['data_fim'] = og['data_fim']
        ou['nome'] = og['nome']
      usuario.ofertas = ofertasDoUser
      #console.log 'ofertas setadas no usuario, retornando...'
      return cb({ok:ok, msg:msg, user: usuario})

syncUsuarioArouca = (usuario, param, callback) ->
  Arouca.Pessoa.exists { cpf: param.cpf }, (err, userAroucaExists, raw) ->
    if err
      console.log 'erro ao consultar pessoa na arouca', err
    console.log userAroucaExists, 'userAroucaExists ----------------------------'
    if userAroucaExists.cpf
      return callback(null, param, usuario)
    else
      sexo = if param.sexo == 'masculino' then 'M' else 'F'
      nPess =
        cpf: param.cpf
        nome: param.nome
        nomeMae: param.nomeMae
        email: param.email
        sexo: sexo
        dataNascimento: param.dataNasc_dia + '/' + param.dataNasc_mes + '/' + param.dataNasc_ano
        municipio: param.municipio
      # return callback(null, param, usuario)
      # console.log nPess, 'pessoa para arouca create'
      Arouca.Pessoa.create nPess, (err, retorno, raw) ->
        if retorno['msgError'] or err
          console.log 'ERRO:', retorno['msgError'], err
          ok = false
          msg = retorno['msgError']
          return callback msg, null, null
        console.log retorno, 'retorno'
        return callback(null, param, usuario)
        #   async.map ofertasUsuario, syncUsuarioArouca, callback

resolveOfertas = (usuario, param, callback)->
  self = this
  usuarioTmp = usuario
  # console.log 'ofertas', param.ofertas
  ofertasUser = []
  ofertasUser = param.ofertas if param.ofertas
  ofertasUser = ofertasUser.filter (o)-> o.conteudo

  # console.log ofertasUser, "ofertasUsuarios"
  ids_arouca = ofertasUser.map (o)-> o.id_arouca
  conteudos = ofertasUser.map (o)-> o.conteudo

  hoje = new Date()
  cond = [{modulo:param.modulo},{data_inicio:{$lt:hoje}},{data_fim_matricula:{$gt:hoje}}, {conteudo:{$in:conteudos}},{conteudo:{$exists:true}}]
  # cond = [{modulo:modulo},{data_inicio:{$lt:hoje}},{data_fim_matricula:{$gt:hoje}}, {id_arouca:{$in:ids_arouca}}];
  # console.log cond, "cond"
  Ofertas.find({$and:cond}).sort({data_inicio:-1}).lean().exec (err, ofertas)->
    if err
      ok = false
      console.log err, 'erro'
      msg = 'Ocorreu um erro ao salvar o seu cadastro'
      return callback {ok, msg, user: null}
    if ofertas.length is 0
      ok = false
      msg = 'Não existe nenhuma oferta aberta para este módulo!'
      resp = {ok:ok, msg:msg, user: null}
      return callback {ok, msg, user: null}

    ofertasUserAbertas = ofertas.filter (o)->
      o.data_inicio >= hoje and hoje <= o.data_fim_matricula and ids_arouca.indexOf(o.id_arouca) > -1

    aVincular = ofertas
    if ofertasUserAbertas.length > 0
      aVincular = ofertasUserAbertas

    vinculaUmaOferta = (uma, callback)->
      Ofertas.find({modulo:uma.modulo, conteudo:uma.conteudo }).exec (err, ofertas)->
        if err
          return callback {ok:false, msg:err, user:null}
        ids_ofertas = ofertas.map (o)-> return o.id_arouca
        ofertasById_arouca = _.groupBy(ofertas, 'id_arouca')

        ofertasUsuarios.findOne({$and:[{dt_conclusao:{$exists:true}}, {cpf:uma.cpf}, {id_arouca:{$in:ids_ofertas}}] }).lean().exec (err, concluida)->
          if err
            return callback {ok:false, msg:err, user:null}
          # console.log(usuario, "cadastro", concluida);
          # concluida = false
          if concluida
            aux = ofertasById_arouca[concluida.id_arouca]
            if aux
              aux = aux[0]
            concluida['conteudo'] = aux['conteudo']
            # console.log(ofertasById_arouca[concluida.id_arouca][0], ofertasById_arouca[concluida.id_arouca][0].conteudo , 'concluida.id_arouca')
            if concluida.url_certificado
              return callback err, concluida
            else
              dt_conclusao = dd_mm_aaaa(new Date(concluida.dt_conclusao))
              requisitar.post {url:'http://dms.ufpel.edu.br/apiarouca/index.php', form: {'metodo': 'recuperarCertificadoConcluinte', 'cpf': concluida.cpf, idOferta:concluida.id_arouca, dataConclusao:dt_conclusao}}, (err,httpResponse,body)->
                if err
                  console.log err
                  return callback null, concluida
                else
                  console.log concluida, JSON.parse(body).url, 'retorno', JSON.parse(body)
                  if JSON.parse(body).url
                    concluida.url_certificado = JSON.parse(body).url
                    ofertasUsuarios.update {_id:concluida._id}, {$set:{url_certificado: concluida.url_certificado }}, (err)->
                      if err
                        console.log err
                      return callback err, concluida
                return callback null, concluida
          else
            ofertasUsuarios.findOne({id_arouca: uma.id_arouca, cpf: uma.cpf}).exec (err, uO)->
              if err
                return callback err, null
              if not uO
                uO = new ofertasUsuarios {id_arouca: uma.id_arouca, cpf:uma.cpf, modulo: uma.modulo, dt_cadastro:new Date(),  'fl_ingresso_arouca':false, 'fl_cadastro_completo':false}
              uO.set 'dt_atualizacao': new Date()
              uO.save (err)->
                if err
                  return callback err, uma
                MonitoraServico.findOne({name:'arouca'}).exec (err, s)->
                  if err or not s.get('online')
                    return callback err, uma 
                  else
                    ingressante =
                      cpf: uO.cpf
                      idOferta: parseInt(uO.id_arouca)
                      dataIngresso: getData()
                    Arouca.Oferta.ingressa ingressante, (err, retorno, raw) ->
                      if err or retorno['msgError']
                        console.log 'erro', retorno['msgError'], err
                        return callback err, uma
                      console.log retorno, 'retorno uma oferta', ingressante
                      uO.set 'fl_ingresso_arouca', true
                      uO.set 'fl_cadastro_completo', true
                      uO.save (err)->
                        return callback err, uma

    f_vinculares = []
    aVincular = aVincular.map (o)->
      {_id:o._id, id_arouca: o.id_arouca, cpf: usuarioTmp.cpf, modulo: o.modulo, conteudo: o.conteudo}
    # console.log aVincular, 'aVincular'
    async.map aVincular, vinculaUmaOferta, (err, ofertasVinculadas)->
      # console.log ofertasVinculadas.length, 'ofertasVinculadas'
      if err
        console.log err, 'error'
        ok = false
        msg = 'Ocorreu um erro ao salvar oferta do seu cadastro'
        return callback {ok, msg, user: null}

      concluidas = ofertasVinculadas.filter (ofv)->
        if ofv.dt_conclusao
          if ofv.url_certificado
            return true
          else
            ofv.url_certificado = 'https://www.unasus.gov.br/'
            return true
        return false

      # if concluidas.length is ofertasVinculadas.length
      #   return callback {ok:false, msg:'Você não pode se cadastrar pois já foi certificado nesse módulo em outra oferta!', certificado: concluidas, user:null}

      Usuarios.findOne {cpf:ofertasVinculadas[0].cpf}, (err, usuarioTmpFim)->
        if err
          resp = {ok:false, msg:'Erro ao cadastrar este usuário.', user: null}
          console.log resp, err
          return callback resp

        ofertas = usuarioTmpFim.ofertas
        ofertas = ofertas.concat ofertasVinculadas.map (ox)-> ox._id

        usuarioTmpFim.set 'ofertas', _.uniq(ofertas, (o)-> JSON.stringify(o))

        # console.log 'ofertasNewUser', usuarioTmpFim.ofertas

        usuarioTmpFim.save (err)->
          if err
            resp = {ok:false, msg:'Erro ao cadastrar este usuário.', user: null}
            console.log resp, err
            return callback resp

          # usuarioTmpFim.set 'ofertas', ofertasVinculadas
          # console.log 'verificar ofertas do user', usuarioTmpFim.cpf
          obtemOfertasByUser usuarioTmpFim, 'Usuário cadastrado com sucesso!', (resp)->
            # console.log 'tudo certo, para o socket', resp
            return callback resp

          # return syncUsuarioArouca self, self.usuario, aVincular, callback
          # console.log resp, 'fim'
          # return callback resp

# ---
# generated by js2coffee 2.2.0
module.exports = routes


