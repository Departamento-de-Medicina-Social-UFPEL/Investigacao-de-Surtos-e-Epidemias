# lib pra pegar argumentos do script
# argv = require('yargs').argv
# ###
# confere se tem id, senão já sai
# ###      
# # pra começar tem que ter o _id do caso
# # aceita --id ou --oid ou --_id 50d82dc3ab52518fdd09adbc
# caso_id = argv.id or argv.oid or argv._id
# # retorna erro e finda se _id não é válido
# return (->
#   console.log '\n -!- _id de caso inválido -!- \n'
#   process.exit()
# )() unless /[0-9abcdef]{24}/img.test caso_id

###
libs externas
###
# velhos conhecidos:
_ = require 'underscore'
async = require 'async'
fs = require 'fs'

# lib pra copia recursiva assín. ncp = node cp, o copy do unix
ncp = require 'ncp'
# limite de concorrencia
ncp.limit = 16;

# gerador de JSON binario
bson = require 'bson'
BSON = new bson()
#.BSONPure.BSON()
###
libs locais
###
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
pub = '/home/dev/test/casca/public'

# path do build/template de JS+CSS da app da casca
# esse script aceita --build pasta/ como argumento
# para usar um build diferente
# a pasta deve conter /js e /css da app
# o build é gerado com o gulp e está descrito em ...casca/gulpfile.coffee
# $ gulp build-all --spec build/ppu-caso-unico.spec.json --out ppu/template
# roda uma vez só e em um momento anterior a execução desse script
# só rodar quando tiver alterado alguma coisa 
# nos componentes ou no app base da casca
# cascaBuildFolder = argv['build'] or "#{pub}/ppu/template"
cascaBuildFolder =  "#{pub}/ppu/template"

# folder destino da pasta que esse script vai gerar
# aceita --dest pasta/ como argumento
# PPUsRootFolder =  argv['dest'] or "#{pub}/ppu"

# aceita --dest pasta/ Gabriel
# PPUsRootFolder =  argv['dest'] or "#{pub}/ppu/gabriel"
PPUsRootFolder = "#{pub}/ppu/gabriel"

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
# declarada aqui mas executa na última linha do arquivo


# recebe um caso e monta um PPU
makePPUfromCaso = (caso, callback)->
    # monta o objeto:
    # que vai no se_unasus_pack.json
    ppuConfigObj = makePpuConfigObj caso
    # que vai no payload.bson
    payloadBson = makePayload caso
    p = ppuConfigObj.Persistence
    console.log ppuConfigObj ,"ppuConfigObj"
    # monta o namespace pra nomear a pasta
    ns = "#{p.InstitutionAcronym}_#{p.Version}_#{p.Name}"
    # path da pasta desse ppu
    folder = "#{PPUsRootFolder}/#{ns}"

    # inicia o levantamento de imagens deste caso
    # última instrução da func, faz a magica de baixar as bibs
    # o fluxo continua no callback dela, (biblios) -> ...
    gatherBiblio caso, (biblios) ->
      # --- aqui biblios já é um array de objetos file que o 'fs' retorna
      # levanta as imagens do caso
      gatherImg caso, (imagens)->
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
          # trava e mostra o erro se tiver
          throw err if err 

          # paths dos principais arquivos na
          # nova pasta criada na cópia
          indexPath = "#{folder}/index.html"
          payloadPath = "#{folder}/payload.bson"
          ppuConfigPath = "#{folder}/se_unasus_pack.json"

          # le o index e segue pro copiaImg, não tranca
          fs.readFile indexPath, "utf-8", (e, indexFile) ->
            # faz as substituições usando (global 'change' declarada no início do arquivo)
            indexFile = indexFile.replace change.title.regex, change.title.with caso.titulo
            # console.log indexFile, "INDEXFILE"
            indexFile = indexFile.replace change.description.regex, change.description.with ppuConfigObj.Resource.Name
            indexFile = indexFile.replace change.brand.regex, change.brand.with ppuConfigObj.Resource.Name
            # cascata de writes
            # escreve o index alterado no destino
            fs.writeFile indexPath, indexFile, (err)->
              throw err if err
              # tudo ok? escreve o payload.bson no destino
              fs.writeFile payloadPath, payloadBson, (err)->
                throw err if err
                # tudo ok? escreve o se_unasus_pack.json no destino
                ppuConfigStr = JSON.stringify(ppuConfigObj, null, 3) 
                fs.writeFile ppuConfigPath, ppuConfigStr, (err)->
                  throw err if err
          
                # iterador para copiar img do caso e colocar na pasta detino
                # de /static/bib -> ./img na pasta destino
                copiaImg = (arquivo, nexta) ->
                  dest = "#{folder}/#{arquivo.filename}"
                  fs.createReadStream arquivo.pathname
                  .pipe fs.createWriteStream dest
                  .on 'finish', ()->
                    do nexta
                    console.log arguments, "salva Img: #{dest}"

                # iterador para copiar bibliografias levantadas
                # de /static/bib -> ./bib na pasta destino
                copiaBib = (bib, nexto) ->
                  console.log bib, 'bib PPU !!!!!!!!!!', bib.filename
                  # console.log nexto, 'NEXTOOOO PPU'
                  dest = "#{folder}/bib/#{bib.filename}"
                  fs.exists dest, (existe)->
                    if existe
                      fs.createReadStream bib.pathname
                      .pipe fs.createWriteStream dest
                      .on 'finish', ()->
                        do nexto
                        console.log bib, 'folderRRRRR' 
                        console.log arguments, "salva Bib: #{dest}"
                    else
                      return callback({msg:"O arquivo #{dest} não existe!"})

                
                # quando termina o loop de bibliografias
                terminouBibs = ->
                  # tenta chamar o callback geral do makePPUfromCaso
                  try
                    return callback(null)

                # quando termina o loop de imagens
                terminouImagens = ->
                  # chama o loop de bilbiografias
                  async.each biblios, copiaBib, terminouBibs  

                # chama o loop de imagens
                async.each imagens, copiaImg, terminouImagens

module.exports = (caso_id, cb) ->
  # busca o caso 
  Caso.findOne _id: caso_id
  .exec (err, caso)->
    throw err if err
    # tudo certo? faz um PPU com o caso
    makePPUfromCaso caso, cb