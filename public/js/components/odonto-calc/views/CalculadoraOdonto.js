// Generated by CoffeeScript 1.8.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'backbone.marionette'], function(Backbone, Marionette) {
  var OdontoMainView;
  OdontoMainView = (function(_super) {
    __extends(OdontoMainView, _super);

    function OdontoMainView() {
      return OdontoMainView.__super__.constructor.apply(this, arguments);
    }

    OdontoMainView.prototype.model = new Backbone.Model;

    OdontoMainView.prototype.className = 'item calculadoras odonto';

    OdontoMainView.prototype.template = '#odonto-calc-main-view';

    OdontoMainView.prototype.ui = {
      'peso': '#pesoId',
      'ehCri': '.ehCri',
      'descricao': '.descricao',
      'resultado': '.resultado',
      'resposta': '.condutaBox',
      'faixa': '.faixa',
      'res_amo': '.res_amo',
      'res_eri': '.res_eri',
      'res_cef': '.res_cef',
      'res_par': '.res_par',
      'res_dip': '.res_dip',
      'res_ibu': '.res_ibu'
    };

    OdontoMainView.prototype.events = {
      'change @ui.ehCri': 'changeDados',
      'blur @ui.peso, @ui.altura': 'changeDados'
    };

    OdontoMainView.prototype.changeDados = function() {
      var dados, faixa, para, pes3, pes4, pesg, peso, pibu;
      dados = this.getDados();
      faixa = dados.ehCri ? 'fx1' : 'fx2';
      peso = parseFloat(dados.peso);
      pes3 = (peso / 3).toFixed(0);
      pes4 = (peso / 4).toFixed(0);
      para = peso;
      pibu = peso;
      if (dados.ehCri) {
        pesg = (peso * 0.6).toFixed(0);
      } else {
        pesg = peso;
      }
      if (pesg > 35) {
        pesg = 35;
      }
      if (pes4 > 10) {
        pes4 = 10;
      }
      if (pes3 > 10) {
        pes3 = 10;
      }
      if (para > 35) {
        para = 35;
      }
      if (pibu > 40) {
        pibu = 40;
      }
      console.log(pes3);
      if (peso) {
        this.ui.res_amo.text('Posologia ' + pes3 + 'ml de 8/8h (3xdia)');
        this.ui.res_eri.text('Posologia ' + pes4 + 'ml de 6/6h (4xdia)');
        this.ui.res_cef.text('Posologia ' + pes4 + 'ml de 6/6h (4xdia)');
        this.ui.res_par.text('Posologia ' + para + ' gotas de 6/6h (4xdia)');
        this.ui.res_dip.text('Posologia ' + pesg + ' gotas de 6/6h (4xdia)');
        this.ui.res_ibu.text('Posologia ' + pibu + ' gotas de 6/6h (4xdia)');
        return this.ui.resposta.show();
      } else {
        return this.ui.resposta.hide();
      }
    };

    OdontoMainView.prototype.getDados = function() {
      var r;
      r = {
        peso: this.limpaNum(this.ui.peso.val() || '0', 0, 250),
        ehCri: this.ui.ehCri.prop('checked')
      };
      if (r.peso !== '0') {
        this.ui.peso.val(r.peso.replace('.', ','));
      }
      return r;
    };

    OdontoMainView.prototype.limpaNum = function(n, min, max, a) {
      var sohOPrim;
      if (a == null) {
        a = 0;
      }
      sohOPrim = function() {
        a++;
        if (a === 1) {
          return '.';
        } else {
          return '';
        }
      };
      n = n.replace(/\s/img, '');
      n = n.replace(',', '.');
      n = n.replace('.', sohOPrim);
      n = parseFloat(n);
      if (_.isNaN(n)) {
        return '';
      }
      switch (true) {
        case n <= min:
          return min + '';
        case n >= max:
          if ((n * 100) > max) {
            n = n / 100;
            if (n <= max) {
              return n + '';
            } else {
              return max + '';
            }
          } else {
            return max + '';
          }
          break;
        default:
          return n + '';
      }
    };

    OdontoMainView.prototype.calculaEscore = function(d, t) {};

    OdontoMainView.prototype.onRender = function(view) {
      this.ui.resposta.hide();
      return setTimeout((function() {
        return $.material.init();
      }), 50);
    };

    return OdontoMainView;

  })(Marionette.ItemView);
  return OdontoMainView;
});
