locomotive = require 'locomotive'
Controller = locomotive.Controller
_ = require 'lodash'
async = require 'async'
fs = require('fs')
PDFImage = require("pdf-image").PDFImage
zipFolder = require('zip-folder')
ZIP = new require('node-zip')()
Casos = require '../models/caso.coffee'
PPUsRootFolderCreate = '/tmp/ppus'
path = require('path')
PPUsRootFolder = path.resolve(__dirname, '../../public/ppu')
makePPUfromCaso = require '../scripts/ppucomcapa.coffee'
repo = path.resolve(__dirname,'../templates/')
jasper = require('node-jasper')(optionsReport = {
  path: '../scripts/jasperreports-6.0.0/',
  reports: {
    # // Report Definition
    "capappu": {
      jasper: repo + '/capasppu.jasper', #Path to jasper file,
      jrxml: repo + '/capasppu.jrxml', #Path to jrxml file,
      conn: 'in_memory_json'
    },
  }
})

class CasosController extends Controller
  getFolder:(caso, zip = false)->
    short = "caso-#{caso.shortname}"
    namespace = short.toUpperCase().replace /[^A-Z]*/img, ''
    ns = "UFPEL_0001_#{namespace}"
    if not zip
      folder = "#{PPUsRootFolder}/#{ns}"
    else
      folder = "#{PPUsRootFolder}/#{ns}.zip"
    folder

  # lista acoes
  index: ()->
    self = this
    Casos.find({titulo:{$ne:""}},{_id:1, shortname:1, titulo:1, id:1, editores:1, autor:1, tsPublicacao:1, profissional:1}).lean().exec (err, casos)=>
      console.log casos, err, '======= casos ====='
      if err
        return self.res.json 500, {msg:'Erro ao consultar caso clinico'}
      iterador = (caso, callback)->
        folder = self.getFolder(caso)
        fs.exists folder, (exists) => 
          caso['ppu_criado'] = exists
          callback null, caso
      callbackf = (err, result)->
        if err
          return self.res.json 500, {msg:"Erro ao buscar PPUs"}
        return self.res.json 200, result
      async.map(casos, iterador, callbackf)
  
  show:()->
    self = @
    id = @params('id')
    Casos.findOne({_id:id},{_id:1, shortname:1, titulo:1}).exec (err, caso)=>
      if err
        return self.res.json 500, {msg:"Erro ao consultar arquivo do ppu"}
      folder = self.getFolder(caso)
      fs.exists folder, (exists)->
        if err or not exists
          return self.res.json 400, {msg:"Arquivo não encontrado!"}
        ZIP.file folder, folder+'.zip'
        data = ZIP.generate {base64:false,compression:'DEFLATE'}
        if data
          console.log(folder+'.zip')
          # self.res.set('Content-Type', 'application/zip, application/octet-stream, application/x-zip-compressed, multipart/x-zip')
          return self.res.download(folder+'.zip')
        else
          return self.res.status(403).send("Erro ao gerar arquivo")
  create:()->
    self = @
    id = @params('id')
    Casos.findOne _id: id
    .exec (err, caso)->
      try
        throw err if err
        makePPUfromCaso caso, (err)->
          console.log("deu erro ao construir ppu")
          return self.res.json( 500, {msg:"Erro ao consultar arquivo do ppu: "+err}) if err
          console.log "feito #{caso.titulo}"
          console.log "o nucleo caso.profissional #{caso.profissional}"
          console.log "testa nucleo #{testaNucleo}"

          testaNucleo = caso.profissional.toUpperCase();
          switch testaNucleo 
            when "MEDICINA"
              nucleo = '1'
            when "ENFERMAGEM"
              nucleo = '2'
            when "ODONTOLOGIA"
              nucleo = '3'
            when "MEDICINA, ENFERMAGEM"
              nucleo = '4'
            when "MEDICINA E ENFERMAGEM"
              nucleo = '4'
            when "ENFERMAGEM E MEDICINA"
              nucleo = '4'
            else     
              nucleo = '0'
          # AQUI COMEÇA A GERAR A CAPA
          item = {"titulo": caso.titulo, "nucleo": nucleo}
          dataset = [ {} ]
          nameReport = 'capappu'
          report = 
            report: nameReport
            data: item
            dataset: dataset
          console.log 'item', item
          filename = 'capa'
          deposito = self.getFolder(caso)
          console.log 'deposito', deposito
          try
            r = jasper.export(report, 'pdf')
          catch err
            return self.res.json( 500, {msg:"Erro ao consultar arquivo do ppu: "+err}) if err 
          console.log 'R', r
          f = path.resolve(deposito, filename + '.pdf')
          console.log 'path', f 
          fs.writeFile f, r, { 'encoding': 'utf-8', 'mode': '0666' }, (err) ->
            # var ok = true;
            console.log 'escreveu arquivos', err
            return self.res.json( 500, {msg:"Erro ao consultar arquivo do ppu: "+err}) if err
            fs.chmod f, '0777', (err) ->
              console.log 'escreveu arquivos 0777', err
              return self.res.json( 500, {msg:"Erro ao consultar arquivo do ppu: "+err}) if err   
              pdfImage = new PDFImage(f)
              console.log 'escreveu arquivos pdfImage', f
              pdfImage.convertPage(0, {omitPageNumOnFileName:true})
              # pdfImage.convertPage(0)
              .then(
                (imagePath)->
                  console.log 'pdf img arquivos', imagePath
                  if !fs.existsSync(imagePath)
                    return self.res.json( 500, {msg:"Erro ao criar arquivo de imagem: "+imagePath})
                  else
                    fs.unlink f, (err) ->
                      urlPasta = self.getFolder(caso)
                      urlZip = self.getFolder(caso, true)
                      console.log 'urlPasta ==>', urlPasta
                      console.log 'urlZip ==>', urlZip
                      zipFolder urlPasta, urlZip, (err) ->
                        return self.res.json( 500, {msg:"Erro ao criar zip arquivo do ppu: "+err}) if err
                        return self.res.json 200, {msg: "PPU criado com sucesso!"}
                (e)->
                  return self.res.json( 500, {msg:"Erro ao escrever capa: "+e}) if e
              )
              return
            return
      catch e
        console.log e ,'erro'
        return self.res.json 500, {msg:"Erro ao construir arquivo do ppu: "+e}


c = new CasosController()
esperaJasper = (req,res,next)->
  if !jasper.hm
    jasper.ready(next)
  else
    next()

c.before 'create', esperaJasper
module.exports = c