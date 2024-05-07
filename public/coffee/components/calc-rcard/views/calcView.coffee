define ['backbone', 'backbone.marionette'], (Backbone, Marionette) ->

  class calcRiscoCardioVascularMainView extends Marionette.ItemView

    model: new Backbone.Model

    className: 'item calculadoras rcard'#calcRiscoCardioVascular'

    template: '#calc-rcard-main'

    ui:
      'resp':'.resultado'
      'item':'.item'
      'next':'#next'
      'prev':'#prev'
      'li':'li'
      'inicio':'.inicio'
      'intervencoes':'.intervencoes'
      'idade': '#idadeId'
      'sexo':'input:radio[name="optionRadios1"]' 
      'fumante':'input:radio[name="optionRadios2"]'
      'criteriorisco':'input:radio[name="optionRadios3"]'
      'pressao': '#pasId'
      'pressaotratada':'input:radio[name="optionRadios4"]'
      'hdl': '#hdlId'
      'colesteroltotal': '#ctId'


    events:
      'click @ui.next': 'next'
      'click @ui.prev': 'prev'
      'click @ui.inicio': 'inicio'
      'change @ui.idade, @ui.sexo, @ui.fumante, @ui.criteriorisco, @ui.pressao, @ui.pressaotratada, @ui.hdl': 'changeDados'

    initialize:()->
      @atual = 0
      @indiceResultado = 4
      @indiceIdade = 0
      # 20a39, 40a49, 50a59, 60a69, 70a79
      #mulheres
      @colesterolTotalMenor160 = [0,0,0,0,0]
      @colesterolTotal160a199 = [4,3,2,1,1]
      @colesterolTotal200a239 = [8,6,4,2,1]
      @colesterolTotal240a279 = [11,8,5,3,2]
      @colesterolTotalMaior280 = [13,10,7,4,2]
      @escoreFumantes = [9, 7, 4, 2, 1]
      #homens
      @colesterolTotalMenor160H = [0,0,0,0,0]
      @colesterolTotal160a199H = [4,3,2,1,0]
      @colesterolTotal200a239H = [7,5,3,1,0]
      @colesterolTotal240a279H = [9,6,4,2,1]
      @colesterolTotalMaior280H = [11,8,5,3,1]
      @escoreFumantesH = [8, 5, 3, 1, 1]

    next:()->
      if @ui.next.hasClass('disabled')
        return
      this.atual = @$el.find('.item.active').data 'indice'
      #console.log(@atual, @ui.criteriorisco.filter(':checked').val())
      if @atual is 2 and @ui.criteriorisco.filter(':checked').val() is '1'
        @exibeResultado 30
        @trocaPara(this.indiceResultado)
        return

      if this.atual < this.indiceResultado
        this.atual++

      if this.atual == this.indiceResultado
        @ui.next.addClass('disabled')
      else
        @ui.next.removeClass('disabled')
      @ui.prev.removeClass('disabled')
      @trocaPara(this.atual)
      
      @changeDados()

    trocaPara:(indice)->
      @$el.find('.item.active').hide()
      @$el.find('.item.active').removeClass 'active'
      if indice is this.indiceResultado
        # @ui.prev.addClass('disabled')
        @ui.next.addClass('disabled')
      #console.log 'trocaPara', indice
      @$el.find('.item-'+indice).addClass('active').show()
      @$el.find('.p'+indice).addClass('active')

    prev:()->
      this.atual = @$el.find('.item.active').data 'indice'

      @$el.find('.item.active').hide()
      @$el.find('.item.active').removeClass 'active'

      if this.atual > 1
        @$el.find('.p'+this.atual).removeClass('active')
        this.atual--
      if this.atual == 1
        @ui.prev.addClass('disabled')
      else
        @ui.prev.removeClass('disabled')
      @ui.next.removeClass('disabled')
      @$el.find('.item-'+this.atual).addClass('active').show()

    inicio:()->
      #console.log 'inicio'
      @ui.li.removeClass 'active'
      @$el.find('.p1').addClass('active')
      @$el.find('.item.active').hide()
      @$el.find('.item.active').removeClass 'active'
      @ui.prev.addClass('disabled')
      @ui.next.removeClass('disabled')
      $('.item-1').addClass('active')
      do @$el.find('.item.active').show

    changeDados:()->
      respostas = do @getDados
      nivel = @calculaEscore respostas
      @exibeResultado(nivel)

    exibeResultado:(nivel)->
      conduta = @getConduta(nivel)
      ## console.log conduta, 'escore', nivel
      @ui.resp.html conduta.descricao
      self = @
      @ui.intervencoes.empty()
      conduta.intervencoes.forEach (i)->
        self.ui.intervencoes.append "<li class='list-group-item'>"+i+"</li>"

    getDados:() ->
      [
        do @ui.idade.val
        do @ui.sexo.filter(':checked').val
        do @ui.fumante.filter(':checked').val
        do @ui.criteriorisco.filter(':checked').val
        do @ui.pressao.val
        do @ui.pressaotratada.filter(':checked').val
        do @ui.hdl.val
        do @ui.colesteroltotal.val
      ]

    calculaEscore: (d)->
      #
      escore = 0
      #idade indice
      if d[0] >= 20 and d[0] <= 39
        @indiceIdade = 0
      if d[0] >= 40 and d[0] <= 44
        @indiceIdade = 1
      if d[0] >= 45 and d[0] <= 49
        @indiceIdade = 2
      if d[0] >= 50 and d[0] <= 54
        @indiceIdade = 3
      if d[0] >= 55 and d[0] <= 59
        @indiceIdade = 4
      if d[0] >= 60 and d[0] <= 64
        @indiceIdade = 5
      if d[0] >= 65 and d[0] <= 69
        @indiceIdade = 6
      if d[0] >= 70 and d[0] <= 74
        @indiceIdade = 7
      if d[0] >= 75 
        @indiceIdade = 8

      ## console.log escore, 'idade'
      
      if d[1] is '1'
        escore += @calculaEscoreMasculino(d)
        switch escore
          when 0, 1, 2, 3, 4
            nivel = 1
          when 5, 6
            nivel = 2
          when 7
            nivel = 3
          when 8
            nivel = 4
          when 9
            nivel = 5
          when 10
            nivel = 6
          when 11
            nivel = 8
          when 12
            nivel = 10
          when 13
            nivel = 12
          when 14
            nivel = 16
          when 15
            nivel = 20
          when 16
            nivel = 25
          else
            if escore < 0
              nivel = -1
            else 
              nivel = 30
      else
        escore += @calculaEscoreFeminino(d)

        switch escore
          when 9, 10, 11, 12
            nivel = 1
          when 13, 14
            nivel = 2
          when 15
            nivel = 3
          when 16
            nivel = 4
          when 17
            nivel = 5
          when 18
            nivel = 6
          when 19
            nivel = 8
          when 20
            nivel = 11
          when 21
            nivel = 14
          when 22
            nivel = 17
          when 23
            nivel = 22
          when 24
            nivel = 27
          else
            if escore < 9
              nivel = 1
            else 
              nivel = 30
      ## console.log escore, 'escore, nivel', nivel
      nivel

    calculaEscoreFeminino: (d)->
      #console.log 'feminino'
      escore = 0
          # colesterol hdl
      if d[6] >= 60
        escore += -1
      if d[6] >= 50 and d[6] <= 59
        escore += 0
      if d[6] >= 40 and d[6] <= 49
        escore += 1
      if d[6] < 40 
        escore += 2
      ## console.log escore, 'colesterol hdl', d[6]

      idade = d[0]
      if idade >= 20 and idade <= 34
        escore = escore - 7
      if idade >= 35 and idade <= 39
        escore = escore - 3
      if idade >= 40 and idade <= 44
        escore += 0
      if idade >= 45 and idade <= 49
        escore += 3
      if idade >= 50 and idade <= 54
        escore += 6
      if idade >= 55 and idade <= 59
        escore += 8
      if idade >= 60 and idade <= 64
        escore += 10
      if idade >= 65 and idade <= 69
        escore += 12
      if idade >= 70 and idade <= 74
        escore += 14
      if idade >= 75 and idade <= 79
        escore += 16 

      ## console.log escore, 'idade'    

      # pressao
      if d[4] < 120
        escore += 0
      if d[4] >= 120 and d[4] <= 129
        escore += 1
      if d[4] >= 130 and d[4] <= 139
        escore += 2
      if d[4] >= 140 and d[4] <= 159
        escore += 3
      if d[4] >= 160
        escore += 4
      ## console.log escore, 'presao'    
      #presao tratada
      if d[5] is '1'
        escore += 2
      ## console.log escore, 'presao tratada'    

      escore += @escoreFumantes[@indiceIdade]
      ## console.log escore, 'fumante'    

      #colesterol total
      if d[7] < 160
        escore +=  this.colesterolTotalMenor160[@indiceIdade]
      if d[7] >= 160 and d[7] < 200
        escore +=  this.colesterolTotal160a199[@indiceIdade]
      if d[7] >= 200 and d[7] < 240
        escore +=  this.colesterolTotal200a239[@indiceIdade]
      if d[7] >= 240 and d[7] < 280
        escore +=  this.colesterolTotal240a279[@indiceIdade]
      if d[7] >= 280
        escore +=  this.colesterolTotalMaior280[@indiceIdade]
      ## console.log escore, 'colesterol total'    

      escore

    calculaEscoreMasculino: (d)->
      #console.log 'masculino'
      escore = 0
      # colesterol hdl
      if d[6] >= 60
        escore += -1
      if d[6] >= 50 and d[6] <= 59
        escore += 0
      if d[6] >= 40 and d[6] <= 49
        escore += 1
      if d[6] < 40 
        escore += 2
      ## console.log escore, 'colesterol hdl', d[6]
      idade = d[0]
      if idade >= 20 and idade <= 34
        escore = escore - 9
      if idade >= 35 and idade <= 39
        escore = escore - 4
      if idade >= 40 and idade <= 44
        escore += 0
      if idade >= 45 and idade <= 49
        escore += 3
      if idade >= 50 and idade <= 54
        escore += 6
      if idade >= 55 and idade <= 59
        escore += 8
      if idade >= 60 and idade <= 64
        escore += 10
      if idade >= 65 and idade <= 69
        escore += 11
      if idade >= 70 and idade <= 74
        escore += 12
      if idade >= 75
        escore += 13
      ## console.log escore, 'idade'

      # pressao
      if d[4] < 120
        escore += 0
      if d[4] >= 120 and d[4] <= 129
        escore += 0
      if d[4] >= 130 and d[4] <= 139
        escore += 1
      if d[4] >= 140 and d[4] <= 159
        escore += 1
      if d[4] >= 160
        escore += 2
      ## console.log escore, 'presao'
      #presao tratada
      if d[5] is '1' and d[4] >= 120
        escore += 1
      ## console.log escore, 'presao tratada'

      escore += @escoreFumantesH[@indiceIdade]
      ## console.log escore, 'fumante'  

      #colesterol total
      if d[7] < 160
        escore +=  this.colesterolTotalMenor160H[@indiceIdade]
      if d[7] >= 160 and d[7] < 200
        escore +=  this.colesterolTotal160a199H[@indiceIdade]
      if d[7] >= 200 and d[7] < 240
        escore +=  this.colesterolTotal200a239H[@indiceIdade]
      if d[7] >= 240 and d[7] < 280
        escore +=  this.colesterolTotal240a279H[@indiceIdade]
      if d[7] >= 280
        escore +=  this.colesterolTotalMaior280H[@indiceIdade]
      ## console.log escore, 'colesterol total'  

      escore
    
    getConduta:(r)->
      ## console.log r, 'teste resultados'
      descricao = "Baixo"
      intervencoes = ["Cessação do fumo", "Alimentação saudável", "Manutenção de peso/cintura", "Atividade Física", "Ênfase em medidas não famácológicas e diurético de baixa dose para hipertensão estágio 1, quando presente"]
      if r > 9 and r < 20
        descricao = "Moderado"
        intervencoes = intervencoes.concat(["Intensificação sobre conselhos de estilo de vida", "Dieta com características cardioprotetoras", "Considerar farmacoterapia contra tabagismo", "Considerar estatinas se colesterol LDL elevado após medidas não famacológicas", "Cautela no uso de AINEs", "Ênfase no controle efetivo da hipertensão arterial sistêmica"])
      if r >= 20
        descricao = "Alto"
        intervencoes = intervencoes.concat(["Estatinas (se não houver contraindicação)", "Ácido acetilsalicílico em homens acima de 55 anos e mulheres acima de 65 anos"])
      resultado = {
        nivel: r
        descricao: descricao
        intervencoes: intervencoes
      }
      resultado

    onRender: (view) ->
      do @ui.item.hide
      do @$el.find('.item.active').show
      @ui.prev.addClass('disabled')
      @$el.find('.p1').addClass('active')
      do @changeDados


  calcRiscoCardioVascularMainView
