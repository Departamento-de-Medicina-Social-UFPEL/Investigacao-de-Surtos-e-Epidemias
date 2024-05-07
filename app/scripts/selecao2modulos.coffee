


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

      id_selecao = '5811f906821f03096b458711'

      # rotina de montar um ppu de caso
      # arquivos
      #   - index.html:
      #     meta description
      #     title
      #

      findSelThan = (callback)->
        Selecao
        .findOne id_selecao
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
          # return prox null unless caso._id.toString().toLowerCase() is '514b002041e46f6039000000'
          ppuConfigObj = makePpuConfigObj caso
          payloadBson = makePayload caso
          p = ppuConfigObj.Persistence
          ns = "#{p.InstitutionAcronym}_#{p.Version}_#{p.Name}"
          folder = "#{ppusHomeFolder}/#{ns}"
          console.log caso.titulo
          gatherBiblio caso, (biblios) ->
            gatherImg caso, (imagens)->
              options =
                filter: (fn) ->
                  bad = /bib\/|img\/|css\/|require\.js|payload\.json|list\.txt/img.test fn
                  imgException = /img\/marcas(.|\n)*?/img.test fn
                  cssException = /css\/style.css/img.test fn
                  # console.log fn, not bad, imgException
                  return true if imgException or cssException
                  not bad
                # clobber: false

              console.log templateFolder, folder, options
              ncp templateFolder, folder, options, (err)->
                # console.log 'finish', arguments
                throw err if err
                indexPath = "#{folder}/index.html"
                payloadPath = "#{folder}/payload.bson"
                ppuConfigPath = "#{folder}/se_unasus_pack.json"

                fs.readFile indexPath, "utf-8", (e, indexFile) ->
                  indexFile = indexFile.replace change.title.regex, change.title.with caso.titulo
                  indexFile = indexFile.replace change.description.regex, change.description.with ppuConfigObj.Resource.Name
                  indexFile = indexFile.replace change.brand.regex, change.brand.with ppuConfigObj.Resource.Name
                  fs.writeFile indexPath, indexFile, (err)->
                    throw err if err
                    fs.writeFile payloadPath, payloadBson, (err)->
                      throw err if err
                      fs.writeFile ppuConfigPath, JSON.stringify(ppuConfigObj, '   '), (err)->
                        throw err if err


                copiaImg = (arquivo, nexta) ->
                  # console.log arquivo
                  dest = "#{folder}/#{arquivo.filename}"
                  fs.createReadStream arquivo.pathname
                  .pipe fs.createWriteStream dest
                  .on 'finish', ()->
                    # console.log arguments, "salva Img: #{dest}"

                copiaBib = (bib, nexto) ->
                  dest = "#{folder}/bib/#{bib.filename}"
                  fs.createReadStream bib.pathname
                  .pipe fs.createWriteStream dest
                  .on 'finish', ()->
                    # console.log arguments, "salva Bib: #{dest}"
                  
                terminouImagens = ->
                  async.each biblios, copiaBib, terminouBibs  

                terminouBibs = ->
                  try
                    return prox(null)

                async.each imagens, copiaImg, terminouImagens

        finito = -> process.exit 0
        async.each casos, fazUmCaso, finito















