configdb = require('/home/dev/config/mongo_db_config.coffee')
Mongoose = require('mongoose')
ConexRepo = Mongoose.createConnection(configdb.modulos)
timestamps = require 'mongoose-timestamp'
{Schema} = Mongoose
{Types} = Schema
{Mixed, ObjectId} = Types



ProgressoSchema = new Schema
  modulo:
    'default': '5669C5C4F9D50797D4F3B497'
    type: ObjectId
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

module.exports = ConexRepo.model "progressos_inativos", ProgressoSchema