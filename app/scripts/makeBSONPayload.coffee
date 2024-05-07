      _ = require 'underscore'
      fs = require 'fs'
      bson = require 'bson'
      BSON = new bson.BSONPure.BSON()
      pub = '/home/dev/test/casca/public'
      templateFolder = "#{pub}/ppu/template"
      ppusHomeFolder = "#{pub}/ppu"
      staticFS = "/home/dev/static/public"
      async = require 'async'
      ncp = require 'ncp'
      ncp.limit = 16;

      Caso = require '../models/caso.coffee'

      oid = "4f1fb5540dd744175dd04962"

      makePayload = (caso)->
        casoObj = caso.toJSON()
        casoObj._id = casoObj._id.toString()
        # console.log casoObj
        modulo = require('./makeModuloCaso.coffee')(casoObj)
        return BSON.serialize modulo, no, yes, no

      Caso
      .findOne _id: oid
      .exec (e, doc)->
        fs.writeFile "payload_#{oid}.bson", makePayload(doc), (err)->
          console.log err, 'OK'

