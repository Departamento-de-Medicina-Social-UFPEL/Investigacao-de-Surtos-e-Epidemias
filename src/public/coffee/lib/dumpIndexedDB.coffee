define ['dexie'], ()->
  console.log arguments
  dumpDB = ->
    Dexie.getDatabaseNames (databaseNames) ->
      dump = (databaseNames) ->
        if databaseNames.length > 0
          db = new Dexie(databaseNames[0])
          db.open().then(->
            db.delete()
            return
          ).finally ->
            db.close()
            dump databaseNames.slice(1)
            return

        else
          console.log """
               DBs Excluídos
          ==========================
          """
        return
      if databaseNames.length is 0
        console.log "There are no databases at current origin. Try loading another sample and then go back to this page."
      else
        dump databaseNames
      return

  dumpDB

