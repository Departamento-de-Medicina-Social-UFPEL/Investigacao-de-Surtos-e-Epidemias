Caso = require '../models/caso.coffee'
Caso.find (err, docs)-> console.log(docs.map((o)-> """ObjectId("#{o._id}")""").join ', \n')
 
