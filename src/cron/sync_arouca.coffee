Usuarios = require '../app/models/usuarios.coffee'
Usuarios = require '../app/models/usuarios.coffee'
Ofertas = require '../app/models/ofertas.coffee'
MonitoraServico = require '../app/models/monitora_arouca.coffee'
Arouca = require('/home/dev/casca/dependencias/arouca/index.js')
_async = require 'async'
_ = require 'underscore'

requisitar = require('request')
dd_mm_aaaa = (date) ->
  d = date.getDate(); m = date.getMonth(); a = date.getFullYear()
  "#{if d > 9 then d else '0'+d}/#{if m > 8 then m+1 else '0'+(m+1)}/#{a}"

sincronizaUser = (user, next)=>
    # console.log especifico
  cpf = user.cpf
  Usuarios.find({cpf:cpf}).exec (err, usuarios)->
    if err
      ok = false
      msg = "Erro ao verificar existencia de usuario"
      return next {ok, msg, user: null}
    console.log 'sincronizando arouca'
    return syncUsuarioArouca usuario, param, (err, param, usuario)-> 
      if err
        return next {ok:false, msg:err, user:null}
      if usuario.cpf isnt cpfInicio
        ok = false
        console.log err, 'erro', new Date(), usuario.cpf, cpfInicio
        msg = 'Ocorreu um erro ao salvar o seu cadastro, cpf em conflito na transação'
        return next {ok, msg, user: null}
      console.log 'resolvendo ofertas'
      return resolveOfertas(usuario, param, callback)

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
      console.log nPess, 'pessoa para arouca create'
      Arouca.Pessoa.create nPess, (err, retorno, raw) ->
        if retorno['msgError'] or err
          console.log 'ERRO:', retorno['msgError'], err
          ok = false
          msg = retorno['msgError']
          return callback msg, null, null
        console.log retorno, 'retorno'
        return callback(null, param, usuario)
        # _async.map ofertasUsuario, syncUsuarioArouca, callback 

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
    _async.map aVincular, vinculaUmaOferta, (err, ofertasVinculadas)->
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

run = ()->
  console.log('run', new Date())
  MonitoraServico.findOne({name:'arouca'}).exec (err, s)->
    if err
      console.log 'erro ao consultar situacao local do servico arouca', err
      throw err
    if not s 
      s = new MonitoraServico()
      s.set('name', 'arouca')
    Arouca.Pessoa.onOnline { cpf: '02607963010' }, (err, userAroucaExists, raw) ->
      if err
        s.set('online', false)
        console.log("Arouca offiline", s)
      else
        s.set('online', true)
        console.log("Arouca online", s)
      s.save (err)->
        if err
          throw err
        if not s.get('online')
          process.exit -1
          return
        Usuarios.find({fl_ingresso_arouca:false}).limit(100).exec (err, users)->
          if(err)
            throw err
          _async.map users, sincronizaUser, (err, usersSincronizeds)->
            if(err)
              console.log err, 'error'
              ok = false
              msg = 'Ocorreu um erro ao syncronizar o usuário na arouca'
              return callback {ok, msg, users: null}
            return callback {ok:true, msg:'ok', users: usersSincronizeds}

run()