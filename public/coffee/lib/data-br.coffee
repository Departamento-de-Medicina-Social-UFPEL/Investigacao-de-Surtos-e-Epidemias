DataPTBR = (ts) ->
  @dias = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]
  @meses = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
  @timestamp = ts
  @charMes = 3
  @charDia = 0
  @comFeira = false
  o = arguments_[1]
  if typeof (o) is "object"
    @charMes = (if o.charMes isnt `undefined` then o.charMes else @charMes)
    @charDia = (if o.charDia isnt `undefined` then o.charDia else @charDia)
    @comFeira = (if o.comFeira isnt `undefined` then o.comFeira else @comFeira)
  @fabricate = ->
    @data = new Date(@timestamp)
    dia = @data.getDay()
    theDia = @dias[dia]
    theMes = @meses[@data.getMonth()]
    theDia = theDia.substring(0, @charDia)  if @charDia > 0
    theMes = theMes.substring(0, @charMes)  if @charMes > 0
    theDia += "-feira"  if @comFeira and dia isnt 0 and dia isnt 6
    data: @data
    dia: theDia
    mes: theMes

module.exports = DataPTBR