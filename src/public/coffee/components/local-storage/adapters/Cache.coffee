define ['underscore', 'lzs'], (_, LZString)->

  class Cache

    constructor: (options) ->
      settings =
        namespace: 'global'
        backend: false
        separator: '-'

      options.namespace = options if _.isString options

      _.extend settings, options if options

      @separator = settings.separator

      @setNamespace settings.namespace

      @setBackend settings.backend if settings.backend

      @storage = window.localStorage

      @compressor = LZString

      @latestSet = 0
      @latestSetAll = 0
      @latestSaveAll = 0
      @latestSyncAll = 0

      _.bindAll @

    clearAllKeysInNS: ()->
      self = @
      all = Object.keys self.storage
      thisNS = all.filter (k)->
        k.indexOf(self.namespace) > -1
      console.log thisNS
      oldKeyValPairs = thisNS.reduce ((m, k)-> m[k] = self.storage[k]; m), {}
      for key in thisNS
        self.storage.removeItem key
      oldKeyValPairs

    setBackend: (backend) ->
      if _.isFunction backend
        @backend = backend
      else
        throw new TypeError "(Cache)(setBackend): backend is not a function"

    setNamespace: (namespace) ->
      if _.isString namespace
        @namespace = @_dasherize namespace
      else
        throw new TypeError "(Cache)(setNamespace): namespace is not a string"

    _ns: (key) ->
      "#{@namespace}.#{@_makeValidKey(key)}"

    _makeValidKey: (key) ->
      if _.isString key
        return @_dasherize key
      else
        throw new TypeError "(Cache)(_makeValidKey): key '#{key}' is not a string"

    _dasherize: (string) -> string.replace /_/g, @separator

    get: (key) ->
      key = @_makeValidKey key
      if not @isObjectExpired()
        return @compressor.decompress(@cachedObject[key]) if @cachedObject[key]
      item = @storage.getItem @_ns key
      return null unless item
      JSON.parse @compressor.decompress item

    set: (key, value) ->
      @latestSet = new Date().getTime()
      if value
        @storage.setItem @_ns(key), @compressor.compress(JSON.stringify value)
      else
        @storage.removeItem @_ns(key)
      value

    setAll: (items) ->
      if _.isObject items
        _.each items, (key, item) =>
          key = @_makeValidKey key
          @set key, item
      else
        throw new TypeError "(Cache)(setAll): items is not an object"

    append: (key, item) ->
      arr = @get key
      if _.isArray arr
        arr.push item
        @set key, arr
      else if arr == null
        arr = [item]
        @set key, arr
      else
        throw new TypeError '(Cache)(append): array expected, instead: ' + typeof arr

    prepend: (key, item) ->
      arr = @get key
      # type check
      if _.isArray arr
        arr.unshift item
        @set key, arr
      else if arr == null
        arr = [item]
        @set key, arr
      else
        throw new TypeError '(Cache)(prepend): array expected'

    extend: (key, object) ->
      if not _.isObject object
        throw new TypeError "(Cache)(extend): object argument '#{object}' is not an object"

      current = @get key
      # type check
      if _.isObject current
        _.extend current, object
        @set key, current
      else
        throw new TypeError "(Cache)(extend): current value for key '#{key}' is not an object"

    all: (isObjectReturned) ->
      isObjectReturned = !!isObjectReturned || false

      return @cachedObject if isObjectReturned and not @isObjectExpired()
      return @cachedArray if not @isArrayExpired()

      objKeys = Object.keys @storage

      nsLength = @namespace.length

      keys = _.filter objKeys, (key) =>
        (key.substring 0, nsLength) == @namespace

      return null if _.isEmpty objKeys

      if isObjectReturned
        obj = {}
        _.each keys, (key) =>
          key = key.substring nsLength + 1, key.length
          obj[key] = @get key
        @_cacheObject obj
      else
        arr = []
        _.each keys, (key) =>
          key = key.substring nsLength + 1, key.length
          arr.push @get key
        @_cacheArray arr

    _cacheArray: (array) ->
      @cachedArray = array
      @cachedArrayTime = new Date().getTime()
      array

    _cacheObject: (object) ->
      @cachedObject = object
      @cachedObjectTime = new Date().getTime()
      object

    isArrayExpired: ->
      return @cachedArrayTime >= @latestSet if @cachedArrayTime
      true

    isObjectExpired: ->
      return @cachedObjectTime >= @latestSet if @cachedObjectTime
      true

    isEmpty: -> Object.keys(@storage) == null

    data: ->
      {
        namespace: @namespace
        latestSet: @latestSet
        latestSetAll: @latestSetAll
        latestSaveAll: @latestSaveAll
        latestSyncAll: @latestSyncAll
      }

    # TODO: save method
    # TODO: sync method

    # @description sync with backend
    syncAll: ->
      if @backend
        allItemsFromBackend = @backend {
          method: 'syncAll'
          items: @all(true)
          data: @data
        }
        @setAll allItemsFromBackend if allItemsFromBackend
        @latestSyncAll = new Date().getTime()
      else
        throw new Error "(Cache)(syncAll): no backend is set"

    # @description one way saveAll call to backend
    saveAll: ->
      if @backend
        @backend {
          method: 'saveAll'
          items: @all(true)
          data: @data
        }
        # set the latest saveAll
        @latestSaveAll = new Date().getTime()
      else
        throw new Error '(Cache)(saveAll): no backend is set'