configdb = require('../../config/mongo_db_config.coffee')
Mongoose = require('mongoose')
ConexRepo = Mongoose.createConnection(configdb.modulos)
timestamps = require 'mongoose-timestamp'
{Schema} = Mongoose
{Types} = Schema
{Mixed, ObjectId} = Types



ProgressoSchema = new Schema
  modulo: 
    type: ObjectId
    default: '578e2fade70643d3bf9989ca'
  id: String
  atividade: String
  seqid: Number
  escore: Number
  user: String
  marcadas: [Number]
  ts: Number
  ativo:
    type: Boolean
    default: true

ProgressoSchema.plugin timestamps

module.exports = ConexRepo.model "progressos", ProgressoSchema