// Generated by CoffeeScript 1.8.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['../models/Paciente', '../collections/SlidesColl', './SlidesColl', './Introbox', './Paciente', 'utils'], function(PacienteModel, SlidesColl, SlidesCollView, IntroboxView, PacienteView, utils) {
  var TesteView;
  TesteView = (function(_super) {
    __extends(TesteView, _super);

    function TesteView() {
      return TesteView.__super__.constructor.apply(this, arguments);
    }

    TesteView.prototype.className = 'caso-main';

    TesteView.prototype.initialize = function() {};

    TesteView.prototype.template = '#teste-progresso-main';

    TesteView.prototype.ui = {
      estResp: '.caso .estadoResposta',
      confirmaReset: '.caso #estadoResposta #confirmaRecomeca',
      recomeca: '#btnRecomeca',
      continua: '#btnContinua'
    };

    TesteView.prototype.events = {
      'click @ui.estResp #btnRecomeca': 'confirmaRecomeca',
      'click @ui.estResp #btnContinua': 'vaiPraQuestaoDaVez'
    };

    TesteView.prototype.vaiPraQuestaoDaVez = function() {
      var page;
      page = $('html, body');
      page.on("scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove", function() {
        page.stop();
        return page.off("scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove");
      });
      return page.animate({
        scrollTop: $("section.slide.daVez").offset().top - 85
      }, 600, function() {
        return page.off("scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove");
      });
    };

    TesteView.prototype.confirmaRecomeca = function() {
      var self;
      self = this;
      this.ui.confirmaReset.modal({
        keyboard: false
      });
      return this.ui.confirmaReset.find('#delete').on('click', function() {
        var page, respDest, resposta, _i, _len;
        respDest = App.progresso.getByAtividadeId(self.model.get('_id'));
        for (_i = 0, _len = respDest.length; _i < _len; _i++) {
          resposta = respDest[_i];
          resposta.destroy();
        }
        App.progresso.calculaProgressoGeral();
        App.progresso.trigger('change');
        page = $('html, body');
        page.removeClass('modal-open');
        return Backbone.history.loadUrl(Backbone.history.fragment);
      });
    };

    TesteView.prototype.onRender = function() {
      var handlerAtualizaProgresso, slidesView, _this;
      this.allSlides = new SlidesColl(this.model.get('slides'), this.paciente, this.model);
      this.addRegions({
        introReg: '.caso #introducao',
        pacienteReg: '.caso #pacienteTopo',
        slidesReg: '.caso #slidesLista'
      });
      this.introReg.show(new IntroboxView({
        model: this.model
      }));
      slidesView = new SlidesCollView({
        collection: new SlidesColl(this.model.get('slides'), this.paciente, this.model)
      });
      this.slidesReg.show(slidesView);
      _this = this;
      handlerAtualizaProgresso = function() {
        return this.getRespostasDeste();
      };
      if (App.user) {
        this.listenTo(App.progresso, 'fetched change', handlerAtualizaProgresso);
      }
      if (App.progresso) {
        App.progresso.temNovosBadges(true);
      }
      setTimeout(function() {
        return $.material.init();
      }, 10);
      this.getRespostasDeste();
      return this.verificaConcluinte();
    };

    TesteView.prototype.getRespostasDeste = function() {
      var respostas;
      if (!App.user) {
        return null;
      }
      respostas = App.progresso.getByAtividadeId(this.model.get('_id'));
      if (respostas.length > 0) {
        this.model.set({
          respostas: respostas
        });
        this.assinalaMarcadas();
        return this.trigger('novasRespostas');
      }
    };

    TesteView.prototype['assinalaMarcadas'] = function() {
      var casoId, mediaG, questoes, respostas, self, slides, soma, texto;
      self = this;
      if (!this.slidesReg) {
        setTimeout(function() {
          return self.assinalaMarcadas;
        }, 300);
        return null;
      }
      casoId = this.model.get('_id');
      slides = this.slidesReg.currentView.children;
      respostas = this.model.get('respostas');
      if (!slides) {
        return null;
      }
      questoes = slides.filter(function(view) {
        return view.model.get('tipo').match(/questao.*/ig);
      });
      soma = respostas.reduce(function(memo, resp) {
        return memo + resp.get('escore');
      }, 0);
      mediaG = soma / respostas.length;
      texto = '';
      this.ui.estResp.find('.mensagem').empty();
      if (respostas.length === questoes.length) {
        this.ui.estResp.find('#btnContinua').hide();
        this.ui.estResp.find('#btnRecomeca').removeClass('btn-xs').addClass('btn-sm');
        texto = "Você já respondeu todas as " + questoes.length + " questões deste teste.";
        this.ui.estResp.find('.mensagem').append($('<p></p>').text(texto));
        texto = "Sua média de acertos final foi de " + (mediaG.toFixed(2).replace('.', ',')) + "%.";
        this.ui.estResp.find('.mensagem').append($('<p></p>').text(texto));
      } else {
        texto = "Você já respondeu " + respostas.length + " das " + questoes.length + " questões deste teste.";
        this.ui.estResp.find('.mensagem').append($('<p></p>').text(texto));
        texto = "Sua média de acertos até agora é de " + (mediaG.toFixed(2).replace('.', ',')) + "%.";
        this.ui.estResp.find('.mensagem').append($('<p></p>').text(texto));
      }
      this.ui.estResp.removeClass('hide').show();
      return respostas.forEach(function(resposta) {
        var e, marca, marcadas, opcs, quest, seqid, _i, _len;
        seqid = resposta.get('seqid');
        quest = questoes[seqid];
        opcs = quest.$el.find('.opcoes');
        marcadas = resposta.get('marcadas');
        for (_i = 0, _len = marcadas.length; _i < _len; _i++) {
          marca = marcadas[_i];
          e = opcs.find("[data-originalidx=\"" + marca + "\"]:input");
          e.attr('checked', true);
          e.parent().removeClass('unchecked').addClass('checked');
        }
        quest.silent = true;
        quest.tocado();
        return quest.ui.btnResp.click();
      });
    };

    TesteView.prototype.verificaConcluinte = function() {
      var self;
      self = this;
      return App.user.ofertas.forEach(function(o) {
        if (o.modulo === App.moduloId && (o.conteudo === self.model.get('profissional').toLowerCase() || o.conteudo === 'interdisciplinar') && o.dt_conclusao) {
          self.ui.recomeca.hide();
          return self.ui.continua.hide();
        }
      });
    };

    return TesteView;

  })(Marionette.LayoutView);
  return TesteView;
});
