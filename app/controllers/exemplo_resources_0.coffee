locomotive = require 'locomotive'
Controller = locomotive.Controller
_ = require 'lodash'

Acoes = require '../models/acao'

class AcoesController extends Controller

  # lista acoes
  index: ()->
    console.log 'AcoesController.index'
    @title = 'Caderno'
    @res.render 'criaAcao'

  # CRUD
  # mostra uma acao
  show: (id)->
    console.log 'AcoesController.show'
    # @_acao criado no before:show
    if /json/.test @res.header['Accept']
      @res.json @_acao
    else
      @render @_acao

  # salva uma acao
  create: ()->
    console.log 'AcoesController.create'
    self = @
    data = @req.body
    console.log data
    nova = new Acoes data
    nova.save (err, doc) ->
      throw err if err
      console.log doc
      self.res.json doc

  # atualiza uma acao
  update: (id)->
    query = _id: id
    upsertData = @req.body
    console.log upsertData
    options = multi: false
    Acoes.update query, upsertData, options, (err)->
      throw err if err
      @res.json [
        '_id': id,
        'error': err
      ]

  # exclui uma acao
  destroy: (id)->
    console.log 'AcoesController.delete'
    @res.send "<h1>#{id}</h1>", 200

  # helpers pra entregar form de criação e edição
  new: ()->
    console.log 'AcoesController.new'
    @res.send '<h1>deu certo</h1>', 200

  edit: ()->
    console.log 'AcoesController.edit'
    @res.send '<h1>deu certo</h1>', 200


getAcaoById = (next)->
  self = @
  Acoes.findOne this.param('id'), (err, acao)->
    return next err if err
    self._acao = acao
    do next

acoesController = new AcoesController

acoesController.before 'show', getAcaoById

module.exports = acoesController
