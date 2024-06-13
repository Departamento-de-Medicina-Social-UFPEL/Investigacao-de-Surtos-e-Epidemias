lti = require 'express-ims-lti'
parser = require 'body-parser'
morgan = require 'morgan'
express = require 'express'
session = require 'express-session'
offline = require 'connect-offline'
favIcon = require 'serve-favicon'
override = require 'method-override'
poweredBy = require 'connect-powered-by'
compression = require 'compression'
serverStatic = require 'serve-static'
path = require 'path'

module.exports = ()->
    # console.log(__dirname, '__dirname')
    @use poweredBy 'Learning Locomotive.js by Adrian Neuhaus'
    # @use morgan 'tiny'
    # @use favIcon __dirname + '/../../public/fav.ico'
    @use serverStatic path.resolve('./')
   # @use serverStatic path.resolve('public/../')
    #console.log('resolve static _____________________', path.resolve('./'), path.resolve('public/../'))
    @use override 'X-HTTP-Method-Override'
    # @use parser.json()
    @use compression threshold: 1024

    @use session
        resave: true
        saveUninitialized: false
        secret: '723d2fb3202c4f10368a9b6be1bd31a66973f109'

    @use parser.urlencoded extended: on
    @use parser.json()

    @enable 'trust proxy'

    # @use (req, res, next) ->
    #     req.originalUrl = '/casca' + req.originalUrl
    #     do next

    @use lti
        'consumer_key': 'cf4fd22b827516459623029711968ebbd258c558'
        'consumer_secret': '723d2fb3202c4f10368a9b6be1bd31a66973f109'
    console.log(__dirname, '__dirname')
    # @use offline
    #     manifest_path: '/application.manifest'
    #     files: [
    #       { dir: path.resolve( './public/css'), prefix: '/css/' },
    #       { dir: path.resolve( './public/lib'), prefix: '/lib/' },
    #       { dir: path.resolve( './public/js'), prefix: '/js/' }
    #     ]
    #     use_fs_watch: true

    @use @router
