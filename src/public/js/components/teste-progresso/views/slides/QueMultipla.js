// Generated by CoffeeScript 2.7.0
define([], function() {
  var SlideQueMultipla;
  SlideQueMultipla = (function() {
    class SlideQueMultipla extends Marionette.ItemView {
      initialize() {
        return console.log(this.model, 'modelo');
      }

      template(data) {
        var opcs;
        if (_.isArray(data.conteudo.opcoes[0])) {
          opcs = data.conteudo.opcoes.map(function(arrOp, i) {
            return {
              correta: arrOp[1],
              texto: arrOp[0],
              originalIdx: i
            };
          });
          if (!data.dontShuffle) {
            // console.log 'data.dontShuffle----------->', data.dontShuffle
            data.conteudo.opcoes = _.shuffle(opcs);
          }
        }
        // console.log data.conteudo.opcoes
        return _.template($('script#teste-progresso-slides-queMultipla').html())(data);
      }

      onRender() {
        console.log(this.model.get('conteudo').resposta.texto, 'modelo teste render');
        this.ui.btnResp.addClass('disabled btn-default').text('Selecione');
        this.bind('respondeu', function(self, tipo, desempenho, media) {});
        // console.log desempenho, media, [arguments]
        return this.verificaConcluinte();
      }

      responde(evt) {
        if (!this.ehTocado) {
          evt.stopPropagation();
          evt.preventDefault();
          return null;
        }
        this.ui.opts.bind('click', function() {
          return false;
        });
        this.ui.btnResp.hide();
        this.ui.opts.addClass('disabled').css({
          color: '#888'
        }).on('click', function() {
          return false;
        });
        this.ui.opts.find(':input').attr('tabIndex', '-1');
        return this.corrige();
      }

      getMarcadas() {
        var map, mapArr, mapArrFiltered;
        // console.log @ui.opts
        map = this.ui.opts.map(function(k, opt) {
          var i;
          i = $(opt).find('input');
          if (i.is(':checked')) {
            return i.data('originalidx');
          } else {
            return null;
          }
        });
        mapArr = map.toArray();
        mapArrFiltered = mapArr.filter(function(e) {
          return typeof e === 'number';
        });
        // console.log map, mapArr, mapArrFiltered
        return mapArrFiltered;
      }

      getCorretas() {
        return this.model.get('conteudo').opcoes;
      }

      corrige() {
        var acertoBadge, acertos, azul, badge, conceito, corr, desempenho, div, ico, media, opcoes, page, resp, salvaResposta, score, scoreAtu, self, strConceito, tipo, totalScore, verde, vermelho;
        self = this;
        corr = this.getCorretas();
        resp = this.getMarcadas();
        // console.log corr, resp
        opcoes = this.ui.opts;
        // console.log opcoes

          // cores da correção
        [vermelho, azul, verde] = ['#e74c3c', '#3498db', '#27ae60'];
        desempenho = [];
        // console.log '_(corr).each (correta, key) ->',opcoes
        corr.forEach(function(opcao, key) {
          var correta, labelOpcao, marcada;
          labelOpcao = self.ui.opts.find(`:input[data-originalidx="${opcao.originalIdx}"]`).parent();
          marcada = $(labelOpcao).find(':input').is(':checked');
          correta = opcao.correta;
          // console.log """
          // OP #{opcao.originalIdx} ( #{if marcada then '*' else ' '} ) #{$(labelOpcao).text().trim()}
          //    opção #{if correta then 'correta' else 'incorreta'}, você #{if !marcada then 'não ' else ''}marcou e #{if correta is marcada then 'acertou' else 'errou'}.
          // """
          labelOpcao.css({
            opacity: '.7'
          });
          labelOpcao.find(':input').css({
            cursor: 'default'
          });
          if (correta) {
            // opcao é correta
            labelOpcao.css('color', azul);
          }
          // acertou porque marcou
          if (correta === marcada) {
            if (correta) {
              labelOpcao.css('color', verde);
            }
            desempenho.push(true);
          }
          if (!correta && marcada) {
            labelOpcao.css('color', vermelho);
            desempenho.push(false);
          }
          if (correta && !marcada) {
            // errou porque não marcou
            return desempenho.push(false);
          }
        });
        // console.log 'desempenho', desempenho
        acertos = (desempenho.filter(function(c) {
          return c;
        })).length;
        media = parseInt(acertos / desempenho.length * 100, 10);
        // console.log acertos, media
        this.ui.corrPorCent.text(media);
        ico = (function() {
          switch (false) {
            case !(media >= 70):
              return 'checkbox-marked-circle';
            case !(media >= 50):
              return 'alert-circle';
            default:
              return 'close-circle';
          }
        })();
        tipo = (function() {
          switch (false) {
            case !(media >= 70):
              return 'success';
            case !(media >= 50):
              return 'warning';
            default:
              return 'danger';
          }
        })();
        this.ui.corrIco.addClass(`mdi-${ico}`);
        this.ui.correcao.removeClass('out hide').addClass(`alert-${tipo} in`);
        this.ui.saiba.removeClass('out hide').addClass('in');
        conceito = $('li.score');
        scoreAtu = parseInt(conceito.data('score'));
        if (scoreAtu === 0) {
          conceito.find('.tit-conceito').text('Conceito');
        }
        totalScore = scoreAtu + media;
        div = 2;
        if (scoreAtu === 0) {
          div = 1;
        }
        score = totalScore / div;
        conceito.data('score', score);
        // console.log "score #{score}"
        strConceito = this.getConceito(score);
        conceito.find('.conceito').text(strConceito);
        if (!this.silent) {
          salvaResposta = {
            atividade: this.model.collection.caso.get('_id'),
            seqid: this.$el.data('seqid'),
            marcadas: this.getMarcadas(),
            modulo: window.modulo._id,
            escore: media,
            ts: Date.now()
          };
          if (App.user) {
            App.progresso.create(salvaResposta);
          }
          page = $('html, body');
          page.on("scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove", function() {
            page.stop();
            return page.off("scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove");
          });
          page.animate({
            scrollTop: self.$el.find('.opcoes').offset().top - 85
          }, 300, function() {
            return page.off("scroll mousedown wheel DOMMouseScroll mousewheel keyup touchmove");
          });
        }
        acertoBadge = (function() {
          switch (false) {
            case tipo !== 'success':
              return 'correto';
            case tipo !== 'warning':
              return 'meio';
            default:
              return 'errado';
          }
        })();
        badge = $('li.quest > span[target="' + this.$el.prop('id') + '"]');
        badge.addClass('corrigido');
        badge.addClass(`${acertoBadge}`);
        this.respondido = true;
        return this.trigger('respondeu', this, tipo, desempenho, media);
      }

      ['getConceito'](conceito) {
        switch (false) {
          case !(conceito >= 95):
            return 'A+';
          case !(conceito >= 90):
            return 'A';
          case !(conceito >= 80):
            return 'B+';
          case !(conceito >= 70):
            return 'B';
          case !(conceito >= 60):
            return 'C+';
          case !(conceito >= 50):
            return 'C';
          case !(conceito >= 40):
            return 'D+';
          case !(conceito >= 30):
            return 'D';
          case !(conceito >= 20):
            return 'E+';
          default:
            return 'E';
        }
      }

      ['tocado'](evt) {
        var self;
        self = this;
        this.ehTocado = true;
        if (this.respondido) {
          // if !@respondido and /label/img.test evt.target.tagName
          //   $(evt.target).find('input').prop('checked', (idx, oldAttr)-> !oldAttr )
          return false;
        }
        // console.log arguments, @, do @getMarcadas
        return setTimeout(function(self) {
          var respostas;
          respostas = self.getMarcadas();
          // console.log respostas
          if (respostas.length !== 0) {
            // console.log self
            return self.ui.btnResp.removeClass('disabled btn-default').addClass('btn-info').text('Responder');
          } else {
            return self.ui.btnResp.removeClass('btn-info').addClass('btn-default disabled').text('Selecione');
          }
        }, 100, this);
      }

      verificaConcluinte() {
        var self;
        self = this;
        return App.user.ofertas.forEach(function(o) {
          var nucleos;
          nucleos = self.model.get('profissional');
          if (o.modulo === App.moduloId && (nucleos.indexOf(o.conteudo) > -1 || o.conteudo === 'interdisciplinar') && o.dt_conclusao) {
            return self.ui.btnResp.hide();
          }
        });
      }

    };

    SlideQueMultipla.prototype.className = 'container-fluid questao';

    SlideQueMultipla.prototype.tagName = 'section';

    SlideQueMultipla.prototype.ui = {
      btnResp: 'button.responder',
      opts: '.checkbox',
      saiba: '.resposta',
      correcao: '.alert',
      corrPorCent: '.alert h2.porcentagem span.valor',
      corrIco: '.alert i'
    };

    SlideQueMultipla.prototype.events = {
      'click button.responder': 'responde',
      'click .checkbox': 'tocado'
    };

    SlideQueMultipla.prototype.ehTocado = false;

    SlideQueMultipla.prototype.respondido = false;

    return SlideQueMultipla;

  }).call(this);
  return SlideQueMultipla;
});
