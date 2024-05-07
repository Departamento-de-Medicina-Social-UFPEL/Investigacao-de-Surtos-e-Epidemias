// Generated by CoffeeScript 1.8.0
define(['backbone.modal', './views/Video'], function(ModalView, VideoView) {
  var Modal;
  Modal = Backbone.Modal.extend({
    template: _.template($('#video-player-tela').html()),
    submitEl: '.bbm-button',
    className: 'container-fluid',
    onRender: function() {
      var $el, b, videoEl;
      b = $('body');
      if (!b.is(':visible')) {
        b.fadeIn();
      }
      $el = $(this.el);
      $el.find('.bbm-modal').css({
        'max-width': '90%',
        'margin-bottom': '235px'
      });
      videoEl = $el.find('video');
      videoEl.prop('volume', 0.5);
      return videoEl.on('playing', function() {
        var jaAnotou, jaeh, _base;
        if (App.user) {
          if ((_base = App.user).especifico == null) {
            _base.especifico = [];
          }
          jaAnotou = _.findWhere(App.user.especifico, {
            modulo: window.modulo._id,
            name: 'viuVideo'
          });
          jaeh = null;
          if (jaAnotou) {
            jaeh = jaAnotou.value;
          }
          if (jaeh) {
            return jaeh;
          }
          App.user.especifico.push({
            modulo: window.modulo._id,
            name: 'viuVideo',
            value: true
          });
          App.local.set("user", App.user);
          return App.execute('storeUser', App.user);
        }
      });
    },
    onDestroy: function() {
      $('body').removeAttr('style').css({
        display: 'block'
      });
      if (App.main.currentView) {
        return App.appRouter.previous();
      }
      return App.appRouter.navigate('/', {
        'trigger': true
      });
    }
  });
  return {
    "play": function() {
      var appComponent;
      console.log('play');
      appComponent = _.findWhere(window.modulo.components, {
        folder: 'video-player'
      });
      return App.modals.show(new Modal({
        model: new Backbone.Model({
          sources: appComponent.sources,
          poster: appComponent.poster,
          title: false,
          fileapoio: false
        })
      }));
    },
    "playUnidade": function(posterName, uni) {
      var unidade;
      console.log('playUnidade, uni', window.modulo.components, {
        unidade: uni,
        folder: 'unidade-progresso'
      });
      unidade = _.findWhere(window.modulo.components, {
        unidade: parseInt(uni),
        folder: 'unidade-progresso'
      });
      console.log('video apre', unidade, uni);
      return App.modals.show(new Modal({
        model: new Backbone.Model({
          sources: unidade.video_apresentacao.sources,
          poster: posterName,
          title: false,
          fileapoio: false
        })
      }));
    },
    "playByPosterNameView": function(posterName) {
      var u, unidade_video, unidades, video;
      console.log(posterName, 'play name');
      unidades = _.where(window.modulo.components, {
        folder: 'unidade-progresso'
      });
      unidade_video = false;
      for (u in unidades) {
        video = _.findWhere(unidades[u].sources, {
          poster: posterName
        });
        if (video) {
          unidade_video = unidades[u];
          break;
        }
      }
      video = _.findWhere(unidade_video.sources, {
        poster: posterName
      });
      return App.modals.show(new Modal({
        model: new Backbone.Model(video)
      }));
    },
    "playByPosterName": function(posterName) {
      var idx, mainView, u, unidade_video, unidades, v, video, videos;
      unidades = _.where(window.modulo.components, {
        folder: 'unidade-progresso'
      });
      unidade_video = false;
      for (u in unidades) {
        video = _.findWhere(unidades[u].sources, {
          poster: posterName
        });
        if (video) {
          unidade_video = unidades[u];
          break;
        }
      }
      if (unidade_video) {
        video = _.findWhere(unidade_video.sources, {
          poster: posterName
        });
        mainView = new VideoView({
          model: new Backbone.Model(video)
        });
        return App.main.show(mainView);
      } else {
        console.log(posterName, 'play from home by ds');
        videos = _.where(window.modulo.components, {
          folder: 'video-player'
        });
        video = false;
        for (idx in videos) {
          v = videos[idx];
          video = _.findWhere(v.sources, {
            filename: posterName
          });
          if (video) {
            video = v;
            break;
          }
        }
        App.modals.show(new Modal({
          model: new Backbone.Model({
            sources: video.sources,
            poster: video.poster,
            title: video.title,
            fileapoio: false
          })
        }));
        return $('body').css({
          'overflow': 'auto'
        });
      }
    }
  };
});
