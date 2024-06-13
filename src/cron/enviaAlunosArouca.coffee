Usuarios = require '../app/models/usuarios.coffee'
Progressos = require '../app/models/progressos.coffee'
Ofertas = require '../app/models/ofertas.coffee'
ofertasUsuarios = require '../app/models/ofertasUsuarios.coffee'
Arouca = require('/home/dev/casca/dependencias/arouca/php/js/index.js');
respostas_validas = require '/home/dev/casca/dependencias/arouca/app/scripts/progressos_validos.coffee'
async = require 'async'
_ = require 'underscore'



# ofertasUsuarios.find({$and:[{fl_ingresso_arouca:{$exists:false}},{dt_conclusao:{$exists:true}}]}).limit(300).exec (err, inscricoes)->
# , id_arouca:{$in:['417503', '417502', '417439', '417504', '417500', '417501', '417497', '417499']}
i = 0
isk = 500 * i;
fim = isk + 501;
ofertasUsuarios.find({$and:[
  {fl_cadastro_completo:{$exists:false}},
  {fl_ingresso_arouca:{$exists:false}},
  {id_arouca:'416496'}
  # {cpf:'11769116869'}
]
}).skip(isk).limit(fim).exec (err, inscricoes)->
# ofertasUsuarios.find({fl_ingresso_arouca:false}).limit(300).exec (err, inscricoes)->
# ofertasUsuarios.find({$and:[{cpf:'13206140609'}]}).limit(300).exec (err, inscricoes)->
  if err
    throw err

  iterador = (o, next)->
    Usuarios.findOne({cpf:o.cpf}).exec (e, u)->
      if e
        throw e
      syncUsuarioArouca u, o, next

  finalizador = (err)->
    if err
      throw err
    console.log 'fim'
  console.log 'inicio', inscricoes.length
  async.each inscricoes, iterador, finalizador
i = 1

getData = (data)->
  if not data
    dataIngresso = new Date()
  else
    dataIngresso = data
  day = dataIngresso.getDate()
  if(day < 10)
    day = '0'+day
  month = dataIngresso.getMonth()
  month++
  if(month < 10)
    month = '0'+month
  return day+'/'+month+'/'+dataIngresso.getFullYear()

syncUsuarioArouca = (user, ofertaUsuario, callback) ->
  console.log i++
  resp = 
    ok: true
    msg: 'Usuário cadastrado com sucesso!'
    user: user
    userOferta: ofertaUsuario
  ingressante = 
    cpf: user.cpf
    idOferta: parseInt(ofertaUsuario.id_arouca)
    dataIngresso: getData(ofertaUsuario.dt_cadastro)
  # if user.fl_cadastro_completo
  Arouca.Pessoa.exists { cpf: user.cpf }, (err, userAroucaExists, raw) ->
    if err
      console.log 'erro ao consultar pessoa na arouca', err
    # console.log userAroucaExists, 'userAroucaExists'
    if userAroucaExists.cpf
      Arouca.Oferta.ingressa ingressante, (err, retorno, raw) ->
        # if err or retorno['msgError']
        #   console.log 'error ingressa:', retorno['msgError'], err
          # console.log retorno['msgError']
        ofertaUsuario.set 'fl_ingresso_arouca', true
        ofertaUsuario.set 'fl_cadastro_completo', true
        ofertaUsuario.save (err, doc) ->
          if err
            console.log 'erro ao salvar local na arouca', ofertaUsuario, err
          return callback()
    else
      Usuarios.findOne({cpf:user.cpf}).lean().exec (err, user)->
        if err
          throw err
        if not user
          console.log('not user');
          return callback()

        sexo = if user.sexo == 'masculino' then 'M' else 'F'
        nPess = 
          cpf: user.cpf
          nome: user.nome
          nomeMae: user.nomeMae
          email: user.email
          sexo: sexo
          dataNascimento: user.dataNasc_dia + '/' + user.dataNasc_mes + '/' + user.dataNasc_ano
          municipio: user.municipio
          # municipio: user.ibge
        Arouca.Pessoa.create nPess, (err, retorno, raw) ->
          if retorno['msgError'] or err
            # if retorno['msgError'].indexOf('Ocorreu um erro ao cadastrarIngressante:Ingressante j\u00e1 cadastrado') is -1
            console.log 'ERRO:', retorno['msgError'], err
            return callback()
          Arouca.Oferta.ingressa ingressante, (err, retorno, raw) ->
            if err or retorno['msgError']
              console.log 'erro ao ingressarrrr', retorno['msgError'], err
              return callback()
            else
              ofertaUsuario.set 'fl_ingresso_arouca', true
              ofertaUsuario.set 'fl_cadastro_completo', true
              ofertaUsuario.save (err, doc) ->
                if err
                  console.log 'erro ao salvar na arouca local', ofertaUsuario, err
                return callback()
# else
  #   ofertaUsuario.set 'fl_ingresso_arouca', false
  #   ofertaUsuario.set 'fl_cadastro_completo', false
  #   ofertaUsuario.save (err, doc) ->
  #     if err
  #       console.log 'erro ao ingressar na arouca cadastro incompleto', ofertaUsuario, err
  #     console.log 'cadastro incompleto'
  #     return callback()
    
