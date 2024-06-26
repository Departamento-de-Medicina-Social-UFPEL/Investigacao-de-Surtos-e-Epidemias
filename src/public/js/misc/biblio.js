// Generated by CoffeeScript 2.7.0
requirejs.config({
  'baseUrl': '/casca',
  'waitSeconds': 100,
  'paths': {
    'utils': 'js/lib/utils',
    'jquery': 'lib/jquery/dist/jquery',
    'underscore': 'lib/lodash/lodash',
    'backbone': 'lib/backbone/backbone',
    'backbone.marionette': 'lib/backbone.marionette/lib/backbone.marionette',
    'bootstrap': 'lib/bootstrap/dist/js/bootstrap'
  },
  'map': {
    '*': {
      'marionette': 'backbone.marionette'
    }
  },
  'shim': {
    'bootstrap': {
      'deps': ['jquery']
    },
    'backbone.marionette': {
      'deps': ['jquery', 'backbone']
    }
  }
});

require(['marionette'], function(Marionette) {
  var Biblio, InfoBiblio, InputBiblioIn;
  InfoBiblio = (function() {
    class InfoBiblio extends Marionette.View {
      ['initialize']() {
        return this.bindUIElements();
      }

      ['checkSelection'](evt) {
        var sel;
        sel = this.getSelection();
        if (sel) {
          return console.log(sel);
        } else {
          return console.log('nada');
        }
      }

      ['getSelection'](evt) {
        if (window.getSelection) {
          return window.getSelection().toString();
        } else if (document.selection && document.selection.type !== "Control") {
          return document.selection.createRange().text;
        } else {
          return null;
        }
      }

    };

    InfoBiblio.prototype['events'] = {
      'mouseup': 'checkSelection'
    };

    InfoBiblio.prototype['ui'] = {
      'content': '.content',
      'externo': '.externo',
      'local': '.local'
    };

    return InfoBiblio;

  }).call(this);
  InputBiblioIn = (function() {
    class InputBiblioIn extends Marionette.View {
      ['updateInfo'](evt) {
        var obj;
        try {
          obj = (new Function(`return ${this.$el.val()}`))();
        } catch (error) {}
        if (obj) {
          App.info.$el.show();
          App.info.ui.content.text(obj.linkTitulo);
          App.info.ui.externo.attr('href', obj.urlExterno);
          return App.info.ui.local.attr('href', obj.urlLocal);
        }
      }

    };

    InputBiblioIn.prototype['events'] = {
      'change': 'updateInfo'
    };

    return InputBiblioIn;

  }).call(this);
  Biblio = class Biblio extends Marionette.Application {
    ['start']() {
      this.input = new InputBiblioIn({
        'el': '.bib-in'
      });
      this.output = new Marionette.View({
        'el': '.bib-out'
      });
      this.info = new InfoBiblio({
        'el': '.bib-info'
      });
      this.info.$el.hide();
      return console.log('start');
    }

  };
  window.App = new Biblio();
  return App.start();
});

// arr = [
//   {
//     "ano": "2004"
//     "autor": "BRASIL. Ministério da Saúde. Secretaria de Atenção à Saúde. Instituto Nacional de Câncer."
//     "titulo": "TNM: classificação de tumores malignos."
//     "etc":"281p. 6 ed. Rio de Janeiro: INCA/UICC,"
//     "url": "TNM.pdf"
//   }
// ]
