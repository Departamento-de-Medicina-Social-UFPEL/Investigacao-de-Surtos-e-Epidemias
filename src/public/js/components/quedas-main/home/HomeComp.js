// Generated by CoffeeScript 2.7.0
define(['./HomeItem'], function(QuedaItemView, quedasTemplate) {
  var Quedas;
  Quedas = (function() {
    class Quedas extends Marionette.CompositeView {
      initialize() {
        return this.collection = App.quedas;
      }

      onRender() {
        return console.log('quedasModel', this.model);
      }

    };

    Quedas.prototype.className = 'item quedas container';

    Quedas.prototype.template = '#quedas-main-home-main';

    Quedas.prototype.childView = QuedaItemView;

    Quedas.prototype.childViewContainer = '.lista-quedas';

    Quedas.prototype.childEvents = {
      "render": function(evt, view) {
        var css, fl, nm;
        // console.log arguments
        fl = view.model.get('folder');
        nm = view.model.get('nome');
        css = {
          'background': `url(${defaultStaticFileService}/img/${fl}/${fl}_fundo.png) cover no-repeat`
        };
        view.$el.attr('style', `background: url(${defaultStaticFileService}/img/${fl}/${fl}_fundo.png) center center no-repeat;
background-size: cover;`);
        view.$el.wrap(`<a href='#queda/${fl}'></a>`);
        return console.log(css);
      },
      "onItemClose": function() {
        return console.log('Queda onItemClose');
      }
    };

    Quedas.prototype.ui = {
      ok: 'ok'
    };

    return Quedas;

  }).call(this);
  return Quedas;
});