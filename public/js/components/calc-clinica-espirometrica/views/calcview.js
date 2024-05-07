// Generated by CoffeeScript 1.8.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['backbone', 'backbone.marionette'], function(Backbone, Marionette) {
  var complexidadePacienteAdMainView;
  complexidadePacienteAdMainView = (function(_super) {
    __extends(complexidadePacienteAdMainView, _super);

    function complexidadePacienteAdMainView() {
      return complexidadePacienteAdMainView.__super__.constructor.apply(this, arguments);
    }

    complexidadePacienteAdMainView.prototype.model = new Backbone.Model;

    complexidadePacienteAdMainView.prototype.className = 'item calculadoras complexidadePacienteAd';

    complexidadePacienteAdMainView.prototype.template = '#calc-clinica-espirometrica-main';

    complexidadePacienteAdMainView.prototype.ui = {
      'resp': '.resultado',
      'item': '.item',
      'next': '#next',
      'prev': '#prev',
      'li': 'li',
      'inicio': '.inicio',
      'processo': '.processoTrabalho',
      'q1': 'input:radio[name="optionRadios1"]',
      'q2': 'input:radio[name="optionRadios2"]',
      'q3': 'input:radio[name="optionRadios3"]',
      'q4': 'input:radio[name="optionRadios4"]',
      'q5': 'input:radio[name="optionRadios5"]',
      'q6': 'input:radio[name="optionRadios6"]',
      'q7': 'input:radio[name="optionRadios7"]',
      'q8': 'input:radio[name="optionRadios8"]',
      'q9': 'input:radio[name="optionRadios9"]'
    };

    complexidadePacienteAdMainView.prototype.events = {
      'click @ui.next': 'next',
      'click @ui.prev': 'prev',
      'click @ui.inicio': 'inicio',
      'change @ui.q1, @ui.q2, @ui.q3, @ui.q4, @ui.q5, @ui.q6, @ui.q7, @ui.q8, @ui.q9': 'changeDados'
    };

    complexidadePacienteAdMainView.prototype.next = function() {
      var atual;
      console.log('next');
      atual = this.$el.find('.item.active').data('indice');
      this.$el.find('.item.active').hide();
      this.$el.find('.item.active').removeClass('active');
      if (atual < 10) {
        atual++;
      }
      console.log(atual, 'next', this.ui.next);
      if (atual === 10) {
        this.ui.next.attr('disabled', 'disabled');
      } else {
        this.ui.next.removeAttr('disabled');
      }
      this.ui.prev.removeAttr('disabled');
      this.$el.find('.item-' + atual).addClass('active').show();
      return this.$el.find('.p' + atual).addClass('active');
    };

    complexidadePacienteAdMainView.prototype.prev = function() {
      var atual;
      atual = this.$el.find('.item.active').data('indice');
      console.log('prev', atual);
      this.$el.find('.item.active').hide();
      this.$el.find('.item.active').removeClass('active');
      if (atual > 1) {
        this.$el.find('.p' + atual).removeClass('active');
        atual--;
      }
      console.log(atual, 'prev');
      if (atual === '1') {
        this.ui.prev.attr('disabled', 'disabled');
      } else {
        this.ui.prev.removeAttr('disabled');
      }
      this.ui.next.removeAttr('disabled');
      return this.$el.find('.item-' + atual).addClass('active').show();
    };

    complexidadePacienteAdMainView.prototype.inicio = function() {
      console.log('inicio');
      this.ui.li.removeClass('active');
      this.$el.find('.p1').addClass('active');
      this.$el.find('.item.active').hide();
      this.$el.find('.item.active').removeClass('active');
      this.ui.prev.attr('disabled', 'disabled');
      this.ui.next.removeAttr('disabled');
      $('.item-1').addClass('active');
      return this.$el.find('.item.active').show();
    };

    complexidadePacienteAdMainView.prototype.changeDados = function() {
      var conduta, item, nivel, respostas, tab, _results;
      respostas = this.getDados();
      console.log('dados', this.getDados());
      nivel = this.calculaEscore(respostas);
      console.log('nivel', nivel);
      tab = this.tabela;
      console.log(tab, 'tab');
      conduta = _.find(tab, function(item) {
        return item.nivel === nivel;
      });
      console.log(conduta, 'conduta', conduta.descricao);
      this.ui.resp.html(conduta.descricao);
      this.ui.processo.empty();
      _results = [];
      for (item in conduta.processos) {
        _results.push(this.ui.processo.append("<li class='list-group-item'>" + conduta.processos[item] + "</li>"));
      }
      return _results;
    };

    complexidadePacienteAdMainView.prototype.getDados = function() {
      return [this.ui.q1.filter(':checked').val(), this.ui.q2.filter(':checked').val(), this.ui.q3.filter(':checked').val(), this.ui.q4.filter(':checked').val(), this.ui.q5.filter(':checked').val(), this.ui.q6.filter(':checked').val(), this.ui.q7.filter(':checked').val(), this.ui.q8.filter(':checked').val(), this.ui.q9.filter(':checked').val()];
    };

    complexidadePacienteAdMainView.prototype.calculaEscore = function(d) {
      var escore, item;
      escore = 0;
      console.log(d, 'd');
      for (item in d) {
        console.log(item, 'item');
        if (item !== void 0) {
          escore = escore + (parseInt(d[item]));
        }
      }
      return escore;
    };

    complexidadePacienteAdMainView.prototype.tabela = [
      {
        nivel: 0,
        descricao: "Nível 0",
        processos: ["Paciente com sua capacidade funcional preservada e baixo risco de agravos à saúde, sem indicação para assistência domiciliar.", " Acompanhamento habitual da ESF."]
      }, {
        nivel: 1,
        descricao: "Nível 1",
        processos: ["Visita mensal de ACS.", "Visita da enfermagem trimestral.", "Atendimento médico semestral (ou pelo tempo máximo pertinente à prescrição médica) e em casos de intercorrências."]
      }, {
        nivel: 2,
        descricao: "Nível 2",
        processos: ["Visita mensal de ACS.", "Visita da enfermagem bimestral e atendimento em casos de intercorrências.", "Atendimento médico quadrimestral e atendimento em casos de intercorrências.", "Atendimento do técnico de enfermagem ou enfermeiro quando indicado e prescrito pela equipe (exemplo: cobertura para úlceras de membros). Acionar a Emad–1 em casos extremos, quando a necessidade de atenção superar a capacidade de oferta da ESF."]
      }, {
        nivel: 3,
        descricao: "Nível 3",
        processos: ["Visita mensal de ACS.", "Visita da enfermagem mensal e atendimento em casos de intercorrências.", "Atendimento médico bimestral e atendimento em casos de intercorrências.", "Atendimento do técnico de enfermagem ou enfermeiro quando indicado e prescrito pela equipe.", "Atendimento do Serviço Social de suporte se necessário.", "Acionar a Emad–1 em caso da necessidade de atenção, superar a capacidade de oferta da ESF."]
      }
    ];

    complexidadePacienteAdMainView.prototype.onRender = function(view) {
      this.ui.item.hide();
      this.$el.find('.item.active').show();
      this.ui.prev.attr('disabled', 'disabled');
      this.$el.find('.p1').addClass('active');
      return this.changeDados();
    };

    return complexidadePacienteAdMainView;

  })(Marionette.ItemView);
  return complexidadePacienteAdMainView;
});
