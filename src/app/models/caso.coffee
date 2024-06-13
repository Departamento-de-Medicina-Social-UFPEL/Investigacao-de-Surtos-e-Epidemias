configdb = require('../../config/mongo_db_config.coffee')
Mongoose = require('mongoose')
ConexRepo = Mongoose.createConnection(configdb.ccurepo)
#ConexRepo = Mongoose.connect(configdb.ccurepo, {useNewUrlParser: true})


timestamps = require 'mongoose-timestamp'
{Schema} = Mongoose
{Types} = Schema
{Mixed} = Types
{ObjectId} = Types


CasoSchema = new Schema
  titulo: String
  subTitulo: String
  id: Number
  tipo:
    type: String
    default: "caso"
  profissional: String
  tsPublicacao: Number
  paciente: Mixed
  editores: Mixed
  autor: Mixed
  shortname: String
  slides: [Mixed]
  bloqueado: Boolean

CasoSchema.plugin timestamps

CasoSchema.virtual('pro').get ()->
  has = @.profissional.match
  [ has /medicina/i , has /enfermagem/i , has /odontologia/i ]

module.exports = ConexRepo.model "casos", CasoSchema