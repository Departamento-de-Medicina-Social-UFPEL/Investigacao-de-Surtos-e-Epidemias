// Generated by CoffeeScript 2.7.0
define(['./error', 'backbone.modal'], function(ErrorView) {
  var Modal;
  return Modal = (function() {
    class Modal extends Backbone.Modal {
      initialize(obj) {}

      onRender() {
        var b, self;
        b = $('body');
        self = this;
        if (!b.is(':visible')) {
          b.fadeIn();
        }
        console.log('setTimeout', new Date());
        return setTimeout((function() {
          return self.salvar();
        }), 5000);
      }

      salvar() {
        console.log('sokect conectado vou tentar salvar', App.socket.connected, new Date());
        if (!navigator.onLine) {
          return window.location.hash = '#comp/logout/error';
        } else {
          // return App.modals.show(new ErrorView({msg:msg}))
          return App.execute('storeUser', App.user, function(dataUser) {
            var jaCertificado;
            // console.log 'retorno store logout', dataUser
            jaCertificado = dataUser.certificado;
            if (!dataUser.ok && !jaCertificado) {
              return window.location.hash = '#comp/logout/error';
            } else {
              // App.modals.show(new ErrorView({msg:msg}))
              App.local.set('user');
              App.user = null;
              App.progresso = null;
              if (!App.user) {
                window.location.hash = '';
              }
              return window.location.reload();
            }
          });
        }
      }

      onDestroy() {
        $('body').css({
          'overflow': 'auto'
        });
        return App.appRouter.previous();
      }

    };

    Modal.prototype.submitEl = '.bbm-button';

    Modal.prototype.template = _.template($('#logout-salvando').html());

    return Modal;

  }).call(this);
});