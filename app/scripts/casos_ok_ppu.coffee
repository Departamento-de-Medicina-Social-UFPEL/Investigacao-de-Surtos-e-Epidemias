Caso = require '../models/caso.coffee'
Selecao = require '../models/selecao.coffee'
_ = require 'lodash'

Selecao.findOne('50754b9eab52518fdd09adae').populate('casos').lean().exec (err, selecao)->
  u = ["4f704354b852fbb6ad3a9a26", "4f18212ddfe4ca6404658fc9", "4f312c670dd744175dd0496f", "a3a767804f03ee13ab09bbf5", "502d3ab8993f0969ec735593", "50088e8581c33f6365ed012a", "503fbb3f680ffca7125d8e68", "5008159081c33f6365ed0128", "51d18c5c41e46f4325000000", "50a3e7f4ab52518fdd09adb7", "52dd207c41e46f8a7c000000", "3463ca004745920f9a61de3f", "51ee87de41e46fd575000000", "50bd1238ab52518fdd09adba", "50bd0093ab52518fdd09adb9", "51c1b5c741e46f411a000000", "4ed4d7872e38a6e9c32e6736", "4fce11c9eb6ccb07c202a4ed", "4f0c53382e38a6e9c32e6737", "503fc1d3680ffca7125d8e6a", "5153099241e46f755d000000", "51a359fd41e46f2105000000", "5152edfe41e46fe746000000", "51d2dad441e46f7048000000", "516e96e941e46f7445000000", "51dab7b341e46f7b44000000", "502d3b04993f0969ec735595", "501ae9d681c33f6365ed012c"]
  filtra = selecao.casos.filter (id)-> id._id.toString() not in u
  OKS = _.map(filtra, (obj)-> _.pick(obj, 'titulo', '_id', 'shortname'))

  for ok, k in OKS
    short = ok.shortname.toUpperCase().replace(/[^A-Z]*/img, '')
    console.log """
    #{k},"#{ok.titulo}",https://dms.ufpel.edu.br/casca/ppu/UFPEL_0001_CASO#{short}/
    """
