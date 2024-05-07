configdb = require('/home/dev/config/mongo_db_config.coffee')
Mongoose = require('mongoose')
# ConexRepo = Mongoose.createConnection(configdb.ccurepo)
ConexRepo = Mongoose.createConnection(configdb.ccurepo, {useNewUrlParser: true})

timestamps = require 'mongoose-timestamp'
{Schema} = Mongoose
{Types} = Schema
{Mixed} = Types
{ObjectId} = Types


CasoSchema = new Schema
  titulo: String
  subTitulo: String
  id: Number
  profissional: String
  tsPublicacao: Number
  paciente: Mixed
  autor: Mixed
  shortname: String
  editores: Mixed
  slides: [Mixed]

CasoSchema.plugin timestamps

CasoSchema.virtual('pro').get ()->
  has = @.profissional.match
  [ has /medicina/i , has /enfermagem/i , has /odontologia/i ]

ConexRepo.model "casos", CasoSchema

SelecaoSchema = new Schema

  titulo: String

  descricao: String

  casos: [
    type: ObjectId
    ref: 'casos'
  ]

  instituicao:
    type: String
    default: 'publico'

  __v: Number

SelecaoSchema.plugin timestamps

module.exports = ConexRepo.model "selecoes", SelecaoSchema