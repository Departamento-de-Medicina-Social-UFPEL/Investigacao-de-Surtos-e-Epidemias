locomotive = require 'locomotive'
bootable = require 'bootable'

app = new locomotive.Application
bootStack = [
  locomotive.boot.controllers __dirname + '/app/controllers'
  do locomotive.boot.views
  require('bootable-environment') __dirname + '/config/environments'
  bootable.initializers __dirname + '/config/initializers'
  locomotive.boot.routes __dirname + '/config/routes'
]

app.phase middleware for middleware in bootStack

app.boot (err)->
  if err
    console.error err.message
    console.error err.stack
    return process.exit -1
