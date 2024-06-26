// Generated by CoffeeScript 2.7.0
define(['./ConteudoItemView', './UnidadesCollView', './ConteudosCollView', './SincronizadorView'], function(ConteudoView, UnidadesCollView, ConteudosCollView, SincronizadorView) {
  var ProgressoLayout;
  ProgressoLayout = (function() {
    class ProgressoLayout extends Marionette.LayoutView {
      initialize() {}

      sincroniza() {
        var flag_inscrito, self;
        console.log('sincroniza');
        self = this;
        // flag_inscrito = @estaInscrito()
        flag_inscrito = true;
        self.ui.sincText.removeClass('alert').removeClass('alert-info').removeClass('alert-danger').html('');
        self.ui.sincBar.parent().show();
        return setTimeout(function() {
          var mensagem;
          self.ui.sincBar.css({
            'width': '50%'
          });
          if (!navigator.onLine || !flag_inscrito || App.progresso.length === 0) {
            mensagem = 'Ocorreu um erro ao sincronizar seu progresso, verifique sua conexão e tente novamente.';
            // if not flag_inscrito
            //   mensagem = 'Para sincronizar seu processo você precisa estar inscrito em um conteúdo!'
            if (App.progresso.length === 0) {
              mensagem = 'Você ainda não possui progressos, faça alguma atividade e tente novamente!';
            }
            self.ui.sincText.addClass('alert alert-danger').html(mensagem);
            return self.ui.sincBar.parent().hide().children().css({
              'width': '10%'
            });
          } else {
            return App.execute('storeUser', App.user, function(dataUser) {
              var c, dt, i, len, mensagemErro, ref;
              console.log('retorno store sincronize', dataUser);
              if (!dataUser.ok && !dataUser.certificado) {
                self.ui.sincBar.parent().hide().children().css({
                  'width': '10%'
                });
                if (!dataUser.msg) {
                  return self.ui.sincText.addClass('alert alert-danger').html('Ocorreu um erro ao sincronizar seu progresso, verifique sua conexão e tente novamente.');
                } else {
                  return self.ui.sincText.addClass('alert alert-danger').html(dataUser.msg);
                }
              } else {
                dt = new Date();
                mensagemErro = 'Progresso sincronizado em: ' + dt.toLocaleString();
                if (dataUser.certificado) {
                  mensagemErro = '<ul class="list-group">';
                  ref = dataUser.certificado;
                  for (i = 0, len = ref.length; i < len; i++) {
                    c = ref[i];
                    console.log('uma certificada', c);
                    mensagemErro += "<li class='list-group-item'><a class='list-group-item' href='" + c.url_certificado + "'> Clique aqui para obter certificado: " + c.conteudo + "</a></li>";
                  }
                  mensagemErro += '</ul>';
                }
                setTimeout(function() {
                  return self.ui.sincBar.css({
                    'width': '100%'
                  });
                }, 1000);
                return setTimeout(function() {
                  self.ui.sincBar.parent().hide().children().css({
                    'width': '10%'
                  });
                  return self.ui.sincText.addClass('alert alert-info').html(mensagemErro);
                }, 1000);
              }
            });
          }
        }, 1000);
      }

      onRender() {
        var fl_integrador, g, integrador, nr_elegivel, oferta, ofertas, self, unidades, view;
        self = this;
        g = App.progresso.geral;
        ofertas = [];
        integrador = {};
        fl_integrador = window.modulo.fl_por_unidade;
        nr_elegivel = 0;
        if (fl_integrador) {
          unidades = _.where(window.modulo.components, {
            folder: 'unidade-progresso'
          });
          unidades = unidades.filter((u) => {
            return u.unidade;
          }).map(function(o) {
            var modelo;
            modelo = {
              'nome': o.short,
              'unidade': o.unidade,
              'bloqueada': o.bloqueada,
              'casos': o.resource.casos,
              'nucleo': 'Interdisciplinar',
              'cor': o.cor
            };
            modelo.percCasos = g.unidade[o.unidade]['percCasosConclu'].toFixed(1);
            modelo.percAcertoPreTeste = g.unidade[o.unidade]['percAcertoPreTeste'].toFixed(1);
            modelo.percAcertoPosTeste = g.unidade[o.unidade]['percAcertoPosTeste'].toFixed(1);
            modelo.lockTesteFinal = App["masterFinalLockUnidade"](o.unidade);
            modelo.fl_cert_casos_clinicos = (parseFloat(g.unidade[o.unidade]['percCasosConclu']) >= 70) || (modelo.casos.length === 0);
            modelo.fl_cert_pos_teste = parseFloat(g.unidade[o.unidade]['percAcertoPosTeste']) >= 70;
            modelo.elegivel = App["masterElegivelCertUnidade"](o.unidade);
            nr_elegivel = modelo.elegivel ? nr_elegivel + 1 : nr_elegivel;
            return ofertas.push(new Backbone.Model(modelo));
          });
          self['unidades'].show(new UnidadesCollView({
            collection: new Backbone.Collection(ofertas)
          }));
        } else {
          window.modulo.ofertasAbertas.forEach(function(o) {
            var conteudo, modelo;
            conteudo = o.conteudo;
            conteudo = conteudo[0].toUpperCase() + conteudo.slice(1);
            console.log(o, 'oferta');
            modelo = {
              'nome': o.nome,
              'tipo': o.tipo,
              'unidade': o.unidade,
              'nucleo': conteudo,
              'id_arouca': o.id_arouca
            };
            modelo.tipo = 'nucleo';
            modelo.percCasos = g['percCasosConcluNucleo' + conteudo].toFixed(1);
            modelo.percAcertoPreTeste = g['percAcertoPreTeste' + conteudo].toFixed(1);
            modelo.percAcertoPosTeste = g['percAcertoPosTeste' + conteudo].toFixed(1);
            modelo.elegivel = App["masterElegivelCert" + conteudo]();
            console.log("masElegivelCert" + conteudo, modelo.elegivel);
            modelo.lockTesteFinal = App["masterFinalLock" + conteudo]();
            modelo.fl_cert_casos_clinicos = parseFloat(g["percCasosConcluNucleo" + conteudo]) >= 70;
            modelo.fl_cert_pos_teste = parseFloat(g["percAcertoPosTeste" + conteudo]) >= 70;
            return self[o.conteudo].show(new ConteudoView({
              model: new Backbone.Model(modelo)
            }));
          });
        }
        if (fl_integrador) {
          oferta = new Backbone.Model(window.modulo.ofertasAbertas[0]);
          oferta.set('nucleo', 'Interdisciplinar');
          oferta.set('tipo', 'unidade');
          oferta.set('elegivel', nr_elegivel === unidades.length ? true : false);
          oferta.set('lockTesteFinal', false);
          oferta.set('fl_cert_casos_clinicos', false);
          oferta.set('fl_cert_pos_teste', false);
          view = new ConteudoView({
            model: oferta
          });
          return self['interdisciplinar'].show(view);
        }
      }

    };

    ProgressoLayout.prototype.className = 'progresso container';

    ProgressoLayout.prototype.template = '#progresso-main';

    ProgressoLayout.prototype.regions = {
      'medicina': '#medicina',
      'enfermagem': '#enfermagem',
      'odontologia': '#odontologia',
      'interdisciplinar': '#interdisciplinar',
      'unidades': '#unidades'
    };

    ProgressoLayout.prototype.ui = {
      'sinc': '.btn-sinc',
      'sincBar': '#progressbar-sinc',
      'btnMenu': '.titulo-block-progresso',
      'sincText': '.text-sinc-progresso'
    };

    ProgressoLayout.prototype.events = {
      'click @ui.sinc': 'sincroniza'
    };

    return ProgressoLayout;

  }).call(this);
  //console.log ofertas, oferta, 'oferta'
  return ProgressoLayout;
});
