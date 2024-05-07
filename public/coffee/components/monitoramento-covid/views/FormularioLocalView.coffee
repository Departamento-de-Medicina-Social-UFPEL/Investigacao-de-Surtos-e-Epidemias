define [
  '../collections/Monitoramentos'
  '../models/Monitoramento'
  'utils'
  'uf_municipios'
], (Monitoramentos, Monitoramento,utils, uf) ->

  class FormularioLocalView extends Marionette.CompositeView
    initialize: ->
      {user, local} = App
      if not @model
        @model = new Monitoramento()

    className: 'container'

    template: '#monitoramento-covid-formulario-local'

    ui:
      'btnClear': ".btn-clear"
      'btnSave': ".btn-save"
      "inputLocal": "#inputLocal"
      "inputUf": "#inputUf"
      "inputMunicipio": "#inputMunicipio"
      "ibge": "#inputIbge"
      "inputTipo":'input:radio[name="optionRadiosTipoAmostragem"]'

    events:
      'click .btn-clear': "limpar"
      'click .btn-save': "salvar"
      'change input': 'removeErro'
      'change [name="inputUf"]': 'obtemMunicipios'
      #'blur #inputLocal': 'prettyNome'
      'change select[name="inputMunicipio"]': 'muni_ibge'
      'blur select[name="inputMunicipio"]': 'muni_ibge'

    removeErro:(e)->
      $(e.target).parent().removeClass 'has-error'

    salvar:()->
      @ui.btnSave.attr 'disabled', true
      dados =
        "user": App.user.cpf
        "local": @ui.inputLocal.val()
        "uf": @ui.inputUf.val()
        "municipio": @ui.inputMunicipio.val()      
        "tipo": @ui.inputTipo.filter(':checked').val()
      err = false
      camposErros = []
      for v of dados
        if not dados[v]
          err = true
          camposErros.push '#input'+v.slice(0,1).toUpperCase()+v.slice(1)
      if err
        camposErros.forEach (c)->
          $(c).parent().addClass 'has-error'
        $(camposErros[0]).focus()
      
      dados['ibge'] = @ui.ibge.val()
      for v of dados
        @model.set v, dados[v]
      if not @model.get 'id'
        dados['id'] = @model.cid
        m = App.monitoramentos.create dados
      else
        m = App.monitoramentos.update @model
      @ui.btnSave.attr 'disabled', false
      App.appRouter.navigate '#comp/monitoramento-covid/local/'+m.id, 'trigger': yes
    
    montaComboEstados:()->
      #console.log 'monta combos estados'
      siglas = staticData.estados.map((v)-> v.sigla)
      @$el.find('[name="inputUf"]').empty()
      @$el.find('[name="inputUf"]').append(
        "<option value='-1'>Selecione</option>"
      )
      for sigla in siglas
        @$el.find('[name="inputUf"]').append(
          "<option value='" + sigla + "'>" + sigla + "</option>"
        )
      if @user
        if @user.uf
          @$el.find('[name="inputUf"]').val(@user.uf)

    obtemMunicipios:()->
      uf = @$el.find('[name="inputUf"]').val()
      muniSel = @$el.find('[name="inputMunicipio"]')
      muniSel.prop('disabled','disabled')
      cits = []
      for estado,k in staticData.estados
        if estado.sigla is uf
          cits = estado.cidades
      muniSel.empty()
      if uf isnt '-1'
        muniSel.append($('<option value="-1">selecione...</option>'))
        for uma of cits
          cit = cits[uma]
          opt = $('<option value="' + cit.nome + '" data-ibge="' + cit.ibge + '">' + cit.nome + '</option>')
          opt.appendTo muniSel
        muniSel.removeAttr('disabled')
      else
        muniSel.append($('<option value="-1">&#8592; Escolha um estado</option>'))
        muniSel.attr('disabled', true)
      if @user
        if @user.municipio
          @$el.find('[name="inputMunicipio"]').val(@user.municipio)

    muni_ibge:()->
      ibge = $('[name="inputMunicipio"]').children(':checked').data('ibge')
      $('[name="ibge"]').val(ibge)
    
    prettyNome: (evt)->
      @hadFocus = $(evt.target)
      str = do $(evt.target).val
      str = utils.pretty.name str
      $(evt.target).val str

    preenche:()->
      #console.log @model, 'model'
      if not @model.get 'id'
        return
      @ui.inputLocal.val @model.get 'nome'
      @ui.inputUf.val @model.get 'uf'
      @ui.inputMunicipio.val @model.get 'municipio'

    onRender: ->
      @montaComboEstados()

      #@obtemMunicipios()      
      @preenche()

  FormularioLocalView