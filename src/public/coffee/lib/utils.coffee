define [], ->

  pretty =
    dig: (str) ->
      str = str.trim()
      dig = str.match(/\d/g)
      if dig isnt null
        dig = dig.join("")
        return dig
      ""

    name: (str) ->
      exc = [
        "de", "da", "do", "dos", "das"
        "e", "las", "del", "los", "y"
        "delas", "delos"
      ]
      str.replace(/\s{2,}/g, " ").trim().split(" ").map((a) ->
        a = a.toLowerCase()
        (if a in exc then a else a.substr(0, 1).toUpperCase() + a.substr(1))
      ).join " "

    tel: (digs) ->
      dig = pretty.dig(digs)
      if dig.length >= 10
        "(" + dig.substr(0, 2) + ") " + dig.substr(2, 4) + "-" + dig.substr(6, 4)
      else
        digs

    cpf: (digs) ->
      dig = pretty.dig(digs)
      if dig.length == 11
        dig.substr(0, 3) + "." + dig.substr(3, 3) + "." + dig.substr(6, 3) + '-' + dig.substr(9, 2)
      else
        digs

  fetch =
    name: (n) -> pretty.name n.primeiro + " " + n.sobrenome

    idade: (i) ->
      i = i.split("/").map((a, i, is_) ->
        (if i is 0 then is_[1] else (if i is 1 then is_[0] else is_[2]))
      ).join("/")
      today = new Date()
      birthDate = new Date(i)
      age = today.getFullYear() - birthDate.getFullYear()
      m = today.getMonth() - birthDate.getMonth()
      age--  if m < 0 or (m is 0 and today.getDate() < birthDate.getDate())
      age

  validaCPF = (cpf) ->
    sum = 0
    return false  if cpf is "00000000000"
    i = 1
    while i <= 9
      sum = sum + parseInt(cpf.substring(i - 1, i)) * (11 - i)
      i++
    rest = (sum * 10) % 11
    rest = 0  if (rest is 10) or (rest is 11)
    return false  unless rest is parseInt(cpf.substring(9, 10))
    sum = 0
    i = 1
    while i <= 10
      sum = sum + parseInt(cpf.substring(i - 1, i)) * (12 - i)
      i++
    rest = (sum * 10) % 11
    rest = 0  if (rest is 10) or (rest is 11)
    return false  unless rest is parseInt(cpf.substring(10, 11))
    true

  pad = (str, num=11, end=false, char='0') ->
    str = pretty.dig str
    char = String char
    while str.length < num
      str = unless end then char+str else str+char
    str

  isEmail = (email) ->
    exclude = /^[a-zA-Z0-9][a-zA-Z0-9\._-]+@([a-zA-Z0-9\._-]+\.)[a-zA-Z-0-9]+/
    if email.search(exclude) == -1 or email.indexOf(',') > -1 or email.indexOf(';') > -1
      false
    else
      true

  DataPTBR = (ts) ->
    @dias = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]
    @meses = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
    @timestamp = ts*1000
    @charMes = 3
    @charDia = 0
    @comFeira = false
    o = arguments[1]
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
    @

  pretty: pretty
  fetch: fetch
  valCPF: validaCPF
  isEmail: isEmail
  databr: DataPTBR
  pad: pad
