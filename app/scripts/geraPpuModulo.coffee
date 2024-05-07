fs = require 'fs'

ibge = require 'municipios-ibge'
ufMun = require '../lib/uf-mun.coffee'
_ = require 'lodash'

Modulos = require '../models/moduloModel.coffee'
Ofertas = require '../models/ofertas.coffee'

makePPUfromCalc = require './ppucomcapa_calc.coffee'
makePPUfromModulo = require './ppucomcapa_modulo.coffee'
_ = require 'lodash'
async = require 'async'
PDFImage = require("pdf-image").PDFImage
zipFolder = require('zip-folder')
ZIP = new require('node-zip')()
PPUsRootFolderCreate = '/tmp/ppus'
path = require('path')
PPUsRootFolder = path.resolve(__dirname, '../../public/ppu/modulos')
repo = path.resolve(__dirname,'../templates/')
jasper = require('node-jasper')(optionsReport = {
  path: 'jasperreports-6.0.0/',
  reports: {
    # // Report Definition
    "capappu": {
      jasper: repo + '/capasppu.jasper', #Path to jasper file,
      jrxml: repo + '/capasppu.jrxml', #Path to jrxml file,
      conn: 'in_memory_json'
    },
  }
})
getFolder = (modulo, zip = false)->
    # console.log modulo.name, modulo.name.indexOf('Calc'), 'tes get folder'
    if modulo.name.indexOf('Calc') > -1
        short = "calculadora-#{modulo.shortname}"
    else
        short = "modulo-#{modulo.shortname}"
    namespace = short.toUpperCase().replace /[^A-Z]*/img, ''
    ns = "UFPEL_0001_#{namespace}"
    if not zip
        folder = "#{PPUsRootFolder}/#{ns}"
    else
        folder = "#{PPUsRootFolder}/#{ns}.zip"
    folder

id = "5d8aab26afcdb9691fbbfdc0"
Modulos.findOne({_id:id}).exec (err, modulo)=>
    if err
        throw err

    throw err if err
    if not modulo
        console.log("Módulo informado não encontrado: ")
    console.log modulo.name, 'name modulo', modulo.name.indexOf('Calc')
    if modulo.name.indexOf('Calc') > -1
        m = makePPUfromCalc
        console.log 'escolheu calc'
    else
        console.log 'escolheu modulo'
        m = makePPUfromModulo
    m modulo, (err)->
        if err
            console.log("deu erro ao construir ppu")
            throw err;
        console.log "feito #{modulo.name}"
        # AQUI COMEÇA A GERAR A CAPA
        item = {"titulo": modulo.name, "nucleo": ""}
        dataset = [ {} ]
        nameReport = 'capappu'
        report = 
            report: nameReport
            data: item
            dataset: dataset
        console.log 'item', item
        filename = 'capa'
        deposito = getFolder(modulo)
        console.log 'deposito', deposito
        try
            r = jasper.export(report, 'pdf')
        catch err
            return console.log("Erro ao consultar arquivo do ppu: "+err) if err 
        console.log 'R', r
        f = path.resolve(deposito, filename + '.pdf')
        console.log 'path', f 
        console.log "escrevendo a capa na pasta"
        fs.writeFile f, r, { 'encoding': 'utf-8', 'mode': '0666' }, (err) ->
            # var ok = true;
            console.log 'escreveu arquivos', err if err
            console.log "trocando as permissões da capa na pasta"
            fs.chmod f, '0777', (err) ->
                console.log 'trocou a permissoa 0777', err if err   
                pdfImage = new PDFImage(f)
                console.log 'gerando imagem da capa a partirr do pdf', f
                pdfImage.convertPage(0, {omitPageNumOnFileName:true})
                # pdfImage.convertPage(0)
                .then(
                    (imagePath)->
                        console.log 'pdf img covertida', imagePath
                        if !fs.existsSync(imagePath)
                            console.log "Erro ao criar arquivo de imagem: "+imagePath
                            return 
                        else
                            fs.unlink f, (err) ->
                                urlPasta = getFolder(modulo)
                                urlZip = getFolder(modulo, true)
                                console.log 'urlPasta ==>', urlPasta
                                console.log 'urlZip ==>', urlZip
                                zipFolder urlPasta, urlZip, (err) ->
                                    if err
                                        console.log("Erro ao criar zip arquivo do ppu: "+err)
                                    else
                                        console.log("PPU criado com sucesso!")
                                        show(modulo)
                                    return
                    (e)->
                        console.log("Erro ao escrever capa: "+e) if e
                )
                return


show = (modulo)->
    folder = getFolder(modulo)
    fs.exists folder, (exists)->
        if not exists
            throw "a seguinte pasta não foi encontrada"+ folder
        ZIP.file folder, folder+'.zip'
        data = ZIP.generate {base64:false,compression:'DEFLATE'}
        if data
            console.log(folder+'.zip')
            # self.res.set('Content-Type', 'application/zip, application/octet-stream, application/x-zip-compressed, multipart/x-zip')
            return 
        else
            console.log 'error'
        return
