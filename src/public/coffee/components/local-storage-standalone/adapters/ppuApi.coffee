define [
  'underscore'
  'ppuStore'
], (_ ,PPUStore)->

  class PPU

    @configLoaded = false
    @isInited = false
    @basePrefix = ''
    @separator = '_'
    @store = false

    constructor: (options, @callback)->

      settings =
        config: do @configModel
        separator: '_'
        callback: ->

      if _.isString options
        settings.config = JSON.parse options
      else
        settings.config = options.config if options.config
        @callback = options.callback if options.callback

      _.extend settings, options if options

      @separator = settings.separator
      @config = settings.config
      @configLoaded = true
      do @init

    sameResourceStores: ->
      return if not @isInited
      p = @config.Persistence
      sep = @separator
      [instAcro, name] = ['InstitutionAcronym','Name'].map (key) ->
        p[key].replace /[_-]/img, @separator
      lookup = new RegExp "#{instAcro}#{sep}\\d{4}#{sep}#{name}.*"
      _.filter _.keys(localStorage), (k) -> lookup.test k

    init: ->
      @basePrefix = do @getBasePrefix
      @store = new PPUStore
        'namespace': @basePrefix
        'separator': @separator
      @isInited = true
      callback.apply this

    getUser: -> localStorage.getItem "PPUPLAYER_USER"

    getBasePrefix: ->
      p = @config.Persistence
      [ p.InstitutionAcronym, p.Version, p.Name ].join @separator

    configModel: ->
      {
        'Institution':
          'ID_Arouca': 0
          'Acronym': ''
          'Name': ''
        'Resource':
          'Name': ''
          'Language': ''
          'CreationDate': ''
          'Review': 0
          'ReviewDate': '1969-12-31'
          'InteractionEstimatedTimeMinutes': 0
          'CoverImage': ''
        'SupportedDevices': ['']
        'Video':
          'Formats': ['']
          'Resolutions': ['']
        'Persistence':
          'InstitutionAcronym': ''
          'Version': ''
          'Name': ''
          'LTIValue': false
      }