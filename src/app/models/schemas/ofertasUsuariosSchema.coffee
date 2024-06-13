Mongoose = require 'mongoose'
timestamps = require 'mongoose-timestamp'
{Schema} = Mongoose
{Types} = Schema
{Mixed, ObjectId} = Types

OfertaSchema = new Schema
  id_arouca:
    type: String
  dt_cadastro: Date
  dt_conclusao: Date
  modulo:
    'type': ObjectId
  cpf: String
  fl_ingresso_arouca:Boolean
  fl_cadastro_completo:Boolean
  url_certificado:String
  dashboard_percentProgresso: Number
  nr_horas: Number

OfertaSchema.plugin timestamps

module.exports = OfertaSchema