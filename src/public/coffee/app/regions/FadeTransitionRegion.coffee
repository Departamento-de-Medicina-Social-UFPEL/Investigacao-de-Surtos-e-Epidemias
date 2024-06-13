define [
  'backbone.marionette'
], (Marionette) ->
  Marionette.Region.extend
    show: (view) ->
      # @ensureEl()
      view.render()
      @close ->
        if @currentView and @currentView != view
          return
        @currentView = view
        @open view, ->
          if view.onShow
            view.onShow()
          view.trigger 'show'
          # console.log @onShow
          if @onShow
            @onShow view
          @trigger 'view:show', view
    close: (cb) ->
      view = @currentView
      delete @currentView
      if !view
        if cb
          cb.call this
        return
      that = this
      view.$el.fadeOut ->
        if view.close
          view.close()
        that.trigger 'view:closed', view
        if cb
          cb.call that
    open: (view, callback) ->
      that = this
      @$el.html view.$el.hide()
      view.$el.fadeIn ->
        console.log 'fade'
        setTimeout ()->
          $.material.init()
        , 10
        callback.call that
