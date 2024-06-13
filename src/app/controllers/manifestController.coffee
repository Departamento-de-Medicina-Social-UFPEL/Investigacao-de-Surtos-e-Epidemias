locomotive = require 'locomotive'
Controller = locomotive.Controller
_ = require 'lodash'
Modulos = require '../models/moduloModel.coffee'

suppress = (url)-> url.replace /.*\/public/img, ''

AppCacheManifestController = new Controller

AppCacheManifestController.show = (id)->
  self = @
  self.res.set 'Content-Type': 'text/cache-manifest'

  Modulos.getCacheFiles '5474EB2F70BF95195804F780', (err, cacheObj) ->
    throw err if err

    resultado = []
    resultado.push(suppress(url)) for k, url of cacheObj

    self.res.send """
    CACHE MANIFEST
    # booster douglas
    CACHE:
    #{resultado.join '\n'}

    NETWORK:
    *
    """





module.exports = AppCacheManifestController
