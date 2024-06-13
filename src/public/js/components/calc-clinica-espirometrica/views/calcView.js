// Generated by CoffeeScript 2.7.0
define(['backbone', 'backbone.marionette'], function(Backbone, Marionette) {
  var complexidadePacienteAdMainView;
  complexidadePacienteAdMainView = (function() {
    class complexidadePacienteAdMainView extends Marionette.ItemView {
      next() {
        var atual;
        console.log('next');
        atual = this.$el.find('.item.active').data('indice');
        this.$el.find('.item.active').hide();
        this.$el.find('.item.active').removeClass('active');
        if (atual < 8) {
          atual++;
        }
        console.log(atual, 'next', this.ui.next);
        if (atual === 8) {
          this.ui.next.attr('disabled', 'disabled');
        } else {
          this.ui.next.removeAttr('disabled');
        }
        this.ui.prev.removeAttr('disabled');
        this.$el.find('.item-' + atual).addClass('active').show();
        this.$el.find('.p' + atual).addClass('active');
        //$('.item-'+atual)
        return this.changeDados();
      }

      prev() {
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
      }

      inicio() {
        console.log('inicio');
        this.ui.li.removeClass('active');
        this.$el.find('.p1').addClass('active');
        this.$el.find('.item.active').hide();
        this.$el.find('.item.active').removeClass('active');
        this.ui.prev.attr('disabled', 'disabled');
        this.ui.next.removeAttr('disabled');
        $('.item-1').addClass('active');
        return this.$el.find('.item.active').show();
      }

      changeDados() {
        var conduta, item, nivel, respostas, results, tab;
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
        results = [];
        for (item in conduta.processos) {
          results.push(this.ui.processo.append("<li class='list-group-item'>" + conduta.processos[item] + "</li>"));
        }
        return results;
      }

      getDados() {
        return [this.ui.q1.filter(':checked').val(), this.ui.q2.filter(':checked').val(), this.ui.q3.filter(':checked').val(), this.ui.q4.filter(':checked').val(), this.ui.q5.filter(':checked').val(), this.ui.q6.filter(':checked').val(), this.ui.q7.filter(':checked').val()];
      }

      calculaEscore(d) {
        var escore;
        
        escore = 0;
        console.log(d, 'd');
        if (d[0] === '1' && d[1] === '1' && d[2] === '1' && d[3] === '1' && d[4] === '1' && d[5] === '1' && d[6] === '1') {
          escore = 0;
        }
        if (d[0] === '2' && d[1] === '2' && d[2] === '2' && d[3] === '2' && d[4] === '2' && d[5] === '1' && d[6] === '2') {
          escore = 1;
        }
        if (d[0] === '3' && d[1] === '3' && d[2] === '3' && d[3] === '2' && d[4] === '2' && d[5] === '2' && d[6] === '3') {
          escore = 2;
        }
        if ((d[0] === '3' || d[0] === '4') && d[1] === '4' && d[2] === '3' && d[3] === '3' && d[4] === '2' && d[5] === '3' && d[6] === '3') {
          escore = 3;
        }
        return escore;
      }

      onRender(view) {
        this.ui.item.hide();
        this.$el.find('.item.active').show();
        this.ui.prev.attr('disabled', 'disabled');
        this.$el.find('.p1').addClass('active');
        return this.changeDados();
      }

    };

    complexidadePacienteAdMainView.prototype.model = new Backbone.Model();

    complexidadePacienteAdMainView.prototype.className = 'item calculadoras clinica-espirometrica'; //complexidadePacienteAd'

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
      'change @ui.q1, @ui.q2, @ui.q3, @ui.q4, @ui.q5, @ui.q6, @ui.q7': 'changeDados'
    };

    complexidadePacienteAdMainView.prototype.tabela = [
      {
        nivel: 0,
        descricao: "Intermitente",
        processos: []
      },
      {
        nivel: 1,
        descricao: "Persistente leve",
        processos: []
      },
      {
        nivel: 2,
        descricao: "Persistente Moderada",
        processos: []
      },
      {
        nivel: 3,
        descricao: "Persistente grave",
        processos: []
      }
    ];

    return complexidadePacienteAdMainView;

  }).call(this);
  return complexidadePacienteAdMainView;
});