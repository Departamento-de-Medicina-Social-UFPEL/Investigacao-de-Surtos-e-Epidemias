# lib pra pegar argumentos do script
# lib para gerar capas

# PDFImage = require("pdf-image").PDFImage
# https://www.npmjs.com/package/pdf-image
# sudo apt-get install imagemagick ghostscript poppler-utils
# lib para zipar pasta
# velhos conhecidos:
_ = require 'underscore'
async = require 'async'
fs = require 'fs'

# lib pra copia recursiva assín. ncp = node cp, o copy do unix
ncp = require 'ncp'
# limite de concorrencia
ncp.limit = 16

# gerador de JSON binario
BSON = require 'bson'
console.log(BSON.BSON, '=======bson=======')

# model de 'modulo' do mongoose (mongo: ccurepo.modulos)
# Caso = require '../models/modulo.coffee'
Modulo = require '../models/moduloModel.coffee'




# script que morfa um modulo em um
# obj temporário na forma de um módulo da casca
# super-gêmeos feelings
# makeModuloCaso = require './makeModuloCaso.coffee'
# makeModuloModulo = require './makeModuloModulo.coffee'

###
vars globais
###
# folder public da app
path = require('path')
pub = '../../public'
pub = path.resolve(__dirname, pub)
PPUsRootFolder = path.resolve(__dirname, '../../public/ppu/modulos/')
cascaBuildFolder = path.resolve(__dirname, "../../ppu/template_calculadoras")

ns = ''
# path do build/template de JS+CSS da app da casca
# esse script aceita --build pasta/ como argumento
# para usar um build diferente
# a pasta deve conter /js e /css da app
# o build é gerado com o gulp e está descrito em ...casca/gulpfile.coffee
# $ gulp build-all --spec build/ppu-modulo-unico.spec.json --out ppu/template
# roda uma vez só e em um momento anterior a execução desse script
# só rodar quando tiver alterado alguma coisa 
# nos componentes ou no app base da casca
# cascaBuildFolder = path.resolve(__dirname, "../../ppu/template_calculadoras")

# folder destino da pasta que esse script vai gerar
# aceita --dest pasta/ como argumento
# PPUsRootFolder =  argv['dest'] or "#{pub}/ppu"

# aceita --dest pasta/ 
# PPUsRootFolder = path.resolve(__dirname, '../../public/ppu/modulos/')
# script que morfa um modulo em um
# obj padrao se_unasus_pack.json
# makePpuConfigObj = require './makePpuConfigObjCaso.coffee'
# makePpuConfigObj = require './makePpuConfigObjCalculadora.coffee'
makePpuConfigObj = require './makePpuConfigObjModulo.coffee'

# script q faz levantamento da bibliografia de uma modulo
# gatherBiblio = require './gatherBiblio.coffee'
# script q levanta imagens de um modulo
gatherFilesExternalResorces = require './gatherFilesExternalResorces.coffee'



### funcoes auxiliares ###

# monta string de substituição
replacer = (str)-> "$1#{str}$3"

# dicionário de substituições a fazer
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

# recebe modulo e retorna payload.bson
makePayload = (modulo)->
  moduloObj = modulo.toJSON()
  moduloObj._id = moduloObj._id.toString()
  # console.log moduloObj
#   modulo = makeModuloCaso moduloObj
  return BSON.serialize modulo, no, yes, no

###
#  
#   ROTINA PRINCIPAL
#  
###

module.exports = (modulo, callback)->
  # monta o objeto:
  # que vai no se_unasus_pack.json
  ppuConfigObj = makePpuConfigObj modulo
  # console.log(modulo, ppuConfigObj, 'config')
  # que vai no payload.bson
  payloadBson = makePayload modulo
  p = ppuConfigObj.Persistence
  # console.log ppuConfigObj ,"ppuConfigObj"
  # monta o namespace pra nomear a pasta
  ns = "#{p.InstitutionAcronym}_#{p.Version}_#{p.Name}"
  # path da pasta desse ppu
  folder = "#{PPUsRootFolder}/#{ns}"
  processa = (err, files)=>
    console.log "plrocessa++++++++++++++++++++++++++++++++++++++++"
    return callback(err) if err 
    console.log cascaBuildFolder, folder
    options =
      filter: (fn) ->
        bad = /bib\/|img\/|css\/|require\.js|payload\.json|list\.txt/img.test fn
        imgException = /img\/marcas(.|\n)*?/img.test fn
        cssException = /css\/style.css/img.test fn
        # console.log fn, not bad, imgException
        return true if imgException or cssException
        not bad
    console.log "executa a copia do build da casca pro destino"
    ncp cascaBuildFolder, folder, {}, (err)->
      return callback(err) if err 
      # paths dos principais arquivos na
      # nova pasta criada na cópia
      indexPath = "#{folder}/index.html"
      payloadPath = "#{folder}/payload.bson"
      ppuConfigPath = "#{folder}/se_unasus_pack.json"

      console.log "le o index e segue pro copiaImg, não tranca"
      fs.readFile indexPath, "utf-8", (e, indexFile) ->
        console.log e,'error readFile'
        return callback(e) if e
        # faz as substituições usando (global 'change' declarada no início do arquivo)
        indexFile = indexFile.replace change.title.regex, change.title.with modulo.name
        # console.log indexFile, "INDEXFILE"
        indexFile = indexFile.replace change.description.regex, change.description.with ppuConfigObj.Resource.Name
        indexFile = indexFile.replace change.brand.regex, change.brand.with ppuConfigObj.Resource.Name
        # cascata de writes
        # escreve o index alterado no destino
        fs.writeFile indexPath, indexFile, (err)->
          return callback(err) if err
          # tudo ok? escreve o payload.bson no destino
          fs.writeFile payloadPath, payloadBson, (err)->
          return callback(err) if err
          # tudo ok? escreve o se_unasus_pack.json no destino
          ppuConfigStr = JSON.stringify(ppuConfigObj, null, 3) 
          fs.writeFile ppuConfigPath, ppuConfigStr, (err)->
            return callback(err) if err
            return callback(null) 
  # inicia o levantamento de imagens deste modulo
  gatherFilesExternalResorces modulo, processa, true