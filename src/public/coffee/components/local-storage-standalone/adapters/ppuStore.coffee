define [
  'cache'
], (Cache)->

  Function::property = (prop, desc) ->
    Object.defineProperty @prototype, prop, desc

  class PPUStore extends Cache

    @property 'debug',
      get: -> @get 'debug'
      set: (val) -> @set 'debug', val

    @property 'persistence',
      get: -> @get 'persistence'
      set: (val) -> @set 'persistence', val

    @property 'lti',
      get: -> @get 'lti'
      set: (val) -> @set 'lti', val

    @property 'percentage',
      get: -> @get 'percentage'
      set: (val) -> @set 'percentage', val

    @property 'status',
      get: -> @get 'status'
      set: (val) -> @set 'status', val

    @property 'shared',
      get: -> @get 'shared'
      set: (val) -> @set 'shared', val

    @property 'log',
      get: -> @get 'log'
      set: (val) -> @set 'log', val
