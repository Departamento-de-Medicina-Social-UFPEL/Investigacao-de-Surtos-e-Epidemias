// Generated by CoffeeScript 2.7.0
define([], function() {
  var Introbox;
  Introbox = (function() {
    class Introbox extends Marionette.ItemView {
      ['initialize'](options) {}

      // gotoReturn: ()->
      // 	if App.appRouter.historico.length > 1
      // 		App.appRouter.previous()
      // 	else
      // 		App.appRouter.navigate "comp/selecao-progresso", true
      onRender() {
        var self, short, uni, unis;
        self = this;
        console.log(this.model, 'modelo introbox');
        unis = _.where(window.modulo.components, {
          folder: 'unidade-progresso'
        });
        uni = unis.filter(function(u) {
          var casos;
          if (!u.resource) {
            return false;
          }
          casos = u.resource.casos.filter(function(c) {
            return c._id === self.model.get('_id');
          });
          return casos.length > 0;
        });
        if (uni.length > 0) {
          short = uni[0].short;
          this.ui.voltarUnidade.css({
            display: 'block'
          });
          this.ui.voltarUnidade.attr({
            href: "#comp/unidade-progresso/" + short
          });
          return this.ui.unidade.html(short);
        }
      }

    };

    Introbox.prototype['template'] = '#saiba-mais-introbox';

    Introbox.prototype['className'] = 'container-fluid introbox-container';

    // events:
    //   'click .gotoReturn': 'gotoReturn'
    Introbox.prototype.ui = {
      'voltarUnidade': '#voltarUnidade',
      'unidade': '#unidade'
    };

    return Introbox;

  }).call(this);
  return Introbox;
});