define [
  'marionette'
], (Marionette, Usuarios) ->
  class MainLayout extends Marionette.LayoutView

    onRender: ->
      for o in window.modulo.ofertas
        mes_inicio = o.data_inicio.slice(5, 7)
        ano_inicio = o.data_inicio.slice(0, 4)
        mes_fim    = o.data_fim.slice(5, 7)
        ano_fim    = o.data_fim.slice(0, 4)
        meses      = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
        display    = meses[parseInt(mes_inicio) - 1] + " " + ano_inicio + " a " + meses[parseInt(mes_fim) - 1] + " " + ano_fim
        @ui.oferta.append '<option value="' + o.id_arouca + '">' + display + '</option>'

      window.find_or_default = (arr, def, pred) ->
        for e in arr
          if pred(e) == true
            return e
        return def

    template: '#dashboard-main'

    ui:
      toggle: '.btn-toggle'
      buscar: '#buscar'
      oferta: 'select[name=oferta]'
      inicio_inscricao: 'input[name=inicio_inscricao]'
      fim_inscricao: 'input[name=fim_inscricao]'
      inicio_certificacao: 'input[name=inicio_certificacao]'
      fim_certificacao: 'input[name=fim_certificacao]'
      #percent_min: 'input[name=percent_min]'
      #percent_max: 'input[name=percent_max]'

    events:
      'click @ui.toggle': 'toggle'
      'click @ui.buscar': 'buscar'

    toggle: (e)->
      $(e.currentTarget).find('.active').removeClass('active')
      $(e.currentTarget).find('.btn-primary').removeClass('btn-primary');
      $(e.currentTarget).find('input').each () ->
        $(this).removeAttr('checked')

      $(e.target).addClass('active');
      $(e.target).addClass('btn-primary');
      $(e.target).find('input').attr('checked', true)

    buscar: ->
      query =
        modulo: App.moduloId
        id_arouca: @ui.oferta.val()
        inicio_inscricao: @ui.inicio_inscricao.val()
        fim_inscricao: @ui.fim_inscricao.val()
        inicio_certificacao: @ui.inicio_certificacao.val()
        fim_certificacao: @ui.fim_certificacao.val()
        percent_min: 0
        percent_max: 100
        inscritos: $('input[name=filtro_inscritos]:checked').val()
        profissao: $('input[name=filtro_profissao]:checked').val()
      return unless App.socket

      App.socket.emit 'dashboard.surtos.g1', query, (resposta)->
        console.log resposta
        return unless resposta.ok
        App.execute 'desenha_grafico_numero_de_inscritos', 'Número de estudantes certificados em relação ao número de inscritos',
          (window.find_or_default resposta.data, {count: 0}, (v) -> v._id == true).count,
          (window.find_or_default resposta.data, {count: 0}, (v) -> v._id == false).count

      App.socket.emit 'dashboard.surtos.g2', query, (resposta)->
        return unless resposta.ok
        ordem = ["<20 anos", "20 - 29 anos", "30 - 39 anos", "40 - 49 anos", "50 - 59 anos", "60 anos ou mais"]
        data = resposta.data.sort((a, b) => ordem.indexOf(a.name) - ordem.indexOf(b.name))
        App.execute 'desenha_grafico_surtos', 'grafico-distribuicao-etaria', 'Distribuição etária em anos', data, ["#9cd3c8", "#51b8e5", "#4dd6bc", "#3989d1", "#3c9687", "#1961ac"]

      App.socket.emit 'dashboard.surtos.g3', query, (resposta)->
        return unless resposta.ok
        App.execute 'desenha_grafico_surtos', 'grafico-nucleo-profissional', 'Núcleo profissional', resposta.data, ["#1961ac", "#3c9687", "#5c77bc", "#51b8e5"]

      App.socket.emit 'dashboard.surtos.g4', query, (resposta)->
        return unless resposta.ok
        ordem =                                                                           ["Acre",    "Amazonas", "Amapá",   "Pará",    "Roraima", "Rondônia", "Tocantins", "Alagoas", "Bahia",   "Ceará",   "Maranhão", "Paraíba", "Pernambuco", "Piauí",   "Rio Grande do Norte", "Sergipe", "Distrito Federal", "Goiás",   "Mato Grosso", "Mato Grosso do Sul", "Espírito Santo", "Minas Gerais", "Rio de Janeiro", "São Paulo", "Paraná",  "Rio Grande do Sul", "Santa Catarina"]
        data = resposta.data.sort((a, b) => ordem.indexOf(a.name) - ordem.indexOf(b.name))
        App.execute 'desenha_grafico_surtos', 'grafico-uf', 'Estado de residência', data, ["#9cd3c8", "#83d877",  "#3c9687", "#c1f0a2", "#4dd6bc", "#19724a",  "#9bce9b",   "#1961ac", "#51b8e5", "#3f66aa", "#00f9ff",  "#4488bc", "#90e5fc",    "#1d5172", "#1a9dc1",             "#00a4ff", "#4b58af",          "#aeb8dc", "#a28fd1",     "#5c77bc",            "#ef8a3f",        "#c4681c",      "#f98c69",        "#ef5d26",   "#d35d55", "#8c3838",           "#db4d4d"]

      App.socket.emit 'dashboard.surtos.g5', query, (resposta)->
        return unless resposta.ok
        ordem = ["Branco", "Preto", "Pardo", "Amarelo", "Indígena", "Não respondeu"]
        data = resposta.data.sort((a, b) => ordem.indexOf(a.name) - ordem.indexOf(b.name))
        App.execute 'desenha_grafico_surtos', 'grafico-raca-cor', 'Raça/Cor', data, ["#4dd6bc", "#4d91c4", "#1961ac", "#51b8e5", "#3c9687", "#90e5fc"]

      App.socket.emit 'dashboard.surtos.g6', query, (resposta)->
        return unless resposta.ok
        ordem = ["Feminino", "Masculino", "Não-binário", "Auto-identificado como outro gênero", "Prefiro não responder", "Não respondeu"]
        data = resposta.data.sort((a, b) => ordem.indexOf(a.name) - ordem.indexOf(b.name))
        App.execute 'desenha_grafico_surtos', 'grafico-genero', 'Gênero', data, ["#6f5c9e", "#4a5da0", "#a28fd1", "#5c77bc", "#aeb8dc"]

      App.socket.emit 'dashboard.surtos.g7', query, (resposta)->
        return unless resposta.ok
        ordem = ["Trabalhador", "Estudante", "Não respondeu"]
        data = resposta.data.sort((a, b) => ordem.indexOf(a.name) - ordem.indexOf(b.name))
        App.execute 'desenha_grafico_surtos', 'grafico-profissao', 'Vínculo', data, ["#1961ac", "#3c9687", "#9cd3c8"]

      App.socket.emit 'dashboard.surtos.g8', query, (resposta)->
        return unless resposta.ok
        ordem = ["<2 anos", "2 - 4 anos", "5 - 9 anos", "10 - 19 anos", "20 anos ou mais"]
        data = resposta.data.sort((a, b) => ordem.indexOf(a.name) - ordem.indexOf(b.name));
        App.execute 'desenha_grafico_surtos', 'grafico-tempo-setor-saude', 'Tempo que os trabalhadores atuam no setor de saúde em anos', data, ["#9cd3c8", "#51b8e5", "#4dd6bc", "#3989d1", "#3f66aa"]

      App.socket.emit 'dashboard.surtos.g9', query, (resposta)->
        return unless resposta.ok

        filtered    = resposta.data.filter((x) -> x.name != "Outro" && x.name != null)
        top5        = filtered.slice(0, 5)
        if !top5.find((x) -> x.name == "Agente comunitário de saúde")
          top5 = [top5..., resposta.data.find((x) -> x.name == "Agente comunitário de saúde")]
          filtered = filtered.filter((x) -> x.name != "Agente comunitário de saúde")

        valor_outro = resposta.data.find((x) -> x.name == "Outro").y + resposta.data.find((x) -> x.name == null).y + filtered.slice(top5.length - 1).reduce(
          (tot, x) -> tot + x.y
          0
        )

        App.execute 'desenha_grafico_surtos', 'grafico-qual-profissao', 'Profissão ou o que está estudando', [top5..., {name: "Outro", y: valor_outro}], ["#6f5c9e", "#4a5da0", "#a28fd1", "#5c77bc", "#aeb8dc"]

      App.socket.emit 'dashboard.surtos.g10', query, (resposta)->
        return unless resposta.ok

        n = resposta.data.length

        data = []
        for entry in resposta.data
          for v in entry.values
            if v.value == "S"
              data[v.name] = (if data[v.name] != undefined then data[v.name] else 0) + 1

        _data = []
        for prop in Object.keys( data )
          _data.push {name: prop, y: data[prop]}

        ordem = [
          "No SUS",
          "No setor de saúde filantrópico",
          "No setor de saúde privado",
          "Na atenção básica",
          "Em ambulatório especializado",
          "Em Unidade de Pronto Atendimento",
          "Em Hospital/Serviço de Emergência",
          "Na gestão de saúde no SUS",
          "Em pesquisa",
        ]
        _data.sort((a, b) => ordem.indexOf(a.name) - ordem.indexOf(b.name));
        App.execute 'desenha_grafico_barras_surtos', 'grafico-local-de-atuacao', 'Local de atuação', _data, ["#1961ac", "#51b8e5", "#4dd6bc", "#4d91c4", "#3c9687", "#83d877", "#5c77bc", "#aeb8dc", "#a28fd1"], n

      App.socket.emit 'dashboard.surtos.g11', query, (resposta)->
        return unless resposta.ok
        ordem = ["Não", "Sim, atuei mas não atuo mais", "Sim, estou atuando", "Não respondeu"]
        data = resposta.data.sort((a, b) => ordem.indexOf(a.name) - ordem.indexOf(b.name));
        App.execute 'desenha_grafico_surtos', 'grafico-atuou-vigilancia-sus', 'Atua ou atuou na vigilância em saúde', data, ["#4dd6bc", "#9cd3c8", "#4d91c4", "#3c9687"]

      App.socket.emit 'dashboard.surtos.g12', query, (resposta)->
        return unless resposta.ok
        ordem = ["<2 anos", "2 - 4 anos", "5 - 9 anos", "10 - 19 anos", "20 anos ou mais"]
        data = resposta.data.sort((a, b) => ordem.indexOf(a.name) - ordem.indexOf(b.name));
        App.execute 'desenha_grafico_surtos', 'grafico-anos-vigilancia-sus', 'Tempo que atua ou atuou na vigilância em saúde', data, ["#9cd3c8", "#51b8e5", "#4dd6bc", "#3989d1", "#3f66aa"]

      App.socket.emit 'dashboard.surtos.t1', query, (resposta)->
        n = resposta.data.length

        data = resposta.data.reduce (acc, i) ->
          acc.agente_comunitario_da_area_de_saude +=  i.agente_comunitario_da_area_de_saude
          acc.agente_comunitario_de_endemia += i.agente_comunitario_de_endemia
          acc.esta_certificado += i.esta_certificado
          acc.profissional_de_enfermagem += i.profissional_de_enfermagem
          acc.trabalha_atualmente_na_vigilancia_de_saude += i.trabalha_atualmente_na_vigilancia_de_saude
          acc.trabalha_ou_trabalhou_na_vigilancia_em_saude += i.trabalha_ou_trabalhou_na_vigilancia_em_saude
          acc.trabalhou_no_passado_na_vigilancia_de_saude += i.trabalhou_no_passado_na_vigilancia_de_saude
          acc
        , {
          agente_comunitario_da_area_de_saude: 0
          agente_comunitario_de_endemia: 0
          esta_certificado: 0
          profissional_de_enfermagem: 0
          trabalha_atualmente_na_vigilancia_de_saude: 0
          trabalha_ou_trabalhou_na_vigilancia_em_saude: 0
          trabalhou_no_passado_na_vigilancia_de_saude: 0
        }

        console.log 'dashboard.surtos.tabela1', resposta, n, data

        $("#td-ninscritos").html                n
        $("#td-nprofenfermagem").html           data.profissional_de_enfermagem
        $("#td-ntraboutrabvigsaude").html       data.trabalha_ou_trabalhou_na_vigilancia_em_saude
        $("#td-ntrabvigsaude").html             data.trabalha_atualmente_na_vigilancia_de_saude
        $("#td-ntrabalhouvigsaude").html        data.trabalhou_no_passado_na_vigilancia_de_saude
        $("#td-nagentecomunitario").html        data.agente_comunitario_da_area_de_saude
        $("#td-nagentecomunitarioendemia").html data.agente_comunitario_de_endemia
        $("#td-ncert").html                     data.esta_certificado
        $("#td-prcntinscritos").html                100.0.toFixed(1)
        $("#td-prcntprofenfermagem").html           (data.profissional_de_enfermagem / n * 100).toFixed(1)
        $("#td-prcnttraboutrabvigsaude").html       (data.trabalha_ou_trabalhou_na_vigilancia_em_saude / n * 100).toFixed(1)
        $("#td-prcnttrabvigsaude").html             (data.trabalha_atualmente_na_vigilancia_de_saude / n * 100).toFixed(1)
        $("#td-prcnttrabalhouvigsaude").html        (data.trabalhou_no_passado_na_vigilancia_de_saude / n * 100).toFixed(1)
        $("#td-prcntagentecomunitario").html        (data.agente_comunitario_da_area_de_saude / n * 100).toFixed(1)
        $("#td-prcntagentecomunitarioendemia").html (data.agente_comunitario_de_endemia / n * 100).toFixed(1)
        $("#td-prcntcert").html                     (data.esta_certificado / n * 100).toFixed(1)

        return unless resposta.ok

      #App.socket.emit 'dashboard.surtos.g13', query, (resposta)->
      #  return unless resposta.ok
      #  ordem = ["<10%", "10% - 29%", "30% - 49%", "50% - 69%", "70% ou mais"]
      #  data = resposta.data.sort((a, b) => ordem.indexOf(a.name) - ordem.indexOf(b.name));
      #  App.execute 'desenha_grafico_surtos', 'grafico-percent-conclusao', 'Porcentagem de conclusão do curso', data, ["#9cd3c8", "#51b8e5", "#4dd6bc", "#3989d1", "#3f66aa"]

    App.commands.setHandler 'desenha_grafico_numero_de_inscritos', (title, certificados, inscritos) ->
      App.execute 'desenha_grafico_surtos', 'grafico-numero-inscritos', title, [
        {name: 'Não Certificados', y: inscritos},
        {name: 'Certificados', y: certificados}
      ], ["#1961AC", "#3c9687"]

    App.commands.setHandler 'desenha_grafico_surtos', (el, titulo, data, colors=["#1961ac", "#3c9687", "#9cd3c8", "#51b8e5", "#4dd6bc", "#3989d1", "#5c77bc"])->
      n = data.reduce(
        (tot, x) -> tot + x.y
        0
      )

      console.log 'desenha_grafico_surtos', el, n, data
      $('#' + el + '-title').html titulo + " (n=" + n + ")"

      # Mover "Outro" para o final
      data = [data.filter((a) -> a.name != "Outro")..., data.filter((a) -> a.name == "Outro")...]

      Highcharts.chart el,
        chart:
          plotBackgroundColor: null
          plotBorderWidth: null
          plotShadow: false
          type: 'pie'
        colors: colors
        styleMode: true
        title: text: null
        tooltip: pointFormatter: () -> return "n=" + this.y + "<br>" + this.percentage.toFixed(1) + "%"
        accessibility: point: valueSuffix: '%'
        plotOptions: pie:
          allowPointSelect: true
          cursor: 'pointer'
          showInLegend: true
          dataLabels:
              enabled: true,
              formatter: () -> return this.percentage.toFixed(1) + "%"
              distance: -60,
              color: 'white'
        series: [{
          name: ''
          colorByPoint: true
          data: data
        }]

    App.commands.setHandler 'desenha_grafico_barras_surtos', (el, titulo, data, colors, n) ->
      console.log 'desenha_grafico_barras_surtos', el, data
      $('#' + el + '-title').html titulo + " (n=" + n + ")"

      Highcharts.chart el,
        chart:
          plotBackgroundColor: null
          plotBorderWidth: null
          plotShadow: false
          type: 'bar'
        xAxis: categories: data.map( (e) -> e.name )
        yAxis:
          endOnTick: false
          max: n
        colors: colors
        styleMode: true
        title: text: null
        tooltip: pointFormatter: () -> return "n=" + this.y + "<br>" + (this.y * 100/n).toFixed(1) + "%"
        plotOptions: bar:
          allowPointSelect: true
          cursor: 'pointer'
          showInLegend: true
          dataLabels:
              enabled: true,
              formatter: () -> return (this.y * 100/n).toFixed(1) + "%"
              #distance: -60,
              #color:'white'
        series: [{
          name: ''
          colorByPoint: true
          data: data
        }]

  MainLayout
