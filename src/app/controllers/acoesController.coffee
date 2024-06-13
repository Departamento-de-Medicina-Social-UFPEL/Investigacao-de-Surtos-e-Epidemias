locomotive = require 'locomotive'
Controller = locomotive.Controller
_ = require 'lodash'

Acoes = require '../models/acao'

class AcoesController extends Controller

  # lista acoes
  index: ()->
    # console.log 'AcoesController.index'
    @title = 'Caderno'
    @res.render 'criaAcao'

  # CRUD
  # mostra uma acao
  show: (id)->
    # console.log 'AcoesController.show'
    # @_acao criado no before:show
    if /json/.test @res.header['Accept']
      @res.json @_acao
    else
      @render

  # salva uma acao
  create: ()->
    self = @
    nova = new Acoes @req.body
    # console.log @req.body
    nova.set @req.body
    nova.save (err, doc) ->
      throw err if err
      # console.log doc
      self.res.json doc

  # atualiza uma acao
  update: (id)->
    self = @
    query = _id: id
    upsertData = '$set' : @req.body
    options = multi: false, upsert: true
    if !@_acao
      @res.json [
        '_id': id
        'ok': false
        'error': 'id não existe'
      ]
      return true
    Acoes.update query, upsertData, options, (err)->
      throw err if err
      self.res.json [
        '_id': id
        'ok': true
        'error': err
      ]

  # exclui uma acao
  delete: (id)->
    # console.log 'AcoesController.delete'
    @res.json { ok: true }

  # helpers pra entregar form de criação e edição
  new: ()->
    # console.log 'AcoesController.new'
    @res.send '<h1>deu certo</h1>', 200
  edit: ()->
    # console.log 'AcoesController.edit'
    @res.send '<h1>deu certo</h1>', 200


getAcaoById = (next)->
  self = @
  Acoes.findOne this.param('id'), (err, acao)->
    return next err if err
    self._acao = acao
    do next

acoesController = new AcoesController

acoesController.before 'show', getAcaoById
acoesController.before 'delete', getAcaoById

module.exports = acoesController
