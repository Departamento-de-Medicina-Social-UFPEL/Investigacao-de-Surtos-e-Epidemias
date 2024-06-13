// Generated by CoffeeScript 2.7.0
define(['backbone.marionette'], function(Marionette) {
  return Marionette.Region.extend({
    show: function(view) {
      // @ensureEl()
      view.render();
      return this.close(function() {
        if (this.currentView && this.currentView !== view) {
          return;
        }
        this.currentView = view;
        return this.open(view, function() {
          if (view.onShow) {
            view.onShow();
          }
          view.trigger('show');
          // console.log @onShow
          if (this.onShow) {
            this.onShow(view);
          }
          return this.trigger('view:show', view);
        });
      });
    },
    close: function(cb) {
      var that, view;
      view = this.currentView;
      delete this.currentView;
      if (!view) {
        if (cb) {
          cb.call(this);
        }
        return;
      }
      that = this;
      return view.$el.fadeOut(function() {
        if (view.close) {
          view.close();
        }
        that.trigger('view:closed', view);
        if (cb) {
          return cb.call(that);
        }
      });
    },
    open: function(view, callback) {
      var that;
      that = this;
      this.$el.html(view.$el.hide());
      return view.$el.fadeIn(function() {
        console.log('fade');
        setTimeout(function() {
          return $.material.init();
        }, 10);
        return callback.call(that);
      });
    }
  });
});