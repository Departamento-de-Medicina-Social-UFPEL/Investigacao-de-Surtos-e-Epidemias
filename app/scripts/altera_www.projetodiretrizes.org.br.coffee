


      Selecao = require '../models/selecao.coffee'

      _ = require 'underscore'
      fs = require 'fs'
      bson = require 'bson'
      BSON = new bson.BSONPure.BSON()
      templateFolder = '/home/dev/test/casca/public/ppu/template'
      async = require 'async'

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

      findSelThan (sel)->
        casos = sel.casos
        for caso in casos
          bibs = caso.slides.filter((c)-> c.tipo is 'bibliografia')[0].conteudo
          biebers = bibs.filter((bib)-> /www\.projetodiretrizes\.org\.br/gim.test bib.urlExterno)
          if biebers.length > 0
            biebers.forEach (bib)->
              console.log """
              #{bib.linkTitulo}

              """
        # fs.readFile "#{templateFolder}/index.html", "utf-8", (e, file) ->
        #   file = file.replace change.title.regex, change.title.with 'Exemplo'
        #   file = file.replace change.description.regex, change.description.with 'Exemplo'
        #   console.log file[0...400]




        # process.exit 0



