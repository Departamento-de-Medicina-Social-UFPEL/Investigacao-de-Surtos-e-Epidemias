titulos = [
	"Urgência odontológica em gestante","Patologia e Cirurgia Oral em Odontopediatria",
	"Puericultura aos cinco meses",
	"Tratamento de lesão profunda de cárie",
	"Trauma dentário em criança",
	"Dor e alteração de mucosa",
	"Avaliação do estado mental",
	"Úlcera venosa em MMII",
	"Atenção domiciliar a paciente com câncer de cólon",
	"Idosa com redução do apetite e dispneia",
	"Avaliação Cardiovascular",
	"Cuidando no domicílio",
	"Pré-natal de baixo risco",
	"Atendimento odontológico de gestante",
	"Gestante vem à consulta com exames laboratoriais",
	"Homem com dor em um dente ao ingerir alimentos quentes ou frios",
	"Lactente de dois meses é trazido para consulta de puericultura",
	"Lactente com febre e dificuldade para respirar",
	"Suporte básico de vida na APS",

	# -- alterado --
	# "Reabilitação protética de paciente desdentado total"
	"Lesões relacionadas ao uso de dentaduras",

	"Alimentação no 1º ano de vida ",
	"Criança com dor de ouvido",
	"Ortodontia interceptiva na APS",
	"Dor após exodontia",

	# -- alterado --
	# "Lesão em bifurcação induzida endodonticamente"
	"Lesão em bifurcação",

	"Hipertenso sentiu-se mal durante o café da manhã",

	# -- alterado --
	# "Lesões de tecidos moles e periodonto de origem infecciosa e cárie"
	"Patologias orais de origem infecciosa",

	# -- alterado --
	# "Complicações em cirurgia oral menor"
	"Complicações após exodontia",

	"Abordagem Sindrômica às IST's",
	"Ação Coletiva em Escolares",

	# -- alterado --
	# "Acidente com material biológico no consultório odontológico"
	"Acidente pérfurocortante",

	"Consulta puerperal",
	"Criança com cárie e problema na mordida",
	"Criança com dentes estragados",
	"Dentes manchados são normais?",
	"Doenças infecciosas da infância",
	"Dor lombar em mulher de 45 anos",
	"Lesões doloridas na boca",
	"Nódulo em mucosa labial inferior",
	"Odeio meu sorriso",
	"Paciente com tosse e febre",
	"Perigo! Criança na cozinha",
	"Tontura e vertigem",
	"Transtorno afetivo bipolar: depressão maior",
	"Uso abusivo de álcool - cuidados de enfermagem em rede",
	"Uso de álcool e drogas ilícitas"
]
editores = []
autores = []
cleanUp = (s)-> s.toLowerCase().trim().replace(/\s{1,}/img, ' ')
titulos = titulos.map cleanUp
_ = require 'underscore'
diff = (A, B)-> _.filter A, (obj)-> obj not in B
Caso = require '../models/caso.coffee'
Caso
.find shortname: {'$exists': yes} 
.exec (e, casos)->
  throw e if e
  relevantes = casos.filter (caso)-> cleanUp(caso.titulo) in titulos
  for caso in relevantes
  	console.log caso._id
  # 	autores = autores.concat [].concat caso.autor
  # 	editores = editores.concat [].concat caso.editores
  # 	# console.log """

  # 	# CASO: #{caso.titulo} (#{caso._id})
  # 	# 	Núcleo: #{caso.profissional}
  # 	# 	Editores: #{caso.editores}

  # 	# """
  # # console.log casos.map (c)-> {_id: c._id, titulo: c.titulo}
  # naoAchou = diff(titulos, _.pluck(relevantes, 'titulo').map cleanUp)
  # # console.log naoAchou
  # for perdido in naoAchou
  # 	require '../models/caso.coffee'
  # 	.findOne titulo: perdido 
  # 	.exec (err, caso)->
  # 		# console.log caso
  # console.log _.uniq([].concat editores, autores).sort()


# Caso
# .findOne autor: 'Luz FB, Barbieri S, Pinto LR, Etges A'
# .exec (err, doc)->
# 	console.log doc.titulo
