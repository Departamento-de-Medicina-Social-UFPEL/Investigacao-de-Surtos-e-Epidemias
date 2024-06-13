// Generated by CoffeeScript 2.7.0
define(['backbone', 'backbone.marionette'], function(Backbone, Marionette) {
  var calcDiagSindromicoDorPelvicaMainView;
  calcDiagSindromicoDorPelvicaMainView = (function() {
    class calcDiagSindromicoDorPelvicaMainView extends Marionette.ItemView {
      initialize() {
        this.atual = 0;
        return this.indiceResultado = 6;
      }

      next() {
        if (this.ui.next.hasClass('disabled')) {
          return;
        }
        this.atual = this.$el.find('.item.active').data('indice');
        if (this.atual < this.indiceResultado) {
          this.atual++;
        }
        if (this.atual === this.indiceResultado) {
          this.ui.next.addClass('disabled');
        } else {
          this.ui.next.removeClass('disabled');
        }
        this.ui.prev.removeClass('disabled');
        this.trocaPara(this.atual);
        return this.changeDados();
      }

      trocaPara(indice) {
        this.$el.find('.item.active').hide();
        this.$el.find('.item.active').removeClass('active');
        if (indice === this.indiceResultado) {
          this.ui.prev.addClass('disabled');
          this.ui.next.addClass('disabled');
        }
        console.log('trocaPara', indice);
        this.$el.find('.item-' + indice).addClass('active').show();
        return this.$el.find('.p' + indice).addClass('active');
      }

      prev() {
        if (this.ui.next.hasClass('disabled')) {
          return;
        }
        this.atual = this.$el.find('.item.active').data('indice');
        this.$el.find('.item.active').hide();
        this.$el.find('.item.active').removeClass('active');
        if (this.atual > 1) {
          this.$el.find('.p' + this.atual).removeClass('active');
          this.atual--;
        }
        if (this.atual === '1') {
          this.ui.prev.addClass('disabled');
        } else {
          this.ui.prev.removeClass('disabled');
        }
        this.ui.next.removeClass('disabled');
        return this.$el.find('.item-' + this.atual).addClass('active').show();
      }

      inicio() {
        console.log('inicio');
        this.ui.li.removeClass('active');
        this.$el.find('.p1').addClass('active');
        this.$el.find('.item.active').hide();
        this.$el.find('.item.active').removeClass('active');
        this.ui.prev.addClass('disabled');
        this.ui.next.removeClass('disabled');
        $('.item-1').addClass('active');
        return this.$el.find('.item.active').show();
      }

      changeDados() {
        var conduta, nivel, respostas, tab;
        respostas = this.getDados();
        nivel = this.calculaEscore(respostas);
        tab = this.tabela;
        conduta = _.find(tab, function(item) {
          return item.nivel === nivel;
        });
        return this.ui.resp.html(conduta.descricao);
      }

      getDados() {
        return [this.ui.q1.filter(':checked').val(), this.ui.q2.filter(':checked').val(), this.ui.q3.filter(':checked').val(), this.ui.q4.filter(':checked').val(), this.ui.q5.filter(':checked').val()];
      }

      calculaEscore(d) {
        var escore;
        
        escore = 0;
        console.log(d, 'd', this.atual);
        if (d[0] === '1' && this.atual === 2) {
          escore = 0;
          this.trocaPara(this.indiceResultado);
        }
        if (d[0] === '2' && d[1] === '1' && this.atual === 3) {
          escore = 0;
          this.trocaPara(this.indiceResultado);
        }
        if (d[0] === '2' && d[1] === '2' && d[2] === '1' && d[3] === '1' && this.atual === 5) {
          escore = 0;
          this.trocaPara(this.indiceResultado);
        }
        if (d[0] === '2' && d[1] === '2' && d[2] === '1' && d[3] === '2' && d[4] === '2' && this.atual === 6) {
          escore = 0;
          this.trocaPara(this.indiceResultado);
        }
        if (d[0] === '2' && d[1] === '2' && d[2] === '2' && this.atual === 4) {
          escore = 1;
          this.trocaPara(this.indiceResultado);
        }
        if (d[0] === '2' && d[1] === '2' && d[2] === '1' && d[3] === '2' && d[4] === '1' && this.atual === 6) {
          escore = 2;
          this.trocaPara(this.indiceResultado);
        }
        console.log(escore, 'escore');
        return escore;
      }

      onRender(view) {
        this.ui.item.hide();
        this.$el.find('.item.active').show();
        this.ui.prev.addClass('disabled');
        this.$el.find('.p1').addClass('active');
        return this.changeDados();
      }

    };

    calcDiagSindromicoDorPelvicaMainView.prototype.model = new Backbone.Model();

    calcDiagSindromicoDorPelvicaMainView.prototype.className = 'item calculadoras diag-sindromico-dor-pelvica'; //calcDiagSindromicoDorPelvica'

    calcDiagSindromicoDorPelvicaMainView.prototype.template = '#calc-diag-sindromico-dor-pelvica-main';

    calcDiagSindromicoDorPelvicaMainView.prototype.ui = {
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
      'q5': 'input:radio[name="optionRadios5"]'
    };

    calcDiagSindromicoDorPelvicaMainView.prototype.events = {
      'click @ui.next': 'next',
      'click @ui.prev': 'prev',
      'click @ui.inicio': 'inicio',
      'change @ui.q1, @ui.q2, @ui.q3, @ui.q4, @ui.q5': 'changeDados'
    };

    calcDiagSindromicoDorPelvicaMainView.prototype.tabela = [
      {
        nivel: 0,
        descricao: "Referenciar",
        processos: []
      },
      {
        nivel: 1,
        descricao: "Investigar outras causas",
        processos: []
      },
      {
        nivel: 2,
        descricao: "Manter conduta, Enfatizar adesão ao tratamento",
        processos: []
      }
    ];

    return calcDiagSindromicoDorPelvicaMainView;

  }).call(this);
  return calcDiagSindromicoDorPelvicaMainView;
});