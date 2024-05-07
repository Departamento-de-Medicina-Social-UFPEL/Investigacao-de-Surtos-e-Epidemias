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
ncp.limit = 16;

# gerador de JSON binario
BSON = require 'bson'
console.log(BSON.BSON, '=======bson=======')

# model de 'caso' do mongoose (mongo: ccurepo.casos)
Caso = require '../models/caso.coffee'

# script q faz levantamento da bibliografia de uma caso
gatherBiblio = require './gatherBiblio.coffee'
# script q levanta imagens de um caso
gatherImg = require './gatherImg.coffee'

# script que morfa um caso em um
# obj padrao se_unasus_pack.json
makePpuConfigObj = require './makePpuConfigObjCaso.coffee'

# script que morfa um caso em um
# obj temporário na forma de um módulo da casca
# super-gêmeos feelings
makeModuloCaso = require './makeModuloCaso.coffee'

###
vars globais
###
# folder public da app
path = require('path')
pub = '../../public'
pub = path.resolve(__dirname, pub)
ns = ''
# path do build/template de JS+CSS da app da casca
# esse script aceita --build pasta/ como argumento
# para usar um build diferente
# a pasta deve conter /js e /css da app
# o build é gerado com o gulp e está descrito em ...casca/gulpfile.coffee
# $ gulp build-all --spec build/ppu-caso-unico.spec.json --out ppu/template
# roda uma vez só e em um momento anterior a execução desse script
# só rodar quando tiver alterado alguma coisa 
# nos componentes ou no app base da casca
cascaBuildFolder = "#{pub}/ppu/template"

# folder destino da pasta que esse script vai gerar
# aceita --dest pasta/ como argumento
# PPUsRootFolder =  argv['dest'] or "#{pub}/ppu"

# aceita --dest pasta/ 
PPUsRootFolder = "#{pub}/ppu"

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

# recebe caso e retorna payload.bson
makePayload = (caso)->
  casoObj = caso.toJSON()
  casoObj._id = casoObj._id.toString()
  # console.log casoObj
  modulo = makeModuloCaso casoObj
  return BSON.serialize modulo, no, yes, no

###
#  
#   ROTINA PRINCIPAL
#  
###

module.exports = (caso, callback)->
  # monta o objeto:
  # que vai no se_unasus_pack.json
  ppuConfigObj = makePpuConfigObj caso
  # que vai no payload.bson
  payloadBson = makePayload caso
  p = ppuConfigObj.Persistence
  # console.log ppuConfigObj ,"ppuConfigObj"
  # monta o namespace pra nomear a pasta
  ns = "#{p.InstitutionAcronym}_#{p.Version}_#{p.Name}"
  # path da pasta desse ppu
  folder = "#{PPUsRootFolder}/#{ns}"

  # inicia o levantamento de imagens deste caso
  # última instrução da func, faz a magica de baixar as bibs
  # o fluxo continua no callback dela, (biblios) -> ...
  gatherBiblio caso, (err, biblios) ->
    return callback(err) if err
    # --- aqui biblios já é um array de objetos file que o 'fs' retorna
    # levanta as imagens do caso
    gatherImg caso, (err, imagens)->
      return callback(err) if err 
      # --- imagens tbm é um array de objetos file
      # opcao de filtro pro ncp copiar 
      # apenas as imagens
      options =
        filter: (fn) ->
          bad = /bib\/|img\/|css\/|require\.js|payload\.json|list\.txt/img.test fn
          imgException = /img\/marcas(.|\n)*?/img.test fn
          cssException = /css\/style.css/img.test fn
          # console.log fn, not bad, imgException
          return true if imgException or cssException
          not bad
        # para não sobreescrever
        # clobber: false

      # mostra o build original e a pasta destino
      console.log cascaBuildFolder, folder

      # executa a copia do build da casca pro destino
      ncp cascaBuildFolder, folder, options, (err)->
        return callback(err) if err 

        # paths dos principais arquivos na
        # nova pasta criada na cópia
        indexPath = "#{folder}/index.html"
        payloadPath = "#{folder}/payload.bson"
        ppuConfigPath = "#{folder}/se_unasus_pack.json"

        # le o index e segue pro copiaImg, não tranca
        fs.readFile indexPath, "utf-8", (e, indexFile) ->
          console.log e,'error readFile'
          return callback(e) if e
          # faz as substituições usando (global 'change' declarada no início do arquivo)
          indexFile = indexFile.replace change.title.regex, change.title.with caso.titulo
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
        
              # iterador para copiar img do caso e colocar na pasta detino
              # de /static/bib -> ./img na pasta destino
              copiaImg = (arquivo, nexta) ->
                dest = "#{folder}/#{arquivo.filename}"
                try
                  fs.createReadStream arquivo.pathname
                  .pipe fs.createWriteStream dest
                  .on 'finish', ()->
                    return nexta()
                    # console.log arguments, "salva Img: #{dest}"
                  .on 'error', (err)->
                    console.log err, 'error'
                    return nexta(err) if err
                catch err
                  throw "Erro ao copiar imagem: "+ arquivo.pathname 

              # iterador para copiar bibliografias levantadas
              # de /static/bib -> ./bib na pasta destino
              copiaBib = (bib, nexto) ->
                # console.log bib, 'bib PPU !!!!!!!!!!'
                # console.log nexto, 'NEXTOOOO PPU'
                dest = "#{folder}/bib/#{bib.filename}"
                origin = bib.pathname
                try
                  fs.createReadStream origin
                  .pipe fs.createWriteStream dest
                  .on 'finish', ()->
                    return nexto()
                  .on 'error', (err)->
                    return nexto(err)
                    # console.log bib, 'folderRRRRR' 
                    # console.log arguments, "salva Bib: #{dest}"
                catch err
                  throw "Erro ao copiar bibliografia: "+ bib.pathname 

              
              # chama o loop de imagens
              async.each imagens, copiaImg, (err)->
                console.log('copia das imagens terminou', err)
                return callback(err) if err
                async.each biblios, copiaBib, (err)->
                  console.log('copia das bibbs terminou', err)
                  return callback(err) if err
                  return callback(null) 

