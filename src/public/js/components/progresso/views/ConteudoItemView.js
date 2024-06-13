// Generated by CoffeeScript 2.7.0
define(['./ErrorView'], function(ErrorView) {
  var ConteudoView;
  ConteudoView = (function() {
    class ConteudoView extends Marionette.ItemView {
      initialize() {
        if (App.socket) {
          this.model.set({
            'fl_cert_conectado': App.socket.connected
          });
        }
        this.model.set('fl_inscrito', false);
        this.model.set('fl_concluinte', false);
        return this.model.set('cumpriuTempoMinimoParaCertificacao', false);
      }

      // 'click @ui.checkCaso': 'paraClick'
      // 'click @ui.checkInternet': 'paraClick'
      // 'click @ui.checkTeste': 'paraClick'
      inscreva() {
        //console.log 'inscreva-se'
        return App.appRouter.navigate('#comp/cadastro', {
          'trigger': true
        });
      }

      trocaCor(evt) {
        var ckVal, modiNovo, modiOld;
        ckVal = $(evt.target).prop("checked");
        modiNovo = ckVal ? "success" : "danger";
        modiOld = !ckVal ? "success" : "danger";
        return $(evt.target).parent().parent().removeClass('check-' + modiOld).addClass('check-' + modiNovo);
      }

      paraClick(evt) {
        evt.preventDefault();
        return evt.stopPropagation();
      }

      verificaEnquetes() {
        var enquetes;
        if (App.enquetes && App.user) {
          if (App.user.enquetes) {
            if (App.user.enquetes[App.moduloId]) {
              enquetes = App.user.enquetes[App.moduloId];
              if (enquetes['conclusao']) {
                return;
              }
            }
          }
          return Backbone.history.navigate('#comp/enquetes/intro/' + App.user.cpf + '/tipo/conclusao', {
            trigger: true
          });
        }
      }

      emitirCertificado(evt) {
        var abreCertificado, self, url;
        self = this;
        //console.log("certificado")
        evt.stopPropagation();
        //if not @model.get('cumpriuTempoMinimoParaCertificacao')
        //  do App.modals.destroyAll
        //  App.modals.show(new ErrorView({link:false,titulo:"Erro  ao emitir certificado", msg:"Você não pode certificar, verifique os critérios na tela de progresso!"}))
        //  return
        abreCertificado = function(data) {
          var veSeExiste;
          window.externa = {};
          veSeExiste = function(msg) {
            if (!window.externa) {
              alert(msg);
              return false;
            }
            return true;
          };
          if (window.externa.alert) {
            window.externa.close();
          }
          window.externa = window.open(data.url, 'externa');
          return setTimeout(veSeExiste, 1000, "Destive o bloqueador de pop-ups para acessar o seu certificado.");
        };
        if (self.model.get('url_certificado')) {
          return abreCertificado({
            url: self.model.get('url_certificado')
          });
        }
        url = "https://" + window.location.host + "/arouca/certifica/oferta/" + self.model.get('id_arouca') + "/user/" + App.user.cpf;
        // respostas = JSON.stringify do App.progresso.toJSON
        // if not @model.elegivel
        //   do App.modals.destroyAll
        //   App.modals.show(new ErrorView({link:false,titulo:"Erro  ao emitir certificado", msg:"Você não pode certificar, verifique os critérios na tela de progresso!"}))
        //   return
        self.verificaEnquetes();
        // return
        self.ui.barCertificado.show();
        self.ui.barCertificado.children().css({
          'width': '50%'
        });
        return $.ajax({
          "type": "post",
          "url": url,
          "success": abreCertificado,
          "error": function(err) {
            var resp;
            App.modals.destroyAll();
            resp = {
              titulo: "Erro ao emitir certificado",
              msg: err.responseJSON.msg,
              url: '',
              link: false
            };
            if (err.responseJSON.certificado) {
              resp.link = {
                url: err.responseJSON.certificado,
                descricao: "Acesse aqui para emitir a 2˚ via dos seus certificados!"
              };
            }
            return App.modals.show(new ErrorView(resp));
          },
          "complete": function() {
            self.ui.barCertificado.children().css({
              'width': '100%'
            });
            return self.ui.barCertificado.hide().children().css({
              'width': '10%'
            });
          }
        });
      }

      emitirDesempenho(evt) {
        var self, url;
        //console.log 'desempenho'
        self = this;
        //console.log("certificado")
        evt.stopPropagation();
        url = "https://" + window.location.host + "/arouca/desempenho/oferta/" + self.model.get('id_arouca') + "/user/" + App.user.cpf;
        // respostas = JSON.stringify do App.progresso.toJSON
        //console.log @model.get('elegivel'), 'fls', @model.get('fl_concluinte')
        if (!this.model.get('elegivel') && !this.model.get('fl_concluinte')) {
          App.modals.destroyAll();
          App.modals.show(new ErrorView({
            titulo: "Erro ao emitir declaração de desempenho",
            msg: "Você só pode imprimir a declaração de desempenho após certificar!",
            link: false
          }));
          return;
        }
        self.ui.barDesempenho.show();
        self.ui.barDesempenho.children().css({
          'width': '50%'
        });
        return $.ajax({
          "type": "post",
          "url": url,
          "success": function(data) {
            var veSeExiste;
            //console.log data, 'url'
            window.externa = {};
            veSeExiste = function(msg) {
              if (!window.externa) {
                alert(msg);
                return false;
              }
              return true;
            };
            if (window.externa.alert) {
              window.externa.close();
            }
            window.externa = window.open(data.url, 'externa');
            return setTimeout(veSeExiste, 1000, "Destive o bloqueador de pop-ups para acessar o seu desempenho.");
          },
          "error": function(err) {
            var modelo;
            App.modals.destroyAll();
            modelo = {
              titulo: "Erro ao emitir declaração de desempenho",
              msg: err.responseJSON.msg,
              link: {
                url: err.responseJSON.url,
                descricao: 'Contatar Suporte informando seu cpf e nome do módulo.'
              }
            };
            return App.modals.show(new ErrorView(modelo));
          },
          "complete": function() {
            self.ui.barDesempenho.children().css({
              'width': '100%'
            });
            return self.ui.barDesempenho.hide().children().css({
              'width': '10%'
            });
          }
        });
      }

      verificaInscricao() {
        var diaMinimoParaCertificacao, fl_inscrito, hoje, self, url_certificado;
        self = this;
        diaMinimoParaCertificacao = new Date();
        hoje = new Date();
        fl_inscrito = false;
        url_certificado = "";
        if (App.user.ofertas) {
          App.user.ofertas.forEach(function(o) {
            var diasParaCertificacao;
            if (o.modulo === App.moduloId && o.conteudo === self.model.get('nucleo').toLowerCase() && o.dt_conclusao) {
              self.model.set('id_arouca', o.id_arouca);
              self.model.set('url_certificado', o.url_certificado);
              return self.model.set('fl_concluinte', true);
            } else if (o.id_arouca === self.model.get('id_arouca')) {
              fl_inscrito = true;
              diasParaCertificacao = o.modulo.tempoMinimoParaCertificacao ? o.modulo.tempoMinimoParaCertificacao : 5;
              diaMinimoParaCertificacao = new Date(o.dt_cadastro);
              diaMinimoParaCertificacao.setDate(diaMinimoParaCertificacao.getDate() + diasParaCertificacao);
              //console.log(hoje, diaMinimoParaCertificacao, hoje >= diaMinimoParaCertificacao)
              //self.model.set 'cumpriuTempoMinimoParaCertificacao', hoje >= diaMinimoParaCertificacao 
              return self.model.set('cumpriuTempoMinimoParaCertificacao', true);
            }
          });
        }
        self.model.set('fl_inscrito', fl_inscrito);
        //console.log('model', self.model)
        if (fl_inscrito || self.model.get("fl_concluinte")) {
          self.$el.find("input[value=" + self.model.get('id_arouca') + "]").prop('checked', true);
          self.ui.linkInscricao.hide();
          self.ui.flInscrito.addClass('check-success');
          if (self.model.get('cumpriuTempoMinimoParaCertificacao')) {
            self.ui.flInscritoCriterio.addClass('check-success');
            if (self.model.get('elegivel')) {
              self.ui.emitirCertificado.attr('disabled', false);
            }
          } else {
            self.ui.flInscritoCriterio.addClass('check-danger');
          }
          if (self.model.get("fl_concluinte")) {
            self.ui.flInscrito.html("<div style='margin-left: 7px;padding: 2px;'>Você já concluiu este conteúdo!</div>");
            self.ui.criterios.hide();
            self.ui.concluinte.show();
            self.ui.emitirDesempenho.attr('disabled', false);
            return self.ui.emitirCertificado.attr('disabled', false);
          } else {
            self.ui.criterios.show();
            return self.ui.concluinte.hide();
          }
        } else {
          self.ui.flInscrito.addClass('check-danger');
          self.ui.flInscritoCriterio.addClass('check-danger');
          return self.ui.linkInscricao.show();
        }
      }

      onRender() {
        this.verificaInscricao();
        this.$el.addClass(this.model.get('nucleo').toLowerCase());
        this.ui.checkInscrito.prop("checked", this.model.get('fl_inscrito') && this.model.get('cumpriuTempoMinimoParaCertificacao'));
        this.ui.checkCaso.prop("checked", this.model.get('fl_cert_casos_clinicos'));
        this.ui.checkUnidades.prop("checked", this.model.get('elegivel'));
        this.ui.checkTeste.prop("checked", this.model.get('fl_cert_pos_teste'));
        return this.ui.checkInternet.prop("checked", this.model.get('fl_cert_conectado'));
      }

    };

    //console.log(@model, 'model enf')
    ConteudoView.prototype.className = 'enf-med-main panel panel-default';

    ConteudoView.prototype.template = '#progresso-conteudo-nucleo';

    ConteudoView.prototype.ui = {
      'emitirCertificado': '.btn-emitir-certificado',
      'emitirDesempenho': '.btn-emitir-desempenho',
      'checkInscrito': '#check-box-inscrito',
      'checkCaso': '#check-box-casos-clinicos',
      'checkUnidades': '#check-box-todas-unidades',
      'checkTeste': '#check-box-pos-teste',
      'checkInternet': '#check-box-internet',
      'linkInscricao': '.link-inscricao',
      'flInscrito': '#fl-inscrito',
      'flInscritoCriterio': '.check-box-inscrito',
      'barDesempenho': '.progresso-desempenho',
      'barCertificado': '.progresso-certificado',
      'todosChecks': "input[type='checkbox']",
      'concluinte': ".concluinte",
      'criterios': ".criterios"
    };

    ConteudoView.prototype.events = {
      'click @ui.emitirCertificado': 'emitirCertificado',
      'click @ui.emitirDesempenho': 'emitirDesempenho',
      'click @ui.flInscrito': 'inscreva',
      'change @ui.checkInscrito': 'trocaCor',
      'change @ui.checkCaso': 'trocaCor',
      'change @ui.checkUnidades': 'trocaCor',
      'change @ui.checkInternet': 'trocaCor',
      'change @ui.checkTeste': 'trocaCor',
      'click @ui.todosChecks': 'paraClick'
    };

    return ConteudoView;

  }).call(this);
  //@model.elegivel = App['masterElegivelCert'+@model.get('nucleo')]()
  //console.log @model.elegivel, 'elegivelMed'

  //console.log 'cumpriuTempoMinimoParaCertificacao', @model.get('cumpriuTempoMinimoParaCertificacao')
  //console.log 'elegivel', @model.get('elegivel')
  //console.log 'fl_concluinte', @model.get('fl_concluinte')
  return ConteudoView;
});