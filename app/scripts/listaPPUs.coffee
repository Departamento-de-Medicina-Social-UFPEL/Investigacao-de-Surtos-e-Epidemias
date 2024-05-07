


      Selecao = require '../models/selecao.coffee'

      _ = require 'underscore'
      fs = require 'fs'
      bson = require 'bson'
      BSON = new bson.BSONPure.BSON()
      pub = '/home/dev/test/casca/public'
      templateFolder = "#{pub}/ppu/template"
      ppusHomeFolder = "#{pub}/ppu"
      staticFS = "/home/dev/static/public"
      async = require 'async'
      ncp = require 'ncp'
      ncp.limit = 16;

      # rotina de montar um ppu de caso
      # arquivos
      #   - index.html:
      #     meta description
      #     title
      #

      findSelThan = (callback)->
        Selecao
        .findOne '50754b9eab52518fdd09adae'
        .populate 'casos'
        .exec (e, selecao) ->
          callback selecao

      replacer = (str)-> "$1#{str}$3"
      change =
        title:
          regex: /(<title>)(.*?)(<\/title>)/gim
          with: replacer
        description:
          regex: /(<meta name="description" content=")([^"]*?)(">)/gim
          with: replacer
        brand:
          regex: /(\[titulo\])/gim
          with: (str)-> "#{str}"


      makePpuConfigObj = require './makePpuConfigObjCaso.coffee'

      makePayload = (caso)->
        casoObj = caso.toJSON()
        casoObj._id = casoObj._id.toString()
        # console.log casoObj
        modulo = require('./makeModuloCaso.coffee')(casoObj)
        return BSON.serialize modulo, no, yes, no

      gatherBiblio = require './gatherBiblio.coffee'
      gatherImg = require './gatherImg.coffee'

      findSelThan (sel)->
        casos = sel.casos

        fazUmCaso = (caso, prox)->
          ppuConfigObj = makePpuConfigObj caso
          payloadBson = makePayload caso
          p = ppuConfigObj.Persistence
          ns = "#{p.InstitutionAcronym}_#{p.Version}_#{p.Name}"
          folder = "#{ppusHomeFolder}/#{ns}"
          console.log """
          #{num++}. #{caso.titulo}
          https://dms.ufpel.edu.br/casca/ppu/#{ns}

          """
        num = 1
        finito = -> process.exit 0
        async.each casos, fazUmCaso, finito















