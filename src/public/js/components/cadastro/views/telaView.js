// Generated by CoffeeScript 2.7.0
define(['backbone.modal', 'utils', 'uf_municipios'], function(ModalView, utils, Uf) {
  var Modal;
  return Modal = (function() {
    class Modal extends Backbone.Modal {
      initialize(user1) {
        this.user = user1;
        if (App.user) {
          return this.cadastro = true;
        } else {
          return this.cadastro = false;
        }
      }

      onRender() {
        var b, cx, o;
        this.montaComboEstados();
        this.user = App.local.get('user');
        // console.log @cadastro, "cadastro", App.moduloId
        if (this.cadastro) {
          //$('.form-group').show()
          $(".form-group[data-estagio=" + this.estagio + "]").show();
          this.$el.find('.btn-avancar').hide();
          this.$el.find('.btn-voltar').hide();
          this.$el.find('.submit-form').css({
            display: 'inline-block'
          });
          this.$el.find('.close-modal').css({
            display: 'inline-block'
          });
          this.$el.find('.form-group').show();
          this.$el.find('.termos').show();
          this.$el.find('#inputCpf').attr('disabled', true);
          this.$el.find('.ja-cadastrado').hide();
          this.marcaInscritas();
        }
        if (window.modulo.ofertasAbertas.length === 1) {
          o = window.modulo.ofertasAbertas[0];
          cx = "input[value=" + o.id_arouca + "]";
          this.$el.find(cx).prop('checked', true);
        }
        $('.bbm-modal--open').css({
          "margin-bottom": "235px"
        });
        b = $('body');
        if (this.user) {
          this.fillForm();
        }
        if (!b.is(':visible')) {
          b.fadeIn();
        }
        return setTimeout((function() {
          return window.$.material.init();
        }), 10);
      }

      marcaInscritas() {
        var hoje, self;
        self = this;
        if (!this.user) {
          return;
        }
        hoje = new Date();
        console.log(this.user.ofertas, 'ofertas do usuario');
        if (this.user.ofertas) {
          return this.user.ofertas.forEach(function(o) {
            var cx;
            if (o.modulo === App.moduloId) { //and ( (new Date(o.data_inicio)) <= hoje and (new Date(o.data_fim_matricula)) >= hoje  )
              cx = "input[value=" + o.id_arouca + "]";
              return self.$el.find(cx).prop('checked', true);
            }
          });
        }
      }

      obtemOfertas() {
        var ofertasInscritas;
        ofertasInscritas = [];
        ofertasInscritas = window.modulo.ofertasAbertas.filter(function(o) {
          return $('input[value="' + o.id_arouca + '"]').is(':checked') === true;
        });
        return ofertasInscritas;
      }

      onDestroy() {
        // console.log 'destroy cadastro', App.appRouter.historico[App.appRouter.historico.length-2]
        $('body').removeAttr('style').css({
          display: 'block'
        });
        $('body').css({
          'overflow': 'auto'
        });
        return App.appRouter.navigate('/', {
          'trigger': true
        });
      }

      fillForm() {
        var check, input, j, l, len, len1, ref, ref1, results;
        console.log(this.user, 'user');
        this.$el.find('#inputNome').val(this.user.nome);
        this.$el.find('#inputNomeMae').val(this.user.nomeMae);
        this.$el.find('#inputCpf').val(this.user.cpf);
        this.$el.find('#inputEmail').val(this.user.email);
        if (this.user.profissional) {
          this.$el.find('#inputNucleoProfissional').val(this.user.profissional);
        }
        if (this.user.nucleo_profissional) {
          this.$el.find('#inputNucleoProfissional').val(this.user.nucleo_profissional);
        }
        this.$el.find('#dataNasc_dia').val(this.user.dataNasc_dia);
        this.$el.find('#dataNasc_mes').val(this.user.dataNasc_mes);
        this.$el.find('#dataNasc_ano').val(this.user.dataNasc_ano);
        this.$el.find('#dataNasc_ano').val(this.user.dataNasc_ano);
        this.$el.find('[name=ibge]').val(this.user.ibge);
        this.montaComboEstados();
        this.obtemMunicipios();
        this.$el.find('#concorda-termos').attr('checked', 'checked');
        this.$el.find('[value="' + this.user.sexo + '"]').prop('checked', true);
        this.$el.find('#mala_direta').attr('checked', this.user.mala_direta);
        this.$el.find('#inputCpf').attr('disabled', 'disabled');
        //@$el.find('#inputNome, #inputNomeMae, #inputCpf, #inputEmail, #dataNasc_dia, #dataNasc_mes, #dataNasc_ano, input[name=sexo]').attr('disabled', 'disabled')
        if (!modulo.fl_layout_alternativo) {
          return;
        }
        ref = ['alt_anos_vigilancia_sus', 'alt_nome_profissao', 'alt_tempo_profissao'];
        for (j = 0, len = ref.length; j < len; j++) {
          input = ref[j];
          if (this.user[input]) {
            $('[name=' + input + ']').val(this.user[input]);
          }
        }
        ref1 = ['alt_atua_ambulatorio_especializado', 'alt_atua_atencao_basica', 'alt_atua_filantropico', 'alt_atua_gestao_saude', 'alt_atua_hospital_emergencia', 'alt_atua_no_sus', 'alt_atua_pesquisa', 'alt_atua_pronto_atendimento', 'alt_atua_saude_privada', 'alt_atuou_vigilancia_sus', 'alt_genero', 'alt_profissao', 'alt_qual_profissao', 'alt_raca_cor'];
        results = [];
        for (l = 0, len1 = ref1.length; l < len1; l++) {
          check = ref1[l];
          if (this.user[check]) {
            results.push($('[name=' + check + '][value="' + this.user[check] + '"]').prop('checked', true));
          } else {
            results.push(void 0);
          }
        }
        return results;
      }

      beforeSubmit(ev) {
        var infoAlternativa, validUser;
        console.log('submit-form');
        // if not @cadastro
        //   return
        this.hadFocus = this.$el.find('a.btn.submit-form');
        this.$el.find('.btn').attr('disabled', true);
        this.$el.find('input').attr('disabled', true);
        this.$el.find('select').attr('disabled', true);
        validUser = this.validaForm(false);
        infoAlternativa = modulo.fl_layout_alternativo ? this.validaEstagio2() : true;
        if (validUser && infoAlternativa) {
          validUser = Object.assign({}, validUser, infoAlternativa);
          this.salvaUser(validUser);
        } else {
          this.$el.find('.btn').removeAttr('disabled');
          this.$el.find('input').removeAttr('disabled');
          this.$el.find('select').removeAttr('disabled');
        }
        return false;
      }

      layoutAlternativoMudouProfissao() {
        if ($('#alt_profissao:checked').val() === 'Profissional') {
          return $('#alt_se_eh_trabalhador').show();
        } else {
          return $('#alt_se_eh_trabalhador').hide();
        }
      }

      layoutAlternativoMudouAtuacaoSus() {
        if ($('#alt_atuou_vigilancia_sus:checked').val() !== "N") {
          return $('#alt_se_atuou_sus').show();
        } else {
          return $('#alt_se_atuou_sus').hide();
        }
      }

      voltar() {
        this.estagio = this.estagio - 1;
        console.log('estagio ', this.estagio + 1, ' -> ', this.estagio);
        return this.mostraEstagio();
      }

      avancar() {
        if (this.estagio === 0 && !this.validaEstagio0()) {
          return;
        } else if (this.estagio === 1 && !this.validaEstagio1()) {
          return;
        }
        if (this.estagio !== 1 || modulo.fl_layout_alternativo) {
          this.estagio = this.estagio + 1;
        }
        console.log('estagio ', this.estagio - 1, ' -> ', this.estagio);
        return this.mostraEstagio();
      }

      mostraEstagio() {
        this.limpaErro();
        $('.termos[data-estagio=1]').hide();
        $('.form-group[data-estagio=1]').hide();
        $('.form-group[data-estagio=2]').hide();
        $('.form-group[data-estagio=3]').hide();
        if (this.estagio === 0) {
          return this.estagio0();
        } else if (this.estagio === 1) {
          return this.estagio1();
        } else if (this.estagio === 2) {
          return this.estagio2();
        }
      }

      estagio0() {}

      // Vazio propositalmente.
      validaEstagio0() {
        var cpf;
        cpf = utils.pretty.dig(this.$el.find('#inputCpf').val());
        if (!(cpf.length === 11 && utils.valCPF(cpf))) { //and not App.usuarios.at(0)
          this.$el.find('#inputCpf').parent().addClass('has-warning');
          this.$el.find('#inputCpf').focus();
          this.exibeErro('O CPF inserido é inválido.<br>');
          return false;
        }
        return true;
      }

      estagio2() {
        $('.form-group[data-estagio=2]').show();
        $('.submit-form').show();
        $('.btn-voltar').show();
        $('.btn-avancar').hide();
        // Refresh
        this.layoutAlternativoMudouProfissao();
        return this.layoutAlternativoMudouAtuacaoSus();
      }

      validaEstagio2(silent = false) {
        var data, mensagemErro, ref;
        data = {};
        mensagemErro = '';
        if ($('[name=alt_raca_cor]:checked').length === 0) {
          $('[name=alt_raca_cor]').parent().addClass('has-error');
          mensagemErro += 'Raça/Cor é um campo obrigatório!<br>';
        } else {
          data.alt_raca_cor = $('[name=alt_raca_cor]:checked').val();
        }
        if ($('[name=alt_genero]:checked').length === 0) {
          $('[name=alt_genero]').parent().addClass('has-error');
          mensagemErro += 'Gênero é um campo obrigatório!<br>';
        } else {
          data.alt_genero = $('[name=alt_genero]:checked').val();
        }
        if ($('[name=alt_profissao]:checked').length === 0) {
          $('[name=alt_profissao]').parent().addClass('has-error');
          mensagemErro += 'Profissão é um campo obrigatório!<br>';
        } else {
          data.alt_profissao = $('[name=alt_profissao]:checked').val();
          if (data.alt_profissao === 'Profissional' && $('[name=alt_tempo_profissao]').val() === '') {
            $('[name=alt_tempo_profissao]').parent().addClass('has-error');
            mensagemErro += 'Tempo de profissão é um campo obrigatório!<br>';
          } else {
            data.alt_tempo_profissao = $('[name=alt_tempo_profissao]').val();
          }
        }
        if ($('[name=alt_qual_profissao]:checked').length === 0) {
          $('[name=alt_qual_profissao]').parent().addClass('has-error');
          mensagemErro += 'Nome da profissão é um campo obrigatório!<br>';
        } else {
          data.alt_qual_profissao = $('[name=alt_qual_profissao]:checked').val();
          if (data.alt_qual_profissao === 'Outro' && $('[name=alt_nome_profissao]').val() === '') {
            $('[name=alt_nome_profissao]').parent().addClass('has-error');
            mensagemErro += 'Nome da profissão é um campo obrigatório!<br>';
          } else {
            data.alt_nome_profissao = $('[name=alt_nome_profissao]').val();
          }
        }
        if ($('[name=alt_atua_no_sus]:checked').length === 0) {
          $('[name=alt_atua_no_sus]').parent().addClass('has-error');
          mensagemErro += 'Area de atuação é um campo obrigatório!<br>';
        } else {
          data.alt_atua_no_sus = $('[name=alt_atua_no_sus]:checked').val();
        }
        if ($('[name=alt_atua_filantropico]:checked').length === 0) {
          $('[name=alt_atua_filantropico]').parent().addClass('has-error');
          mensagemErro += 'Area de atuação é um campo obrigatório!<br>';
        } else {
          data.alt_atua_filantropico = $('[name=alt_atua_filantropico]:checked').val();
        }
        if ($('[name=alt_atua_saude_privada]:checked').length === 0) {
          $('[name=alt_atua_saude_privada]').parent().addClass('has-error');
          mensagemErro += 'Area de atuação é um campo obrigatório!<br>';
        } else {
          data.alt_atua_saude_privada = $('[name=alt_atua_saude_privada]:checked').val();
        }
        if ($('[name=alt_atua_atencao_basica]:checked').length === 0) {
          $('[name=alt_atua_atencao_basica]').parent().addClass('has-error');
          mensagemErro += 'Area de atuação é um campo obrigatório!<br>';
        } else {
          data.alt_atua_atencao_basica = $('[name=alt_atua_atencao_basica]:checked').val();
        }
        if ($('[name=alt_atua_ambulatorio_especializado]:checked').length === 0) {
          $('[name=alt_atua_ambulatorio_especializado]').parent().addClass('has-error');
          mensagemErro += 'Area de atuação é um campo obrigatório!<br>';
        } else {
          data.alt_atua_ambulatorio_especializado = $('[name=alt_atua_ambulatorio_especializado]:checked').val();
        }
        if ($('[name=alt_atua_pronto_atendimento]:checked').length === 0) {
          $('[name=alt_atua_pronto_atendimento]').parent().addClass('has-error');
          mensagemErro += 'Area de atuação é um campo obrigatório!<br>';
        } else {
          data.alt_atua_pronto_atendimento = $('[name=alt_atua_pronto_atendimento]:checked').val();
        }
        if ($('[name=alt_atua_hospital_emergencia]:checked').length === 0) {
          $('[name=alt_atua_hospital_emergencia]').parent().addClass('has-error');
          mensagemErro += 'Area de atuação é um campo obrigatório!<br>';
        } else {
          data.alt_atua_hospital_emergencia = $('[name=alt_atua_hospital_emergencia]:checked').val();
        }
        if ($('[name=alt_atua_gestao_saude]:checked').length === 0) {
          $('[name=alt_atua_gestao_saude]').parent().addClass('has-error');
          mensagemErro += 'Area de atuação é um campo obrigatório!<br>';
        } else {
          data.alt_atua_gestao_saude = $('[name=alt_atua_gestao_saude]:checked').val();
        }
        if ($('[name=alt_atua_pesquisa]:checked').length === 0) {
          $('[name=alt_atua_pesquisa]').parent().addClass('has-error');
          mensagemErro += 'Area de atuação é um campo obrigatório!<br>';
        } else {
          data.alt_atua_pesquisa = $('[name=alt_atua_pesquisa]:checked').val();
        }
        if ($('[name=alt_atuou_vigilancia_sus]:checked').length === 0) {
          $('[name=alt_atuou_vigilancia_sus]').parent().addClass('has-error');
          mensagemErro += 'Area de atuação é um campo obrigatório!<br>';
        } else {
          data.alt_atuou_vigilancia_sus = $('[name=alt_atuou_vigilancia_sus]:checked').val();
          if (((ref = data.alt_atuou_vigilancia_sus) === 'S' || ref === 'A') && $('[name=alt_anos_vigilancia_sus]').val() === '') {
            $('[name=alt_anos_vigilancia_sus]').parent().addClass('has-error');
            mensagemErro += 'Area de atuação é um campo obrigatório!<br>';
          } else {
            data.alt_anos_vigilancia_sus = $('[name=alt_anos_vigilancia_sus]').val();
          }
        }
        if (!silent) {
          this.exibeErro(mensagemErro);
        }
        if (mensagemErro === '') {
          return data;
        } else {
          return null;
        }
      }

      verificaIntegracao() {
        var fl_integrador_marcada, inscricoes, oferta_integradora, self, soFaltaUma;
        inscricoes = [];
        this.$el.find('.conteudos').filter(':checked').map(function(k, i) {
          return inscricoes.push($(i).val());
        });
        fl_integrador_marcada = false;
        oferta_integradora = null;
        self = this;
        window.modulo.ofertasAbertas.forEach(function(o) {
          if (o.tipo === 'integrador') {
            oferta_integradora = o;
          }
          if (inscricoes.indexOf(o.id_arouca) > -1) {
            if (o.tipo === 'integrador') {
              self.$el.find('.conteudos').prop({
                'checked': true
              });
              return fl_integrador_marcada = true;
            }
          }
        });
        soFaltaUma = window.modulo.ofertasAbertas.length - 1 === inscricoes.length;
        if (soFaltaUma && !fl_integrador_marcada && oferta_integradora) {
          return this.$el.find('[value="' + oferta_integradora.id_arouca + '"]').prop('checked', true);
        }
      }

      normalDateNumber(evt) {
        var str;
        this.hadFocus = $(evt.target);
        str = $(evt.target).val().replace(/\D/g, "");
        return $(evt.target).val(str);
      }

      validaEstagio1() {
        var cpf;
        console.log(this.validaForm(false));
        cpf = utils.pretty.dig(this.$el.find('#inputCpf').val());
        if (!(cpf.length === 11 && utils.valCPF(cpf))) { //and not App.usuarios.at(0)
          this.$el.find('#inputCpf').parent().addClass('has-warning');
          this.$el.find('#inputCpf').focus();
          this.exibeErro('O CPF inserido é inválido.<br>');
          return false;
        }
        return true;
      }

      estagio1(evt) {
        var cpf, local, progresso, self, socket;
        self = this;
        this.$el.find('.btn-avancar').attr('disabled', true); // Desabilita enquanto procura pelo usuário.
        $('.submit-form').hide();
        $('.btn-voltar').hide();
        $('.btn-avancar').show();
        ({local, socket, progresso} = App);
        if (!socket) {
          return;
        }
        cpf = utils.pretty.dig(this.$el.find('#inputCpf').val());
        console.log("emit getuser", App.moduloId);
        return socket.emit('getuser', {
          cpf: cpf,
          modulo: App.moduloId
        }, function(resposta) {
          var c, erroServidor, j, len, mensagemErro, ref, u;
          console.log("ENCONTREI UM USER\n", resposta);
          if (resposta.ok) {
            if (resposta.user.cpf !== cpf) {
              self.exibeErro("O usuário encontrado tem um cpf diferente! Contate o suporte técnico (suporte.moodle.esf@gmail.com), informando seu cpf e nome do módulo.");
              self.$el.find('.btn-avancar').attr('disabled', false);
              erroServidor = "Conflito de cpf enviado: " + cpf + " recebido " + resposta.user.cpf;
              socket.emit('senderror', erroServidor, function(r) {
                return console.log('erro salvo no servidor');
              });
              return;
            } else {
              console.log(resposta.user, '<- aqui esta');
              u = resposta.user;
              self.cadastro = true;
              if (u.profissional) {
                u['nucleo_profissional'] = u.profissional;
              } else {
                u['profissional'] = u.nucleo_profissional;
              }
              self.user = u;
              if (self.user) {
                self.fillForm();
              }
              if (self.user) {
                self.marcaInscritas();
              }
            }
          } else {
            console.log('tentei buscar user porem:', resposta.msg);
            mensagemErro = '<h3>' + resposta.msg + '</h3>';
            if (resposta.certificado) {
              App.local.set('user', null);
              App.user = null;
              mensagemErro += '<ul class="list-group">';
              ref = resposta.certificado;
              for (j = 0, len = ref.length; j < len; j++) {
                c = ref[j];
                console.log('uma certificada', c);
                mensagemErro += "<li><a class='list-group-item' style='color:white' href='" + c.url_certificado + "'> Para obter a 2˚ via do seu certificado acesse aqui: " + c.conteudo + "</a></li>";
              }
              mensagemErro += '</ul>';
              self.exibeErro(mensagemErro);
            }
          }
          if (!resposta.certificado) {
            if (modulo.fl_layout_alternativo) {
              self.$el.find('.btn-avancar').attr('disabled', false);
              self.$el.find('.btn-voltar').hide();
            } else {
              self.$el.find('.btn-avancar').hide();
              self.$el.find('.submit-form').css({
                display: 'inline-block'
              });
            }
            self.$el.find('.close-modal').css({
              display: 'inline-block'
            });
            $('.form-group[data-estagio=1]').show();
            $('.termos[data-estagio=1]').show();
          } else {
            self.$el.find('.btn-avancar').attr('disabled', false);
          }
          return $('.bbm-modal--open').css({
            "margin-bottom": "235px"
          });
        });
      }

      limpaErro() {
        return $('.alert').empty();
      }

      exibeErro(mensagemErro) {
        this.$el.find('.alert').addClass('alert-danger');
        this.limpaErro();
        this.$el.find('.alert').append(mensagemErro);
        return this.$el.find('.alert').show();
      }

      temNucleo(evt) {
        var nc;
        nc = this.$el.find('#inputNucleoProfissional').find('option:selected').val();
        if (nc === '-1' || nc === '0') {
          return this.$el.find('.temNucleo').hide();
        } else {
          return this.$el.find('.temNucleo').show();
        }
      }

      prettyNome(evt) {
        var str;
        this.hadFocus = $(evt.target);
        str = $(evt.target).val();
        str = utils.pretty.name(str);
        return $(evt.target).val(str);
      }

      // do @validaForm
      normalCpf(evt) {
        var str;
        this.hadFocus = $(evt.target);
        str = $(evt.target).val();
        str = utils.pretty.dig(str);
        return $(evt.target).val(str);
      }

      // do @validaForm
      normalEmail(evt) {
        var str;
        this.hadFocus = $(evt.target);
        str = $(evt.target).val();
        str = str.toLowerCase();
        return $(evt.target).val(str);
      }

      // do @validaForm
      limpaError(evt) {
        this.$el.find('.alert').removeClass('alert-warning alert-success').hide();
        return $(evt.target).parent().removeClass('has-error has-success has-warning');
      }

      concorda(evt) {
        var chk, el;
        el = $(evt.target);
        chk = el.attr('checked');
        if (chk === 'checked') {
          return el.removeAttr('checked');
        }
        return el.attr('checked', 'checked');
      }

      validaForm(silent = true) {
        var ano, campo, campoProblema, concorda, cpf, dia, email, ibge, mala_direta, mensagemErro, mes, municipio, nome, nomeMae, nucleo, obj, ofertasUsuario, self, sexo, uf;
        self = this;
        campoProblema = [];
        mensagemErro = '';
        concorda = this.$el.find('#concorda-termos').attr('checked');
        mala_direta = this.$el.find('#mala_direta').is(':checked');
        if (this.$el.find('#inputCpf').val() === '') {
          campoProblema.push(this.$el.find('#inputCpf'));
          this.$el.find('#inputCpf').parent().addClass('has-error');
          mensagemErro += 'CPF é um campo obrigatório.<br>';
        } else {
          cpf = utils.pretty.dig(this.$el.find('#inputCpf').val());
          if (utils.valCPF(cpf) && cpf.length === 11) {
            this.$el.find('#inputCpf').parent().addClass('has-success');
          } else {
            mensagemErro += 'O CPF inserido é inválido.<br>';
            this.$el.find('#inputCpf').parent().addClass('has-warning');
            this.$el.find('#inputCpf').focus();
          }
        }
        if (this.$el.find('#inputNome').val() === '') {
          campoProblema.push(this.$el.find('#inputNome'));
          this.$el.find('#inputNome').parent().addClass('has-error');
          mensagemErro += 'Nome é um campo obrigatório.<br>';
        } else {
          nome = this.$el.find('#inputNome').val();
          this.$el.find('#inputNome').parent().addClass('has-success');
        }
        //data nascimento
        if (this.$el.find('[name="dataNasc_dia"]').val() === '' || this.$el.find('[name="dataNasc_mes"]').val() === '' || this.$el.find('[name="dataNasc_ano"]').val() === '') {
          campoProblema.push(this.$el.find('[name="dataNasc_dia"]'));
          this.$el.find('[name="dataNasc_dia"]').parent().addClass('has-error');
          this.$el.find('[name="dataNasc_mes"]').parent().addClass('has-error');
          this.$el.find('[name="dataNasc_ano"]').parent().addClass('has-error');
          mensagemErro += 'Data de nascimento é um campo obrigatório!<br>';
        } else {
          dia = this.$el.find('[name="dataNasc_dia"]').val();
          mes = this.$el.find('[name="dataNasc_mes"]').val();
          ano = this.$el.find('[name="dataNasc_ano"]').val();
          this.$el.find('[name="dataNasc_dia"]').parent().addClass('has-success');
          this.$el.find('[name="dataNasc_mes"]').parent().addClass('has-success');
          this.$el.find('[name="dataNasc_ano"]').parent().addClass('has-success');
        }
        //sexo
        sexo = this.$el.find('[name="sexo"]:checked').val();
        if (!sexo) {
          campoProblema.push(this.$el.find('[name=sexo]'));
          this.$el.find('[name=sexo]').parent().addClass('has-error');
          mensagemErro += 'Sexo é um campo obrigatório!<br>';
        }
        if (this.$el.find('#inputNomeMae').val() === '') {
          campoProblema.push(this.$el.find('#inputNomeMae'));
          this.$el.find('#inputNomeMae').parent().addClass('has-error');
          mensagemErro += 'Nome da mãe é um campo obrigatório.<br>';
        } else {
          nomeMae = this.$el.find('#inputNomeMae').val();
          this.$el.find('#inputNomeMae').parent().addClass('has-success');
        }
        if (this.$el.find('#inputEmail').val() === '') {
          campoProblema.push(this.$el.find('#inputEmail'));
          this.$el.find('#inputEmail').parent().addClass('has-error');
          mensagemErro += 'E-mail é um campo obrigatório.<br>';
        } else {
          email = this.$el.find('#inputEmail').val();
          if (utils.isEmail(email)) {
            this.$el.find('#inputEmail').parent().addClass('has-success');
          } else {
            campoProblema.push(this.$el.find('#inputEmail'));
            this.$el.find('#inputEmail').parent().addClass('has-error');
            mensagemErro += 'E-mail inválido.<br>';
          }
        }
        if (this.$el.find('#inputNucleoProfissional').find('option:selected').val() === '-1') {
          campoProblema.push(this.$el.find('#inputNucleoProfissional'));
          this.$el.find('#inputNucleoProfissional').parent().addClass('has-error');
          mensagemErro += 'Núcleo profissional é um campo obrigatório.<br>';
        } else {
          nucleo = this.$el.find('#inputNucleoProfissional').find('option:selected').val();
          this.$el.find('#inputNucleoProfissional').parent().addClass('has-success');
        }
        //uf
        campo = '[name="uf"]';
        if (this.$el.find(campo).val() === '-1') {
          campoProblema.push(this.$el.find(campo));
          this.$el.find(campo).parent().addClass('has-error');
          mensagemErro += 'Estado é um campo obrigatório!<br>';
        } else {
          uf = this.$el.find(campo).val();
          this.$el.find(campo).parent().addClass('has-success');
        }
        //municipio
        campo = '[name="municipio"]';
        if (this.$el.find(campo).val() === '-1') {
          campoProblema.push(this.$el.find(campo));
          this.$el.find(campo).parent().addClass('has-error');
          mensagemErro += 'Municipio é um campo obrigatório!<br>';
        } else {
          municipio = this.$el.find(campo).val();
          this.$el.find(campo).parent().addClass('has-success');
        }
        ibge = this.$el.find('[name="ibge"]').val();
        if (concorda !== 'checked') {
          campoProblema.push(this.$el.find('#concorda-termos'));
          this.$el.find('#concorda-termos').parent().addClass('has-error');
          mensagemErro += 'Você precisa aceitar os Termos de Uso.<br>';
        }
        ofertasUsuario = this.obtemOfertas();
        console.log(ofertasUsuario, 'ofertasUsuario', this.obtemOfertas);
        if (ofertasUsuario.length === 0) {
          campoProblema.push(this.$el.find('.conteudos')[0]);
          this.$el.find('.conteudos').parent().parent().addClass('has-error');
          mensagemErro += 'Você precisa escolher ao menos um conteúdo para certificar.<br>';
        }
        if (!silent) {
          this.$el.find('input').attr('disabled', false);
          this.$el.find('select').attr('disabled', false);
        }
        if (campoProblema.length > 0) {
          this.$el.find('input').attr('disabled', false);
          this.$el.find('select').attr('disabled', false);
          this.exibeErro(mensagemErro);
          if (this.hadFocus.is('a.btn.submit-form')) {
            campoProblema[0].focus();
          }
          return false;
        } else {
          obj = {
            cpf,
            nome,
            nomeMae,
            email,
            dataNasc_dia: dia,
            dataNasc_mes: mes,
            dataNasc_ano: ano,
            municipio,
            uf,
            ibge,
            mala_direta,
            sexo,
            profissional: nucleo,
            modulo: App.moduloId,
            ofertas: ofertasUsuario
          };
          return obj;
        }
      }

      salvaUser(user) {
        var destroyCallback, self;
        self = this;
        self.$el.find('input').attr('disabled', true);
        self.$el.find('select').attr('disabled', true);
        self.$el.find('.progress').show();
        self.$el.find('.carregando').show().css('width', '10%');
        self.$el.find('.alert').removeClass('alert-danger').addClass('alert-success').empty();
        user.synced = false;
        self = this;
        destroyCallback = function() {
          var respKey, respostas, usr;
          self.$el.find('.carregando').hide();
          self.destroy();
          console.log('destriu');
          if (App.local) {
            usr = App.local.get('user');
            App.user = usr;
            respKey = `respostas-${App.user.cpf}`;
            respostas = App.local.get(respKey);
            return App.loadUserMenu();
          }
        };
        self.$el.find('.alert').show().html('<h3>Usuário salvo neste navegador, tentando salvar no servidor...</h3>');
        self.$el.find('.btn').attr('disabled', true);
        self.$el.find('.carregando').css('width', '60%');
        return App.execute('storeUser', user, function(resposta) {
          var c, j, len, msg, ref;
          self.$el.find('.carregando').css('width', '100%');
          self.$el.find('.alert').removeClass('alert-danger').removeClass('alert-success').show().empty();
          if (resposta.ok) {
            $('.dropdown-componentes').find('ul.dropdown-menu li').show();
            self.$el.find('.alert').html('<h3>Usuário salvo no servidor</h3>');
            return setTimeout(destroyCallback(), 1000);
          } else {
            msg = '<h3>' + resposta.msg + '</h3>';
            if (resposta.certificado) {
              msg += '<ul class="list-group">';
              ref = resposta.certificado;
              for (j = 0, len = ref.length; j < len; j++) {
                c = ref[j];
                msg += "<li><a class='list-group-item' style='color:white' href='" + c.url_certificado + "'> Para obter a 2˚ via do seu certificado acesse aqui: " + c.conteudo + "</a></li>";
              }
              msg += '</ul>';
            }
            if (msg.indexOf('SOAP-ERROR') > -1) {
              msg = 'Devido a problemas de conexão com a plataforma arouca não foi possível gerar seu certificado, por favor, tente mais tarde!';
            }
            self.$el.find('.alert').html(msg);
            self.$el.find('.btn').attr('disabled', false);
            return self.$el.find('.progress').hide();
          }
        });
      }

      montaComboEstados() {
        var j, len, sigla, siglas;
        siglas = staticData.estados.map(function(v) {
          return v.sigla;
        });
        this.$el.find('[name="uf"]').empty();
        this.$el.find('[name="uf"]').append("<option value='-1'>Selecione</option>");
        for (j = 0, len = siglas.length; j < len; j++) {
          sigla = siglas[j];
          this.$el.find('[name="uf"]').append("<option value='" + sigla + "'>" + sigla + "</option>");
        }
        if (this.user) {
          if (this.user.uf) {
            return this.$el.find('[name="uf"]').val(this.user.uf);
          }
        }
      }

      obtemMunicipios() {
        var cit, cits, estado, j, k, len, muniSel, opt, ref, uf, uma;
        uf = this.$el.find('[name="uf"]').val();
        muniSel = this.$el.find('[name="municipio"]');
        muniSel.prop('disabled', 'disabled');
        cits = [];
        ref = staticData.estados;
        for (k = j = 0, len = ref.length; j < len; k = ++j) {
          estado = ref[k];
          if (estado.sigla === uf) {
            cits = estado.cidades;
          }
        }
        muniSel.empty();
        if (uf !== '-1') {
          muniSel.append($('<option value="-1">selecione...</option>'));
          for (uma in cits) {
            cit = cits[uma];
            opt = $('<option value="' + cit.nome + '" data-ibge="' + cit.ibge + '">' + cit.nome + '</option>');
            opt.appendTo(muniSel);
          }
          muniSel.removeAttr('disabled');
        } else {
          muniSel.append($('<option value="-1">&#8592; Escolha um estado</option>'));
          muniSel.attr('disabled', true);
        }
        if (this.user) {
          if (this.user.municipio) {
            return this.$el.find('[name="municipio"]').val(this.user.municipio);
          }
        }
      }

      muni_ibge() {
        var ibge;
        ibge = $('[name="municipio"]').children(':checked').data('ibge');
        return $('[name="ibge"]').val(ibge);
      }

    };

    Modal.prototype.template = _.template($('#cadastro-template').html());

    Modal.prototype.submitEl = '.submit-form';

    Modal.prototype.cancelEl = '.close-modal';

    Modal.prototype.estagio = 0;

    Modal.prototype.ui = {
      'cpf': '#inputCpf',
      'inscricoes': '.conteudos',
      'progresso': '.progresso'
    };

    Modal.prototype.events = {
      "click #concorda-termos": 'concorda',
      'keypress input': 'limpaError',
      'blur #inputCpf': 'normalCpf',
      'blur #inputEmail': 'normalEmail',
      'blur #inputNomeMae,#inputNome': 'prettyNome',
      'change select[name="municipio"]': 'muni_ibge',
      'blur select[name="municipio"]': 'muni_ibge',
      'change select': 'limpaError',
      'click .close-modal': 'destroy',
      'change #inputNucleoProfissional': 'temNucleo',
      'click .btn-avancar': 'avancar',
      'click .btn-voltar': 'voltar',
      'change [name="uf"]': 'obtemMunicipios',
      'blur [name="dataNasc_dia"]': 'normalDateNumber',
      'blur [name="dataNasc_mes"]': 'normalDateNumber',
      'blur [name="dataNasc_ano"]': 'normalDateNumber',
      'blur [name="alt_dia_nascimento"]': 'normalDateNumber',
      'blur [name="alt_mes_nascimento"]': 'normalDateNumber',
      'blur [name="alt_ano_nascimento"]': 'normalDateNumber',
      'change .conteudos': 'verificaIntegracao',
      'change #alt_profissao': 'layoutAlternativoMudouProfissao',
      'change #alt_atuou_vigilancia_sus': 'layoutAlternativoMudouAtuacaoSus'
    };

    Modal.prototype.hadFocus = null;

    return Modal;

  }).call(this);
});