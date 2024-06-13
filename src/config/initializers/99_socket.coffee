io = require 'socket.io'
socketMVC = require 'socket.mvc'
path = require 'path'
module.exports = ()->

  self = this
  #n = io.sockets.clients('room')
  console.log '@websocketServer.address', @websocketServer.address()

  io = io @websocketServer, { path: '/ws' }

  @socketio = io

  io.on 'connection', (socket)->
    # console.log "+1 conectado"
    config =
      debug: false
      filePath: [path.resolve(__dirname + '/../socket.coffee')]

    socketMVC.init io, socket, config
