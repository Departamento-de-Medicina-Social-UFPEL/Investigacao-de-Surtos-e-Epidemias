// Generated by CoffeeScript 1.8.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['./OfertaInscricaoItem'], function(OfertaInscricaoItem) {
  var TestesLayout;
  TestesLayout = (function(_super) {
    __extends(TestesLayout, _super);

    function TestesLayout() {
      return TestesLayout.__super__.constructor.apply(this, arguments);
    }

    TestesLayout.prototype.initialize = function() {};

    TestesLayout.prototype.className = 'selecao-testes-progresso container';

    TestesLayout.prototype.template = '#selecao-testes-progresso-testes';

    TestesLayout.prototype.ui = {
      'inscricoes': '.inscricoes'
    };

    TestesLayout.prototype.onRender = function() {
      var self;
      return self = this;
    };

    TestesLayout.prototype.events = {
      'click .gotoTestes': 'gotoTestes',
      'click .gotoInicialEnfermagem': 'gotoInicialEnfermagem',
      'click .gotoFinalEnfermagem': 'gotoFinalEnfermagem',
      'click .gotoInicialMedicina': 'gotoInicialMedicina',
      'click .gotoFinalMedicina': 'gotoFinalMedicina',
      'click .gotoInicialOdontologia': 'gotoInicialOdontologia',
      'click .gotoFinalOdontologia': 'gotoFinalOdontologia',
      'click .emitir-certificado': 'emitirCertificado'
    };

    TestesLayout.prototype.gotoHome = function() {
      return Backbone.history.navigate('#comp/home', {
        trigger: true
      });
    };

    TestesLayout.prototype.gotoInicialInterdisciplinar = function() {
      var inicialDaPro, _id;
      if (!App.user) {
        this.gotoHome();
      }
      inicialDaPro = App.testes.filter(function(d) {
        return /inicial/img.test(d.get('titulo'));
      })[0];
      if (!inicialDaPro) {
        Backbone.history.navigate("comp/selecao-testes-progresso", {
          trigger: true
        });
      }
      _id = inicialDaPro.get('_id');
      return Backbone.history.navigate("comp/teste-progresso/" + _id, {
        trigger: true
      });
    };

    TestesLayout.prototype.gotoInicialEnfermagem = function() {
      var inicialDaPro, proMap, uPro, _id;
      if (!App.user) {
        this.gotoHome();
      }
      proMap = {
        '1': 1,
        '2': 0,
        '3': 2
      };
      uPro = proMap['1'];
      inicialDaPro = App.testes.filter(function(d) {
        return /inicial/img.test(d.get('titulo')) && d.get('pro')[uPro];
      })[0];
      if (!inicialDaPro) {
        Backbone.history.navigate("comp/selecao-testes-progresso", {
          trigger: true
        });
      }
      _id = inicialDaPro.get('_id');
      return Backbone.history.navigate("comp/teste-progresso/" + _id, {
        trigger: true
      });
    };

    TestesLayout.prototype.gotoInicialMedicina = function() {
      var inicialDaPro, proMap, uPro, _id;
      if (!App.user) {
        this.gotoHome();
      }
      proMap = {
        '1': 1,
        '2': 0,
        '3': 2
      };
      uPro = proMap['2'];
      inicialDaPro = App.testes.filter(function(d) {
        return /inicial/img.test(d.get('titulo')) && d.get('pro')[uPro];
      })[0];
      if (!inicialDaPro) {
        Backbone.history.navigate("comp/selecao-testes-progresso", {
          trigger: true
        });
      }
      _id = inicialDaPro.get('_id');
      return Backbone.history.navigate("comp/teste-progresso/" + _id, {
        trigger: true
      });
    };

    TestesLayout.prototype.gotoInicialOdontologia = function() {
      var inicialDaPro, proMap, uPro, _id;
      if (!App.user) {
        this.gotoHome();
      }
      proMap = {
        '1': 1,
        '2': 0,
        '3': 2
      };
      uPro = proMap['3'];
      inicialDaPro = App.testes.filter(function(d) {
        return /inicial/img.test(d.get('titulo')) && d.get('pro')[uPro];
      })[0];
      if (!inicialDaPro) {
        Backbone.history.navigate("comp/selecao-testes-progresso", {
          trigger: true
        });
      }
      _id = inicialDaPro.get('_id');
      return Backbone.history.navigate("comp/teste-progresso/" + _id, {
        trigger: true
      });
    };

    TestesLayout.prototype.gotoFinalInterdisciplinar = function() {
      var finalDaPro, _id;
      if (!App.user) {
        this.gotoHome();
      }
      if (App.masterFinalLockInterdisciplinar) {
        return Backbone.history.navigate("comp/home/teste-bloqueado", {
          trigger: true
        });
      }
      finalDaPro = App.testes.filter(function(d) {
        return /final/img.test(d.get('titulo')) && d.get('pro')[uPro];
      })[0];
      _id = finalDaPro.get('_id');
      return Backbone.history.navigate("comp/teste-progresso/" + _id, {
        trigger: true
      });
    };

    TestesLayout.prototype.gotoFinalEnfermagem = function() {
      var finalDaPro, proMap, uPro, _id;
      if (!App.user) {
        this.gotoHome();
      }
      proMap = {
        '1': 1,
        '2': 0,
        '3': 2,
        '0': 9
      };
      uPro = proMap['1'];
      if (App.masterFinalLockEnfermagem) {
        return Backbone.history.navigate("comp/home/teste-bloqueado", {
          trigger: true
        });
      }
      finalDaPro = App.testes.filter(function(d) {
        return /final/img.test(d.get('titulo')) && d.get('pro')[uPro];
      })[0];
      _id = finalDaPro.get('_id');
      return Backbone.history.navigate("comp/teste-progresso/" + _id, {
        trigger: true
      });
    };

    TestesLayout.prototype.gotoFinalMedicina = function() {
      var finalDaPro, proMap, uPro, _id;
      if (!App.user) {
        this.gotoHome();
      }
      proMap = {
        '1': 1,
        '2': 0,
        '3': 2,
        '0': 9
      };
      uPro = proMap['2'];
      if (App.masterFinalLockMedicina()) {
        return Backbone.history.navigate("comp/home/teste-bloqueado", {
          trigger: true
        });
      }
      finalDaPro = App.testes.filter(function(d) {
        return /final/img.test(d.get('titulo')) && d.get('pro')[uPro];
      })[0];
      _id = finalDaPro.get('_id');
      return Backbone.history.navigate("comp/teste-progresso/" + _id, {
        trigger: true
      });
    };

    TestesLayout.prototype.gotoFinalOdontologia = function() {
      var finalDaPro, proMap, uPro, _id;
      if (!App.user) {
        this.gotoHome();
      }
      proMap = {
        '1': 1,
        '2': 0,
        '3': 2,
        '0': 9
      };
      uPro = proMap['3'];
      if (App.masterFinalLockOdontologia()) {
        return Backbone.history.navigate("comp/home/teste-bloqueado", {
          trigger: true
        });
      }
      finalDaPro = App.testes.filter(function(d) {
        return /final/img.test(d.get('titulo')) && d.get('pro')[uPro];
      })[0];
      _id = finalDaPro.get('_id');
      return Backbone.history.navigate("comp/teste-progresso/" + _id, {
        trigger: true
      });
    };

    return TestesLayout;

  })(Marionette.LayoutView);
  return TestesLayout;
});
