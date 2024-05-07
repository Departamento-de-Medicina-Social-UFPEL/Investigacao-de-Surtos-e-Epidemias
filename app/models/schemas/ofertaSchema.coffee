Mongoose = require 'mongoose'
timestamps = require 'mongoose-timestamp'
{Schema} = Mongoose
{Types} = Schema
{Mixed} = Types
{ObjectId} = Types

OfertaSchema = new Schema
  id_arouca:
    type: String
  curso_arouca:
    type: String
  apelido:
    type: String
    unique: true
  data_inicio: Date
  data_fim: Date
  nome: String
  modulo: ObjectId
  conteudo: String
  tipo: String
  ofertas_integradas: Array

OfertaSchema.plugin timestamps

module.exports = OfertaSchema