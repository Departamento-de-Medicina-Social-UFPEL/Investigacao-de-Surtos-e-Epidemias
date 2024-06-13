locomotive = require 'locomotive'
Controller = locomotive.Controller
_ = require 'lodash'
Casos = require '../models/casos.coffee'

class AcoesController extends Controller

  # lista acoes
  index: ()->
    # console.log 'AcoesController.index'
    console.log('acoes', this.req.body)
    self = this
    Casos.find({}).exec (err, casos)=>
        if err
            return self.res.json 500, {msg:'Erro ao consultar caso clinico'
        return self.res.json 200, casos




module.exports = AcoesController
