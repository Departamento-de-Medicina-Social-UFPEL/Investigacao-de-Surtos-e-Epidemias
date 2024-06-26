// Generated by CoffeeScript 2.7.0
define(['backbone'], function(Backbone) {
  var Criterio, CriteriosBadge;
  Criterio = class Criterio extends Backbone.Model {
    ['initialize'](regra) {
      this.verifica = new Function(['prop', 'valor'], `return prop ${regra.crit} valor`);
      this.crit = regra.crit;
      this.propriedade = regra.prop;
      this.valor = parseFloat(regra.val);
      if (isNaN(this.valor)) {
        return this.valor = regra.val;
      }
    }

    ['test'](referencia) {
      var p, rp, t, v;
      p = this.propriedade;
      rp = referencia[p];
      v = this.valor;
      t = this.verifica(rp, v);
      //console.log p, rp, @crit, v, t, 'merece?', referencia, referencia[p]
      return t;
    }

  };
  CriteriosBadge = (function() {
    class CriteriosBadge extends Backbone.Collection {};

    CriteriosBadge.prototype.model = Criterio;

    return CriteriosBadge;

  }).call(this);
  return CriteriosBadge;
});
