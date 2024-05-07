Dexie.getDatabaseNames (databaseNames) ->
  dump = (databaseNames) ->
    if databaseNames.length > 0
      db = new Dexie(databaseNames[0])
      db.open().then(->
        console.log "var db = new Dexie('" + db.name + "');"
        console.log "db.version(" + db.verno + ").stores({"
        db.tables.forEach (table, i) ->
          primKeyAndIndexes = [table.schema.primKey].concat(table.schema.indexes)
          schemaSyntax = primKeyAndIndexes.map((index) ->
            index.src
          ).join(",")
          console.log "    " + table.name + ": " + "'" + schemaSyntax + "'" + ((if i < db.tables.length - 1 then "," else ""))
          table.each (object) ->
            console.log JSON.stringify(object)
            return

          return

        console.log "});\n"
        return
      ).afinally ->
        db.close()
        dump databaseNames.slice(1)
        return

    else
      console.log "Finished dumping databases"
      console.log "=========================="
    return
  if databaseNames.length is 0
    console.log "There are no databases at current origin. Try loading another sample and then go back to this page."
  else
    dump databaseNames
  return


