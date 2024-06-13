// Generated by CoffeeScript 2.7.0
define(['../collections/SlidesColl', './SlidesColl', './Introbox', 'utils'], function(SlidesColl, SlidesCollView, IntroboxView, utils) {
  var CasoView;
  CasoView = (function() {
    class CasoView extends Marionette.LayoutView {
      initialize() {
        this.atual = App.progresso.getByAtividadeId(this.model.get('_id')).length;
        return this.indiceResultado = this.model.get('slides').length;
      }

      next() {
        if (this.ui.next.hasClass('disabled')) {
          return;
        }
        this.atual = this.$el.find('li.active>.link-item').data('indice');
        if (this.atual < this.indiceResultado) {
          this.atual++;
        }
        if (this.atual === this.indiceResultado - 1) {
          this.ui.next.hide();
        } else {
          this.ui.next.show();
        }
        this.ui.prev.show();
        return this.trocaPara(this.atual);
      }

      trocaPara(indice) {
        this.atual = indice;
        console.log('trocaPara', indice);
        this.avancou(indice);
        if (indice === this.indiceResultado) {
          return;
        }
        this.$el.find('.item-' + (indice - 1)).addClass('hide');
        this.$el.find('.item-' + indice).addClass('active').removeClass('hide');
        this.$el.find('li.active').removeClass('active');
        return this.$el.find('.p' + indice).addClass('active');
      }

      prev() {
        if (this.ui.next.hasClass('disabled')) {
          return;
        }
        this.atual = this.$el.find('li.active>.link-item').data('indice');
        this.$el.find('.item.active').addClass('hide');
        this.$el.find('.item.active').removeClass('active');
        console.log(this.atual, 'atual');
        if (this.atual > 0) {
          this.$el.find('.p' + this.atual).removeClass('active');
          this.atual--;
        }
        if (this.atual === 0) {
          this.ui.prev.hide();
        } else {
          this.ui.prev.show();
        }
        this.ui.next.show();
        this.$el.find('.item-' + this.atual).addClass('active').removeClass('hide');
        return this.$el.find('.p' + this.atual).addClass('active');
      }

      avancou(indice) {
        var salvaResposta;
        if ((App.progresso.where({
          atividade: this.model.get('_id'),
          seqid: indice
        })).length === 0) {
          salvaResposta = {
            atividade: this.model.get('_id'),
            seqid: indice,
            modulo: window.modulo._id,
            marcadas: [1],
            escore: 100,
            ts: Date.now()
          };
          if (App.user) {
            return App.progresso.create(salvaResposta);
          }
        }
      }

      getRespostasDeste() {
        var respostas;
        if (!App.user) {
          return null;
        }
        return respostas = App.progresso.getByAtividadeId(this.model.get('_id'));
      }

      vaiParaOndeEstava() {}

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

      // vaiPraQuestaoDaVez: () ->
      //   page = $('html, body')
      //   page.on "scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove", ->
      //     do page.stop
      //     page.off "scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove"
      //   page.animate(
      //     scrollTop: $("section.slide.daVez").offset().top - 85
      //   , 600, -> page.off "scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove" )
      onRender() {
        var _this, slides, slidesView;
        // console.log @ui.estResp
        // console.log @model, @paciente
        this.allSlides = new SlidesColl(this.model.get('slides'), this.paciente, this.model);
        this.addRegions({
          introReg: '.caso #introducao',
          slidesReg: '.caso #slidesLista'
        });
        this.introReg.show(new IntroboxView({
          model: this.model
        }));
        slides = this.model.get('slides');
        if (slides[0].tipo === 'intro') {
          slides = slides.slice(1);
        }
        slidesView = new SlidesCollView({
          collection: new SlidesColl(slides, this.paciente, this.model)
        });
        this.slidesReg.show(slidesView);
        _this = this;
        this.trocaPara(this.atual === 0 ? 0 : this.atual - 1);
        if (this.atual === 0) {
          this.ui.prev.hide();
        } else {
          this.ui.prev.show();
        }
        if (this.atual === this.indiceResultado - 1) {
          this.ui.next.hide();
        } else {
          this.ui.next.show();
        }
        return setTimeout(function() {
          return $.material.init();
        }, 10);
      }

    };

    CasoView.prototype.className = 'saiba-mais-main container';

    CasoView.prototype.template = '#saiba-mais-main';

    CasoView.prototype.ui = {
      'item': '.item',
      'next': '.next',
      'prev': '.prev',
      'li': 'li',
      'inicio': '.inicio'
    };

    CasoView.prototype.events = {
      'click @ui.next': 'next',
      'click @ui.prev': 'prev',
      'click @ui.inicio': 'inicio'
    };

    return CasoView;

  }).call(this);
  return CasoView;
});