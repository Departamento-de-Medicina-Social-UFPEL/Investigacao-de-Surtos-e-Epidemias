mongoose = require "mongoose"
mongooseTimestamp = require 'mongoose-timestamp'
mongooseTypes = require "mongoose-types"

mongooseTypes.loadTypes mongoose

{ Schema } = mongoose
# var Schema = mongoose.Schema;

{ Mixed } = Schema.Types
# var Mixed = Schema.Types.Mixed;

{ Email } = mongoose.SchemaTypes
# var Email = mongoose.SchemaTypes.Email;

Acao = new Schema
  nome:
    'type': String
# var Acao = new Schema( { nome: { type: String } } );
# _id é criado sozinho pelo mongo

Acao.plugin mongooseTimestamp
# Acao.plugin(mongooseTimestamp);
connection = mongoose.createConnection 'mongodb://localhost/caderno_teste'
# var connection = mongoose.createConnection('mongodb://localhost/caderno_teste');
module.exports = connection.model 'acoes', Acao
# module.exports = connection.model('acoes', Acao);