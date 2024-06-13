// Generated by CoffeeScript 2.7.0
define(['backbone.modal'], function() {
  var Modal;
  return Modal = (function() {
    class Modal extends Backbone.Modal {
      initialize(obj) {
        return this.model = new Backbone.Model(obj);
      }

      onRender() {
        var b;
        b = $('body');
        if (!b.is(':visible')) {
          return b.fadeIn();
        }
      }

      onDestroy() {
        return $('body').css({
          'overflow': 'auto'
        });
      }

    };

    Modal.prototype.submitEl = '.close-modal';

    Modal.prototype.template = _.template($('#progresso-error').html());

    return Modal;

  }).call(this);
});