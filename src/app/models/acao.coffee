# !!! leia comentado no arquivo exemplo_0.coffee
mongoose = require "mongoose"
mongooseTimestamp = require 'mongoose-timestamp'
{ Schema } = mongoose
{ Mixed } = Schema.Types

Acao = new Schema
  nome:
    type: String

Acao.plugin mongooseTimestamp

connection = mongoose.createConnection 'mongodb://localhost/caderno_teste'
module.exports = connection.model 'acoes', Acao