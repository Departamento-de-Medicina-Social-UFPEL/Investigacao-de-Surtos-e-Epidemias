

      Caso = require '../models/caso.coffee'
      async = require 'async'


      casos = [
        {
          "_id": "502d3ae0993f0969ec735594",
          "titulo": "Urgência odontológica em gestante",
          "shortname": "urge-odonto-gesta"
        }, {
          "_id": "4fe9b3f281c33f6365ed0126",
          "titulo": "Patologia e Cirurgia Oral em Odontopediatria",
          "shortname": "pato-cirur-odontoped"
        }, {
          "_id": "4feb0edb81c33f6365ed0127",
          "titulo": "Puericultura aos cinco meses",
          "shortname": "pueri-cinco-meses"
        }, {
          "_id": "4fd8db2381c33f6365ed0125",
          "titulo": "Tratamento de lesão profunda de cárie",
          "shortname": "trata-lesa-carie"
        }, {
          "_id": "4fb3ce49eb6ccb07c202a4e8",
          "titulo": "Trauma dentário em criança",
          "shortname": "trauma-dente-cria"
        }, {
          "_id": "4f8d66194e6dab942b05e3a9",
          "titulo": "Tratamento de dor e alteração de mucosa",
          "shortname": "trata-dor-mucosa"
        }, {
          "_id": "4f8c14b44e6dab942b05e3a8",
          "titulo": "Avaliação do estado mental",
          "shortname": "aval-mental"
        }, {
          "_id": "4f641594b852fbb6ad3a9a22",
          "titulo": "Úlcera venosa em MMII",
          "shortname": "ulcera-mmii"
        }, {
          "_id": "4fa13fa74e6dab942b05e3ab",
          "titulo": "Atenção domiciliar a paciente com câncer de cólon",
          "shortname": "ad-cancer-colon"
        }, {
          "_id": "4f749b7d4e6dab942b05e3a6",
          "titulo": "Idosa com redução do apetite e dispneia",
          "shortname": "idosa-apetite-dispneia"
        }, {
          "_id": "4f704354b852fbb6ad3a9a26",
          "titulo": "Dispneia",
          "shortname": "dispneia"
        }, {
          "_id": "4f6415a8b852fbb6ad3a9a23",
          "titulo": "Avaliação Cardiovascular",
          "shortname": "aval-cariovasc"
        }, {
          "_id": "503fc193680ffca7125d8e69",
          "titulo": "Cuidando no domicílio",
          "shortname": "cuida-dom"
        }, {
          "_id": "4fb3ce62eb6ccb07c202a4e9",
          "titulo": "Pré-natal de baixo risco",
          "shortname": "pre-natal-baixo-risco"
        }, {
          "_id": "4f390aea0dd744175dd04973",
          "titulo": "Atendimento odontológico de gestante",
          "shortname": "atend-odonto-gesta"
        }, {
          "_id": "4f3e49470dd744175dd04975",
          "titulo": "Gestante vem à consulta com exames laboratoriais",
          "shortname": "gesta-consulta-exames-lab"
        }, {
          "_id": "4f21b47b0dd744175dd04964",
          "titulo": "Homem com dor em um dente ao ingerir alimentos quentes ou frios",
          "shortname": "dor-ingesta-quente-frio"
        }, {
          "_id": "4f1fb5540dd744175dd04962",
          "titulo": "Lactente de dois meses é trazido para consulta de puericultura",
          "shortname": "pueri-lacta-dois-meses"
        }, {
          "_id": "50088e8581c33f6365ed012a",
          "titulo": "Cuidados Paliativos na Atenção Primária",
          "shortname": "cuida-palia-aps"
        }, {
          "_id": "4f19b6d20dd744175dd0495f",
          "titulo": "Lactente com febre e dificuldade para respirar",
          "shortname": "pueri-lacta-febre-dif-respira"
        }, {
          "_id": "4f18212ddfe4ca6404658fc9",
          "titulo": "Alerta: sangramento gengival",
          "shortname": "sangra-gengiva"
        }, {
          "_id": "4f0c53382e38a6e9c32e6737",
          "titulo": "Criança com diarreia",
          "shortname": "cria-diarreia"
        }, {
          "_id": "4ed4d7872e38a6e9c32e6736",
          "titulo": "Criança com falta de ar",
          "shortname": "cria-falta-ar"
        }, {
          "_id": "4fc62b1aeb6ccb07c202a4eb",
          "titulo": "Suporte básico de vida na APS",
          "shortname": "sup-bas-vida-aps"
        }, {
          "_id": "4f732a4f4e6dab942b05e3a5",
          "titulo": "Reabilitação protética de paciente desdentado total",
          "shortname": "reab-pac-desdenta-total"
        }, {
          "_id": "4f7f5bb54e6dab942b05e3a7",
          "titulo": "Alimentação no 1º ano de vida ",
          "shortname": "alim-prim-ano-vida"
        }, {
          "_id": "4fce11c9eb6ccb07c202a4ed",
          "titulo": "Acidente por mordedura de cão",
          "shortname": "mordida-cao"
        }, {
          "_id": "502d3b04993f0969ec735595",
          "titulo": "Mal-estar e tontura na fila da UBS",
          "shortname": "tonta-fila-ubs"
        }, {
          "_id": "502d3ab8993f0969ec735593",
          "titulo": "Criança com crise de choro noturno",
          "shortname": "cria-crise-choro-not"
        }, {
          "_id": "503fc1d3680ffca7125d8e6a",
          "titulo": "Dor em baixo ventre",
          "shortname": "dor-baixo-ventre"
        }, {
          "_id": "501a8e1081c33f6365ed012b",
          "titulo": "Criança com dor de ouvido",
          "shortname": "cria-dor-ouvido"
        }, {
          "_id": "501aeb2581c33f6365ed012d",
          "titulo": "Ortodontia interceptiva na APS",
          "shortname": "orto-intercept-aps"
        }, {
          "_id": "4fa0d8ef4e6dab942b05e3aa",
          "titulo": "Dor após exodontia",
          "shortname": "dor-pos-exodont"
        }, {
          "_id": "5008163081c33f6365ed0129",
          "titulo": "Lesão em bifurcação induzida endodonticamente",
          "shortname": "lesa-bifurca-endodont"
        }, {
          "_id": "4fb3ce7deb6ccb07c202a4ea",
          "titulo": "Hipertenso sentiu-se mal durante o café da manhã",
          "shortname": "hipertenso-mal-cafe-manha"
        }, {
          "_id": "4f312c670dd744175dd0496f",
          "titulo": "Leucorréia e rastreamento do câncer ginecológico",
          "shortname": "leuco-rastrea-cancer-gineco"
        }, {
          "_id": "4f6415bbb852fbb6ad3a9a24",
          "titulo": "Lesões de tecidos moles e periodonto de origem infecciosa e cárie",
          "shortname": "lesa-periodonto"
        }, {
          "_id": "503fbb3f680ffca7125d8e68",
          "titulo": "Tratamentos Conservadores da Polpa",
          "shortname": "trata-conserva-polpa"
        }, {
          "_id": "4fc62b2aeb6ccb07c202a4ec",
          "titulo": "Complicações em cirurgia oral menor",
          "shortname": "complica-cirur"
        }, {
          "_id": "501ae9d681c33f6365ed012c",
          "titulo": "Eu não sou hipertensa!",
          "shortname": "nao-sou-hiper"
        }, {
          "_id": "5008159081c33f6365ed0128",
          "titulo": "Mulher jovem com queixa de taquicardia e dispneia",
          "shortname": "jovem-taqui-dispneia"
        }, {
          "_id": "5183bc3341e46f8970000000",
          "titulo": "Abordagem Sindrômica às IST's",
          "shortname": "aborda-sindro-ist"
        }, {
          "_id": "50ffe99741e46f8962000000",
          "titulo": "Ação Coletiva em Escolares",
          "shortname": "acao-coletiva-escola"
        }, {
          "_id": "515c412741e46fc26a000000",
          "titulo": "Acidente com material biológico no consultório odontológico",
          "shortname": "acidente-mat-bio-odonto"
        }, {
          "_id": "5153099241e46f755d000000",
          "titulo": "Acidente com perfurocortante na sala de vacinas",
          "shortname": "acidente-prefurocort-sala-vacina"
        }, {
          "_id": "51d18c5c41e46f4325000000",
          "titulo": "Atenção domiciliar a idoso com confusão aguda",
          "shortname": "ad-idoso-confuso-aguda"
        }, {
          "_id": "51c1b5c741e46f411a000000",
          "titulo": "Atenção odontológica aos Pacientes Portadores de Necessidades Especiais na Atenção Básica",
          "shortname": "atencao-odonto"
        }, {
          "_id": "50a3e7f4ab52518fdd09adb7",
          "titulo": "Cefaleia",
          "shortname": "cefaleia"
        }, {
          "_id": "50be77a7ab52518fdd09adbb",
          "titulo": "Consulta puerperal",
          "shortname": "consulta-puerpera"
        }, {
          "_id": "525c044f41e46fc850000000",
          "titulo": "Criança com cárie e problema na mordida",
          "shortname": "cria-carie-prob-morde"
        }, {
          "_id": "514b002041e46f6039000000",
          "titulo": "Criança com dentes estragados",
          "shortname": "cria-dente-estraga"
        }, {
          "_id": "51a359fd41e46f2105000000",
          "titulo": "Criança com dificuldade na fala",
          "shortname": "cria-dif-fala"
        }, {
          "_id": "5152edfe41e46fe746000000",
          "titulo": "Criança com exantema e febre. Será dengue?",
          "shortname": "cria-exantema-febre-dengue"
        }, {
          "_id": "5152f91341e46f704b000000",
          "titulo": "Dentes manchados são normais?",
          "shortname": "dente-mancha"
        }, {
          "_id": "520a41de41e46f4c0a000000",
          "titulo": "Doenças infecciosas da infância",
          "shortname": "doenca-infec-infancia"
        }, {
          "_id": "520b8ece41e46f8c1b000000",
          "titulo": "Dor lombar em mulher de 45 anos",
          "shortname": "dor-lombar"
        }, {
          "_id": "52dd207c41e46f8a7c000000",
          "titulo": "HANSENÍASE: e agora, o que eu faço?",
          "shortname": "hanseniase"
        }, {
          "_id": "51d2dad441e46f7048000000",
          "titulo": "Imunização em criança menor de um ano",
          "shortname": "imuniza-cria-menos-um-ano"
        }, {
          "_id": "50a3e4dfab52518fdd09adb5",
          "titulo": "Lesões doloridas na boca",
          "shortname": "lesao-dor-boca"
        }, {
          "_id": "5282339041e46fdc48000000",
          "titulo": "Nódulo em mucosa labial inferior",
          "shortname": "nodulo-mucosa-labial"
        }, {
          "_id": "50bd0093ab52518fdd09adb9",
          "titulo": "O perigo está na boca",
          "shortname": "perigo-boca"
        }, {
          "_id": "50a3e9cbab52518fdd09adb8",
          "titulo": "Odeio meu sorriso",
          "shortname": "odeio-sorriso"
        }, {
          "_id": "51ee87de41e46fd575000000",
          "titulo": "Paciente com dentes desgastados",
          "shortname": "dente-estragado"
        }, {
          "_id": "51f672fa41e46f9609000000",
          "titulo": "Paciente com tosse e febre",
          "shortname": "tosse-febre"
        }, {
          "_id": "50d82de2ab52518fdd09adbd",
          "titulo": "Perigo! Criança na cozinha",
          "shortname": "perigo-cria-cozinha"
        }, {
          "_id": "50bd1238ab52518fdd09adba",
          "titulo": "Processamento de materiais",
          "shortname": "processo-material"
        }, {
          "_id": "5150fb6c41e46feb20000000",
          "titulo": "Tontura e vertigem",
          "shortname": "tontura-vertigem"
        }, {
          "_id": "5152ec5d41e46f2645000000",
          "titulo": "Transtorno afetivo bipolar: depressão maior",
          "shortname": "tras-afetivo-bipolar"
        }, {
          "_id": "51dab7b341e46f7b44000000",
          "titulo": "Tratamento periodontal de paciente hemofílico",
          "shortname": "trata-peri-hemo"
        }, {
          "_id": "516e96e941e46f7445000000",
          "titulo": "Tuberculose: da antiguidade para a atualidade",
          "shortname": "tuberculose"
        }, {
          "_id": "50d82dc3ab52518fdd09adbc",
          "titulo": "Uso abusivo de álcool - cuidados de enfermagem em rede",
          "shortname": "abuso-alcool"
        }, {
          "_id": "51e5572641e46fa875000000",
          "titulo": "Uso de álcool e drogas ilícitas",
          "shortname": "uso-droga-ilicita"
        }
      ]

      faz = (caso, next)->
        Caso.update {_id: caso._id}, {shortname: caso.shortname}, (e, doc)->
          console.log doc.titulo
          next null

      fim = -> process.exit 0

      testa = (caso, next)->
        Caso.findOne {_id: caso._id},  (e, doc)->
          console.log doc.titulo
          next null

      async.each casos, faz, fim


