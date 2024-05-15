print("mongo init start --------------------");

db.getSiblingDB("admin").auth("mamongo", "mamongo");
db.createUser({
  user: "mamongo",
  pwd: "mamongo",
  roles: [
    {
      role: "readWrite",
      db: "mamongo",
    },
  ],
});

db = db.getSiblingDB("ccurepo");
db.createCollection("casos", { capped: false });
db.casos.insertMany([
  {
    _id: ObjectId("62f39ab641e46ff40a7cc73d"),
    id: "9060",
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "41 anos",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "interdisciplinar",
    slides: [
      {
        conteudo: { texto: "", delay: "5" },
        titulo: "Introdução",
        tipo: "intro",
      },
      {
        conteudo: {
          contexto:
            "\u003cp\u003eTrata-se de uma Instituição de Longa Permanência para Idosos (ILPI) localizada na área urbana de município de médio porte (300 mil habitantes). A ILPI recebe residentes idosos e adultos com necessidades de cuidados permanentes (sequelas de acidente vascular cerebral, deficiências físicas, dificuldades motoras, etc.). Conta com assistência médica e, mediante convênio, oferece serviços de fisioterapia, suporte laboratorial e farmácia. A assistência médica se dá por atendimento de demanda em caso de necessidade. A responsabilidade técnica e direção da instituição é exercida por profissional da área da saúde. A estrutura física do local conta com aposentos individuais (quarto) e coletivos (acomodando dois indivíduos). Os banheiros são compartilhados. A área de convivência possui salas de estar e salão para eventos, refeitório, jardins e varandas.\u003c/p\u003e\u003cp\u003eDurante a estadia na ILPI é permitido receber familiares e amigos nas áreas de convivência e espaços privativos do residente. Também é facultada a realização de passeios externos à instituição, desde que com acompanhante.\u003c/p\u003e",
        },
        titulo: "Contexto",
        tipo: "contexto",
      },
      {
        conteudo: {
          descricaoCaso:
            '\u003cp\u003eEm 27 de janeiro de 2021, durante o transcurso da epidemia de covid-19, a Vigilância Epidemiológica (VE) foi notificada (Figura 1) sobre uma suspeita clínica de Síndrome Gripal (SG) em uma idosa (M.A.S.). A notificação foi realizada pelo Pronto Socorro municipal em razão de M.A.S. estar apresentando febre, mal-estar e dispneia há dois dias (25/01/2021). Seguindo o protocolo, foi coletada e enviada amostra de secreção nasofaríngea (RT-PCR para covid-19) para análise no laboratório de referência. \u003cbr/\u003e\u003ch6\u003eFigura 1. Ficha do SIVEP-Gripe de registro individual do caso, 2021.\u003c/h6\u003e\u003ctable\u003e\u003ctr\u003e\u003ctd\u003e\u003cimg src="img/caso1_figura1_SE.png"\u003e\u003c/td\u003e\u003ctd\u003e\u003cimg src="img/caso1_figura1_1_SE.png"\u003e\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003c/p\u003e',
        },
        titulo: "Descrição do Caso",
        tipo: "descricaocaso",
      },
      {
        conteudo: {
          saibaCont:
            '\u003ch3\u003eNotificação de covid-19\u003c/h3\u003e\u003cp\u003eA notificação imediata (em até 24h) dos casos suspeitos e/ou confirmados e óbitos por covid-19, logo após o atendimento que levante hipótese diagnóstica para o agravo é obrigatória por se tratar de um Evento de Saúde Pública (ESP). Um ESP é toda situação que pode se constituir em potencial ameaça à saúde pública, como a ocorrência de surto ou epidemia, doença ou agravo de causa desconhecida, alteração no padrão clínico-epidemiológico das doenças conhecidas, considerando o potencial de disseminação, a magnitude, a gravidade, a severidade, a transcendência e a vulnerabilidade, bem como epizootias ou agravos decorrentes de desastres ou acidentes.\u003c/p\u003e\u003cp\u003eAs especificidades quanto à notificação e ao registro dos casos suspeitos de SG e SRAG por covid-19 seguem o fluxo apresentado na Figura 2.\u003c/p\u003e\u003ch6\u003e(BRASIL 2016, 2021)\u003c/h6\u003e\u003ch6\u003eFigura 2. Fluxo de notificação e registro de casos suspeitos de SG e SRAG por covid-19\u003c/h6\u003e\u003cimg src="img/caso1_figura2_SE.png"\u003e\u003cp\u003eA equipe da Vigilância Epidemiológica deu início à investigação epidemiológica no dia 28 de janeiro de 2021, com o objetivo de rastrear contatos para definir as medidas de quarentena preventiva. Assim, a equipe deslocou-se ao endereço informado na notificação, o que permitiu verificar que a M.A.S. residia em ILPI.\u003c/p\u003e',
        },
        titulo: "Saiba Mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eNesse momento, com apenas um caso de síndrome gripal identificado, é preciso definir a data de início dos sintomas para determinar a possibilidade de contato com outros casos nos 14 dias que antecederam ao aparecimento dos sintomas. Esta data também é fundamental para determinar o tempo de isolamento desta idosa, como medida de controle de contaminação dos outros residentes, trabalhadores e familiares. A situação da vacinação contra covid-19 e outras doenças que cursam com quadro respiratório se faz necessária para definição dos agentes etiológicos possíveis nesta situação. Por fim, o rastreamento de contatos é fundamental como medida de prevenção no sentido de evitar a disseminação do agente para outras pessoas do convívio deste caso.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Acompanhar a evolução clínica de M.A.S.", false],
            [
              "Verificar perfil vacinal de M.A.S para covid-19, influenza, pneumococo",
              true,
            ],
            [
              "Identificar quais são as comorbidades da idosa M.A.S., cujo caso foi notificado",
              false,
            ],
            [
              "Realocar todos os residentes da ILPI para outro local e suspender as atividades do estabelecimento",
              false,
            ],
            ["Realizar rastreamento dos contatos", true],
            ["Checar a data de início dos sintomas de M.A.S.", true],
          ],
        },
        pergunta:
          "Quais as primeiras ações da investigação epidemiológica ao chegar na ILPI?",
        titulo: "Questão 1",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eSurto ou evento inusitado em saúde pública é uma situação em que há aumento acima do esperado na ocorrência de casos de evento ou doença em uma área ou entre um grupo específico de pessoas, em determinado período. Ressalta-se que, para doenças raras, um único caso pode representar um surto.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["há uma suspeita de  surto de covid-19 nessa ILPI", false],
            ["há um surto de covid-19 nessa ILPI", true],
            [
              "não há surto nem suspeita de surto de covid-19 nessa ILPI",
              false,
            ],
            ["ainda não é possível definir se há surto", false],
          ],
        },
        pergunta:
          "Com as informações, até esse momento, é possível afirmar que:",
        titulo: "Questão 2",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eDefinição de Surto de covid-19\u003c/h3\u003e\u003cp\u003ePode variar de local para local, mas consiste, basicamente, em uma transmissão potencialmente extensa em um local ou organização. Sua abordagem é uma tarefa complexa, necessitando da investigação de múltiplos casos e contatos ao mesmo tempo.\u003c/p\u003e\u003cp\u003eOs surtos de doença pelo Coronavírus SARS-CoV-2 (covid-19) se configuram pela ocorrência de pelo menos três casos confirmados de covid-19 por RT-PCR em tempo real associado a reuniões, coletividades e comunidades fechadas ou semifechadas, com vínculo temporal, ou seja, casos que ocorreram em menos de 14 dias entre eles.\u003c/p\u003e\u003cp\u003eNo caso das Instituições de Longa Permanência para Idosos, considerando a Nota Técnica 55/20 e as características da instituição, do serviço ofertado, que exige contato próximo e frequente entre os profissionais e os clientes, e a acentuada vulnerabilidade dos idosos residentes, a ocorrência de um caso deve ser caracterizada como surto e esse devidamente notificado no NOTIFICA-COVID-19.\u003c/p\u003e\u003cp\u003eCasos entre indivíduos que moram juntos com vínculo próximo, como famílias, e apresentam covid-19, não configuram ocorrência de surto. Entretanto, a adequação da definição de surto, bem como sua prevenção e manejo, deve ser adequada ao contexto local. Sendo assim, é recomendado elaborar uma definição operacional e protocolos específicos para cada contexto.\u003c/p\u003e\u003ch6\u003e(PARANÁ, 2020)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eComo já foi definido que se trata de um surto de covid-19, o passo seguinte é determinar quais são as medidas de prevenção e controle a serem instituídas para conter a progressão dos casos na ILPI, evitar a disseminação para outros serviços de saúde, por meio dos trabalhadores da ILPI, e para as famílias dos residentes (no caso das visitas de familiares).\u003c/br\u003eDiante da constatação da ocorrência de surto de covid-19 na ILPI a Vigilância Sanitária e a Vigilância em Saúde do Trabalhador foram acionadas. O trabalho em conjunto com os outros elementos da Vigilância irá permitir a avaliação de riscos, cumprimento de medidas de prevenção e definição conjunta com a Vigilância Epidemiológica das medidas de controle (isolamento de sintomáticos, por exemplo).\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Definir medidas de prevenção e controle", true],
            ["Testar todos os residentes e trabalhadores para covid-19", true],
            ["Iniciar um estudo de caso-controle", false],
            ["Isolar todos os residentes em conjunto", false],
            [
              "Providenciar a remoção de todos os residentes para outra ILPI",
              false,
            ],
          ],
        },
        pergunta:
          "Após definir que se trata de um surto de covid-19, o que deve ser feito?",
        titulo: "Questão 3",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eMedidas de controle administrativo são aquelas que se caracterizam por mudanças organizacionais nas políticas ou,  sempre que possível, rotinas de trabalho que minimizem a exposição a um risco, sua duração, frequência e intensidade.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Disponibilizar condições para higiene das mãos", true],
            [
              "Garantir que os profissionais mantenham as unhas limpas e bem aparadas",
              true,
            ],
            ["Restringir visitas", true],
            ["Impedir o ingresso de novos residentes", true],
            [
              "Instalar antecâmaras e vestiários de barreira no acesso às unidades de pacientes com covid-19",
              false,
            ],
            ["Disponibilizar áreas para paramentação e desparamentação", false],
            ["Instalar pontos de higienização", false],
            [
              "Colocar divisórias entre pacientes nas áreas compartilhadas",
              false,
            ],
            ["Adaptar o sistema de climatização", false],
          ],
        },
        pergunta:
          "Considerando os fatos relatados, quais das ações a seguir correspondem às medidas de \u003ci\u003econtrole administrativo\u003c/i\u003e para eliminar, reduzir ou controlar os fatores e as situações de risco?",
        titulo: "Questão 4",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eAs medidas de controle de engenharia consistem em alterações estruturais que ajudam a reduzir a propagação e a concentração de agentes infecciosos, neste caso covid-19, nos ambientes, o número de áreas com exposição potencial, e o número de pessoas expostas que, em conjunto com medidas de controle administrativo e de proteção individual, potencializam seu efeito sobre as situações de risco.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Isolar residentes sintomáticos", false],
            ["Ampliar o  distanciamento no refeitório", true],
            ["Assegurar boa ventilação em ambientes fechados", true],
            [
              "Instalar barreiras físicas que evitem a dispersão do vírus",
              true,
            ],
            [
              "Adaptar o sistema de climatização certificando-se que a solução adotada não irá contaminar os ambientes",
              true,
            ],
            ["Utilizar álcool à 70% para limpeza de superfícies", false],
            ["Reforçar uso de máscaras", false],
            ["Restringir visitas", false],
            ["Impedir o ingresso de novos residentes", false],
          ],
        },
        pergunta:
          "Quais das ações a seguir correspondem às medidas de \u003ci\u003econtrole de engenharia\u003c/i\u003e para eliminar, reduzir ou controlar os fatores e as situações de risco?",
        titulo: "Questão 5",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eDurante a verificação da listagem com identificação de todos os residentes e de trabalhadores em atividade no local, leitura dos prontuários/registros de saúde e entrevista com a direção técnica a Vigilância Epidemiológica detectou que uma outra idosa residente (J.L.P.) teria apresentado sinais e sintomas respiratórios (febre, dispneia, confusão mental e rebaixamento do sensório), duas semanas antes de M.A.S. À época, tais manifestações foram consideradas como evento adverso pós vacinação pela direção da ILPI. No entanto, devido ao agravamento do quadro clínico de J.L.P, esta necessitou de hospitalização. A equipe da Vigilância Epidemiológica não localizou notificação de evento adverso para J.L.P no SI-PNI/SI-EAPV, mas encontrou uma notificação de SG suspeita de covid-19 no e-SUS notifica, consequente à coleta de amostra nasofaríngea para realização de RT-PCR para covid-19 solicitada pela unidade de pronto atendimento que atendeu J.L.P. Houve agravamento da condição clínica de J.L.P. que necessitou ser transferida para a UTI, com uso de ventilação mecânica e evolução para óbito. De posse do resultado do RT-PCR para covid-19 no mesmo dia do óbito, a Vigilância Epidemiológica confirma que também se tratava de um caso de covid-19.\u003c/p\u003e\u003cp\u003eEm relação à paciente M.A.S. a coleta do RT-PCR realizada em 28 de janeiro confirmou para infecção por coronavírus (SARS-CoV-2). A idosa também foi internada em UTI onde necessitou receber suporte ventilatório invasivo, evoluindo para o óbito em dois dias.\u003c/p\u003e\u003cp\u003eA partir da listagem dos residentes e trabalhadores da ILPI realizou-se uma varredura nos sistemas de informação (e-SUS notifica e SIVEP-gripe). Foram identificadas quatro notificações de SG desencadeadas por resultado positivo em testes rápidos de antígeno para covid-19 em funcionários e integrantes da direção técnica da instituição realizados na semana anterior ao início dos sintomas da M.A.S. A triagem clínica e revisão dos prontuários dos residentes seguiu como rotina diária e verificou a ocorrência de 31 casos sintomáticos durante o período de monitoramento do surto, dos quais 30 precisaram de internação hospitalar (todos estes eram residentes).\u003c/p\u003e\u003cp\u003eO quadro a seguir apresenta o consolidado com os resultados da investigação.\u003c/p\u003e \u003ch6\u003eQuadro 1. Consolidado de informações com os resultados da investigação do surto de covid-19 na ILPI.\u003c/h6\u003e\u003ctable class='table'\u003e\u003ctr\u003e\u003ctd\u003eNome do estabelecimento\u003c/td\u003e\u003ctd\u003eILPI\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eSTATUS DO SURTO\u003c/td\u003e\u003ctd\u003eENCERRADO\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eCIDADE\u003c/td\u003e\u003ctd\u003e-----------------\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eTotal de Expostos (n)\u003c/td\u003e\u003ctd\u003e115\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eData de estimativa do início do surto\u003c/td\u003e\u003ctd\u003e-----------------\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eData de definição do surto\u003c/td\u003e\u003ctd\u003e28/01/2021\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eSINAN/SG (n° de notificação)\u003c/td\u003e\u003ctd\u003e-----------------\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eTotal de Sintomáticos\u003c/td\u003e\u003ctd\u003e31\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eAfastados total (n)\u003c/td\u003e\u003ctd\u003e0\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eTotal PCR\u003c/td\u003e\u003ctd\u003e93\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003ePositivos PCR\u003c/td\u003e\u003ctd\u003e78\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eTotal teste rápido antígeno\u003c/td\u003e\u003ctd\u003e10\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003ePositivos teste rápido antígeno\u003c/td\u003e\u003ctd\u003e9\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003ePositivos por outros testes\u003c/td\u003e\u003ctd\u003e0\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003ePositivos por outro critério\u003c/td\u003e\u003ctd\u003e0\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eTotal positivos\u003c/td\u003e\u003ctd\u003e87\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eÓbitos (n)\u003c/td\u003e\u003ctd\u003e15\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eÓbitos secundários\u003c/td\u003e\u003ctd\u003e0\u003c/td\u003e\u003c/tr\u003e \u003ctr\u003e\u003ctd\u003eDUPLICIDADE\u003c/td\u003e\u003ctd\u003e0\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eDUPLICIDADE (n)\u003c/td\u003e\u003ctd\u003e0\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eTaxa de ataque\u003c/td\u003e\u003ctd\u003e?\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              '\u003cp\u003eA taxa de ataque (TA) da doença é uma medida de incidência que se refere a populações específicas, em períodos limitados, como, por exemplo, durante surtos e epidemias. É expressa usualmente em percentagem. Segue a fórmula para cálculo:\u003c/p\u003e\u003cp\u003eTA da Exposição:\u003c/p\u003e\u003cbr/\u003e\u003cimg src="img/caso1_figura5_SE.png"\u003e\u003cbr/\u003eTA na ILPI = 87/115 = 75,6%\u003c/p\u003e',
            tipo: "texto",
          },
          opcoes: [
            ["75,6%", true],
            ["26,9%", false],
            ["80,8%", false],
            ["132,1%", false],
          ],
        },
        pergunta:
          "No Quadro 1, a última linha corresponde ao valor da taxa de ataque. Com base nas informações fornecidas calcule a taxa de ataque nesta ILPI?",
        titulo: "Questão 6",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          resposta: {
            texto:
              '\u003cp\u003eNesta questão, em específico, foi solicitado o cálculo da TA em cada um dos grupos de residentes e dos trabalhadores em separado.\u003c/p\u003e\u003cp\u003eTaxa de ataque nos trabalhadores:\u003c/p\u003e\u003cimg src="img/caso1_figura0_SE.png"\u003e\u003cp\u003eTA nos residentes 59/73 = 80,8%\u003c/p\u003e',
            tipo: "texto",
          },
          opcoes: [
            ["66,7% e 80,8%;", true],
            ["26,9% e 67,8%;", false],
            ["32,1% e 50,0%;", false],
            ["33,3% e 19,8%.", false],
          ],
        },
        pergunta:
          "Analise os dados da tabela a seguir e calcule a taxa de ataque nesta ILPI entre funcionários e residentes.\u003ch6\u003eTabela 1. Frequência de infectados no surto de covid-19 da ILPI, conforme resultados da Investigação Epidemiológica. 2021.\u003c/h6\u003e\u003ctable class='table'\u003e\u003ctr\u003e\u003ctd\u003e\u003cb\u003eInfectados\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003ePositivos\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eNegativos\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eTotal\u003c/b\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eFuncionários\u003c/td\u003e\u003ctd\u003e28\u003c/td\u003e\u003ctd\u003e14\u003c/td\u003e\u003ctd\u003e42\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eResidentes\u003c/td\u003e\u003ctd\u003e59\u003c/td\u003e\u003ctd\u003e14\u003c/td\u003e\u003ctd\u003e73\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eTotal\u003c/td\u003e\u003ctd\u003e87\u003c/td\u003e\u003ctd\u003e28\u003c/td\u003e\u003ctd\u003e115\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003cbr/\u003eA taxa de ataque nesta ILPI entre funcionários e residentes é, respectivamente:",
        titulo: "Questão 7",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            '\u003cp\u003eO surto se prolongou por quase 30 dias, período em que houveram novos casos detectados devido às \u003cb\u003ebarreiras para a realização da investigação epidemiológica\u003c/b\u003e, tais como:\u003cul\u003e\u003cli\u003edificuldades iniciais no acesso às informações por listagem nominal de residentes e trabalhadores incompleta e/ou desatualizada; prontuário inexistente ou, quando presente, com escassez de informação sobre a evolução clínica;\u003c/li\u003e\u003cli\u003eestrutura inadequada para implantação de medidas de prevenção e controle tanto individuais (cumprimento de isolamento de sintomáticos, fornecimento de EPI para residentes e trabalhadores, impedimento do ingresso de novos residentes durante o surto e sub identificação de sinais/sintomas de SG por parte da equipe de assistência à saúde da instituição), quanto administrativas (disponibilizar condições para higiene das mãos; os profissionais que prestam assistência aos pacientes não devem utilizar adornos, principalmente nas mãos ou antebraços, e devem manter suas unhas limpas e bem aparadas; criar estratégias de demarcação e orientações para manter distância mínima de um metro entre as pessoas; evitar aglomerações; reforçar a necessidade o uso de máscara facial durante toda a permanência em qualquer ambiente do serviço de saúde; orientar para que os profissionais não circulem nos ambientes que não fazem parte da área de assistência utilizando EPIs, que só devem ser usados durante a prestação de assistência direta aos pacientes; aumentar o espaçamento entre mesas e cadeiras e de engenharia (ventilação de ambientes fechados; adaptação dos ambientes para que se instale antecâmaras e vestiários de barreira no acesso às unidades de pacientes com covid-19, com áreas para paramentação e desparamentação, bem como dispositivos para higiene de mãos; barreiras ou partições físicas para orientação e atendimento dos pacientes/acompanhantes nas áreas de triagem; adoção de divisórias entre pacientes nas áreas compartilhadas);\u003c/li\u003e\u003cli\u003emanutenção da admissão de novos residentes;\u003c/li\u003e\u003cli\u003emanutenção dos idosos residindo na ILPI durante o surto;\u003c/li\u003e\u003cli\u003ecarência de acompanhamento médico e de enfermagem;\u003c/li\u003e\u003cli\u003esubvalorização dos achados clínicos em idosos que não apresentavam outros sinais "clássicos" de SG como, por exemplo, desconsiderar a baixa saturação de O2 como um indicador de agravamento do quadro;\u003c/li\u003e\u003cli\u003eatribuição de sinais e sintomas de SG como manifestação adversa pós-vacinal;\u003c/li\u003e\u003cli\u003eocorrência de sintomáticos respiratórios e casos confirmados entre trabalhadores da instituição que não foram notificados oportunamente e não afastados do trabalho;\u003c/li\u003e\u003cli\u003emanutenção dos espaços coletivos com circulação de moradores e trabalhadores.\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e',
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: [
          {
            urlExterno:
              "https://www.gov.br/anvisa/pt-br/centraisdeconteudo/publicacoes/servicosdesaude/notas-tecnicas/2020/nota-tecnica-gvims-ggtes-anvisa-no-07-2020#:~:text=O%20diagn%C3%B3stico%20sindr%C3%B4mico%20Page%2014,epidemiol%C3%B3gica%20e%20do%20exame%20f%C3%ADsico",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "ANVISA. Agência Nacional de Vigilância Sanitária. Nota Técnica GVIMS/GGTES/ANVISA Nº 07/2020. \u003cb\u003eOrientações para prevenção e Vigilância Epidemiológica das infecções por SARS-CoV-2\u003c/b\u003e (covid-19) dentro dos serviços de saúde. Revisão 3 de 23 de julho de 2021. Brasília (DF), 2020. Disponível em:",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/saudelegis/gm/2016/prt0204_17_02_2016.html",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. \u003cb\u003ePortaria nº 204, de 17 de fevereiro de 2016\u003c/b\u003e. Diário Oficial da República Federativa do Brasil, Brasília (DF), 2016. Disponível em: ",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/guia_investigacao_surtos_epidemias.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Vigilância das Doenças Transmissíveis. \u003cb\u003eGuia para Investigações de Surtos ou Epidemias\u003c/b\u003e / Ministério da Saúde, Secretaria de Vigilância em Saúde, Departamento de Vigilância das Doenças Transmissíveis – Brasília : Ministério da Saúde, 2018. Disponível em: ",
          },
          {
            urlExterno:
              "https://www.gov.br/saude/pt-br/centrais-de-conteudo/publicacoes/publicacoes-svs/coronavirus/guia-de-vigilancia-epidemiologica-covid-19_2021.pdf/view",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. \u003cb\u003eGuia de vigilância epidemiológica\u003c/b\u003e: emergência de saúde pública de importância nacional pela doença pelo coronavírus 2019 – covid-19 / Ministério da Saúde, Secretaria de Vigilância em Saúde. – Brasília : Ministério da Saúde, 2022. Disponível em:",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/guia_vigilancia_saude_5ed_rev_atual.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. \u003cb\u003eGuia de Vigilância em Saúde\u003c/b\u003e [recurso eletrônico] / Ministério da Saúde, Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. – 5. ed. rev. – Brasília : Ministério da Saúde, 2022. Disponível em",
          },
          {
            urlExterno:
              "https://www.in.gov.br/en/web/dou/-/portaria-n-1.565-de-18-de-junho-de-2020-262408151",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. \u003cb\u003ePortaria GM/MS n.° 1.565, de 18 de junho de 2020\u003c/b\u003e. Estabelece orientações gerais visando à prevenção, ao controle e à mitigação da transmissão da COVID-19.  Disponível em:.",
          },
          {
            urlExterno:
              "http://scielo.iec.gov.br/scielo.php?script=sci_arttext\u0026pid=S0104-16731999000400005\u0026lng=pt\u0026nrm=iso",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "LAGUARDIA, Josué; PENNA, Maria Lúcia. \u003cb\u003eDefinição de caso e vigilância epidemiológica\u003c/b\u003e. Inf. Epidemiol. Sus,  Brasília ,  v. 8, n. 4, p. 63-66,  dez.  1999 .   Disponível",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/modulo_principios_epidemiologia_3.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "OPAS. Organização Pan-Americana da Saúde. \u003cb\u003eMódulos de Princípios de Epidemiologia para o Controle de Enfermidades.\u003c/b\u003e Módulo 3: medida das condições de saúde e doença na população / Organização Pan-Americana da Saúde. Brasília : Organização Pan-Americana da Saúde; Ministério da Saúde, 2010. Disponível em: ",
          },
          {
            urlExterno:
              "https://www.saude.pr.gov.br/sites/default/arquivos_restritos/files/documento/2020-12/NO_55_SURTOS_V1.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "PARANÁ. Secretaria de Estado da Saúde. \u003cb\u003eNota Técnica 55/2020\u003c/b\u003e - Surtos de doença pelo coronavírus SARS-CoV-2. Informações gerais. Paraná: Secretaria de Estado da Saúde, 2020. Disponível em: ",
          },
          {
            urlExterno:
              "https://apps.who.int/iris/bitstream/handle/10665/43771/9789241547222_eng.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "WHO. \u003cb\u003eFoodborne disease outbreaks:\u003c/b\u003e Guidelines for investigation and control. World Health Organization. (‎2008). Disponível em:",
          },
        ],
        tipo: "bibliografia",
      },
    ],
    subTitulo: "",
    titulo: "Síndrome Gripal em uma Instituição de Longa Permanência",
    tsPublicacao: "1234567890",
    shortname: "Sindrome Gripal em uma Institição de Longa Permanência",
    autor: ["Dóris Schuch", "Marcínia Bueno"],
    editores: ["Everton Fantinel", "Denise Silveira"],
  },
  {
    _id: ObjectId("62f968a141e46f53119d100b"),
    autor: ["Dóris Schuch", "Marcínia Bueno"],
    editores: ["Everton Fantinel", "Denise Silveira"],
    id: 9061.0,
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "41 anos",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "interdisciplinar",
    slides: [
      {
        conteudo: { texto: "", delay: "5" },
        titulo: "Introdução",
        tipo: "intro",
      },
      {
        conteudo: {
          descricaoCaso:
            '\u003cp\u003eNa manhã do dia 30 de janeiro de 2022, a Vigilância Epidemiológica (VE) de  um município de 75 mil habitantes, recebeu uma notificação de suspeita de um surto de doença diarreica aguda (DDA) por meio da “FICHA DE INVESTIGAÇÃO DE SURTO - DTA” do SISTEMA DE INFORMAÇÃO DE AGRAVOS DE NOTIFICAÇÃO (SINAN),  proveniente de uma de suas Unidades de Pronto Atendimento. Conforme este documento (Figura 1),  18 operários  de uma empresa de eletrificação rural procuraram atendimento por apresentarem diarreia, vômitos e fortes dores abdominais iniciadas a partir da tarde do dia anterior (aproximadamente 20 horas antes). Na consulta, os pacientes relataram que outros operários, instalados em alojamento coletivo locado pela referida empresa, apresentavam sintomas similares.\u003c/p\u003e\u003ch6\u003eFigura 1. Ficha de investigação de surto - DTA, SINAN, 2022.\u003c/h6\u003e\u003ctable\u003e\u003ctr\u003e\u003ctd\u003e\u003cimg src="img/caso2_figura1_ALMONDEGA.png"\u003e\u003c/td\u003e\u003ctd\u003e\u003cimg src="img/caso2_figura1_1_ALMONDEGA.png"\u003e\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003cp\u003eA VE solicitou então o nome e os sinais e sintomas de cada pessoa atendida, bem como a data e horário de início de cada um deles. Imediatamente, a coordenação e técnicos da VE reuniram-se com as equipes da Vigilância Sanitária, Vigilância em Saúde do Trabalhador, Vigilância Ambiental em Saúde  da Secretaria Municipal de Saúde e Atenção Primária à Saúde do bairro onde se situava o referido alojamento, para comunicar a suspeita do surto. Após informar a todos sobre os dados disponíveis até o momento, a VE definiu as atribuições de cada equipe na investigação. Nesta mesma reunião foram reiterados os propósitos da VE diante de um surto de DTA e as principais atividades necessárias para operacionalizá-las.\u003c/p\u003e',
        },
        titulo: "Descrição do Caso",
        tipo: "descricaocaso",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA busca por respostas mais efetivas para as demandas e os problemas de saúde promoveram a incorporação de uma estrutura organizacional no campo da saúde coletiva a partir da constituição do conceito de vigilância em saúde. Esse modelo propõe o trabalho norteado por um conjunto de ações articuladas e integradas entre seus componentes (vigilância epidemiológica, vigilância sanitária, vigilância em saúde ambiental e do trabalhador e vigilância da situação de saúde). Não é competência da Vigilância Epidemiológica verificar as condições ambientais da água de consumo humano ou mesmo a coleta de amostra para análise, ações que são de responsabilidade da Vigilância Ambiental.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "fornecer orientação técnica permanente para os profissionais de saúde sobre mudanças nos fatores determinantes e condicionantes da saúde individual ou coletiva",
              true,
            ],
            [
              "recomendar medidas de prevenção e controle de doenças e agravos",
              true,
            ],
            [
              "propiciar a normatização, o planejamento e a execução de atividades técnicas correspondentes por se tratar de um instrumento de gestão",
              true,
            ],
            [
              "verificar condições ambientais da água de consumo humano e proceder coleta de amostras para análise de orientação",
              false,
            ],
          ],
        },
        pergunta: "Os propósitos da vigilância epidemiológica são:",
        titulo: "Questão 1",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eO desenvolvimento oportuno das ações de VE promove a disposição de dados e de informações mais consistentes, o que possibilita melhor compreensão dos panoramas de saúde municipal, regional, estadual/distrital e nacional. Nesse contexto, as intervenções do nível estadual/distrital e, com maior razão, do federal devem ser direcionadas às ações que, pela sua transcendência, requerem avaliação complexa e abrangente, muitas vezes com envolvimento de outros setores.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "indicação e promoção das medidas de prevenção e controle apropriadas",
              true,
            ],
            ["avaliação da eficácia e efetividade das medidas adotadas", true],
            ["análise e interpretação dos dados processados", true],
            ["divulgação de informações pertinentes", true],
            ["coleta e processamento de dados", true],
          ],
        },
        pergunta:
          "Para operacionalizar as atividades da vigilância epidemiológica, recomenda-se que sejam realizadas, pelo menos:",
        titulo: "Questão 2",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eAs ações da vigilância frequentemente são multiprofissionais e intersetoriais, necessitando de articulação entre as diferentes equipes que atuam no campo, bem como entre os investigadores de um mesmo núcleo de trabalho. Dessa forma é fundamental que os papéis de cada profissional estejam bem estabelecidos para otimizar o fluxo de trabalho. No que concerne à equipe de Vigilância Epidemiológica cabe a definição de caso suspeito, definido a partir da avaliação clínica dos operários sintomáticos; sistematização de dados de data/hora de início de sintomas, para definir curva de transmissão de forma a estimar o tipo de transmissão (pessoa-a-pessoa ou fonte comum).\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "Definição de caso suspeito a partir da avaliação clínica e sistematização de dados de data/hora de início de sintomas",
              true,
            ],
            [
              "Avaliação clínica dos sintomáticos e medidas de atenção individuais, identificação de sinais e sintomas",
              false,
            ],
            [
              "Verificar as instalações, produtos e serviços disponíveis, definir riscos sanitários para correção e fazer eventuais coletas de amostras que se façam necessárias",
              false,
            ],
            [
              "Verificar as condições de alojamento dos trabalhadores e possíveis riscos relacionados, verificar registros de saúde e a disponibilidade de atenção à saúde dos operários",
              false,
            ],
          ],
        },
        pergunta:
          "No contexto do início da investigação de uma suspeita de surto de DTA quais são as atribuições iniciais dos profissionais da equipe de Vigilância Epidemiológica?",
        titulo: "Questão 3",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eAtribuições dos profissionais\u003c/h3\u003eAs atribuições dos técnicos e/ou profissionais de acordo com a equipe à qual pertencem são:\u003cul\u003e\u003cli\u003eEquipe de Atenção Primária: avaliação clínica dos sintomáticos e medidas de atenção individuais, identificação de sinais e sintomas.\u003c/li\u003e\u003cli\u003eVigilância Epidemiológica: Definição de caso suspeito definido a partir da avaliação clínica dos operários sintomáticos. Sistematização de dados de data/hora de início de sintomas, para definir curva de transmissão de forma a estimar o tipo de transmissão (pessoa-a-pessoa ou fonte comum)\u003c/li\u003e\u003cli\u003eVigilância Sanitária: Verificar as instalações, produtos e serviços disponíveis, definir riscos sanitários para correção, fazer eventuais coletas de amostras que se façam necessárias.\u003c/li\u003e\u003cli\u003eVigilância Ambiental: trabalhar em colaboração com a Vigilância Sanitária na avaliação de riscos no local. Verificar condições ambientais da água de consumo humano e proceder coleta de amostras para análise de orientação.\u003c/li\u003e\u003cli\u003eVigilância em Saúde do Trabalhador: verificar as condições de alojamento dos trabalhadores e possíveis riscos relacionados, verificar registros de saúde e a disponibilidade de atenção à saúde dos operários, por parte da empresa.\u003c/li\u003e\u003c/ul\u003e\u003ch6\u003e(BRASIL, 2018)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            '\u003cp\u003eApós esta definição de atividades por equipe, o laboratório de saúde pública de referência foi comunicado da investigação do surto, de forma que estivesse organizado para a coleta e/ou análise oportuna das amostras dos pacientes, alimentos e água à medida que os casos fossem identificados e as entrevistas realizadas. \u003c/p\u003e\u003cp\u003eSeguindo a investigação, após a notificação dos 18 casos de DTA atendidos na UPA, as equipes se dirigiram ao alojamento onde estavam os operários contratados pela empresa de eletrificação rural, a fim de confirmar se existiam outros casos que ainda não haviam procurado atendimento médico. No alojamento foram detectados 49 casos sintomáticos com queixas de vômitos, cefaleia, fraqueza, diarreia, dor e distensão abdominal. \u003c/p\u003e\u003cp\u003eO conjunto de sinais e sintomas apresentados pelos operários caracterizou tratar-se de manifestações da DTA, restando agora a identificação da etiologia, fonte/forma de transmissão. A depender do agente etiológico a transmissão pode ocorrer pessoa-a-pessoa ou por fonte comum. Dessa forma, os próximos passos da investigação têm como propósito definir o modo de transmissão e identificar qual a fonte da contaminação pelo agente etiológico.\u003c/p\u003e\u003cp\u003eAvançando na investigação foi elaborada uma planilha com todos os operários da empresa, possíveis expostos a uma determinada fonte/forma de transmissão, com identificação dos sintomáticos e elaboração de uma lista de sintomas, com data/horário de início do quadro clínico para cada um destes. Após sistematização dos dados a VE: a) estabeleceu a definição de caso suspeito para o presente surto de DTA - “Indivíduos com atividade laboral relacionada a uma empresa prestadora de serviços e que compartilhavam um alojamento coletivo, apresentando sintomas de vômito, diarreia e dor abdominal”; b) Elaborou uma Curva Epidêmica com o número de casos de acordo com a data de início dos primeiros sinais e sintomas (Figura 2).\u003c/p\u003e\u003ch6\u003eFigura 2. Histograma da data/horário de início de sintomas dos casos no surto no alojamento de operários empresa de eletrificação do bairro Progresso do município de Fraternidade, 2022 (n=67).\u003c/h6\u003e\u003cimg src="img/caso2_figura2_ALMONDEGA.png"/\u003e',
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA definição de um conjunto de critérios é fundamental para que seja possível determinar quais pessoas têm ou tiveram a doença ou evento que será investigado naquele período e lugar, bem como excluir aquelas que não estariam relacionadas ao surto.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "características das pessoas afetadas (ex.: idade, sexo, escolaridade)",
              true,
            ],
            ["informação clínica (e laboratorial) sobre a doença", true],
            ["informação sobre o local ou região de ocorrência", true],
            ["determinação do período em que ocorreu o surto", true],
          ],
        },
        pergunta:
          "No contexto da elaboração da definição de caso suspeito deste surto de DTA, a VE levou em consideração o(s) seguinte(s) componente(s):",
        titulo: "Questão 4",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA curva epidêmica é o instrumento básico para caracterizar um surto no tempo, o que envolve o estabelecimento da duração do surto (que variará de acordo com a infectividade do agente etiológico, o modo de transmissão, a população exposta, o período de incubação da doença e a efetividade das medidas de controle imediato) e a definição da sua natureza (surtos de fonte comum – pontual ou contínua – ou propagada – pessoa a pessoa. A depender das características do surto, a data de início dos sintomas dos casos identificados pode ser expressa na curva epidêmica em horas, dias ou meses. Em uma curva epidêmica de fonte comum, a figura demonstra uma curva com aclive rápido e declive gradual, pois os casos ocorrem repentinamente depois do período de incubação mínimo e continuam por um breve período relacionado com a variabilidade do tempo de incubação. Na transmissão de fonte pessoa a pessoa a curva é irregular, podendo apresentar vários picos e intervalos correspondentes ao período de incubação da doença, indicando uma exposição a uma fonte propagada, em que a transmissão geralmente ocorre de pessoa a pessoa. O contato dos casos com o agente etiológico se dá em períodos diversos e sucessivos.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["fonte comum", true],
            ["pessoa a pessoa", false],
            ["fonte cruzada", false],
            ["fonte independente", false],
          ],
        },
        pergunta:
          "A análise dos dados do histograma com as datas e horários de início dos sintomas permitiu à VE formular a hipótese de transmissão do tipo:",
        titulo: "Questão 5",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eFormulação de hipóteses\u003c/h3\u003e\u003cp\u003eA partir da consolidação e da análise das informações obtidas durante o processo de investigação, é possível formular hipóteses preliminares sobre o modo e o veículo prováveis de transmissão, grupos de risco e fonte do agente causal do surto, com o propósito de estabelecer as causas básicas da ocorrência do surto na população e a aplicação oportuna e efetiva de medidas de prevenção e controle definitivas.\u003c/p\u003e\u003cp\u003eCaso a identificação do agente etiológico ocorra rapidamente, é possível a aplicação de medidas de prevenção e controle de forma mais imediata, principalmente quando o quadro clínico é característico (patognomônico) – como exemplo, em casos de botulismo; quando se conhece a circulação de agentes etiológicos por alguma razão; quando há algum aspecto, como contato com casos confirmados de determinadas doenças, entre outros fatores que podem ser identificados e considerados de acordo com a história natural de cada DTHA.\u003c/p\u003e\u003ch6\u003e(BRASIL, 2021)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eNa hipótese de modo de transmissão de fonte comum, pressupõe-se que as pessoas se expuseram ao mesmo tempo ao agente causal e tiveram sintomas também em um período similar. Neste surto, a maior parte dos casos identificados apresentaram o começo do quadro de DTA no mesmo período, inclusive com vários operários tendo sintomas no mesmo dia, remetendo a uma exposição simultânea dos expostos sintomáticos, seja por meio de alimento ou água.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eFormas de Transmissão\u003c/h3\u003e\u003cp\u003eNo surto por transmissão de fonte comum os casos sintomáticos aparecem dentro de um intervalo igual ao período de incubação clínica da doença, o que sugere a exposição simultânea (ou quase simultânea) de muitas pessoas ao agente etiológico. No presente surto o início dos sintomas aponta para datas que indicam uma exposição simultânea dos expostos sintomáticos (alimento, água, etc.), o que remete a necessidade de verificar quem destes efetivamente fez refeição em comum (alimento / água) no período incubação (período compreendido entre data da refeição comum e data de início de sintomas). O período de incubação e os sinais e sintomas irão nortear o nexo da checagem do provável alimento ou água sob suspeita, o que posteriormente deve concordar com os achados das análises laboratoriais das amostras. As medidas de controle imediato naquelas situações nas quais a investigação de surto sugere uma fonte comum de infecção devem ser voltadas para a remoção, controle, supressão, eliminação ou correção de tal fonte comum.\u003c/p\u003e\u003cp\u003eNo surto por transmissão pessoa a pessoa, haveria a distribuição de data de início de sintomas de acordo com os contatos entre as pessoas e o período de incubação do agente etiológico em questão. Nas situações em que a investigação do surto sugere transmissão de pessoa a pessoa e suspeita-se de alta patogenicidade ou virulência do agente causal, as medidas de controle devem ser dirigidas à fonte de infecção (os doentes) e a proteção dos suscetíveis (os contatos).\u003c/p\u003e\u003ch6\u003e(OPAS, 2010)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            '\u003cp\u003eO passo seguinte é a determinação de  vínculo epidemiológico entre os casos no período anterior ao aparecimento dos sintomas. A equipe da Vigilância Ambiental procedeu à coleta de água de consumo (amostras da água que chegava do sistema público ao alojamento, amostra dos reservatórios, da torneira da cozinha e dos bebedouros existentes no local). Todas as análises estavam em concordância com padrão de potabilidade, não sendo detectada alteração macroscópica nem crescimento de agentes patogênicos.\u003c/p\u003e\u003cp\u003eConcomitantemente a VE buscou identificar qual das refeições servidas no alojamento da empresa poderia ser implicada pelo adoecimento dos operários. A maioria dos sintomáticos relatou que havia almoçado na empresa entre 11:30 e 13 horas do dia anterior ao início do quadro clínico. Essa refeição foi elaborada por três cozinheiros contratados pela empresa, sendo que os mesmos se utilizaram da cozinha do refeitório. Os alimentos servidos na refeição foram:\u003cul\u003e\u003cli\u003eArroz\u003c/li\u003e\u003cli\u003eFeijão\u003c/li\u003e\u003cli\u003eAlmôndegas de carne\u003c/li\u003e\u003cli\u003eOvo cozido\u003c/li\u003e\u003cli\u003eMassa ao Sugo\u003c/li\u003e\u003cli\u003eBatata frita\u003c/li\u003e\u003cli\u003eAlface\u003c/li\u003e\u003cli\u003eVinagrete\u003c/li\u003e\u003cli\u003eSuco de Salada Frutas\u003c/li\u003e\u003cli\u003eGelatina (sobremesa)\u003c/li\u003e\u003c/ul\u003e\u003cp\u003eA lista de alimentos deste cardápio foi utilizada para elaborar um questionário padronizado onde constavam todos os alimentos disponíveis na refeição em comum (almoço do dia 29/1/22). Tal questionário foi disponibilizado aos investigadores da VE para que pudessem verificar individualmente os alimentos que cada um dos expostos consumiu. A partir destas informações foi elaborada uma lista com nominata de todos os expostos, identificando para cada um se Comensal doente ou Comensal não doente. Se comensal doente, a especificação dos sintomas e a data/hora de início de sintomas era registrada. Com estes dados foi possível calcular a taxa de ataque dos alimentos em cada um dos grupos.\u003c/p\u003e\u003cimg src="img/caso2_figura3_ALMONDEGA.png"/\u003e\u003ch6\u003eQuadro 1. Alimentos consumidos e comensais envolvidos na suspeita de surto em operários da empresa sem os valores calculados para as taxas de ataque e risco relativo, 2022.\u003c/h6\u003e',
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              '\u003cp\u003eA taxa de ataque (TA) da doença é uma medida de incidência que se refere a populações específicas, em períodos de tempo limitados, como por exemplo, durante surtos e epidemias. É expressa usualmente em percentagem. Seguem  as fórmulas para o cálculo da Taxa de ataque (TA) nos expostos (consumiram) e não expostos (não consumiram), para cada refeição/alimento:\u003c/p\u003e\u003cimg src="img/caso2_figura4_ALMONDEGA.png"/\u003e\u003cbr/\u003e\u003cbr/\u003e\u003cimg src="img/caso2_figura5_ALMONDEGA.png"/\u003e\u003cbr/\u003e\u003cimg src="img/caso2_figura6_ALMONDEGA.png"/\u003e\u003ch6\u003eQuadro 2. Alimentos consumidos e comensais envolvidos na suspeita de surto em operários da empresa, 2022.\u003c/h6\u003e',
            tipo: "texto",
          },
          opcoes: [
            ["feijão: 70,9", true],
            ["almôndegas de carne: 77,4", true],
            ["ovo cozido: 28,3", false],
            ["massa ao sugo: 30,1", false],
          ],
        },
        pergunta:
          "A partir das informações do Quadro 1 assinale a alternativa que apresenta a associação correta entre alimento e correspondente taxa de ataque entre os expostos:",
        titulo: "Questão 6",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          resposta: {
            texto:
              '\u003cp\u003eRisco relativo (RR): é uma medida da força de associação entre um fator de risco e um desfecho (evento ou doença) , expressando o risco de um evento ocorrer a um indivíduo, relativo à determinada exposição. Assim, é a partir da análise do risco relativo que se estabelece a causa de um surto. É calculado pela razão entre a taxa de ataque nos indivíduos expostos e a taxa de ataque nos indivíduos não expostos, e aponta quantas vezes a ocorrência do resultado no grupo de expostos é maior que aquela entre os não expostos.\u003c/p\u003e\u003cp\u003eA fórmula para cálculo do RR é:\u003c/p\u003e\u003cimg src="img/caso2_figura7_ALMONDEGA.png"/\u003e\u003cp\u003eOnde TA1 se refere a taxa de ataque entre os expostos (comensais) e TA2, entre os não expostos (não comensais).\u003c/p\u003e\u003cp\u003eInterpretação do resultado do RR:\u003cbr/\u003eRR=1:  ausência de associação;\u003cbr/\u003eRR\u003c1:  sugere que o fator estudado não apresenta risco, mas pode ser um fator de proteção;\u003cbr/\u003eRR\u003e1: sugere que há associação e que o fator estudado é um fator de risco para ocorrência do efeito.\u003c/p\u003e\u003cp\u003eEm síntese, o risco relativo é o primeiro critério a ser considerado para analisar a associação entre o alimento/refeição e o adoecimento. Sendo o risco relativo maior do que um, sugere-se uma associação positiva e recomenda-se fortemente a realização da análise laboratorial dessas amostras. Neste surto, os comensais que se alimentaram com alface e aqueles que consumiram almôndegas de carne apresentaram risco maior de adoecerem que aqueles que consumiram outros alimentos. Por outro lado, alimentos como ovo cozido, batata frita ou vinagrete não apresentaram maior risco de DTA, considerando que o risco relativo foi 1,0.\u003c/p\u003e\u003cp\u003eEm situações em que uma das taxas de ataque for igual a zero e, consequentemente, o risco relativo for infinito, recomenda-se que a decisão seja pautada na análise de outras medidas, como a diferença entre os riscos - Risco Atribuível (RA). O RA é uma medida da diferença do risco entre os indivíduos expostos e os indivíduos não expostos. O RA representa o risco adicional de doença (ou qualquer outro evento) relacionado à exposição ao quantificar quanto da incidência da doença pode ser atribuída exclusivamente ao fator de risco em estudo.\u003c/p\u003e\u003cp\u003ePara calcular o RA devemos usar a fórmula:\u003cp\u003e\u003cimg src="img/caso2_figura8_ALMONDEGA.png"/\u003e\u003cp\u003eOnde TA1 se refere a taxa de ataque entre os expostos (comensais) e TA2, entre os não expostos (não comensais).\u003c/p\u003e\u003cp\u003eInterpretação do resultado do RA:\u003c/p\u003e\u003cp\u003eOs alimentos ou as refeições que apresentarem as maiores diferenças positivas entre as taxas de ataque, ou seja, os maiores valores de RA, provavelmente são responsáveis pelo surto. \u003c/p\u003e',
            tipo: "texto",
          },
          opcoes: [
            [
              "operários que comeram almôndegas de carne tiveram um risco 3,5 vezes maior de adoecer do que os que não consumiram este alimento",
              true,
            ],
            [
              "operários que comeram ovo cozido tiveram um risco 1,0 vez maior de adoecer do que os que ingeriram massa ao sugo",
              false,
            ],
            [
              "operários que se alimentaram com alface tiveram um risco 2 vezes maior de adoecer que os que comeram gelatina",
              false,
            ],
            [
              "operário que beberam suco de frutas tiveram um risco 9 vezes maior de adoecer do que os que não consumiram este alimento",
              false,
            ],
          ],
        },
        pergunta:
          "A análise do Risco Relativo de cada alimento possibilita afirmar que:",
        titulo: "Questão 7",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eConcomitante à verificação detalhada dos alimentos consumidos sob responsabilidade da equipe da VE, a Vigilância Sanitária realizou a coleta de amostras dos alimentos que haviam sobrado desta refeição em comum (arroz, feijão e almôndegas de carne moída), ungueais e de fezes dos três cozinheiros, bem como amostra  de fezes de 13 pessoas sintomáticas para análise no laboratório de referência. As amostras de fezes foram coletadas por swab retal, que era imediatamente semeado em tubo com meio \u003ci\u003eCary Blair\u003c/i\u003e.\u003c/p\u003e\u003cp\u003eA análise dos alimentos detectou presença de Bacillus cereus nas amostras das almôndegas restantes da refeição e que estavam na geladeira da cozinha. Já o material coletado dos cozinheiros apresentava bactérias (\u003ci\u003eE. coli, Proteus sp., Staphylococcus aureus,\u003c/i\u003e etc) e em 12 dos 13 casos foi detectada presença de \u003ci\u003eBacillus cereus.\u003c/i\u003e\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            '\u003cp\u003eCom base nos resultados de investigação clínica e laboratorial dos casos, resultados laboratoriais das amostras de alimentos servidos na refeição em comum e, ainda, as taxas de ataque dos alimentos oferecidos na refeição suspeita concluiu-se pela ocorrência de surto transmitido por alimentos, sob forma de uma intoxicação por esporos de Bacillus cereus (no caso o alimento contaminado seriam as almôndegas de carne moída). A ausência de febre, os sintomas verificados e o período de incubação reforçam a definição de intoxicação. Não houve internação nem óbito decorrente do surto.\u003c/p\u003e\u003cp\u003eAs medidas de controle foram desencadeadas já durante a própria investigação e constatou-se as falhas no processamento, das boas práticas de manipulação dos alimentos até a oferta na refeição, como causa da intoxicação. Além das medidas corretivas imediatas, a Vigilância Sanitária tomou as medidas administrativas cabíveis com Auto de Infração Sanitária que desencadeou a abertura de Processo Administrativo Sanitário, nos termos do rito pertinente à legislação cabível.\u003c/p\u003e\u003cp\u003eNa etapa final da investigação todas as informações foram reunidas e resumidas por meio de relatório com o objetivo de comunicar / divulgar os resultados às autoridades de saúde e aos envolvidos no surto (Figura 3). A disseminação da informação é fundamental para apoiar outros atores na prevenção de casos ou de surtos semelhantes, por meio da adoção de medidas de prevenção, além de prestar contas à sociedade em relação ao trabalho desenvolvido\u003c/p\u003e\u003ch6\u003eFigura 3. Relatório final da investigação epidemiológica de DTA, 2022.\u003c/h6\u003e\u003cimg src="img/caso2_figura9_ALMONDEGA.png"/\u003e\u003cp\u003eA equipe da VE enfrentou algumas \u003cb\u003ebarreiras para a realização da investigação epidemiológica\u003c/b\u003e tais como:\u003c/p\u003e\u003cul\u003e\u003cli\u003e A empresa não tinha a ficha de saúde dos cozinheiros, o que impediu a avaliação do status de saúde destes trabalhadores.\u003c/li\u003e\u003cli\u003eA realização de coleta de amostras para envio ao laboratório de referência ocorreu apenas para os alimentos que haviam sobrado da refeição: arroz, feijão e almôndegas de carne moída.\u003c/li\u003e\u003c/ul\u003e',
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: [
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/modulo_principios_epidemiologia_4.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. \u003cb\u003eMódulos de Princípios de Epidemiologia para o Controle de Enfermidades.\u003c/b\u003e Módulo 4: vigilância em saúde pública / Organização Pan-Americana da Saúde. Brasília: Organização Pan-Americana da Saúde ; Ministério da Saúde, 2010. Disponível em:",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/guia_investigacao_surtos_epidemias.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Vigilância das Doenças Transmissíveis. \u003cb\u003eGuia para Investigações de Surtos ou Epidemias\u003c/b\u003e / Ministério da Saúde, Secretaria de Vigilância em Saúde, Departamento de Vigilância das Doenças Transmissíveis – Brasília : Ministério da Saúde, 2018. Disponível em:",
          },
          {
            urlExterno:
              "https://www.gov.br/saude/pt-br/centrais-de-conteudo/publicacoes/publicacoes-svs/doencas-transmitidas-por-alimentos-dta/manual_dtha_2021_web.pdf/@@download/file/manual_DTHA_2021_web.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Imunizações e Doenças Transmissíveis. \u003cb\u003eVigilância epidemiológica das doenças de transmissão hídrica e alimentar:\u003c/b\u003e manual de treinamento / Ministério da Saúde, Secretaria de Vigilância em Saúde, Departamento de Imunização e Doenças Transmissíveis. – Brasília : Ministério da Saúde, 2021. Disponível em: ",
          },
          {
            urlExterno:
              "http://portalsinan.saude.gov.br/images/documentos/Agravos/DTA/Surto_DTA_v5.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Sistema de Informação de Agravos de Notificação - SINAN. SINANWEB. \u003cb\u003eFicha de Investigação de Surto\u003c/b\u003e - DTA. 2022. Disponível em: ",
          },
          {
            urlExterno: "https://pensesus.fiocruz.br/vigilancia-em-saude",
            acessoEm: "Acesso em: 06 de ago 2022.",
            urlLocal: "",
            linkTitulo:
              "BRASIL. FIOCRUZ. Vigilância em Saúde - \u003cb\u003eSUS: O que é?\u003c/b\u003e Leia mais no PenseSUS. 2022. Disponível em:",
          },
        ],
        tipo: "bibliografia",
      },
    ],
    subTitulo: "",
    titulo: "Funcionários de uma empresa com diarreia",
    tsPublicacao: 1.23456789e9,
    shortname: "Funcionários de uma empresa com diarreia",
  },
  {
    _id: ObjectId("62f97d9041e46f60119d100b"),
    autor: ["José Rosa"],
    editores: ["Everton Fantinel", "Denise Silveira"],
    id: "9062",
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "41 anos",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "interdiscplinar",
    slides: [
      {
        conteudo: { texto: "", delay: "5" },
        titulo: "Introdução",
        tipo: "intro",
      },
      {
        conteudo: {
          contexto:
            '\u003cp\u003eO município em questão localiza-se na Serra Gaúcha e contava com 123.090 habitantes em 2021 (IBGE).\u003c/p\u003e\u003cp\u003eA monitorização semanal das doenças diarreicas agudas começou no ano de 2002, em acordo com as orientações da Secretaria Estadual da Saúde do Rio Grande do Sul, a cargo da Vigilância Epidemiológica (VE) municipal. Atualmente, o principal instrumento para a realização desta ação é a planilha de Monitoramento dos Casos de Doenças Diarreicas Agudas (MDDA) (Figura 1), na qual são informados os casos de doença diarreica aguda atendidos nos principais serviços de assistência à saúde. A planilha é preenchida em todas as 27 unidades básicas de saúde (UBS), em duas unidades de pronto atendimento (UPAs) localizadas nas zonas sul e norte do município, no serviço de urgência hospitalar e em um serviço privado de atendimento ambulatorial.\u003c/p\u003e\u003cp\u003eAs UBS enviam semanalmente as planilhas de MDDA para a VE, enquanto nas UPAs, no hospital e no serviço privado elas são recolhidas por um técnico da VE, também com frequência semanal.\u003c/p\u003e\u003cp\u003eOs dados de todas as planilhas são compilados e consolidados e, posteriormente, são digitados no Sistema de Informações de Vigilância Epidemiológica das Doenças Diarreicas Agudas (SIVEP-DDA).\u003c/p\u003e\u003ch6\u003eFigura 1. Planilha do Ministério da Saúde para a Monitorização dos Casos de Doenças Diarreicas Agudas.\u003c/h6\u003e\u003cimg src="img/caso3_figura1_norovirus.png"/\u003e',
        },
        titulo: "Contexto",
        tipo: "contexto",
      },
      {
        conteudo: {
          descricaoCaso:
            '\u003cp\u003eAproximadamente na semana epidemiológica 37 iniciou um aumento no número de casos de doença diarreica aguda (DDA), cujos casos foram registrados nas planilhas de MDDA, que serviram de subsídio para a VE consolidar as informações, alimentar o sistema de informação e construir a \u003cb\u003ecurva epidêmica\u003c/b\u003e referente ao município, encontrando a situação demonstrada no Gráfico 1.\u003c/p\u003e\u003ch6\u003eFigura 2. Curva epidêmica de casos de Doença Diarreica Aguda por semana epidemiológica, Município da Serra Gaúcha, 2021.\u003c/h6\u003e\u003cimg src="img/caso3_figura2_norovirus.png"/\u003e',
        },
        titulo: "Descrição do Caso",
        tipo: "descricaocaso",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eMuitas doenças apresentam sazonalidade nítida na sua distribuição, ou seja, ocorre aumento do número de casos em uma determinada época do ano. Essas oscilações não são consideradas epidêmicas, e refletem condições do ambiente em que vivem as pessoas – como incrementos na densidade populacional; a ocorrência de eventos que possibilitam aglomeração (colheitas ou festividades, por exemplo); alterações nas condições climáticas que provocam proliferação de vetores etc. Conhecer a sazonalidade de uma doença possibilita organizar a estrutura dos serviços de saúde tanto para a prevenção, quanto para a atenção a esses casos, identificando os meses em que elas são mais frequentes e ajudando a detectar o seu caráter endêmico ou epidêmico. A distribuição temporal dos casos por semanas epidemiológicas e comparativa a outros períodos, contribui para identificar o início de prováveis surtos.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "permite caracterizar a sazonalidade das DDAs ao longo do ano",
              true,
            ],
            [
              "ajuda a visualizar o aumento de casos nas semanas epidemiológicas",
              true,
            ],
            [
              "facilita comparar a distribuição dos casos de um ano com outro",
              true,
            ],
            ["não apresenta variação no período avaliado", false],
          ],
        },
        pergunta:
          "Em vigilância epidemiológica, padroniza-se o uso do calendário epidemiológico  em que os casos de doenças/agravos são registrados por semana (Semana Epidemiológica - SE), de acordo com a data dos primeiros sintomas. Analisando o Figura 2 deste caso, é possível afirmar que a distribuição dos casos no tempo:",
        titulo: "Questão 1",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA identificação da possibilidade do surto de DDA de 2021 decorreu da observação de um aumento abrupto no número de casos a partir da semana epidemiológica 37, com pico máximo na semana 41, o que reforçou a hipótese de surto. Nos anos de 2017 e de 2019 também se observam alguns picos de casos de DDA no mês de outubro. Estes seguem um padrão de repetição em um mesmo período, assumindo um comportamento sazonal e esperado para essa época do ano.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "houve notificação de casos acima do esperado nas semanas epidemiológicas 5, 8, 14, 27 e 41",
              false,
            ],
            [
              "ocorreram vários picos de elevação do número de casos ao longo do ano",
              false,
            ],
            [
              "a variação média no período foi dentro do esperado, observando-se apenas uma elevação espúria",
              false,
            ],
            [
              "houve um aumento abrupto do número de casos entre as semanas epidemiológicas 37 e 41",
              true,
            ],
          ],
        },
        pergunta:
          "Os técnicos da VE ao analisar o padrão de ocorrência da doença diarreica aguda, em 2021, representado no Figura 2, tomaram a decisão de inferir sobre a possibilidade de surto de DDA por quê:",
        titulo: "Questão 2",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eO que são as doenças diarreicas?\u003c/h3\u003e\u003cp\u003eAs doenças diarreicas agudas (DDA) correspondem à síndrome causada por diferentes agentes etiológicos (bactérias, vírus e parasitos intestinais oportunistas), cuja manifestação predominante é o aumento do número de evacuações, com diminuição da consistência das fezes. Em alguns casos, há presença de muco e sangue. Podem ser acompanhadas de náusea, vômito, febre e dor abdominal. No geral, é autolimitada, com duração de até 14 dias. As formas variam desde leve até grave, com desidratação e distúrbios eletrolíticos, principalmente quando associadas à desnutrição. O período de incubação das DDA varia conforme o agente etiológico causador, mas usualmente é curto, variando de um a sete dias. Os agentes mais frequentes são os de origem bacteriana e viral, como, por exemplo, Salmonella spp., Escherichia coli, Staphylococcus aureus, rotavírus, norovírus e adenovírus. Como a diarreia é um sinal presente na maioria das Doenças de Transmissão Hídrica e Alimentar (DTHA), a Monitorização das Doenças Diarreicas Agudas é uma estratégia utilizada pela VE das DDA (VE-DDA) para acompanhar o perfil de casos notificados em unidades sentinelas ao longo dos anos.\u003c/p\u003e\u003cp\u003eA monitorização das DDAs ajuda a avaliar o perfil epidemiológico dos casos em uma região (bairro, município, estado), sua sazonalidade e tipo de população exposta. Ela também pode servir como instrumento de detecção de surtos de doenças transmitidas por água e alimentos, bem como, por outras doenças transmitidas de pessoa a pessoa. Quando bem conduzida, uma investigação de surto de DDAs pode ajudar a identificar possíveis agentes etiológicos e suas fontes de exposição e contágio, essenciais para a balizar das condutas de controle e de prevenção a serem adotadas pelas autoridades de Saúde Pública. Importante ressaltar a importância do trabalho em conjunto dos técnicos da Vigilância em Saúde (municipal e estadual), do envolvimento das unidades da atenção primária, dos laboratórios e dos hospitais.\u003c/p\u003e\u003ch6\u003e(BRASIL, 2021, 2010)\u003c/h6\u003e\u003cp\u003eMediante a análise do gráfico ficou evidente que o  pico de casos observado entre as Semanas Epidemiológicas 37 e 41 demonstra notificação de casos acima do esperado, sinalizando uma alteração no padrão das DDA e a possibilidade de ocorrência de surto. Desde a identificação do surto de DDA na semana epidemiológica 37, os casos aumentaram progressivamente até atingirem seu pico na semana epidemiológica 41, passando de 130 para 543, neste período de 5 semanas. Neste momento, foram avaliadas as possíveis causas que poderiam estar elevando o número de casos.\u003c/p\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      { conteudo: { saibaCont: "" }, titulo: "Saiba mais", tipo: "saibaMais" },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eMediante a análise do gráfico ficou evidente que o pico de casos observado entre as Semanas Epidemiológicas 37 e 41 demonstra notificação de casos acima do esperado, sinalizando uma alteração no padrão das DDA e a possibilidade de ocorrência de surto. Desde a identificação do surto de DDA na semana epidemiológica 37, os casos aumentaram progressivamente até atingirem seu pico na semana epidemiológica 41, passando de 130 para 543, neste período de 5 semanas. Neste momento, foram avaliadas as possíveis causas que poderiam estar elevando o número de casos.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "mudanças nos fluxos de notificação ou na definição do caso",
              true,
            ],
            ["alterações nos métodos de diagnóstico", true],
            [
              "estabelecimento de novas unidades sentinelas notificadoras",
              true,
            ],
            [
              "reorganização da equipe e (re)distribuição dos processos de trabalho",
              true,
            ],
            ["treinamentos realizados", true],
            [
              "mudanças no tamanho da população – como regiões turísticas, cidades universitárias,   áreas com trabalhadores migrantes, entre outros",
              true,
            ],
          ],
        },
        pergunta:
          "Além dos surtos, quais outras causas podem levar ao aumento do número de notificações de casos e devem ser consideradas:",
        titulo: "Questão 3",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA definição de caso necessariamente não precisa ser exatamente igual à definição clínica do evento, mas deve ser suficientemente sensível para captar os casos verdadeiros de forma simples e rápida e suficientemente específica para evitar um número excessivo de casos falso-positivos. Entre os elementos fundamentais da definição de caso estão as informações relacionadas à pessoa, tempo e lugar, permitindo a identificação de grupos de população. Assim, costumam ser incluídos a idade e o sexo, bem como o lugar geográfico de residência e atenção à saúde e a data de início da doença. Esta, por sua vez, pode ser determinada de acordo com uma definição operacional padronizada que pode ser obtida em um manual de normas e procedimentos de vigilância, por exemplo.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["critérios clínicos e, preferencialmente, laboratoriais", true],
            ["características das pessoas com a doença", true],
            ["determinação do período em que ocorreu o surto", true],
            ["informação sobre o local ou região de ocorrência", true],
          ],
        },
        pergunta:
          "Assinale qual(is) componente(s) deve(em) ser incluído(s) em uma definição de caso:",
        titulo: "Questão 4",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eDefinição de caso\u003c/h3\u003e\u003cp\u003eImportante que, logo no início da investigação, a equipe estabeleça critérios para associar os expostos ao surto, considerando as características comuns dos envolvidos (caracterização de tempo, pessoa e lugar), e, consequentemente, determine definições de casos suspeitos, confirmados, descartados e, quando necessário, de casos prováveis.\u003c/p\u003e\u003cp\u003eNa fase inicial da investigação, o objetivo é detectar o maior número possível de casos da doença na população, o que requer definição de caso suspeito sensível, ou seja, com alta capacidade de captar os expostos (definição de caso suspeito). Já na fase seguinte, o propósito da investigação é se concentrar nos casos que tenham maior probabilidade de estarem associados com o surto; e, para isso, pode ser necessária uma nova definição de caso mais específica, ou seja, com maior capacidade de captar os doentes (definição de caso confirmado) e descartar os não doentes ou sem vínculo epidemiológico (caso descartado).\u003c/p\u003e\u003cp\u003eVale considerar que uma definição de caso muito sensível pode incorrer em elevados investimentos de tempo e dinheiro com o risco de captação de poucos casos confirmados; por outro lado, uma definição muito específica poderá incluir somente pessoas com características restritas, havendo a possibilidade de perda de casos subclínicos ou algum que não tenha apenas uma característica da definição de caso. Para minimizar esses prejuízos à investigação, sugere-se que a construção da definição de caso seja baseada em estudo descritivo prévio dos casos iniciais, se possível, e na história natural da doença e em outras informações.\u003c/p\u003e\u003cp\u003eEntre os componentes da definição de caso devem ser considerados:  critérios clínicos e, preferencialmente, exames de apoio diagnóstico (nível elevado de anticorpos, identificação de agente etiológico, exame de imagem, etc.) para avaliar se uma pessoa tem a doença sob investigação (com foco nas características clínicas significantes ou nos sinais e sintomas marcantes da doença); um período definido durante o qual os casos podem ser associados ao surto, levando-se em consideração a história natural da doença/agente etiológico suspeito (por exemplo, data do início dos sintomas do primeiro caso e período de incubação); especificação de 'lugar' permitindo estabelecer a área de ocorrência dos casos como, por exemplo, limitando o grupo aos clientes que frequentaram determinado restaurante, funcionários de determinada fábrica ou residentes de determinado município; características das pessoas para indicar grupos de risco (características como idade, raça/cor, sexo, etc.) ou tipos de exposição (ocupação, lazer, hábitos alimentares, uso de medicamentos, fumantes, uso de droga, etc.). Tais fatores podem ser importantes, pois podem estar relacionados com a suscetibilidade à doença ou oportunidade de exposição.\u003c/p\u003e \u003cbr/\u003e\u003ch6\u003e(BRASIL, 2010, 2018, 2021)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eOs técnicos da VE identificaram as duas UPAs como as principais fontes notificadoras de casos na planilha de MDDA , cuja investigação inicial mostrou uma distribuição etária heterogênea (31,3% entre crianças menores de 10 anos, 42,3% entre 20 e 39 anos, 13,3% entre 40 e 59 anos e 4% de doentes com 60 anos e mais), indicando que o surto não estava impactando sobre um grupo etário específico. A distribuição etária, permite caracterizar quais grupos estão sendo mais afetados, identificando os que apresentam maior vulnerabilidade às complicações da DDA (como a desidratação e a desnutrição, em crianças e idosos, bem como, a descompensação de doenças de base pré-existentes).\u003c/p\u003e\u003cp\u003eNa sequência, calculou-se a incidência de DDA por grupos etários com o objetivo de compreender o comportamento da doença e formular hipóteses para a tomada de decisões (Tabela 1).\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA DDA acometeu principalmente as crianças menores de 5 anos de idade, alcançando incidência 3 vezes maior que a média do surto no grupo etário de 1 a 4 anos. Do ponto de vista epidemiológico, é importante conhecer quantos casos novos surgem de uma população que está em risco de sofrer uma determinada doença ou dano à saúde, isso é, um indicador da velocidade de mudança do processo dinâmico de saúde e doença na população. A medida de ocorrência de casos novos de doença em uma população sob risco em um tempo determinado denomina-se incidência. Geralmente, a incidência nos proporciona uma idéia do risco médio que existe nos indivíduos da população de sofrer a doença, bem como avaliar a eficácia das ações de controle adotadas.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["72,9 por 1.000 habitantes; 32,1 por 1.000 habitantes", true],
            ["10,5 por 1.000 habitantes; 18,6 por 1.000 habitantes", false],
            ["25,8 por 1.000 habitantes; 33,8 por 1.000 habitantes", false],
            ["42,7 por 1.000 habitantes; 10,7 por 1.000 habitantes", false],
          ],
        },
        pergunta:
          'A incidência de DDA no surto de 2021, para o grupo etário de 1 a 4 anos e 5 a 9 anos é respectivamente:\u003cbr/\u003e\u003ch6\u003eTabela 1. Distribuição dos casos de diarreia aguda em um município da Serra Gaúcha, 2021.\u003c/h6\u003e\u003ctable class="table table-striped table-bordered table-sm table-responsive text-center"\u003e\u003ctr\u003e\u003ctd\u003e\u003cb\u003eGrupo etário\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eCasos de DDA\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003ePopulação\u003c/b\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e\u003c1\u003c/td\u003e\u003ctd\u003e72\u003c/td\u003e\u003ctd\u003e1.276\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e1 a 4\u003c/td\u003e\u003ctd\u003e375\u003c/td\u003e\u003ctd\u003e5.145\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e5 a 9\u003c/td\u003e\u003ctd\u003e223\u003c/td\u003e\u003ctd\u003e6.951\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e10 a 19\u003c/td\u003e\u003ctd\u003e319\u003c/td\u003e\u003ctd\u003e17.662\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e20 a 29\u003c/td\u003e\u003ctd\u003e869\u003c/td\u003e\u003ctd\u003e23.500\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e30 a 39\u003c/td\u003e\u003ctd\u003e662\u003c/td\u003e\u003ctd\u003e19.585\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e40 a 49\u003c/td\u003e\u003ctd\u003e337\u003c/td\u003e\u003ctd\u003e18.714\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e50 a 59\u003c/td\u003e\u003ctd\u003e158\u003c/td\u003e\u003ctd\u003e14.805\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e60 a 69\u003c/td\u003e\u003ctd\u003e95\u003c/td\u003e\u003ctd\u003e8.646\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e70 e mais\u003c/td\u003e\u003ctd\u003e72\u003c/td\u003e\u003ctd\u003e6.806\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eTotal\u003c/td\u003e\u003ctd\u003e3.182\u003c/td\u003e\u003ctd\u003e123.000*\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003ch6\u003e* População total do município\u003c/h6\u003e',
        titulo: "Questão 5",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            '\u003ch3\u003eIncidência:\u003c/h3\u003e\u003cp\u003eÉ a medida do número de casos novos, chamados casos incidentes, de uma doença, originados de uma população em risco de sofrê-la, durante um período de tempo determinado A incidência é um indicador da velocidade de ocorrência de uma doença ou outro evento de saúde na população e, consequentemente, é um estimador do risco absoluto de vir a padecer da mesma\u003c/p\u003e\u003cimg src="img/caso3_figura4_norovirus.png"/\u003e\u003cp\u003eNos cálculos de incidência e de prevalência, sempre é importante deixar bem claro qual é a população e a que período de tempo se refere. Pode-se relacionar com a população inteira de uma região ou com um grupo específico que estaria exposto ao problema. Por exemplo, ao determinar o denominador de incidência de câncer de colo de útero deveríamos incluir exclusivamente às mulheres enquanto no denominador para a incidência de gonorreia, a população sexualmente ativa.\u003c/p\u003e\u003ch6\u003e(BRASIL, 2010)\u003c/h6\u003e',
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            '\u003cp\u003eA visualização da distribuição geográfica dos casos de DDA por bairro/distrito de residência, como mostrado no Mapa, possibilitou melhor visualização das áreas e comunidades mais afetadas. No presente surto observou-se que não havia concentração de casos em determinado local ou região, o que rebate a possibilidade de fonte comum de exposição.\u003c/p\u003e\u003ch6\u003eFigura 3. Mapa com a distribuição dos casos de doença diarreica aguda de acordo com o bairro de residência. Município da Serra Gaúcha, 2021.\u003c/h6\u003e\u003cimg src="img/caso3_figura5_norovirus.png"/\u003e',
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cP\u003eEm algumas situações, a concentração de vários casos em determinado local pode significar uma fonte comum de exposição. Analisando a distribuição espacial dos casos e apesar de existirem bairros que se sobressaiam em termos numéricos, não há um claro predomínio ou concentração em torno de um local do município, indicando uma fonte comum de exposição, seja biológica ou química.\u003c/P\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "definir quais os tipos de amostras deverão ser coletadas, bem como, os exames laboratoriais que serão necessários para fazer o diagnóstico dos prováveis agentes etiológicos (microbiológicos, toxicológicos)",
              false,
            ],
            [
              "identificar fontes comunitárias de exposição (como um local de trabalho, creche, escola ou abrigo, reservatórios de água) que constituem elos da cadeia de transmissão de agentes causadores de DDA",
              true,
            ],
            [
              "direcionar as ações de investigação, bem como, a adoção das medidas de prevenção e controle para as áreas onde elas são prioritárias",
              true,
            ],
          ],
        },
        pergunta:
          "A identificação geográfica das áreas mais afetadas pode contribuir para:",
        titulo: "Questão 6",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eBuscando compreender se os sinais e sintomas poderiam sugerir algum agente infeccioso específico como etiologia da diarreia aguda foi realizado um levantamento dos sinais e sintomas por meio do sistema de prontuário eletrônico do município - onde os profissionais de saúde fazem o registro das consultas. Tal busca mostrou que não havia informações consistentes quanto ao registro do aspecto da diarreia (presença de sangue, por exemplo), do início dos sintomas, da presença de febre, impossibilitando caracterizar um provável agente, seja biológico ou químico. Analisando os registros dos primeiros casos com DDA - notificados na semana epidemiológica 37 - observou-se que 75% dos pacientes apresentavam vômito e de diarreia e o restante apresentava diarreia como sintoma isolado.\u003c/p\u003e\u003cp\u003eNão foi identificado que os doentes tivessem frequentado nenhum evento comunitário, festas, nem mesmo consumido alimentos em restaurantes, ou empresas, sugerindo não se tratar de um surto de doença transmitida por alimento (DTA). Complementarmente, no mesmo período não houve nenhum surto de DTA oficialmente notificado.\u003c/p\u003e\u003cp\u003eImediatamente após a constatação da existência do surto de DDA o coordenador da VE convidou representantes da vigilância sanitária e  da coordenação da atenção básica do município para uma reunião, a fim de traçar estratégias de investigação, concomitantes a eleição de ações de controle do surto e prevenção da ocorrência de novos casos a serem implementadas.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "As seguintes ações são úteis para identificação de novos casos: contato com os serviços de saúde (hospitais, ambulatórios, Estratégia Saúde da Família – ESF, clínicas, laboratórios etc.) e entrevista aberta com os profissionais que atenderam os casos; busca ativa retrospectiva para identificação de novos casos suspeitos em contatos de casos confirmados (entrevista aberta com os casos); ou revisão de registros de saúde (prontuários, fichas de pronto atendimento, fichas de encaminhamento, fichas de notificação de síndromes febris etc.). Essas estratégias permitem inclusive aprimorar a definição de caso, com a incorporação de critérios mais específicos, que aumentam a sensibilidade da definição.",
            tipo: "texto",
          },
          opcoes: [
            ["revisão dos prontuários", true],
            ["contato com os serviços de saúde", true],
            [
              "busca ativa retrospectiva para identificação de novos casos suspeitos em contatos de casos confirmados",
              true,
            ],
            [
              "entrevista aberta com os profissionais que atenderam os casos",
              true,
            ],
          ],
        },
        pergunta:
          "Neste sentido, assinale ações que podem ter sido empregadas na investigação:",
        titulo: "Questão 7",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eEstratégias de Busca\u003c/h3\u003e\u003cp\u003eRecomenda-se que seja feita busca de casos semelhantes no espaço geográfico onde ocorreram os casos quando houver a suspeita da existência de contatos e/ou de fonte de transmissão no território, a fim de determinar a extensão do problema e a população em risco de adoecer. Tal busca pode ser restrita (domicílio, creche/escola, rua, bairro), ampliada aos serviços de saúde (unidades de saúde, clínicas privadas, hospitais, laboratórios), ou ultrapassar barreiras geográficas de municípios ou estados, de acordo com as características da fonte de transmissão.\u003c/p\u003e\u003cp\u003eNesse sentido, os surtos de podem ser definidos como fechados quando ocorrem em eventos limitados a locais e grupos bem definidos (como em escolas, hospitais, presídios, ou em eventos como festas, casamentos etc.), em que seja possível identificar a quantidade de pessoas expostas. Já nos surtos abertos, a identificação das pessoas expostas é mais difícil e geralmente são detectados a partir de dados da vigilância epidemiológica, e requerem o conhecimento prévio do comportamento da doença para indicar se o número de casos notificados excede o número esperado.\u003c/p\u003e\u003cp\u003eAlém disso, a busca de casos pode ser ativa ou passiva. A busca ativa permite a identificação de casos que ainda não foram notificados, casos oligossintomáticos que não procuraram atendimento médico ou assintomáticos de grupos de alto risco (manipuladores de alimentos, cuidadores de crianças ou idosos, trabalhadores de creches e escolas, e profissionais de saúde), que podem continuar transmitindo a doença. Por essa razão, é importante utilizar todas as informações coletadas dos primeiros casos para melhor definir possíveis vínculos epidemiológicos e estabelecer uma área de busca adequada. A busca passiva ocorre quando os cidadãos, espontaneamente, entram em contato com o setor responsável para avisar da ocorrência de casos. Ademais, a busca pode apresentar uma direção temporal do tipo retrospectivo ou prospectivo, em que há a busca de registros de dados anterior e posterior ao evento/surto, respectivamente. \u003c/p\u003e\u003ch6\u003e(BRASIL, 2018, 2021)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eAlguns fatores envolvidos no evento como a diversidade etária dos doentes, a dispersão dos casos em diferentes bairros de residência, a falta de evidência de uma fonte alimentar comum bem como a ausência da definição de uma fonte de contaminação biológica ou química a partir dos sinais e sintomas, até este momento da investigação não havia sido possível estabelecer a causa para o surto. Assim, a VE levantou a hipótese de que o aumento de casos de DDA pudesse estar relacionado a um possível problema de abastecimento da água servida no município. É importante ressaltar que a avaliação do abastecimento público de água é uma das prioridades em uma investigação de surto de DDA. Na investigação desta hipótese, a Vigilância Ambiental (VA) foi consultada pelos técnicos da VE, para averiguar se houve alguma ocorrência relacionada ao abastecimento público de água. Entretanto, não havia registro de nenhum problema e os relatórios de análises de potabilidade da água dos últimos 30 dias confirmavam que os parâmetros estavam dentro da normalidade. Também foram coletadas amostras dos principais pontos de abastecimento, analisadas pela Fiocruz, e amostras coletadas na rede de distribuição dos bairros com maior número de casos de DDA, foram avaliadas pelo Laboratório Central de Saúde Pública do Estado do Rio Grande do Sul (LACEN). Nenhuma destas análises demonstrou agentes microbiológicos patogênicos.\u003c/p\u003e\u003cp\u003eOs técnicos da VE solicitaram a todas as unidades públicas de saúde que coletassem e enviassem amostras de fezes de paciente com quadro clínico compatível com diarreia aguda. A equipe da investigação sugeriu para as UPAs que a coleta das fezes fosse feita de pacientes com quadros clínicos de diarreia mais graves, a fim de aumentar a possibilidade de obter amostras com cargas maiores de agentes infectantes. Além disso, a chance de conseguir coletar amostras de fezes de pacientes que permanecem em observação nos serviços de emergência é melhor do que entre os doentes que são liberados para fazer tratamento domiciliar, uma vez que, nem sempre, esses indivíduos retornam ao serviço para entregar este tipo de amostra. Aproximadamente 70% das amostras apresentaram resultados positivos para Norovírus, o mesmo vírus causador de outros surtos registrados no Rio Grande do Sul. Todas as amostras foram negativas para Rotavírus.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eNorovirose\u003c/h3\u003e\u003cp\u003eO norovírus (vírus Norwalk-like) pertence à família dos calicivírus. A norovirose é uma das causas mais comuns de gastrenterite. O período médio de incubação para o norovírus é de 24 a 48 horas. O quadro clínico é caracterizado por: vômito de início agudo, diarreia não sanguinolenta, ou ambos, durante 12 a 60 horas. Também podem ocorrer dor abdominal, febre, cefaléia, dores musculares e cansaço. A doença inicia de forma repentina e a pessoa infectada pode transmitir o vírus desde o início dos sintomas, até 3 dias após a recuperação. Qualquer pessoa pode infectar-se pelo norovírus. Existem muitas cepas diferentes e a imunidade não é duradoura, por isso, as pessoas podem ter vários episódios de gastroenterite por esse agente ao longo da vida. Todas as faixas etárias podem ser atingidas e as crianças e os idosos podem apresentar complicações como desidratação.\u003c/p\u003e\u003cp\u003eEm estudos clínicos, aproximadamente dois terços das pessoas infectadas com o norovírus apresentaram sintomas da doença. A principal via de transmissão da norovirose é fecal-oral, incluindo o consumo de alimento ou água contaminados por fezes, contato direto pessoa a pessoa e objetos ou ambientes contaminados. A transmissão por via aérea através de gotículas de vômito também pode ocorrer. Durante a ocorrência de surtos, os primeiros casos frequentemente resultam da exposição a um alimento, a um objeto ou a um ambiente contaminado por fezes (especialmente, creches e asilos).\u003c/p\u003e\u003cp\u003eOs casos secundários resultam da transmissão de pessoa a pessoa. As noroviroses e as infecções por norovírus têm numerosas características que facilitam sua propagação durante um surto, incluindo: uma baixa carga viral para a infecção; disseminação prolongada, contaminantes assintomáticos (isto é, pessoas infectadas sem sintomas); estabilidade ambiental do vírus; e falta de imunidade durável nas pessoas previamente infectadas. As cepas epidêmicas do norovírus podem ser muito virulentas ou mais persistentes no ambiente do que as cepas não epidêmicas. No Rio Grande do Sul, segundo a Secretaria Estadual da Saúde, surtos de norovírus têm sido detectados, desde 2005.\u003c/p\u003e\u003ch6\u003e(CDC, 2006; RIO GRANDE DO SUL, 2015)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eAtendendo as normativas do Ministério da Saúde, a VE municipal notificou o surto à equipe da Vigilância em Saúde da sua Regional, aos técnicos do Centro Estadual de Vigilância em Saúde (CEVS) da Secretaria Estadual da Saúde e no Sistema de Informação de Agravos de Notificação (SINAN),  passando a emitir informes técnicos semanais, através da assessoria de imprensa do município - alertas à população sobre o surto e as medidas de higiene pessoal e da água. O CEVS divulgou a ocorrência de surtos de DDA  em 25 municípios gaúchos durante a SE 40  através do seu site de notícias, mostrando tratar-se de um evento de abrangência estadual.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eA partir da semana epidemiológica 42, começou um movimento de queda do número de casos no município, chegando a 69 doentes na semana epidemiológica 47 (ver Gráfico 1). Entre as semanas epidemiológicas 48 a 51, embora tenha ocorrido um novo aumento no número de casos de DDA, eles não foram expressivos e se mantiveram estáveis, voltando a cair na semana epidemiológica 52.\u003c/p\u003e\u003cp\u003eAssim, para fins de vigilância, o surto foi encerrado no SINAN, por critério clínico laboratorial (análise das amostras de fezes) ao final da semana epidemiológica 47, tendo como agente etiológico o norovírus, o mesmo vírus que estava causando surtos de doença diarreica aguda em outros municípios do RS. Entre o início e o término do surto, foram contabilizados 3.182 doentes, sendo 56,3% deles notificados durante o mês de outubro.\u003c/p\u003e\u003cp\u003eNão foi possível determinar se os doentes tiveram contato com uma fonte comum de infecção. Considerou-se a contaminação pessoa-a-pessoa como a forma de contágio mais provável deste surto, favorecida pela sazonalidade do vírus, bem como, pelo aumento do contato interpessoal comunitário, após o relaxamento das medidas de distanciamento social que estavam sendo adotadas durante a vigência da pandemia do Coronavírus.\u003c/p\u003e\u003cp\u003eDo total de doentes envolvidos neste surto, as maiores proporções estavam nas faixas etárias de menor de 10 anos (21,1%), de 20 a 29 anos (27,3%) e de 30 a 39 anos (20,8%). Nenhum caso evoluiu para óbito e/ou internação hospitalar, e 143 (4,5%) necessitaram de terapia de reposição volêmica (hidratação intravenosa) em leito de observação nas Unidades de Pronto Atendimento. Importante ressaltar que, tanto no período anterior ao surto (janeiro a agosto), como no período de vigência do surto (setembro a dezembro), os serviços que mais notificaram casos de DDA foram as duas unidades de pronto atendimento públicas, totalizando 80,8% dos doentes, durante o surto.\u003c/p\u003e\u003cp\u003eA investigação deste surto apontou uma alta taxa de notificação de casos de DDA realizada nos serviços públicos de urgência, suscitando a necessidade de avaliar o fluxograma de atendimento dos casos de diarreia no sistema de saúde do município, uma vez que, a priori, a diarreia é um problema de saúde que poderia ser identificado e manejado nas unidades de saúde da atenção primária ( menos de 1% dos registros de diarreias nas planilhas da MDDA foram realizados por estas unidades). Também ficou evidenciada a baixa taxa de coleta de amostras de fezes para exame. Desta baixa representatividade decorre a impossibilidade dos resultados laboratoriais poderem ser generalizados para toda a população de doentes. Em outras palavras, não se pode afirmar que o surto de diarreia tenha sido causado única e exclusivamente pelo norovírus, uma vez que não se conseguiu descartar, com segurança, a possibilidade de existirem outros agentes infectocontagiosos envolvidos neste surto.\u003c/p\u003e\u003cp\u003eA equipe da VE enfrentou algumas \u003cb\u003ebarreiras para a realização da investigação epidemiológica\u003c/b\u003e tais como: \u003cp\u003e\u003cul\u003e\u003cli\u003eBaixa qualidade das informações sobre os sinais e sintomas dos casos de DDA nos registros de atendimento, o que levou à dificuldade de caracterizar o perfil epidemiológico do quadro clínico dos doentes. Para a grande maioria dos casos, não havia registros nos prontuários eletrônicos sobre a característica da diarreia (número de episódios, consistência das fezes, presença de sangue), nem sobre a ocorrência de febre ou vômito, o que teria ajudado a elaborar a hipótese inicial sobre o(s) possível agente etiológico.\u003c/li\u003e\u003cli\u003ePouca compreensão e adesão dos profissionais de saúde sobre a necessidade de solicitarem as amostras de fezes aos doentes, mesmo quando estes estão apresentando diarreia durante o atendimento.\u003c/li\u003e\u003cli\u003eNão coleta de amostras de fezes dos portadores de diarreia durante o atendimento nos serviços de saúde na vigência do surto, pois os doentes dificilmente retornam para os serviços de saúde para entregarem suas amostras de fezes.\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: [
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/capacitacao_monitoramento_diarreicas_treinando.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Vigilância Epidemiológica. \u003cb\u003eCapacitação em monitorização das doenças diarreicas agudas\u003c/b\u003e – MDDA: manual do treinando / Ministério da Saúde, Secretaria de Vigilância em Saúde, Departamento de Vigilância Epidemiológica. – Brasília: Editora Ministério da Saúde, 2010. Disponível em:",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/guia_investigacao_surtos_epidemias.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Vigilância das Doenças Transmissíveis. \u003cb\u003eGuia para Investigações de Surtos ou Epidemias\u003c/b\u003e / Ministério da Saúde, Secretaria de Vigilância em Saúde, Departamento de Vigilância das Doenças Transmissíveis – Brasília: Ministério da Saúde, 2018. Disponível em: ",
          },
          {
            urlExterno:
              "https://www.gov.br/saude/pt-br/centrais-de-conteudo/publicacoes/publicacoes-svs/doencas-transmitidas-por-alimentos-dta/manual_dtha_2021_web.pdf/@@download/file/manual_DTHA_2021_web.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Imunizações e Doenças Transmissíveis. \u003cb\u003eVigilância epidemiológica das doenças de transmissão hídrica e alimentar: manual de treinamento\u003c/b\u003e / Ministério da Saúde, Secretaria de Vigilância em Saúde, Departamento de Imunização e Doenças Transmissíveis. – Brasília: Ministério da Saúde, 2021. Disponível em:",
          },
          {
            urlExterno:
              "https://www.cdc.gov/mmwr/preview/mmwrhtml/mm5627a1.htm",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "CENTER FOR DISEASE CONTROL AND PREVENTION. \u003cb\u003eMultistate outbreak of norovirus gastroenteritis among attendees at a family reunion\u003c/b\u003e - Grant County, West Virginia, October 2006. July 13, 2007 / 56(27);673-678. Disponível em:",
          },
          {
            urlExterno: "https://censo2010.ibge.gov.br/resultados",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "IBGE. Instituto Brasileiro de Geografia e Estatística. \u003cb\u003eCenso demográfico 2010\u003c/b\u003e [Internet]. Rio de Janeiro: IBGE; 2020. Disponível em: ",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/modulo_principios_epidemiologia_3.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "Organização Pan-Americana da Saúde. \u003cb\u003eMódulos de Princípios de Epidemiologia para o Controle de Enfermidades\u003c/b\u003e. Módulo 3: medida das condições de saúde e doença na população / Organização Pan-Americana da Saúde. Brasília: Organização Pan-Americana da Saúde; Ministério da Saúde, 2010. Disponível em:",
          },
          {
            urlExterno: "",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "RIO GRANDE DO SUL. Secretaria Estadual da Saúde. Centro Estadual de Vigilância em Saúde. Divisão de Vigilância Epidemiológica. \u003cb\u003eInforme técnico:\u003c/b\u003e surtos de doenças diarreicas agudas. Porto Alegre, 2015.",
          },
        ],
        tipo: "bibliografia",
      },
    ],
    subTitulo: "",
    titulo: "Aumento das notificações de doença diarreica aguda",
    tsPublicacao: "1234567890",
    shortname: "Aumento das notificações de doença diarreica aguda",
  },
  {
    _id: ObjectId("62fae14e41e46f423d2cfd67"),
    autor: ["Dóris Schuch", "Marcínia Bueno"],
    editores: ["Associados: Everton Fantinel", "Denise Silveira"],
    id: "9063",
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "41 anos",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "interdisciplinar",
    slides: [
      {
        conteudo: { texto: "", delay: "5" },
        titulo: "Introdução",
        tipo: "intro",
      },
      {
        conteudo: {
          descricaoCaso:
            "\u003cp\u003eEm 17 de abril de 2018, a Vigilância Epidemiológica recebeu a notificação da identificação de dois casos suspeitos de sarampo em crianças residentes no município de Céu Azul.\u003c/p\u003e\r\n          \u003cp\u003eOs pais das crianças relataram viagem de 21 a 28 de março para Esperança, utilizando transporte aéreo com escala em Noite Estrelada. O roteiro de permanência em Esperança incluiu estadia no hotel, ida a restaurantes e visita ao shopping, em suas áreas de diversões e brinquedos infantis. Em todas as atividades eles negaram contato com pessoas que se apresentavam com febre e exantema. Durante a estadia, uma das  crianças apresentou episódios de intensa diarreia, sintomas negados pelos pais e a outra irmã.\u003c/p\u003e\u003cp\u003eEm 28 de março, a família realizou viagem aérea partindo de Esperança com destino a Luar, o que incluiu escala em Céu Azul. Nesta viagem, as duas crianças ficaram sentadas juntas e não circularam dentro do avião. No dia 29 de março a família se deslocou de Luar para o município de Areias Claras, sul do estado, e ficou na casa de parentes. O retorno à cidade de Céu Azul ocorreu em 31 de março. \u003c/p\u003e\u003cp\u003eNa primeira semana de abril as duas crianças retornaram às atividades escolares no município Céu Azul e às aulas de Inglês no município de Estrela, região metropolitana da Grande Céu Azul. \u003c/p\u003e\u003cp\u003eNo dia 03/04, S.A.M. uma das crianças desta família apresentou febre. Trata-se de uma criança do sexo feminino, de 11 anos de idade, não vacinada devido a alergia a ovo, estudante e residente em Céu Azul. No dia 05/04, foi levada a um serviço de emergência de saúde apresentando febre, hiperemia de orofaringe, tosse, obstrução nasal e monilíase oral. Nessa mesma data, iniciou o uso de antibiótico. Em 07/04 retornou ao serviço de emergência ainda com febre, dor no corpo, sinais gripais, exantema, hiperemia ocular bilateral purulenta, amígdalas hipertrofiadas, sangramento gengival e “língua em framboesa”. O diagnóstico médico foi de conjuntivite e febre não especificada.\u003c/p\u003e",
        },
        titulo: "Descrição do Caso",
        tipo: "descricaocaso",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eComo o objetivo da Vigilância Epidemiológica é controlar e eliminar a transmissão do vírus do sarampo no Brasil, ao se deparar com um caso de doença exantemática o profissional deve realizar a notificação imediata, em até 24 horas, e só então seguem-se ações no sentido de esclarecer a suspeita.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Notificação imediata, em até 24 horas", true],
            ["Coletar amostras", false],
            ["Referenciar o paciente para o serviço de urgência", false],
            ["Adotar medidas de controle", false],
          ],
        },
        pergunta:
          "Qual a primeira ação que deve ser realizada pelo profissional que atende um caso de doença exantemática semelhante ao de S.A.M.?",
        titulo: "Questão 1",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eConduta frente a caso suspeito/confirmado de sarampo\u003c/h3\u003e\u003cp\u003ea. Notificar imediatamente todo caso suspeito de sarampo em até 24 horas.\u003cbr/\u003eb. Investigar em até 48 horas da notificação.\u003cbr/\u003ec. Coletar amostras.\u003cbr/\u003ed. Realizar bloqueio vacinal seletivo em até 72 horas após a notificação.\u003cbr/\u003ee. Realizar busca retrospectiva de casos suspeitos, nos últimos 30 dias, a partir da data do exantema do primeiro caso confirmado.\u003cbr/\u003ef. Realizar busca ativa de casos suspeitos nos serviços de saúde.\u003cbr/\u003eg. Acompanhar os contatos de casos suspeitos ou confirmados por 30 dias.\u003cbr/\u003eh. Preencher adequadamente a ficha de notificação/investigação do caso, com informações legíveis e completas.\u003cbr/\u003ei. Encerrar todos os casos.\u003cbr/\u003ej. Além disso, deve ser preenchido e enviado ao Ministério da Saúde o Boletim de Notificação Semanal (BNS), incluindo informações de locais em que haja notificação negativa.\u003c/p\u003e\u003ch6\u003e(BRASIL, 2006, 2012, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eAs causas de exantema incluem doenças infecciosas por agentes como vírus, bactérias, fungos e protozoários, e doenças não infecciosas tais como reações medicamentosas, doenças autoimunes e neoplasias.  Crianças com exantema e febre, em geral, apresentam um agente infeccioso viral em sua etiologia.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Rubéola e eritema infeccioso", true],
            ["Sarampo e escarlatina", true],
            ["Varicela e exantema súbito", true],
            ["Mononucleose e dengue", true],
            ["Chikungunya e zika vírus", true],
            ["Esporotricose e filariose.", false],
          ],
        },
        pergunta:
          "Que doenças exantemáticas devem ser consideradas no diagnóstico diferencial de S.A.M.?",
        titulo: "Questão 2",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            '\u003ch3\u003eCaracterísticas gerais do exantema\u003c/h3\u003e\u003cp\u003eO exantema é uma erupção geralmente avermelhada que aparece na pele devido à dilatação dos vasos sanguíneos ou inflamação. Podem se manifestar desde manchas planas até pequenas vesículas ou bolhas.\u003c/p\u003e\u003cp\u003eAs doenças exantemáticas, também conhecidas como febres eruptivas, são as doenças infecciosas agudas que têm como principal característica o exantema. São bastante comuns, principalmente na infância, e sua principal importância é que algumas delas apresentam alto risco de contágio e de potenciais complicações. \u003c/p\u003e\u003cp\u003eA maior parte dos exantemas são autolimitados, todavia a correta identificação da etiologia tem importância clínica pela gravidade e piora do prognóstico em caso de atraso no diagnóstico em alguns casos, e para a saúde pública, tendo em vista o potencial de contágio das causas infecciosas.\u003c/p\u003e\u003cp\u003eA inespecificidade clínica das doenças exantemáticas exige uma abordagem sistemática para o seu diagnóstico, que inclui a coleta de anamnese completa e exame físico amplo e cuidadoso. Podem-se prevenir algumas doenças exantemáticas através da vacinação e evitando contato com doentes.\u003c/p\u003e\u003ch3\u003eDiagnóstico diferencial das doenças exantemáticas\u003c/h3\u003eO diagnóstico diferencial é realizado para detecção de outras doenças exantemáticas febris em amostras:\u003cul\u003e\u003cli\u003eNegativas de casos suspeitos de sarampo.\u003c/li\u003e\u003cli\u003eSorologia para sarampo em amostras negativas de outras doenças exantemáticas, de acordo com a situação epidemiológica do local: surtos, casos isolados, áreas de baixa cobertura vacinal, resultados sorológicos IgM reagente ou inconclusivo para sarampo e outras.\u003c/li\u003e\u003c/ul\u003e\u003cp\u003eÉ recomendada a investigação de outras doenças exantemáticas febris agudas, entre as quais destacam-se: rubéola, exantema súbito (herpes vírus 6), dengue, eritema infeccioso (parvovírus B19), febre de chikungunya, vírus Zika, enteroviroses e riquetsiose, considerando-se a situação epidemiológica local.\u003c/p\u003e\u003cp\u003eComo a situação epidemiológica é dinâmica, a indicação e a interpretação dos exames laboratoriais para a realização do diagnóstico diferencial das doenças exantemáticas febris deverão ser discutidas em conjunto com os técnicos responsáveis das secretarias municipais e estaduais (vigilância epidemiológica e laboratório) e com a SVS/MS (exantematicas@saude.gov.br; clinica.cglab@saude.gov.br).\u003c/p\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e\u003ch6\u003eQuadro 1. Diagnóstico diferencial das doenças exantemáticas\u003c/h6\u003e\u003cimg src="img/caso4_figura1_enxatematica.png"/\u003e\u003cimg src="img/caso4_figura2_enxatematica.png"/\u003e\u003cbr/\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e',
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA partir das informações de S.A.M., é possível inferir que se trata de um caso suspeito de sarampo pela apresentação de febre e exantema maculopapular acompanhado de um ou mais dos seguintes sinais e sintomas: tosse e/ou coriza e/ou conjuntivite, independentemente de idade e de situação vacinal. Assim, diante de uma pessoa que apresente febre, sintomas catarrais e exantema, sempre devemos suspeitar de sarampo.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["sarampo", true],
            ["varicela", false],
            ["riquetsiose", false],
            ["zika", false],
          ],
        },
        pergunta:
          "A partir do quadro clínico de S.A.M. é possível inferir que se trata de um caso suspeito de:",
        titulo: "Questão 3",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eDefinição de caso suspeito de sarampo\u003c/h3\u003e\u003cp\u003eTodo indivíduo que apresentar febre e exantema maculopapular morbiliforme de direção cefalocaudal, acompanhados de um ou mais dos seguintes sinais e sintomas: tosse e/ou coriza e/ou conjuntivite, independentemente de idade e de situação vacinal.\u003c/p\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eApós três dias depois (10/04), devido à piora do quadro e surgimento de exantema maculopapular, a criança (S.A.M.) ficou hospitalizada por dois dias. Neste momento, não foi realizada coleta de sangue para sorologias específicas, apenas para exames laboratoriais rotineiros  de apoio à avaliação clínica do caso.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA principal medida de controle, além do isolamento do caso suspeito é a realização de vacinação de bloqueio em conjunto com a equipe de imunizações. Esta ação é preconizada a ser realizada no prazo máximo de até 72 horas após a notificação do caso, a fim de interromper a cadeia de transmissão e, consequentemente, eliminar os suscetíveis no menor tempo possível.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["72 horas", true],
            ["48 horas", false],
            ["36 horas", false],
            ["24 horas", false],
            ["12 horas", false],
          ],
        },
        pergunta:
          "No contexto da interrupção da cadeia de transmissão do sarampo e a vacinação dos indivíduos não vacinados, deve ser realizada a vacinação de bloqueio no prazo máximo de até:",
        titulo: "Questão 4",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            '\u003ch3\u003eAções de vacinação contra o sarampo no Brasil\u003c/h3\u003e\u003ch6\u003eQuadro 2. Vacinação contra sarampo. Brasil, 2022.\u003c/h6\u003e\u003cimg src="img/caso4_tela1_exantematica.png"/\u003e\u003cimg src="img/caso4_tela2_exantematica.png"/\u003e',
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eEm geral, um caso suspeito de sarampo requer diagnóstico laboratorial por meio da detecção de anticorpos IgM para sarampo por meio do ensaio imunoenzimático (ELISA). A confirmação de um caso de sarampo unicamente por critério clínico não é recomendada na rotina, exceto em situações de surto. O critério clínico-epidemiológico seria possível na hipótese de S.A.M. ser contato de outro caso que já tivesse sido confirmado por critério laboratorial, o que não é a situação até este momento da investigação. A coleta de apenas uma amostra de IgG não é suficiente para contemplar o critério laboratorial.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "é necessária a detecção de anticorpos IgM para sarampo em ensaio imunoenzimático",
              true,
            ],
            [
              "o quadro clínico inicial cumpre os requisitos para confirmação pelo critério clínico-epidemiológico",
              false,
            ],
            [
              "o agravamento dos sinais e sintomas com necessidade de hospitalização contempla a confirmação segundo o critério clínico",
              false,
            ],
            [
              "é necessária a detecção de anticorpos IgG para sarampo em ensaio imunoenzimático em única amostra",
              false,
            ],
          ],
        },
        pergunta:
          "Para classificar S.A.M. como caso confirmado de sarampo a partir das informações obtidas, pode-se afirmar que:",
        titulo: "Questão 5",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eDefinição de caso confirmado de sarampo\u003c/h3\u003e \u003cp\u003eÉ todo caso suspeito com a comprovação como caso de sarampo, a partir de, pelo menos, um dos critérios a seguir:\u003c/p\u003e\u003cul\u003e\u003cli\u003eCRITÉRIO LABORATORIAL \u003cbr/\u003eOs casos de sarampo podem ser confirmados laboratorialmente através da sorologia reagente (IgM e IgG, de acordo com a Figura 3) e/ou Biologia Molecular (RT-PCR). Em locais onde se tenha evidência da circulação ativa do vírus do sarampo, os demais casos poderão ser confirmados mediante uma das opções abaixo:\u003cbr/\u003ea) Detecção de anticorpos IgM específicos do sarampo em um laboratório aprovado ou certificado.\u003cbr/\u003eb) Soroconversão ou aumento na titulação de anticorpos IgG em soros pareados (S1 e S2).\u003cbr/\u003ec) Detecção e identificação viral por RT-PCR em tempo real. \u003c/li\u003e\u003cli\u003eCRITÉRIO VÍNCULO EPIDEMIOLÓGICO\u003cbr/\u003eCaso suspeito, contato de um ou mais casos de sarampo confirmados por exame laboratorial, que apresentou os primeiros sinais e sintomas da doença entre 7 e 21 dias da exposição ao contato (vínculo epidemiológico).\u003c/li\u003e\u003cli\u003eCRITÉRIO CLÍNICO\u003cbr/\u003eCaso suspeito que apresente febre, exantema maculopapular morbiliforme de direção cefalocaudal, acompanhados de um ou mais dos seguintes sinais e sintomas: tosse e/ou coriza e/ou conjuntivite (independentemente da idade e da situação vacinal). A confirmação do caso suspeito pelo critério clínico não é recomendada na rotina, contudo, em situações de surto, esse critério poderá ser utilizado.\u003c/li\u003e\u003c/ul\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eO diagnóstico laboratorial é realizado por meio de sorologia para detecção de anticorpos IgM específicos e soroconversão ou aumento de anticorpos IgG em amostras de soro, utilizando-se a técnica de ensaio imunoenzimático (ELISA). A detecção de anticorpos IgM na fase aguda da doença ocorre desde os primeiros dias até quatro semanas após o aparecimento do exantema EXCETO se o suspeito tiver recebido vacina oito dias a seis semanas antes da coleta da amostra e não houver evidência de transmissão do sarampo na comunidade e nenhum histórico de viagens. Embora possa ser um falso negativo em até 25% dos casos quando feito precocemente (menos de cinco dias do início do exantema), esses anticorpos geralmente atingem o pico em uma a três semanas após o início do exantema e torna-se indetectável em quatro a oito semanas. Os anticorpos específicos da classe IgG podem, eventualmente, aparecer na fase aguda da doença, e costumam ser detectados muitos anos após a infecção. Amostras coletadas após o 30º dia são consideradas tardias, mas, mesmo assim, devem ser enviadas ao laboratório. Todo material deverá ser encaminhado ao Lacen pela equipe de profissionais de saúde local em cinco dias, acompanhado de cópia da Ficha de Notificação / Investigação de Doenças Exantemáticas Febris Sarampo/ Rubéola devidamente preenchida, que servirá de orientação para os exames indicados.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "amostras coletadas entre o 1º e o 30º dia do aparecimento do exantema são consideradas amostras oportunas.",
              true,
            ],
            [
              "o aparecimento de anticorpos IgM não sofre influência de imunização anti-sarampo entre oito dias a seis semanas antes da coleta da amostra",
              false,
            ],
            [
              "se ocorrer coleta tardia de amostra, a mesma não deve ser enviada ao laboratório para análise",
              false,
            ],
            [
              "quando a amostra é coletada precocemente (menos de cinco dias do início do exantema), a taxa de falso negativo torna-se muito baixa (10%)",
              false,
            ],
            [
              "esses anticorpos geralmente atingem o pico em uma a três semanas após o início do exantema e tornam-se indetectáveis dez semanas",
              false,
            ],
          ],
        },
        pergunta:
          "Para o diagnóstico laboratorial, sempre que possível, é imprescindível assegurar a coleta de amostras de sangue de casos suspeitos no primeiro atendimento ao paciente. Com relação a detecção de anticorpos IgM é correto afirmar que:",
        titulo: "Questão 6",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "No dia 11/04 a irmã de S.A.M., R.A.M., uma menina de 10 anos de idade, não vacinada, estudante, residente no mesmo domicílio, apresentou febre e coriza a partir do dia 11/04. Após quatro dias (15/04) passou a apresentar hiperemia de orofaringe, exantema e “língua em framboesa”. No dia seguinte (16/04) houve agravamento do quadro e foi hospitalizada. Foi transferida para a UTI em 17/04 com pneumonite, porém, sem necessidade de ventilação mecânica, onde permaneceu até o dia 19/04, com melhora do quadro clínico. Para confirmação de R.A.M. como sarampo foi necessário solicitar coleta de amostra para diagnóstico laboratorial, que resultou positiva. Diante deste resultado, também houve coleta de sorologia para sarampo na criança do S.A.M..",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA vacinação é a medida mais eficaz de prevenção, de controle e de eliminação do sarampo. No país, é realizada mediante múltiplas ações, que podem ocorrer em unidades fixas ou extramuros desenvolvimento de atividades fora dos serviços de saúde). A situação vacinal dos indivíduos das contendo o componente sarampo (tríplice viral e tetra viral) orientará o bloqueio vacinal seletivo de todos os pacientes e profissionais dos serviços de saúde que tiveram contato com a pessoa que esteja com suspeita ou diagnóstico de sarampo.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Tríplice viral", true],
            ["Tetra viral", true],
            ["Pentavalente", false],
            ["Pneumocócica 10 Valente (conjugada)", false],
            ["DTP", false],
          ],
        },
        pergunta:
          "As crianças S.A.M. e R.A.M não foram imunizadas e, portanto, estavam suscetíveis ao vírus do sarampo. Sabe-se que o sarampo é uma doença prevenível por vacinação. Assim, a investigação do estado vacinal durante um surto de sarampo deve averiguar sobre a(s) dose(s) da(s) seguinte(s) vacina(s):",
        titulo: "Questão 7",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eS.A.M. foi o primeiro caso identificado nesta investigação, por isso é classificado como caso-índice. Já R.A.M foi contato de S.A.M., o que o qualifica como caso secundário\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["caso-índice e caso secundário", true],
            ["caso secundário e caso primário", false],
            ["caso secundário e caso-índice", false],
            ["caso-índice e caso com fonte de infecção desconhecida.", false],
          ],
        },
        pergunta:
          "Segundo a classificação dos casos confirmados de sarampo, o S.A.M. e o R.A.M são, respectivamente:",
        titulo: "Questão 8",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eClassificação dos casos confirmados de sarampo, de acordo com a fonte de infecção:\u003c/h3\u003e\u003cul\u003e\u003cli\u003eCaso importado: a infecção ocorreu fora do local de residência durante os 7 e 21 dias prévios ao surgimento do exantema, de acordo com a análise dos dados epidemiológicos ou virológicos.\u003c/li\u003e\u003cli\u003eCaso com fonte de infecção desconhecida: situação em que não foi possível estabelecer a origem da fonte de infecção após investigação epidemiológica minuciosa.\u003c/li\u003e\u003cli\u003eCaso-índice: primeiro caso identificado entre vários casos de natureza similar e epidemiologicamente relacionados, é o caso que leva à investigação inicial, não sendo necessariamente o primeiro caso a desenvolver sintomas.\u003c/li\u003e\u003cli\u003eCaso primário: é o caso que introduz o vírus do sarampo em determinada população, e não necessariamente o primeiro caso da cadeia de transmissão. Não basta que seja o primeiro caso cronologicamente, porque todos os casos podem ter acontecido da mesma fonte comum.\u003c/li\u003e\u003cli\u003eCaso secundário: caso novo, a partir do contato com o caso-índice e/ou primário.\u003c/li\u003e\u003cli\u003eCaso autóctone: caso relacionado à cadeia de transmissão sustentada em uma determinada localidade.\u003cbr/\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eDurante a investigação dos casos de S.A.M. e R.A.M. dois contactantes das meninas foram identificados e avaliados , ambos assintomáticos. Um dos contatos era uma criança de 11 anos de idade, com história vacinal de três doses de Tríplice Viral, vizinha e amiga das meninas e que estuda na mesma escola. O outro contato era a professora de Inglês (26 anos) com história de vacina contra o sarampo aos nove meses de vida. Foram realizadas coletas de espécimes clínicas destes dois contactantes que resultaram negativos para o sarampo. \u003c/p\u003e\u003cp\u003eA equipe da VE enfrentou algumas \u003cb\u003ebarreiras para a realização da investigação epidemiológica\u003c/b\u003e tais como: \u003c/li\u003e\u003cli\u003eDificuldade para identificar contatos devido a duração do período de transmissibilidade - seis dias antes do exantema até quatro dias após seu aparecimento.\u003c/li\u003e\u003cli\u003eCompromissos pessoais das crianças (viagens e deslocamentos dentro do município) prejudicaram a busca retrospectiva dos casos suspeitos.\u003c/li\u003e\u003cli\u003eFalta de disponibilidade dos contatos em receber os investigadores da VE, dificultando ou impossibilitando a avaliação do histórico de vacinação e, por conseguinte, a vacinação de bloqueio seletiva em até 72h.\u003c/li\u003e\u003cli\u003ePerda de seguimento ao tentar acompanhar os contatos de casos suspeitos ou confirmados por 30 dias.\u003c/li\u003e\u003c/ul\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: [
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/guia_vigilancia_saude_5ed_rev_atual.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. \u003cb\u003eGuia de Vigilância em Saúde \u003c/b\u003e[recurso eletrônico] / Ministério da Saúde, Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. – 5. ed. rev. – Brasília : Ministério da Saúde, 2022. Disponível em:",
          },
        ],
        tipo: "bibliografia",
      },
    ],
    subTitulo: "",
    titulo: "Crianças com suspeita de sarampo",
    tsPublicacao: "1234567890",
    shortname: "Crianças com suspeita de sarampo",
  },
  {
    _id: ObjectId("62faf42e41e46fb4652cfd67"),
    autor: ["Dóris Schuch", "Marcínia Bueno"],
    editores: ["Everton Fantinel", "Denise Silveira"],
    id: "9064",
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "41 anos",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "interdisciplinar",
    slides: [
      {
        conteudo: { texto: "", delay: "5" },
        titulo: "Introdução",
        tipo: "intro",
      },
      {
        conteudo: {
          descricaoCaso:
            '\u003cp\u003eA Vigilância Epidemiológica (VE) do município de Lagoa Azul recebeu em 06 de abril uma notificação de caso suspeito de leptospirose por meio da Ficha de Investigação de Leptospirose (Figura 1). Tal caso foi notificado por uma médica pediatra ao atender uma menina de 7 anos de idade em seu consultório no dia 30 de março, por quadro clínico de cefaleia intensa, febre, mialgia, náuseas, inapetência e vômito de início abrupto, desde 29 de março. A pediatra havia solicitado alguns exames laboratoriais o que permitiu descartar hepatite viral. Entretanto o quadro progrediu e a menina começou com icterícia. Dessa forma, após fazer a notificação do caso, a médica entrou em contato com a Vigilância Epidemiológica, quando decidiram que seria necessário coletar exame laboratorial para melhor avaliar a suspeita. Considerando o tempo necessário para obtenção do resultado da sorologia, optou-se por isolar o agente em amostra de sangue para abreviar a espera. A mãe da criança havia comentado que outras crianças, colegas de turma da menina, apresentavam quadro clínico similar.\u003c/p\u003e\u003ch6\u003eFigura 1. Ficha de investigação de leptospirose do Sistema de Informação de Agravos de Notificação (SINAN), 2022.\u003c/h6\u003e\u003ctable\u003e\u003ctr\u003e\u003ctd\u003e\u003cimg src="img/caso5_figura1_lepto.png"/\u003e\u003c/td\u003e\u003ctd\u003e\u003cimg src="img/caso5_figura1_1_lepto.png"/\u003e\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e',
        },
        titulo: "Descrição do Caso",
        tipo: "descricaocaso",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eConforme o Critério 2 de caso suspeito para leptospirose a definição inclui a manifestação de febre, cefaleia e mialgia concomitante a icterícia.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["icterícia", true],
            ["cianose", false],
            ["inapetência", false],
            ["identificação de outros casos semelhantes", false],
          ],
        },
        pergunta:
          "Por definição, a menina contempla o critério para definição de caso suspeito de leptospirose  por apresentar febre, cefaleia e mialgia associados a:",
        titulo: "Questão 1",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eDefinição de caso suspeito de leptospirose:\u003c/h3\u003eIndivíduo com febre, cefaleia e mialgia, que apresente pelo menos um dos critérios a seguir elencados.\u003cul\u003e\u003cli\u003eCritério 1 - Presença de antecedentes epidemiológicos sugestivos nos 30 dias anteriores à data de início dos sintomas, como:\u003cul\u003e\u003cli\u003e Exposição a enchentes, alagamentos, lama ou coleções hídricas;\u003c/li\u003e\u003cli\u003eExposição a fossas, esgoto, lixo e entulho;\u003c/li\u003e\u003cli\u003eAtividades que envolvam risco ocupacional, como coleta de lixo e de material para reciclagem, limpeza de córregos, trabalho em água ou esgoto, manejo de animais, agricultura em áreas alagadas;\u003c/li\u003e\u003cli\u003eVínculo epidemiológico com um caso confirmado por critério laboratorial;\u003c/li\u003e\u003cli\u003eResidência ou local de trabalho em área de risco para leptospirose.\u003c/li\u003e\u003c/ul\u003e\u003c/li\u003e\u003cli\u003eCritério 2 - Presença de pelo menos um dos seguintes sinais ou sintomas:\u003cul\u003e\u003cli\u003eIcterícia;\u003c/li\u003e\u003cli\u003eAumento de bilirrubinas;\u003c/li\u003e\u003cli\u003e Sufusão conjuntival;\u003c/li\u003e\u003cli\u003eFenômeno hemorrágico;\u003c/li\u003e\u003cli\u003eSinais de insuficiência renal aguda.\u003c/li\u003e\u003c/ul\u003e\u003c/li\u003e\u003c/ul\u003e\u003ch6\u003e(BRASIL, 2021)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "Avaliando uma suspeita de leptospirose ao investigar uma Síndrome Febril Aguda é preciso identificar o local provável de infecção (LPI).",
            tipo: "texto",
          },
          opcoes: [
            [
              "contato físico com áreas alagadas, lama ou esgoto, principalmente após fortes chuvas ou ocorrência de enchentes",
              true,
            ],
            ["residência ou trabalho em áreas de risco da doença", true],
            ["presença de roedores em ambiente domiciliar e de trabalho", true],
            [
              " localização de focos de \u003ci\u003eAedes aegypti\u003c/i\u003e",
              false,
            ],
          ],
        },
        pergunta:
          "Para avaliação de casos com Síndrome Febril Aguda decorrente de leptospirose (febre, cefaleia, mialgia) assinale as informações dos antecedentes epidemiológicos que são relevantes:",
        titulo: "Questão 2",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eIdentificação do Local Provável de Infecção\u003c/h3\u003e\u003cp\u003eNa identificação do Local Provável de Infecção (LPI) é preciso que se busque caracterizar se houve contato com água, solo ou alimentos que poderiam estar contaminados pela urina de roedores; contato direto com roedores ou outros reservatórios animais; condições propícias à proliferação ou presença de roedores nos locais de trabalho ou moradia; ocorrência de enchentes, atividades de lazer em áreas potencialmente contaminadas, entre outras; área provável de infecção (urbana, rural, periurbana) e o ambiente provável de infecção (domiciliar, trabalho, lazer ou outros).\u003c/p\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eNo dia seguinte à notificação, a equipe da VE visitou a escola. Em entrevista com  a diretora e a professora da menina, a VE recebeu a confirmação que mais cinco crianças estavam afastadas das aulas por apresentarem cefaleia, febre, vômitos, náuseas, manifestações semelhantes ao primeiro caso. Apenas uma destas crianças queixou de mialgia intensa e nenhuma tinha diarreia.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA suspeita de um surto pode ser levantada ao evidenciarmos casos que se apresentam com quadro clínico semelhante e compatível com leptospirose, em um período de tempo relativamente próximo e que conviviam em um mesmo ambiente (vínculo). A presença destas condições dispensa a obrigatoriedade de termos resultado laboratorial reagente de todos os casos  para confirmar o surto. A diarreia não é uma manifestação clínica presente na definição de caso suspeito.\u003cp\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["datas de início dos sintomas próximas", true],
            ["sinais e sintomas semelhantes entre os casos", true],
            ["casos convivem em um mesmo ambiente (escola)", true],
            ["ausência de diarreia entre as queixas dos casos", false],
          ],
        },
        pergunta:
          "Com as informações iniciais obtidas com a direção da escola é possível estabelecer a hipótese de que há um surto de leptospirose. Assinale quais alternativas contém as informações que contribuem para formulação da hipótese:",
        titulo: "Questão 3",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eA direção da escola relatou que todas as crianças estudavam no 1º ano do ensino fundamental, na mesma sala, e entregou a lista de alunos e professora, com respectivos endereços. A partir da lista, a VE iniciou a investigação dos casos mediante a verificação das datas de início das manifestações clínicas de todos os suspeitos e das atividades e exposições comuns que as pessoas tiveram, considerando o período de incubação do agente de 1 a 30 dias, média de 5 a 14 dias. Assim, constatou-se que o primeiro caso iniciou sintomas no dia 29 de março e os demais apresentaram sintomas na semana seguinte.\u003c/p\u003e\u003cp\u003eA professora da turma informou que os casos se sucederam em uma semana, mas que não houve nenhum outro caso de adoecimento na turma após este período. Ela também não apresentou qualquer sintoma e/ou sinal de doença. A seguir foi constatado que os familiares das seis crianças não apresentavam sintomas semelhantes aos dos casos.\u003c/p\u003e\r\n          ",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "Se faz necessário a avaliação do local provável de infecção a fim de confirmar a existência de roedores, o que é uma atribuição da Vigilância Ambiental.",
            tipo: "texto",
          },
          opcoes: [
            ["Vigilância Ambiental", true],
            ["Vigilância em Saúde do Trabalhador", false],
            ["Departamento de Doenças e Agravos Não Transmissíveis", false],
            ["Coordenação de Imunização", false],
          ],
        },
        pergunta:
          "Como a Síndrome Febril Aguda pode ser decorrente de leptospirose, uma antropozoonose, a investigação precisa contar com o apoio da:",
        titulo: "Questão 4",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            '\u003ch3\u003eRoteiro de investigação\u003c/h3\u003e\u003cp\u003eA investigação epidemiológica de caso suspeito ou confirmado deverá ser realizada com base no preenchimento da Ficha de Investigação da Leptospirose, devendo seguir o roteiro específico para esta ação (Figura 2).\u003c/p\u003e\u003ch6\u003eFigura 2. Roteiro de investigação da leptospirose.\u003c/h6\u003e\u003cimg src="img/caso5_figura2_lepto.png"/\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e',
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eSeguindo com a investigação, a VE solicitou uma inspeção zoossanitária para a Vigilância Ambiental em Saúde com o objetivo de avaliar risco de exposição a roedores na escola. Neste momento, a VE recebe o resultado do exame do primeiro caso confirmando tratar-se de leptospirose por identificação da leptospira em amostra de sangue, realizada 4 dias após o início dos primeiros sintomas (critério clínico-laboratorial). \u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "A confirmação do caso pelo MAT em amostra única é possível quando o título for maior ou igual a 800. Já a utilização do ELISA-IgM, requer também que sejam coletadas duas amostras para realização de MAT.",
            tipo: "texto",
          },
          opcoes: [
            ["MAT em uma amostra com título maior ou igual a 800", true],
            ["ELISA-IgM reagente", false],
            ["isolamento da leptospira na urina", false],
            ["imunofluorescência indireta com título acima de 60", false],
          ],
        },
        pergunta:
          "Para confirmação de um caso suspeito de leptospirose a partir do critério clínico-laboratorial, uma alternativa quando não há possibilidade de isolar a leptospira em sangue ou de realizar a coleta de duas amostras ou mais de soroconversão na microaglutinação (MAT) é:",
        titulo: "Questão 5",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eCritério clínico-laboratorial:\u003c/h3\u003e\u003cul\u003e\u003cli\u003eELISA-IgM reagente, mais soroconversão na microaglutinação (MAT) com duas amostras, entendida como primeira amostra (fase aguda) não reagente e segunda amostra (14 dias após a data de início dos sintomas com máximo de até 60 dias) com título maior ou igual a 200.\u003c/li\u003e\u003cli\u003eAumento de quatro vezes ou mais nos títulos da MAT, entre duas amostras sanguíneas coletadas com intervalo de aproximadamente 14 dias após o início dos sintomas (máximo de 60 dias) entre elas.\u003c/li\u003e\u003cli\u003eQuando não houver disponibilidade de duas ou mais amostras, um título maior ou igual a 800 na MAT confirma o diagnóstico.\u003c/li\u003e\u003cli\u003eIsolamento da leptospira em sangue.\u003c/li\u003e\u003cli\u003eDetecção de DNA por PCR em amostra de sangue com anticoagulante (exceto heparina) em pacientes com até dez dias de início dos sintomas\u003c/li\u003e\u003c/ul\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eAo realizar a inspeção zoossanitária, a Vigilância Ambiental (VA) não encontrou sinais de roedores no interior da escola (salas, refeitório, ginásio, auditório, corredores, sanitários, sótão e porão). Também os reservatórios de água foram verificados e nenhum sinal de roedor foi detectado.  Analisando retrospectivamente as atividades das crianças restaram aquelas realizadas no educandário como fonte de exposição comum. No pátio da escola, junto a pracinha, foram encontradas tocas de ratazana e, junto às lixeiras e na caixa de areia, foi verificada a presença de fezes de ratazanas. Apenas a turma do 1ª ano do ensino fundamental utilizava a pracinha para atividades de recreio e aulas ao ar livre. \u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "A redução da população de roedores é uma das medidas de controle relativas às fontes de infecção por meio de ações programadas, com ciclos periódicos de desratização nas áreas de maior risco para contrair a doença. A organização de um sistema de orientação aos empregadores e profissionais sobre os resíduos sólidos, mapeamento das áreas e uso de sistemas de previsão climática são medidas relativas às fontes de exposição.",
            tipo: "texto",
          },
          opcoes: [
            ["controle da população de roedores", true],
            ["uso de informações dos sistemas de previsão climática", false],
            [
              "conhecimento da distribuição espacial e temporal dos casos, mapeamento das áreas e do período de ocorrência dos casos, assim como dos locais com maior potencial para a transmissão de leptospirose",
              false,
            ],
            [
              "organização de um sistema de orientação aos empregadores e aos profissionais que atuam nos serviços de coleta e segregação de resíduos sólidos",
              false,
            ],
          ],
        },
        pergunta:
          "Uma medida de prevenção e controle da leptospirose relativa às fontes de infecção que deve ser adotada é:",
        titulo: "Questão 6",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eMedidas de prevenção e controle relativas às fontes de infecção\u003c/h3\u003e\u003cul\u003e\u003cli\u003eControle da população de roedores: ações programadas de controle de roedores, com ciclos periódicos de desratização nas áreas de maior risco para contrair a doença; e intensificação das ações de educação em saúde nessas áreas, com ênfase nas medidas de antirradiação. Também devem ser desratizadas, periodicamente, as bocas de lobo localizadas no entorno das áreas de transmissão de leptospirose.\u003c/li\u003e\u003cli\u003eSegregação e tratamento de animais de produção e companhia acometidos pela doença. No caso de animais de produção, deve-se atentar para as medidas de barreiras sanitárias impostas pelos demais órgãos envolvidos com a questão, por exemplo, o Ministério da Agricultura, Pecuária e Abastecimento.\u003c/li\u003e\u003cli\u003eCriação de animais seguindo os preceitos das boas práticas de manejo e guarda responsável. Deve-se cuidar da higiene animal, especialmente da remoção e do destino adequados de resíduos alimentares, excretas, cadáveres e restos de animais, limpeza e desinfecção permanentes dos canis ou locais de criação, medidas essenciais para evitar a proliferação de roedores e o risco de adoecimento e transmissão de leptospirose no ambiente da criação.\u003c/li\u003e\u003cli\u003eArmazenamento apropriado dos alimentos pelos proprietários de imóveis residenciais, comerciais ou rurais, em locais inacessíveis aos roedores. Também se devem manter esses imóveis livres de entulho, materiais de construção ou objetos em desuso que possam oferecer abrigo a roedores, assim como vedar frestas e vãos nos telhados, paredes e demais estruturas da alvenaria ou construção. Não se devem deixar os alimentos de animais expostos por longos períodos e sim recolhê-los logo após os animais terem se alimentado. As latas de lixo devem ser bem vedadas, e seu conteúdo, destinado ao serviço de coleta pública.\u003c/li\u003e\u003cli\u003eTratamento adequado dos resíduos sólidos, coletados, acondicionados e destinados aos pontos de armazenamento e tratamento definidos pelo órgão competente. Nas áreas urbanas, deve-se ter especial cuidado com o armazenamento e a destinação do lixo doméstico, principal fonte de alimento para roedores nessas áreas.\u003c/li\u003e\u003cli\u003eManutenção de terrenos, públicos ou privados, murados, limpos e livres de mato e entulhos, evitando condições propícias à instalação e à proliferação de roedores.\u003c/li\u003e\u003c/ul\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "Definir os locais com elevado potencial para a transmissão de leptospirose é uma das medidas de controle relativas às fontes de exposição que devem ser consideradas neste contexto. O tratamento adequado dos resíduos, criação de animais seguindo boas práticas de manejo e armazenamento apropriado dos alimentos são medidas relativas às fontes de infecção.",
            tipo: "texto",
          },
          opcoes: [
            [
              "conhecimento da distribuição espacial e temporal dos casos, mapeamento das áreas e do período de ocorrência dos casos, assim como dos locais com maior potencial para a transmissão de leptospirose",
              true,
            ],
            [
              "tratamento adequado dos resíduos sólidos, coletados, acondicionados e destinados aos pontos de armazenamento e tratamento definidos pelo órgão competente",
              false,
            ],
            [
              "criação de animais seguindo os preceitos das boas práticas de manejo e guarda responsável",
              false,
            ],
            [
              "armazenamento apropriado dos alimentos pelos proprietários de imóveis residenciais, comerciais ou rurais, em locais inacessíveis aos roedores",
              false,
            ],
          ],
        },
        pergunta:
          "Uma medida de prevenção e controle da leptospirose relativa às fontes de exposição que deve ser adotada é:",
        titulo: "Questão 7",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eMedidas de prevenção e controle relativas às fontes de exposição\u003c/h3\u003e\u003cul\u003e\u003cli\u003eConhecimento da distribuição espacial e temporal dos casos, mapeamento das áreas e do período de ocorrência dos casos, assim como dos locais com maior potencial para a transmissão de leptospirose, criando um banco de dados das áreas prioritárias, para controle e prevenção. Para isso, pode-se recorrer à epidemiologia e ao geoprocessamento.\u003c/li\u003e\u003cli\u003eUso de informações dos sistemas de previsão climática, para desencadear alertas de risco de enchentes às populações que vivem em áreas sujeitas a esses eventos e, com isso, orientá-las a evitar a exposição às águas das enchentes, caso estas venham a ocorrer. Deve-se, também, articular um sistema de troca de informações e de colaboração nas intervenções, com a Defesa Civil, o Corpo de Bombeiros e demais órgãos atuantes em situações de catástrofes e de acidentes naturais.\u003c/li\u003e\u003cli\u003eOrganização de um sistema de orientação aos empregadores e aos profissionais que atuam nos serviços de coleta e segregação de resíduos sólidos, tratamento de efluentes, limpeza e manutenção de galerias de águas pluviais e esgotos, controle de pragas, manipulação e criação de animais, entre outras atividades afins, sobre a necessidade do uso de equipamentos de proteção individual.\u003c/li\u003e\u003c/ul\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eO desenrolar da investigação da VE durante este surto de leptospirose na escola contabilizou 47 alunos testados para a detecção de anticorpos do tipo IgM para leptospirose, sendo 12 reagentes sorologicamente e 35 negativos, além do primeiro caso confirmado por isolamento da leptospira em sangue.\u003c/p\u003e \u003cp\u003eDesde o início da investigação, a VE neste surto atuou articulada à VA. Ressalta-se que em outras situações, dependendo do local e  tipo de exposição, a Vigilância Sanitária (VISA) também deverá ser acionada, pois prestadores de serviço, a exemplo da escola, estão sob sua regulação. Durante o processo de investigação a VE também desenvolveu algumas atividades de informação aos pais alertando para sinais e sintomas de leptospirose utilizando como estratégias reuniões na escola, produção de cartazes e folders. Para a direção da escola foi orientado realizar a limpeza contínua do pátio e inspeções periódicas, em busca de sinais da presença de roedores  (tocas, fezes, restos de alimentos); garantir a proteção da caixa de areia por meio de uma cobertura a fim impedir o acesso de roedores; e, limpar diariamente da caixa de areia.\u003c/p\u003e \u003cp\u003eA questão de alagamentos ou enchentes e as exposições ocupacionais a animais infectados, eventos tipicamente associados à leptospirose, não foram os determinantes deste surto. A investigação identificou a  limpeza inadequada do pátio onde as crianças brincavam, juntamente com  a disponibilidade de alimento (restos de merenda mal descartada) e abrigo  aos roedores (tocas de ratazanas), como fatores que facilitaram a exposição das crianças à leptospira.\u003c/p\u003e\u003cp\u003eA equipe da VE enfrentou como \u003cb\u003ebarreira para a realização da investigação epidemiológica\u003c/b\u003e a dificuldade da direção da escola em reconhecer que o surto se originou nas dependências da mesma.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: [
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/guia_vigilancia_saude_5ed_rev_atual.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. \u003cb\u003eGuia de Vigilância em Saúde\u003c/b\u003e [recurso eletrônico] / Ministério da Saúde, Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. – 5. ed. rev. – Brasília : Ministério da Saúde, 2022. Disponível em:",
          },
        ],
        tipo: "bibliografia",
      },
    ],
    subTitulo: "",
    titulo: "Criança com suspeita de leptospirose",
    tsPublicacao: "1234567890",
    shortname: "Criança com suspeita de leptospirose",
  },
  {
    _id: ObjectId("62fb004a41e46f607c2cfd67"),
    autor: ["José Rosa"],
    editores: ["Everton Fantinel", "Denise Silveira"],
    id: 9065.0,
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "41 anos",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "interdisciplinar",
    slides: [
      {
        conteudo: { texto: "", delay: "5" },
        titulo: "Introdução",
        tipo: "intro",
      },
      {
        conteudo: {
          contexto:
            '\u003cp\u003eNo dia 04/12/2017 (segunda-feira), o serviço de Vigilância Epidemiológica (VE) da Secretaria Municipal da Saúde de Arroio das Neves recebeu a notificação de 11 pessoas na Ficha de Investigação de Surto-DTA (Figura 1) com quadro de gastrenterite que haviam sido atendidas no plantão de urgência do hospital local, todas na noite do dia 02/12/2017 (sábado).\u003c/p\u003e\u003ch6\u003eFigura 1. Ficha de investigação de surto - DTA, SINAN, 2022.\u003c/h6\u003e\u003ctable\u003e\u003ctr\u003e\u003ctd\u003e\u003cimg src="img/caso6_figura1_churrasco.png"/\u003e\u003c/td\u003e\u003ctd\u003e\u003cimg src="img/caso6_figura1_1_churrasco.png"/\u003e\u003c/tr\u003e\u003c/table\u003e\u003cp\u003eDe posse da notificação, os técnicos da VE contataram por telefone o coordenador do serviço de urgência do hospital, a fim de obter dados mais detalhados sobre os casos. Foi informado que estas 11 pessoas haviam procurado atendimento médico, após terem participado de um jantar em comum no dia 02/12/2017 (sábado), na casa de um dos doentes. De posse dos números dos telefones celulares de sete destas 11 pessoas, a VE desencadeou a investigação de cada um destes casos por inquérito telefônico.\u003c/p\u003e\u003cp\u003eUm dos primeiros doentes contatados, ainda na segunda-feira (04/12/2022), confirmou ter participado de um jantar na residência de um amigo, juntamente com outras 14 pessoas, o que corroborou a suspeita de um surto de doença transmitida por alimento (DTA). Com base nestas informações, a VE, a Vigilância Sanitária (VISA) e a Vigilância Ambiental (VA) do município iniciaram o processo de investigação.\u003c/p\u003e',
        },
        titulo: "Contexto",
        tipo: "contexto",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003ePara elucidação de uma suspeita de um surto a Vigilância Epidemiológica precisa realizar um inquérito com o primeiro caso, análise dos comensais doentes e, na sequência, a lista de alimentos consumidos pelos comensais e partir destas informações levantar as primeiras hipóteses.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Inquérito com os casos notificados", true],
            ["Análise dos comensais doentes", true],
            ["Análise Estatística dos Alimentos Consumidos", true],
            ["Levantamento das primeiras hipóteses", true],
          ],
        },
        pergunta:
          "Quais ações são desenvolvidas pela Vigilância Epidemiológica nesta suspeita de surto de DTA?",
        titulo: "Questão 1",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eA Vigilância Epidemiológica tentando confirmar a presença do surto e traçar uma definição de caso a partir de um inquérito telefônico com o primeiro doente investigado, os técnicos do VE identificaram a pessoa que havia oferecido o jantar. Tratava-se de um homem de 65 anos que tinha uma casa numa propriedade rural do município de Arroio das Neves, que também havia adoecido e procurado atendimento na emergência do hospital na noite do dia 02/12/2017. Nesta entrevista foi obtida a lista completa com os nomes e números de telefone (fixo ou celular) de todos os comensais, bem como, o detalhamento do cardápio do jantar. Estas informações possibilitaram o preenchimento do Formulário para Notificação de Surto de DTA e do Formulário Individual para Registro de Informações dos Comensais de Surto de DTA, bem como realizada a notificação da Coordenadoria Regional de Saúde e da área técnica do Centro Estadual de Vigilância em Saúde (CEVS) da Secretaria Estadual de Saúde.\u003c/p\u003e\u003cp\u003eA investigação dos comensais também foi realizada por meio de inquérito telefônico, o que permitiu encontrar mais uma pessoa doente, além daquelas que haviam procurado atendimento hospitalar.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003ePara caracterizar o vínculo epidemiológico com o evento e estabelecer uma fonte comum é necessário que os comensais doentes consigam definir quais alimentos e em que horário foram ingeridos, assim como os sinais e sintomas apresentados e seu horário de início.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["alimentos ingeridos no jantar", true],
            ["horário da ingestão de cada alimento", true],
            ["sinais e sintomas apresentados", true],
            ["horário do início dos sinais e sintomas", true],
            ["histórico de viagem nos últimos 30 dias", false],
          ],
        },
        pergunta:
          "No inquérito telefônico com os comensais doentes os técnicos da VE investigaram as seguintes questões:",
        titulo: "Questão 2",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            '\u003cp\u003eDando seguimento a investigação, os comensais entrevistados detalharam aos técnicos da VE os alimentos ingeridos, o horário da ingestão de cada alimento, os sinais e sintomas apresentados, juntamente com o horário de início de cada manifestação clínica. Os dados também foram complementados por intermédio da investigação nos prontuários médicos dos doentes que haviam sido atendidos no hospital. Todas estas informações foram compiladas na Ficha de Inquérito Coletivo de Surtos de Doenças Transmitida por Alimento (Figura 2). Após,  foram digitados em uma planilha eletrônica para realização dos cálculos da mediana do período de incubação, das taxas de ataque e do risco relativo de cada alimento, das prevalências por sexo e faixa etária dos doentes, das prevalências dos principais sinais e sintomas dos doentes e a distribuição temporal dos casos (entre o primeiro e o último doente).\u003c/p\u003e\u003ch6\u003eFigura 2. Ficha de Inquérito Coletivo de Surtos de Doenças Transmitida por Alimento - DTA. Fonte: Ministério da Saúde, 2022.\u003c/h6\u003e\u003cimg src="img/caso6_figura2_churrasco.png"/\u003e\u003cp\u003eA análise dos dados mostrou que entre os 15 comensais expostos entrevistados, 12 (80,0%) informaram ter adoecido. O jantar foi servido às 20:30 horas do dia 02/12/2017 (sábado) e os dois primeiros doentes referiram ter apresentado sinais e sintomas cerca de 30 minutos após terem comido. Entretanto, para a maioria dos comensais (66,6%), os sintomas iniciaram-se cerca de 1 hora após a ingestão do jantar. O último caso de doença foi registrado às 15 horas do dia 03/12/2017 (sintomas iniciados cerca de 18:30 horas após a ingestão do jantar.\u003c/p\u003e\u003cp\u003eO Gráfico 1 apresenta o histograma com a distribuição dos casos (doentes) de acordo com o dia e horário do início dos sintomas. Do total dos comensais doentes, apenas um comensal adoeceu no dia 03/12. Entre os demais, a maioria (n = 11; 91,6%) iniciou seus sintomas entre meia hora e uma hora e 10 minutos após o jantar ter sido servido. A mediana do período de incubação foi de aproximadamente 1 hora, sendo que o menor período entre a ingestão e a manifestação dos sintomas foi 30 minutos e o maior de 18h e 30 minutos. Um comensal necessitou de internação hospitalar. Ele tinha 65 anos, era cardiopata prévio, e apresentou náusea, vômito, diarreia, fraqueza, muscular, suor, tontura, desmaio com inconsciência e convulsões.\u003c/p\u003e\u003cimg src="img/caso6_figura3_churrasco.png"/\u003e\u003ch6\u003eGráfico 1. Histograma da distribuição dos comensais doentes de acordo com o dia e horário do início dos sintomas (n = 12).\u003c/h6\u003e\u003cp\u003eA frequência dos sinais e sintomas apresentados pelos comensais doentes está sistematizada na Tabela 1.\u003c/p\u003e\u003ch6\u003eTabela 1. Principais Sinais e Sintomas dos Comensais Doentes, Arroio das Neves, Dezembro de 2017 (N= 12).\u003c/h6\u003e\u003ctable class="table"\u003e\u003ctr\u003e\u003ctd\u003e\u003cb\u003eSinais/Sintomas\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eNº\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003e(%)\u003c/b\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eVômito\u003c/td\u003e\u003ctd\u003e10\u003c/td\u003e\u003ctd\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eDiarreia\u003c/td\u003e\u003ctd\u003e9\u003c/td\u003e\u003ctd\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eFraqueza Muscular/Tremedeira\u003c/td\u003e\u003ctd\u003e10\u003c/td\u003e\u003ctd\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eNáusea\u003c/td\u003e\u003ctd\u003e7\u003c/td\u003e\u003ctd\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eSuor frio\u003c/td\u003e\u003ctd\u003e7\u003c/td\u003e\u003ctd\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eTontura\u003c/td\u003e\u003ctd\u003e5\u003c/td\u003e\u003ctd\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eCefaleia\u003c/td\u003e\u003ctd\u003e2\u003c/td\u003e\u003ctd\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eCólica abdominal\u003c/td\u003e\u003ctd\u003e1\u003c/td\u003e\u003ctd\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eConvulsão\u003c/td\u003e\u003ctd\u003e1\u003c/td\u003e\u003ctd\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eDesmaio\u003c/td\u003e\u003ctd\u003e1\u003c/td\u003e\u003ctd\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eDistensão abdominal\u003c/td\u003e\u003ctd\u003e0\u003c/td\u003e\u003ctd\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eFebre\u003c/td\u003e\u003ctd\u003e0\u003c/td\u003e\u003ctd\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e\u003cb\u003eTotal\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e12\u003c/td\u003e\u003ctd\u003e\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e',
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              '\u003cp\u003eA Tabela 2 apresenta as prevalências dos sinais e sintomas. Assim pode-se observar que a tontura foi referida com menor frequência que a cefaleia e três sintomas tiveram prevalência maior que 70%\u003c/p\u003e\u003ch6\u003eTabela 2. Principais Sinais e Sintomas dos Comensais Doentes adicionando a prevalência, Arroio das Neves, Dezembro de 2017 (N= 12).\u003c/h6\u003e\u003cimg src="img/caso6_figura5_churrasco.png"/\u003e',
            tipo: "texto",
          },
          opcoes: [
            [
              "os sintomas de vômito e fraqueza muscular foram os mais frequentes",
              true,
            ],
            ["a diarréia esteve presente em 75,0% dos casos", true],
            ["náusea e sudorese acometeram 58,3% dos doentes", true],
            [
              "a ocorrência de sensação de tontura foi similar à de cefaleia",
              false,
            ],
            [
              "apenas dois sintomas tiveram prevalência maior do que 70%",
              false,
            ],
          ],
        },
        pergunta:
          "A partir dos dados da Tabela 1 calcule a prevalência. De acordo com as prevalências encontradas, podemos afirmar que entre os comensais doentes:",
        titulo: "Questão 3",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eO levantamento de hipóteses a respeito das fontes de contaminação e de transmissão é utilizado para identificar exposições específicas que podem ter causado a doença. Tais hipóteses são testadas por meio da aplicação de métodos estatísticos apropriados. Os casos identificados nesta investigação tiveram como manifestações sinais e sintomas das vias digestivas superiores (náuseas, vômitos) que aparecem primeiro ou predominam, com um período de incubação é de aproximadamente uma hora, características da infecção por \u003ci\u003eStaphylococcus aureus\u003c/i\u003e e o \u003ci\u003eBacillus cereus\u003c/i\u003e (cepa emética). Nas situações em que o agente etiológico são os vírus, o quadro predominante é do trato digestivo inferior e o período de incubação maior que 72 horas, semelhante ao que ocorre com parasitas intestinais. Já as toxinas não alteram as características do alimento, ou seja, seu sabor, odor e mesmo aparência. \u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "microrganismos não causadores de febre, como o Staphylococcus aureus e o Bacillus cereus (cepa emética).",
              true,
            ],
            ["vírus que causam gastrenterite, mas não causam febre.", false],
            ["parasitas intestinais, como a Giardia e os Enterococos.", false],
            [
              "toxinas que alteram o sabor dos alimentos e suas características físicas.",
              false,
            ],
          ],
        },
        pergunta:
          "Os achados iniciais da investigação indicaram um quadro clínico dos doentes com uma maior prevalência de vômito e de diarreia sem a existência de febre e um período de incubação predominante de aproximadamente 1 hora. Assim, a hipótese de agente etiológico:",
        titulo: "Questão 4",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eBaseado nas informações iniciais sobre o quadro clínico dos doentes que constatou uma maior prevalência de vômito e diarreia, a inexistência de febre entre os doentes e um período de incubação de 1 hora, considerou-se como possíveis agentes etiológicos desse surto os microrganismos não causadores de febre, como o \u003ci\u003eStaphylococcus aureus\u003c/i\u003e e \u003ci\u003eBacillus cereus\u003c/i\u003e (cepa emética)\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eAgente etiológico conforme período de incubação\u003c/h3\u003e\u003cp\u003ePrincipais agentes etiológicos implicados segundo manifestações e tempo de incubação:\u003cbr/\u003e\u003cb\u003eSinais e sintomas das vias digestivas superiores (náuseas, vômitos) que aparecem primeiro ou predominam\u003c/b\u003e\u003c/p\u003e\u003cul\u003e\u003cli\u003e Período de incubação \u003c 1h: fungos silvestres, antimônio, cádmio, cobre, fluoreto de sódio, chumbo, estanho e zinco\u003c/li\u003e\u003cli\u003ePeríodo de incubação entre 1 e 8h: \u003ci\u003eStaphylococcus aureus, Bacillus cereus\u003c/i\u003e (cepa emética) e nitritos\u003c/li\u003e\u003cli\u003ePeríodo de incubação entre 7 e 12h: fungos c/ ciclopeptídios e fungos c/ giromitrínicos\u003c/li\u003e\u003c/ul\u003e\u003cp\u003e\u003cb\u003eSinais e sintomas das vias digestivas inferiores (dores abdominais, diarreia) predominantes\u003c/b\u003e\u003c/p\u003e\u003cul\u003e\u003cli\u003ePeríodo de incubação entre 7 e 12h: \u003ci\u003eBacillus cereus\u003c/i\u003e (cepa diarreica) e \u003ci\u003eClostridium perfringens\u003c/i\u003e\u003c/li\u003e\u003cli\u003ePeríodo de incubação entre 12 e 72h: \u003ci\u003eVibrio cholerae, Escherichia coli\u003c/i\u003e patogênica, \u003ci\u003eSalmonella spp, Shigella, Vibrio parahaemolyticus, Vibrio vulnificus, Campylobacter spp, Plesiomonas shigelloides, Aeromonas hidrophila\u003c/i\u003e\u003c/li\u003e\u003cli\u003ePeríodo de incubação \u003e 72h: Virus entéricos (ECHO, coxsackie, pólio, reovírus, adenovírus e outros), \u003ci\u003eEntamoeba hystolytica, Taenia saginata\u003c/i\u003e, Diphylobotrium latum, \u003ci\u003eTaenia solium, Yersinia enterocolitica, Giardia intestinalis, Escherichia coli\u003c/i\u003e O157:H7 e outros parasitas intestinais.\u003c/li\u003e\u003c/ul\u003e\u003cp\u003e\u003cb\u003eSinais e sintomas neurológicos (transtornos visuais, formigamento e paralisia)\u003c/b\u003e\u003c/br\u003eSinais e sintomas das vias digestivas superiores (náuseas, vômitos) que aparecem primeiro ou predominam\u003c/p\u003e\u003cul\u003e\u003cli\u003ePeríodo de incubação \u003c 1h: fungos com ácido ibotênico e fungos com muscinol\u003c/li\u003e\u003cli\u003ePeríodo de incubação entre 1 e 6h: hidrocarbonetos clorados, Ciguatera, “Erva de feiticeiro” e “saia branca”, cicuta aquática, fungos com muscarina, Organofosforados, toxinas marinhas, Tetraodontídeos\u003c/li\u003e\u003c/ul\u003e\u003cp\u003eSinais e sintomas das vias digestivas inferiores (dores abdominais, diarreia) predominantes\u003c/p\u003e\u003cul\u003e\u003cli\u003ePeríodo de incubação entre 12 e 72h: \u003ci\u003eClostridium botulinum\u003c/i\u003e\u003c/li\u003e\u003cli\u003ePeríodo de incubação \u003e 72h: mercúrio e fosfato de triortocresil\u003c/li\u003e\u003c/ul\u003e\u003cp\u003eSinais e sintomas sistêmicos\u003c/p\u003e\u003cul\u003e\u003cli\u003ePeríodo de incubação \u003c 1 hora: histamina, tiramina, glutamato monossódico e ácido nicotínico\u003c/li\u003e\u003cli\u003ePeríodo de incubação entre 1 e 6 horas: vitamina A\u003c/li\u003e\u003cli\u003ePeríodo de incubação \u003e 72 horas: \u003c/i\u003eBrucella abortus, Brucella melitensis, Brucella suis, Coxiella burnetti \u003c/i\u003e(febre Q), Salmonella typhi, vírus da hepatite A e E, \u003ci\u003eAngiostrongylus cantonensis, Toxoplasma gondii, Trichinella spiralis, Mycobacterium spp, Echinococcus spp\u003c/i\u003e\u003c/li\u003e\u003c/ul\u003e\u003cp\u003eSinais e sintomas respiratórios e faríngeos\u003c/p\u003e\u003cul\u003e\u003cli\u003ePeríodo de incubação \u003c1 hora: hidróxido de sódio\u003c/li\u003e\u003cli\u003ePeríodo de incubação entre 12 e 72 horas: Streptococcus pyogenes\u003c/li\u003e\u003c/ul\u003e\u003ch3\u003e\u003ci\u003eBacillus Cereus\u003c/i\u003e\u003c/h3\u003e\u003cp\u003eO Bacillus cereus pertence ao gênero Bacillus, sendo uma bactéria ubíqua, que se apresenta em forma de bastão, Gram-positiva, aeróbica facultativa e móvel. Apresenta um ótimo crescimento em temperatura entre 28 e 35°C, o tempo de geração no organismo humano varia de 18 a 27 minutos, tolera uma ampla faixa de pH que vai de 4,9 a 9,3 e cresce em concentrações salinas de até 7,5% e em alimentos com atividade de água.\u003c/p\u003e\u003cp\u003eSão transmitidos através de alimentos contaminados sendo seus esporos bacterianos entidades dormentes e altamente resistentes ao calor, à radiação ultravioleta (UV), à dessecação, a valores de pH altos ou baixos e a produtos químicos tóxicos. Como habitante comum do solo, esta bactéria pode ser transmitida facilmente para a vegetação e posteriormente para os alimentos, podendo ser encontrado em produtos lácteos, carnes, especiarias e cereais.\u003c/p\u003e\u003cp\u003eO Bacillus cereus é responsável por intoxicações alimentares podendo provocar dois tipos de síndromes: emética e diarreica. A síndrome emética é decorrente do crescimento das bactérias no alimento e, se manifesta por náuseas e vômitos, dentro de 1 a 5 horas após o consumo de alimentos contaminados. Na síndrome diarreica a intoxicação alimentar é decorrente da ação de enterotoxinas, causando dores abdominais, diarreia aquosa profusa, náuseas e vômitos de 8 a 16 horas, após a contaminação. Em ambos os casos, os sintomas duram, geralmente, menos de 48 horas.\u003c/p\u003e\u003cp\u003eEle possui excelente capacidade de aderir a superfícies de aço inoxidável e de formar biofilmes, já tendo sido encontrado em 24 utensílios e em 6 equipamentos de cozinha em um restaurante de uma universidade pública, mostrando um potencial risco de contaminação cruzada.\u003c/p\u003e\u003ch6\u003e(BRASIL, 2010)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eApós detalhamento sobre o cardápio do jantar do dia 02/12,  foi identificado que oito alimentos foram servidos, dos quais quatro eram industrializados e não passaram por nenhuma técnica de preparo:\u003c/br\u003e1) Carne de Gado (churrasco);\u003c/br\u003e2) Carne de Javali (assada);\u003c/br\u003e3) Alface (salada in natura);\u003c/br\u003e4) Salada de frutas (kiwi, maçã, mamão, abacaxi, mamão);\u003c/br\u003e5) Sorvete de Creme (industrializado);\u003c/br\u003e6) Cerveja (industrializado);\u003c/br\u003e7) Vinho (industrializado);\u003c/br\u003e8) Água com gás (industrializado).\u003c/p\u003e\u003cp\u003eForam realizadas as análises estatísticas de todos os alimentos consumidos no jantar, sendo calculadas as taxas de ataque de cada alimento entre as pessoas que comeram (doentes e não doentes) e entre as que não comeram (doentes e não doentes), a diferença percentual e o risco relativo.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA realização de inquérito epidemiológico com os comensais (pessoas expostas) e os não comensais (pessoas não expostas) na vigência de um surto integra o roteiro de investigação epidemiológica das Doenças Transmitidas por Alimentos (DTA). O inquérito tem por objetivo obter informações mais específicas sobre as pessoas e ter melhor clareza sobre quem está sob risco. Aplica-se, portanto, o Formulário Inquérito Coletivo de Surto de DTHA (Figura 2), que contém perguntas sobre os alimentos consumidos, sinais e sintomas (SS), data do início dos SS e exames laboratoriais.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "caracterizar os principais sinais e sintomas, estimar o período de incubação entre ingestão dos alimentos e início dos sintomas, calcular as taxas de ataque dos alimentos ingeridos",
              true,
            ],
            [
              "verificar qual é a situação do evento, se há uma elevação do número de casos na área e se os casos são realmente de um mesmo evento, pois o excesso de casos pode não representar um surto, mas uma mudança no sistema de vigilância",
              false,
            ],
            [
              "confirmar a ocorrência da doença ou evento por meio de critérios clínicos amplos ou específicos, ou então acrescentar ou restringir-se a resultados de exames, tais como nível elevado de anticorpos e/ou identificação de agente etiológico",
              false,
            ],
            [
              "definir um conjunto de critérios científicos que permitam incluir quais as pessoas que têm ou tiveram a doença ou evento que será investigado naquele período e lugar, bem como excluir aquelas que não estariam relacionadas ao surto",
              false,
            ],
          ],
        },
        pergunta:
          "Numa investigação de surto de DTA, o inquérito com os comensais doentes e não doentes possibilita:",
        titulo: "Questão 5",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            '\u003cp\u003eO Quadro 1 apresenta a distribuição dos comensais e não comensais segundo os alimentos consumidos no jantar e a apresentação ou não da doença. Para responder às Questões 6 e 7 é necessário realizar os cálculos das Taxas de Ataque e do Risco Relativo (RR).\u003c/p\u003e\u003cimg src="img/caso6_figura8_churrasco.png"/\u003e\u003ch6\u003eQuadro 1. Alimentos consumidos e comensais envolvidos na suspeita de surto no jantar sem os valores calculados para as taxas de ataque e risco relativo, 2017.\u003c/h6\u003e',
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              '\u003cp\u003eA taxa de ataque (TA) da doença  é uma medida de incidência que se refere a populações específicas, em períodos de tempo limitados, como por exemplo, durante surtos e epidemias. É expressa usualmente em percentagem. Seguem  as fórmulas para o cálculo da Taxa de ataque (TA) nos expostos (consumiram) e não expostos (não consumiram), para cada refeição/alimento:\u003c/p\u003e\u003cimg src="img/caso6_figura9_churrasco.png"/\u003e\u003cimg src="img/caso6_figura9_1_churrasco.png"/\u003e\u003ch6\u003eQuadro 2. Alimentos consumidos e comensais envolvidos na suspeita de surto no jantar com os valores calculados para as taxas de ataque e risco relativo, 2017.\u003c/h6\u003e',
            tipo: "texto",
          },
          opcoes: [
            ["Carne de javali: 92,3 e 33,3", true],
            ["Carne de gado: 91,7 e 40,0", true],
            ["Salada de frutas: 11,8 e 28,5", false],
            ["Sorvete: 91,7  e 20,0", false],
          ],
        },
        pergunta:
          "A partir das informações do Quadro 1, qual alternativa apresenta a associação correta entre alimento e correspondente  taxa de ataque entre os expostos e os não expostos, respectivamente? ",
        titulo: "Questão 6",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eRisco relativo (RR): é uma medida da força de associação entre um fator de risco e o resultado de um estudo epidemiológico, expressando o risco de um evento ocorrer a um indivíduo, relativo à determinada exposição. Assim, é a partir da análise do risco relativo que se estabelece a causa de um surto. É calculado pela razão entre a taxa de ataque nos indivíduos expostos e a taxa de ataque nos indivíduos não expostos, e aponta quantas vezes a ocorrência do resultado no grupo de expostos é maior que aquela entre os não expostos.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "os comensais que ingeriram carne de javali tiveram um risco 2,8 vezes maior de adoecer do que os que não consumiram este alimento",
              true,
            ],
            [
              "os comensais que comeram carne de gado tiveram um risco 2,3 vezes maior de adoecer do que os que não consumiram este alimento",
              true,
            ],
            [
              "os comensais que se alimentaram com alface tiveram um risco 0,8 vezes maior de adoecer",
              false,
            ],
            [
              "os comensais que beberam cerveja tiveram um risco 8 vezes maior de adoecer do que os que não consumiram este alimento",
              false,
            ],
          ],
        },
        pergunta:
          "A análise do risco relativo de cada alimento possibilita afirmar que:",
        titulo: "Questão 7",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            '\u003ch3\u003eCálculo do risco relativo\u003c/h3\u003e\u003cp\u003eA fórmula para cálculo do RR é:\u003c/p\u003e\u003cimg src="img/caso6_figura10_churrasco.png"/\u003e\u003cp\u003eOnde TA1 se refere a taxa de ataque entre os expostos (comensais) e TA2, entre os não expostos (não comensais).\u003cbr/\u003e\u003cbr/\u003e Interpretação do resultado do RR:\u003cbr/\u003eRR=1:  ausência de associação;\u003cbr/\u003eRR\u003c1:  sugere que o fator estudado não apresenta risco, mas é um fator de proteção;\u003cbr/\u003eRR\u003e1: sugere que há associação e que o fator estudado é um fator de risco para ocorrência do efeito.\u003cbr/\u003e\u003c/p\u003e',
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eComo resultado da investigação deste surto, a VE constatou que apenas a carne de javali apresentou, simultaneamente, três medidas que a caracterizariam como provável causadora do surto: maior taxa de ataque entre os que a ingeriram (92,3%), menor taxa entre os que não a ingeriram e maior risco relativo.\u003c/p\u003e\u003cp\u003eAs atividades da Vigilância Epidemiológica foram articuladas em ações com a Vigilância Sanitária (VS) e a Vigilância Ambiental (VA). A VS realizou uma vistoria na cozinha onde os alimentos foram preparados e na área da churrasqueira onde os alimentos foram servidos e consumidos. Diante disso, faz-se necessária a integração de todas as áreas afins.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eNo início das investigações de surto, o veículo de transmissão (água e/ou alimento) geralmente é incerto. Normalmente, os parasitas, as substâncias tóxicas e os micróbios prejudiciais à saúde entram em contato com o alimento durante a manipulação e preparo. Os cuidados com as condições de acondicionamento e conservação dos alimentos também devem ser rigorosamente revisados por serem elementos chave na investigação de surtos de origem alimentar. É necessário ainda avaliar a qualidade da água disponível para consumo e para preparo dos alimentos. De forma complementar se faz necessário inquirir sobre as condições de saúde dos manipuladores e sua capacitação profissional.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["o horário do preparo dos alimentos para o jantar", true],
            [
              "as condições (higiene, temperatura, embalagens, local) de armazenamento",
              true,
            ],
            ["a origem da água utilizada para consumo e preparo", true],
            [
              "a situação de saúde e capacitação dos manipuladores de alimentos",
              true,
            ],
            ["as condições de umidade dos alimentos", false],
          ],
        },
        pergunta:
          "No contexto das DTA a contaminação pode ocorrer em toda a cadeia alimentar, desde a produção primária até o consumo. Podemos identificar falhas no processo de elaboração da refeição suspeita avaliando os seguintes aspectos:",
        titulo: "Questão 8",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eAvaliando o preparo dos alimentos, foi possível identificar inconformidades sanitárias no preparo de quatro alimentos pelos manipuladores (carne de gado, carne de javali, salada de alface e salada de frutas):\u003c/p\u003e\u003cul\u003e\u003cli\u003eCarne de gado assada (churrasco)\u003cul\u003e\u003cli\u003eManutenção em calor inadequado (abaixo de 60° C).\u003c/li\u003e\u003cli\u003ePossibilidade de contaminação cruzada.\u003c/li\u003e\u003c/ul\u003e\u003c/li\u003e\u003cli\u003eCarne de javali assada (churrasco de javali)\u003cul\u003e\u003cli\u003eManipulação incorreta.\u003c/li\u003e\u003cli\u003ePossibilidade de contaminação cruzada.\u003c/li\u003e\u003cli\u003eManutenção em temperatura ambiente por mais de 2 horas.\u003c/li\u003e\u003cli\u003eManutenção em calor inadequado (abaixo de 60° C).\u003c/li\u003e\u003cli\u003eMatéria-prima sem inspeção (clandestina).\u003c/li\u003e\u003cli\u003eTransporte inadequado.\u003c/li\u003e\u003c/ul\u003e\u003c/li\u003e\u003cli\u003eSalada de alface\u003cul\u003e\u003cli\u003eMatéria-prima sem inspeção.\u003c/li\u003e\u003cli\u003eManipulação incorreta.\u003c/li\u003e\u003cli\u003ePossibilidade de contaminação cruzada.\u003c/li\u003e\u003c/ul\u003e\u003c/li\u003e\u003cli\u003eSalada de frutas\u003cul\u003e\u003cli\u003eManipulação incorreta.\u003c/li\u003e\u003cli\u003ePossibilidade de contaminação cruzada.\u003c/li\u003e\u003c/ul\u003e\u003c/li\u003e\u003c/ul\u003e\u003cp\u003eA utilização de matéria-prima de origem clandestina, associada ao descongelamento e manutenção em temperaturas inadequadas (acima de 7º C), provavelmente, contribuíram para o crescimento dos microrganismos encontrados na análise bromatológica dos alimentos. \u003c/p\u003e\u003cp\u003eOs alimentos foram preparados por duas pessoas que eram funcionárias (caseiros) do proprietário da casa onde o jantar foi servido. A saúde dos manipuladores foi avaliada por meio de entrevista e de avaliação visual e não foram constatadas enfermidades e/ou ferimentos relevantes nas mãos. Não foram realizados exames de swab subungueal, nem coprocultura.\u003c/p\u003e\u003cp\u003eOs fiscais da VS conseguiram coletar apenas amostras da carne de gado assada (churrasco). Não havia amostras dos demais alimentos servidos e ingeridos no jantar. A amostra da carne foi enviada para a análise bromatológica ao Laboratório Central do Estado (LACEN) que acusou a sua contaminação por dois microrganismos: Escherichia coli (7,4 x 103 NMP/g) e \u003ci\u003eBacillus cereus\u003c/i\u003e (3,3 x 104 UFC/g). Os laudos da bromatologia foram disponibilizados no dia 09/01/2018. \u003c/p\u003e\u003cp\u003eOs técnicos da VA coletaram amostras de água servida na residência onde os alimentos foram preparados, em três pontos de abastecimento, no dia 05/12. As amostras de água coletadas na saída do poço artesiano, na pia da cozinha e na pia ao lado da churrasqueira foram enviadas ao LACEN da Coordenadoria Regional de Saúde. As análises destes três pontos de abastecimento não apresentaram evidências de contaminação microbiológica por coliformes totais e por E. coli. A turbidez também estava satisfatória. Nenhuma delas tinha cloro residual. Os laudos da água foram disponibilizados no dia 08/12/2017. \u003c/p\u003e\u003cp\u003eApós a vistoria inicial do local onde os alimentos foram servidos, a realização do inquérito sobre o preparo dos alimentos e avaliação dos manipuladores, a VS indicou orientações gerais sobre as Boas Práticas de Alimentação. Contudo, por se tratar de uma residência, as mesmas foram transmitidas em caráter orientativo, e não impositivo, o que ocorreria caso se tratasse de um estabelecimento comercial. Além disso, foi reforçada a importância da utilização de matérias-primas de origem animal e vegetal devidamente inspecionadas pelos órgãos competentes. Alertou ainda sobre os cuidados para a conservação adequada dos alimentos, antes, durante e após o seu preparo.\u003c/p\u003e\u003cp\u003eDurante a investigação do surto, as equipes das Vigilâncias Sanitária, Ambiental e Epidemiológica da Secretaria Municipal de Saúde reuniram-se e compartilharam informações entre si e com a coordenação da Vigilância das DTAs do Centro Estadual de Vigilância em Saúde. A elaboração das hipóteses sobre as prováveis fontes de exposição e os possíveis agentes etiológicos deste surto foram sendo discutidas e revisadas pelas equipes da Vigilância em Saúde do município. Os dados das avaliações in loco, bem como, as evidências laboratoriais (exames da água e dos alimentos) foram sendo disponibilizados na medida que eram produzidos.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eAs manifestações e as características da infecção sugerem a infecção pelo \u003ci\u003eBacillus cereus\u003c/i\u003e e a identificação laboratorial colaboraram na confirmação do agente etiológico. \u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "nas análises laboratoriais da carne de gado (churrasco) que acusaram o crescimento de \u003ci\u003eE. Coli\u003c/i\u003e e de \u003ci\u003eBacillus cereus\u003c/i\u003e.",
              true,
            ],
            [
              "no quadro clínico dos doentes que indicou a prevalência de sinais e sintomas com predomínio de vômito e diarreia e compatíveis com a infecção por microrganismos não causadores de febre, como os causados pelo \u003ci\u003eBacillus cereus\u003c/i\u003e.",
              true,
            ],
            [
              "em um período de incubação curto, compatível com a infecção pelo \u003ci\u003eBacillus cereus\u003c/i\u003e",
              true,
            ],
          ],
        },
        pergunta:
          "O encerramento desta investigação concluiu que o provável agente etiológico do surto foi o \u003ci\u003eBacillus cereus\u003c/i\u003e baseando-se:",
        titulo: "Questão 9",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eO surto foi encerrado em 28/02/2018, após a avaliação das evidências e da discussão entre os técnicos do município com os da Secretaria Estadual da Saúde considerando as análises laboratoriais da água que não mostraram a presença de E. coli e de coliformes totais; as análises laboratoriais da carne de gado (churrasco) que acusaram o crescimento de \u003ci\u003eE. coli\u003c/i\u003e e de \u003ci\u003eBacillus cereus\u003c/i\u003e; no quadro clínico dos doentes que indicou a prevalência de sinais e sintomas com predomínio de vômito e diarreia e compatíveis com a infecção por microrganismos não causadores de febre, como os causados pelo \u003ci\u003eBacillus cereus\u003c/i\u003e; o curto período de incubação, compatível com a infecção pelo \u003ci\u003eBacillus cereus\u003c/i\u003e. Concluiu-se que o provável agente etiológico do surto seria o \u003ci\u003eBacillus cereus\u003c/i\u003e, e a fonte de exposição à carne de gado (churrasco).\u003c/p\u003e\u003cp\u003eA possibilidade de contaminação prévia, bem como, de contaminação cruzada não pode ser menosprezada, haja vista, as diversas inconformidades observadas no preparo dos alimentos deste surto, especialmente, a utilização de matérias-primas “sem procedência” (como a carne de javali e a alface), bem como, a conservação inadequada dos alimentos servidos que, seguramente, favoreceu o crescimento de microrganismos.\u003c/p\u003e\u003cp\u003eAo que se refere à contaminação cruzada, existem estudos apontando a presença de E. coli e de \u003ci\u003eBacillus cereus\u003c/i\u003e em diferentes utensílios de cozinha. Também vale a pena destacar a carne de javali, que desde sua origem, transporte e conservação acumulou um alto potencial de risco à saúde de seus consumidores. Infelizmente, não havia mais amostra desse alimento para a análise bromatológica.\u003c/p\u003e\u003cp\u003eO responsável pelo jantar e todos os comensais foram convidados para uma reunião com os técnicos das três Vigilâncias, na qual foram apresentados os dados da investigação, bem como, entregues cópias do relatório, dos laudos de bromatologia dos alimentos, dos laudos da água, dos termos de vistoria, entre outras documentações. Foram esclarecidas as dúvidas e reforçadas as orientações que já estavam sendo feitas desde o início da investigação a respeito dos cuidados, do controle e da prevenção da contaminação de alimentos e da água.\u003c/p\u003e\u003cp\u003eA equipe da VE enfrentou algumas \u003cb\u003ebarreiras para a realização da investigação epidemiológica\u003c/b\u003e tais como:\u003c/p\u003e\u003cul\u003e\u003cli\u003eA coleta de amostras de alimentos para a pesquisa e identificação dos prováveis agentes etiológicos constitui um importante desafio na investigação de surtos de doenças transmitidas por alimentos ocorridos em ambientes familiares ou domiciliares. Isso deve-se, em parte, ao fato de que os surtos domiciliares não estão sujeitos ao cumprimento das mesmas orientações sanitárias aplicadas às instituições, às empresas comerciais e às indústrias. Para estas, há a recomendação de guardar amostras de alimentos preparados e servidos por um prazo de até 72 horas (período no qual, em geral, costumam ocorrer os surtos). Entretanto, vale salientar, que, a depender dos estados e dos municípios, a guarda de amostras de alimentos por 72 horas não é apenas uma recomendação, mas, sim, uma determinação da legislação sanitária. Assim, no presente surto, não foi possível conseguir amostras de todos os alimentos servidos no jantar, especialmente a carne de javali que apresentava inúmeras situações de risco para ser a causa de um surto de doença alimentar.\u003c/li\u003e\u003cli\u003eA coleta de amostras de coprocultura dos doentes para a pesquisa e identificação dos prováveis agentes etiológicos também constitui um desafio na investigação de surtos de doenças transmitidas por alimentos. Isso deve-se a diferentes motivos, como, por exemplo, ao fato de que a grande maioria dos profissionais que atendem os doentes de surtos alimentares em serviços de saúde (geralmente nas emergências) desconhecem a necessidade de solicitar exames de coprocultura como meio de diagnóstico, ou, simplesmente, porque estes serviços não dispõem dos meios para coleta (swabs), ou porque não disponibilizam este exame em seus laboratórios. Além disso, quando os surtos ocorrem em finais de semana ou feriados, ou quando não são devidamente notificados, via de regra, eles só chegam ao conhecimento dos técnicos da Vigilância em Saúde dias após o seu início, quando não é mais tecnicamente oportuno realizar a coleta de coproculturas e enviá-las aos laboratórios de referência.\u003c/li\u003e\u003cli\u003eSomado a isso, nem todos os doentes permitem que lhes seja feita a coleta dos swabs retais, seja por constrangimento, ou por não se disponibilizarem a comparecer às coletas, quando convidados. Como resultado disso, nem sempre é possível realizar as coletas, ou quando muito, um número muito pequeno de amostras para coprocultura é conseguido, dificultando uma importante etapa da investigação laboratorial dos surtos. Adicionalmente, como mencionado anteriormente, surtos ocorridos em ambientes domiciliares não estão sujeitos ao cumprimento das mesmas orientações sanitárias que costumam ser exigidas das instituições e das empresas. Como consequência disso, há uma maior probabilidade de ocorrerem “brechas” na execução das recomendações de boas práticas alimentares relativas ao preparo e à conservação dos alimentos, ou à higiene do ambiente e dos utensílios de cozinha, bem como, à saúde dos manipuladores, como observado na investigação deste surto.\u003c/li\u003e\u003c/ul\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: [
          {
            urlExterno:
              "https://sistemas.uft.edu.br/periodicos/index.php/desafios/article/download/5089/13657",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BATISTA, Ryhára Dias, et alii. \u003cb\u003eContaminação por Bacillus cereus e os riscos gerados através da intoxicação alimentar\u003c/b\u003e. In: Revista Desafios, v. 5, n. 02, 2018 Disponível",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/capacitacao_monitoramento_diarreicas_treinando.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Vigilância Epidemiológica. \u003cb\u003eCapacitação em monitorização das doenças diarreicas agudas\u003c/b\u003e – MDDA: manual do treinando / Ministério da Saúde, Secretaria de Vigilância em Saúde, Departamento de Vigilância Epidemiológica. – Brasília: Editora Ministério da Saúde, 2010. Disponível em:",
          },
          {
            urlExterno:
              "https://www.gov.br/saude/pt-br/centrais-de-conteudo/publicacoes/publicacoes-svs/doencas-transmitidas-por-alimentos-dta/manual_dtha_2021_web.pdf/@@download/file/manual_DTHA_2021_web.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Imunizações e Doenças Transmissíveis. \u003cb\u003eVigilância epidemiológica das doenças de transmissão hídrica e alimentar:\u003c/b\u003e manual de treinamento / Ministério da Saúde, Secretaria de Vigilância em Saúde, Departamento de Imunização e Doenças Transmissíveis. – Brasília: Ministério da Saúde, 2021. Disponível em: ",
          },
        ],
        tipo: "bibliografia",
      },
    ],
    subTitulo: "",
    titulo: "Onze pessoas no serviço de urgência com gastroenterite",
    tsPublicacao: 1.23456789e9,
    shortname: "Onze pessoas no serviço de urgência com gastroenterite",
  },
  {
    _id: ObjectId("630cb5ca41e46fa01e0115f8"),
    autor: ["Dóris Schuch", "Marcínia Bueno"],
    editores: ["Everton Fantinel", "Denise Silveira"],
    id: 9069.0,
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "41 anos",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "interdisciplinar",
    slides: [
      {
        conteudo: { texto: "", delay: "5" },
        titulo: "Introdução",
        tipo: "intro",
      },
      {
        conteudo: {
          descricaoCaso:
            "\u003cp\u003eUma escola de futebol recebe cerca de 80 adolescentes entre 14 e 18 anos, com periodicidade de treinos três vezes por semana. Neste local, há disponibilidade de alojamento para alunos que residem em outras cidades e desejam permanecer na escola durante a semana. Nos últimos dias alguns destes alunos apresentaram febre, tosse, cefaleia, coriza, artralgia e diarreia.\u003c/p\u003e",
        },
        titulo: "Descrição do Caso",
        tipo: "descricaocaso",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eDefinição de Síndrome Gripal leve (SG) - Indivíduo com quadro respiratório agudo, caracterizado por pelo menos dois (2) dos seguintes. sinais e sintomas: febre (mesmo que referida), calafrios, dor de garganta, dor de cabeça, tosse, coriza, distúrbios olfativos ou distúrbios gustativos. Em crianças: além dos itens anteriores, considera-se também obstrução nasal, na ausência de outro diagnóstico específico. Em idosos: deve-se considerar também critérios específicos de agravamento como a presença de síncope, confusão mental, sonolência excessiva, irritabilidade e inapetência. Na suspeita da covid-19, a febre pode estar ausente, e sintomas gastrointestinais (diarreia) podem estar presentes.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Dor de garganta", true],
            ["Calafrios", true],
            ["Mialgia", true],
            ["Fadiga", true],
            ["Convulsões", false],
          ],
        },
        pergunta:
          "Os alunos da escola apresentaram alguns sinais e sintomas que caracterizam casos de Síndrome Gripal ou Síndrome Respiratória Aguda leve. Além da febre, da tosse, da cefaleia, da artralgia e da diarreia, quais outros sinais e sintomas podem estar presentes?",
        titulo: "Questão 1",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA notificação deve ser realizada em até 24 horas a partir da suspeita inicial de SG, de Síndrome Respiratória Aguda Grave SRAG hospitalizado (de qualquer etiologia), óbito por SRAG, independentemente de hospitalização. Os indivíduos assintomáticos com confirmação laboratorial por biologia molecular, teste de antígeno ou exame imunológico que evidenciam infecção recente por covid-19, também devem ser notificados com esta temporalidade. A notificação dos laboratórios deve ser realizada no prazo de até 24 (vinte e quatro) horas contado da data do resultado do teste, mediante registro e transmissão de informações da Rede Nacional de Dados em Saúde (Portaria GM/MS n.° 1.792, de 21/7/2020, e Portaria GM/MS n.° 1.046, de 24/5/2021).\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["24 horas a partir da suspeita inicial do caso", true],
            ["48 horas a partir da suspeita inicial do caso", false],
            ["24 horas a partir do resultado do exame de imagem", false],
            ["48 horas a partir do resultado do exame de laboratório", false],
          ],
        },
        pergunta:
          "Para operacionalizar as atividades da vigilância epidemiológica recomenda-se que a notificação seja realizada, pelo menos:",
        titulo: "Questão 2",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eO departamento médico da escola de futebol notificou a Vigilância Epidemiológica (VE) no dia 9 de maio de 2022 sobre estes vários casos com a mesma sintomatologia. De imediato, no dia 10/09, a VE encaminhou seus técnicos à escola para fazer a investigação dos casos (ação in loco). Ao conversar com o médico que estava acompanhando estes casos, foi identificado que o início dos sintomas do primeiro caso ocorreu no dia 5 de maio de 2022 e que, até o momento, já havia 19 casos suspeitos de síndrome gripal entre os alunos alojados e os não alojados na escola, estabelecendo-se assim a suspeita de surto de Síndrome Gripal. Durante a presença dos técnicos da VE na escola, o treinador dos adolescentes solicitou atendimento para mais três alunos com manifestações clínicas semelhantes às dos demais. Diante dos 22 casos apresentados, a VE realizou teste rápido de antígeno para covid-19  em cinco dos alunos presentes no momento da investigação, cujos exames tiveram resultado negativo. Assim, foram realizadas novas coletas da nasofaringe com swab destes cinco alunos para diagnóstico laboratorial de H1N1 no LACEN.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA investigação da data de início dos primeiros sintomas permite ao investigador situar em que período do surgimento dos casos a investigação foi desencadeada. Além disso, se a doença foi descrita e a exposição é conhecida, é possível calcular o período de incubação e até estimar o período em que ocorreu a exposição. Esse fato também permite elaborar perguntas mais precisas aos doentes, como exposições antes do período de incubação e voltadas ao período de exposição, bem como possibilita fazer inferências sobre o padrão da transmissão: fonte comum, disseminação pessoa a pessoa, ou ambos. O número de casos é necessário para verificar se houve aumento acima do esperado na ocorrência do evento ou doença em uma área ou entre um grupo específico de pessoas, em determinado período. Ressalta-se que, para doenças raras, um único caso pode representar um surto. A determinação da existência de um surto não depende do conhecimento da situação vacinal de casos e contatos e da coleta de exames.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["a data dos primeiros sintomas", true],
            ["o número de casos", true],
            ["a situação da vacinação contra influenza", false],
            ["a coleta de swab nasal para exame", false],
          ],
        },
        pergunta:
          "Contribuíram para verificar se os casos tinham vínculo epidemiológico e se estaríamos diante de um surto ou casos isolados de Síndrome Gripal as seguintes informações:",
        titulo: "Questão 3",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eEnquanto as análises das amostras coletadas estavam sendo processadas para H1N1, medidas de controle deste surto de SG foram encaminhadas em ação conjunta da VE com a Vigilância Sanitária na escola. Previamente, foram realizadas inspeções no alojamento e áreas de convivência, que contribuíram para orientar o plano de contingência municipal.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eQuando a investigação epidemiológica realizada pela Vigilância em Saúde local, identificar a ocorrência de surto de SG em comunidades fechadas, medidas de prevenção, devem ser adotadas para reduzir o risco de transmissão na população tais como: vacinação; manter distanciamento físico; frequente higienização das mãos; utilização de máscara facial cobrindo nariz e boca; utilizar lenço descartável para higiene nasal; cobrir nariz e boca quando espirrar ou tossir; higienizar as mãos após tossir ou espirrar - no caso de não haver água e sabão, usar álcool gel; evitar tocar mucosas de olhos, nariz e boca; não compartilhar alimentos, copos, toalhas e objetos de uso pessoal; evitar aperto de mãos, abraços e beijo social; evitar contato próximo com pessoas que apresentem sinais e sintomas de gripe; evitar aglomerações e ambientes fechados; evitar visitas a hospitais; limpeza e desinfecção de ambientes; manter os ambientes bem ventilados; evitar contato próximo a pessoas que apresentem sinais ou sintomas de SG; evitar sair de casa em período de transmissão da doença; adotar hábitos saudáveis, como alimentação balanceada e ingestão de líquidos; orientar o afastamento temporário (trabalho, escola etc.) até 24 horas após cessar a febre. As luvas são recomendadas para os profissionais de saúde e somente no momento da realização de procedimentos específicos.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["etiqueta respiratória ao tossir ou respirar", true],
            ["higienizar as mãos com frequência", true],
            [
              "não partilhar alimentos, copos, toalhas e objetos de uso pessoal",
              true,
            ],
            ["uso de máscara facial", true],
            ["uso de luvas", false],
          ],
        },
        pergunta:
          "Assinale medidas gerais de prevenção que precisam ser implantadas / implementadas para reduzir o risco de transmissão da Síndrome Gripal:",
        titulo: "Questão 4",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eRecomendações gerais para escolas e creches\u003c/h3\u003e\u003cul\u003e\u003cli\u003eNão há indicação de quimioprofilaxia para comunidade.\u003c/li\u003eAlunos, professores e demais funcionários que adoecerem devem permanecer em afastamento temporário na suspeita clínica de inﬂuenza, podendo ser liberado o retorno à escola se clinicamente estável, sem uso de antitérmico e sem febre por 24 horas.\u003c/li\u003e\u003cli\u003eAo retornar à escola, manter cuidados de etiqueta respiratória durante sintomas respiratórios.\u003c/li\u003e\u003cli\u003eNão está indicada a suspensão de aulas e outras atividades para controle de surto de inﬂuenza como medida de prevenção e controle de infecção.\u003c/li\u003e\u003c/ul\u003e\u003ch3\u003eCuidados no manejo de crianças em creches\u003c/h3\u003e\u003cul\u003e\u003cli\u003eEncorajar cuidadores e crianças a lavar as mãos e os brinquedos, com água e sabão, quando estiverem visivelmente sujos.\u003c/li\u003e\u003cli\u003eEncorajar os cuidadores a lavar as mãos, após contato com secreções nasais e orais das crianças, principalmente quando a criança estiver com suspeita de síndrome gripal.\u003c/li\u003e\u003cli\u003eOrientar os cuidadores a observar se há crianças com tosse, febre e dor de garganta, principalmente quando há notificação de surto de SG na cidade. Os cuidadores devem notificar os pais quando a criança apresentar os sintomas citados.\u003cli\u003eEvitar o contato da criança doente com as demais. Recomenda-se que a criança doente fique em casa, a fim de evitar a transmissão da doença.\u003c/li\u003e\u003cli\u003eOrientar os cuidadores e responsáveis pela creche que notifiquem à secretaria de saúde municipal, caso observem um aumento do número de crianças doentes com SG ou com absenteísmo pela mesma causa.\u003c/li\u003e\u003c/ul\u003e\u003ch6\u003e(BRASIL, 2018)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eNa manhã do dia 12 de maio os exames foram disponibilizados com resultados RT-PCR detectável para Influenza A H1N1. Neste momento, todas as medidas foram intensificadas para o controle do surto.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eOs medicamentos antivirais apresentam de 70% a 90% de efetividade na prevenção da inﬂuenza e constituem ferramenta adjuvante da vacinação. Entretanto, a quimioprofilaxia indiscriminada NÃO é recomendável, pois pode promover o aparecimento de resistência viral. A quimioprofilaxia com antiviral não é recomendada se o período após a última exposição* a uma pessoa com infecção pelo vírus for maior que 48 horas. Para que a quimioprofilaxia seja efetiva, o antiviral deve ser administrado durante a potencial exposição à pessoa com inﬂuenza e continuar por mais sete dias após a última exposição conhecida.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "os medicamentos antivirais apresentam de 70% a 90% de efetividade.",
              true,
            ],
            [
              "a quimioprofilaxia indiscriminada é recomendada para todas as pessoas.",
              false,
            ],
            [
              "está indicada para pessoas de baixo risco de complicações não vacinadas ou vacinadas.",
              false,
            ],
            [
              "não existem evidências científicas para indicar quimioprofilaxia.",
              false,
            ],
          ],
        },
        pergunta:
          "No contexto da quimioprofilaxia com antivirais na prevenção de influenza podemos afirmar que:",
        titulo: "Questão 5",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eIndicações da quimioprofilaxia para influenza:\u003c/h3\u003e\u003cp\u003e\u003cul\u003e\u003cli\u003ePessoas com risco elevado de complicações não vacinadas ou vacinadas há menos de duas semanas, após exposição a caso suspeito ou confirmado de inﬂuenza.\u003c/li\u003e\u003cli\u003eCrianças com menos de 9 anos de idade, primovacinadas, necessitam de segunda dose da vacina com intervalo de um mês para serem consideradas vacinadas. Aquelas com condições ou fatores de risco que foram expostas a caso suspeito ou confirmado no intervalo entre a primeira e a segunda dose ou com menos de duas semanas após a segunda dose.\u003c/li\u003e\u003cli\u003ePessoas com graves deficiências imunológicas (exemplos: pessoas que usam medicamentos imunossupressores; pessoas com aids com imunodepressão avançada) ou outros fatores que possam interferir na resposta à vacinação contra a inﬂuenza, após contato com pessoa com infecção.\u003c/li\u003e\u003cli\u003eProfissionais de laboratório, não vacinados ou vacinados a menos de 15 dias, que tenham manipulado amostras clínicas de origem respiratória que contenham o vírus inﬂuenza sem uso adequado de Equipamento de Proteção Individual (EPI).\u003c/li\u003e\u003cli\u003eTrabalhadores de saúde, não vacinados ou vacinados a menos de 15 dias, e que estiveram envolvidos na realização de procedimentos invasivos geradores de aerossóis ou na manipulação de secreções de caso suspeito ou confirmado de inﬂuenza sem o uso adequado de EPI.\u003c/li\u003e\u003cli\u003eResidentes de alto risco em instituições fechadas e hospitais de longa permanência, durante surtos na instituição deverão receber quimioprofilaxia, se tiverem comorbidades.\u003c/li\u003e\u003c/ul\u003e\u003ch6\u003e(BRASIL, 2018)\u003c/h6\u003e\u003c/p\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eO tratamento com o antiviral, de maneira precoce, pode reduzir a duração dos sintomas e, principalmente, a redução da ocorrência de complicações da infecção pelo vírus inﬂuenza. Todas as afirmações estão corretas.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "o maior benefício clínico é alcançado quando o fosfato de oseltamivir é iniciado até 48 horas do início dos sintomas.",
              true,
            ],
            [
              "o fosfato de oseltamivir pode ainda ser benéfico para pacientes hospitalizados se iniciado de quatro a cinco dias após o início do quadro clínico.",
              true,
            ],
            [
              "no caso de pacientes gestantes, em qualquer trimestre, com infecção por inﬂuenza A(H1N1)pdm09, o maior benefício foi demonstrado nos casos que receberam tratamento até 72 horas",
              true,
            ],
            [
              "a indicação de zanamivir somente está autorizada em casos de intolerância gastrointestinal grave, alergia e resistência ao fosfato de oseltamivir.",
              true,
            ],
          ],
        },
        pergunta:
          "Sobre o uso de antiviral de maneira precoce para o tratamento da infecção por influenza está correto afirmar que:",
        titulo: "Questão 6",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eTratamento - uso de antivirais na infecção por Influenza:\u003c/h3\u003e\u003cp\u003e\u003cul\u003e\u003cli\u003eO oseltamivir (Tamiﬂu®) e zanamivir (Relenza®) são medicamentos inibidores de neuraminidase, classe de drogas com efeito contra o vírus inﬂuenza.\u003c/li\u003e\u003cli\u003eEstudos observacionais incluindo pacientes hospitalizados demonstraram maior benefício clínico quando o fosfato de oseltamivir é iniciado até 48 horas do início dos sintomas. Entretanto, alguns estudos sugerem que o fosfato de oseltamivir pode ainda ser benéfico para pacientes hospitalizados se iniciado de quatro a cinco dias após o início do quadro clínico.\u003c/li\u003e\u003cli\u003eNo caso de pacientes gestantes, em qualquer trimestre, com infecção por inﬂuenza A(H1N1)pdm09, o maior benefício em prevenir falência respiratória e óbito foi demonstrado nos casos que receberam tratamento até 72 horas, porém ainda houve benefício quando iniciado entre três a quatro dias após o início dos sintomas, quando comparado com casos que receberam o antiviral após cinco dias do início do quadro clínico.\u003c/li\u003e\u003cli\u003eOs efeitos do uso dos antivirais em situações clínicas graves não foram avaliados em estudos clínicos randomizados controlados duplo-cego, incluindo placebo, uma vez que a maior parte dos estudos clínicos anteriores foram conduzidos em pacientes ambulatoriais apresentando apenas Síndrome Gripal. Segundo as agências internacionais, os inibidores de neuraminidase (oseltamivir e zanamivir) são considerados \u003ci\u003estand of care\u003c/i\u003e e únicas drogas disponíveis aprovadas para pacientes com inﬂuenza hospitalizados.\u003c/li\u003e\u003c/ul\u003e\u003ch3\u003eTratamento com Zanamivir:\u003c/h3\u003e\u003cul\u003e\u003cli\u003eA indicação de zanamivir somente está autorizada em casos de intolerância gastrointestinal grave, alergia e resistência ao fosfato de oseltamivir.\u003c/li\u003e\u003cli\u003eO zanamivir é contraindicado em menores de 5 anos para tratamento ou para quimioprofilaxia e para todo paciente com doença respiratória crônica pelo risco de broncoespasmo severo.\u003c/li\u003e\u003cli\u003eO zanamivir não pode ser administrado em pacientes em ventilação mecânica, porque essa medicação pode obstruir os circuitos do ventilador.\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e\u003ch6\u003e(BRASIL, 2018)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eAinda durante o processo de investigação na escola, foi identificado que um dos alunos (D.M.A.) que retornou para seu município de origem no final de semana, também veio apresentar sintomas respiratórios leves, que se agravaram, passando a apresentar febre persistente, prostração e dispneia. Este aluno necessitou de internação hospitalar e, ao final, evoluiu para cura.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eConsidera-se a síndrome respiratória aguda grave (síndrome gripal que apresente dispneia/desconforto respiratório ou pressão persistente no tórax ou saturação de O2 menor que 95% em ar ambiente ou coloração azulada de lábios ou rosto). Para crianças, os principais sintomas incluem taquipneia (maior ou igual a 70 irpm para menores de 1 ano e maior ou igual a 50 irpm para crianças maiores de 1 ano), hipoxemia, desconforto respiratório, alteração da consciência, desidratação, dificuldade para se alimentar, lesão miocárdica, elevação de enzimas hepáticas, disfunção da coagulação, rabdomiólise, cianose central ou SpO2\u003c90-92% em repouso e ar ambiente, letargia, convulsões, dificuldade de alimentação/recusa alimentar.\u003cp\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["SRAG", true],
            ["bronquite aguda", false],
            ["pneumonia", false],
            ["broncopneumonia", false],
          ],
        },
        pergunta:
          "As manifestações clínicas de agravamento da Síndrome Gripal de D.M.A. permitem afirmar que agora estamos diante de um caso de:",
        titulo: "Questão 7",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            '\u003cp\u003eO caso de D.M.A. foi corretamente notificado pelo hospital na Ficha de Registro Individual - Casos de Síndrome Respiratória Aguda Grave Hospitalizado no SIVEP-GRIPE\u003c/p\u003e\u003ch6\u003eFigura 1. Ficha de registro individual - caso de síndrome respiratória aguda grave hospitalizado, SIVEP Gripe, 2022.\u003c/h6\u003e\u003ctable\u003e\u003ctr\u003e\u003ctd\u003e\u003cimg src="img/caso10_figura1_1_RESPIRATORIA.png"/\u003e\u003c/td\u003e\u003ctd\u003e\u003cimg src="img/caso10_figura1_RESPIRATORIA.png"/\u003e\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003cp\u003eA equipe da VE enfrentou algumas \u003cb\u003ebarreiras para a realização da investigação epidemiológica\u003c/b\u003e tais como:\u003c/p\u003e\u003cul\u003e\u003cli\u003eA grande rotatividade de professores e alunos, a hospedagem de alunos em alojamento conjunto,  levou a necessidade de listar e acompanhar as pessoas que circularam na escola por período prolongado.\u003c/li\u003e\u003cli\u003eManter em quarentena e isolamento os alunos e trabalhadores da escola.\u003c/li\u003e\u003cli\u003eAcompanhar os contatos das pessoas que frequentavam a escola.\u003c/li\u003e\u003cli\u003eAbsenteísmo de professores e alunos.\u003c/li\u003e\u003cli\u003eIdentificar o caso índice do surto.\u003c/li\u003e\u003c/ul\u003e',
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: [
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/protocolo_tratamento_influenza_2017.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de \u003cb\u003eVigilância das Doenças Transmissíveis. Protocolo de tratamento de Influenza:\u003c/b\u003e 2017 [recurso eletrônico] / Ministério da Saúde, Secretaria de Vigilância em Saúde, Departamento de Vigilância das Doenças Transmissíveis. – Brasília: Ministério da Saúde, 2018. Disponível em: ",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/guia_vigilancia_saude_3ed.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Coordenação-Geral de Desenvolvimento da Epidemiologia em Serviços. \u003cb\u003eGuia de Vigilância em Saúde:\u003c/b\u003e volume único [recurso eletrônico] / Ministério da Saúde, Secretaria de Vigilância em Saúde, Coordenação-Geral de Desenvolvimento da Epidemiologia em Serviços. 3ª. ed. – Brasília: Ministério da Saúde, 2019. Disponível em: ",
          },
          {
            urlExterno:
              "https://www.gov.br/saude/pt-br/centrais-de-conteudo/publicacoes/publicacoes-svs/coronavirus/guia-de-vigilancia-epidemiologica-covid-19_2021.pdf/view",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. \u003cb\u003eGuia de vigilância epidemiológica:\u003c/b\u003e emergência de saúde pública de importância nacional pela doença pelo coronavírus 2019 – covid-19 / Ministério da Saúde, Secretaria de Vigilância em Saúde. – Brasília: Ministério da Saúde, 2022. Disponível em: ",
          },
          {
            urlExterno:
              "https://www.gov.br/saude/pt-br/coronavirus/publicacoes-tecnicas/notas-tecnicas/nota-tecnica-no-31-2022-cgpni-deidt-svs-ms.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde Departamento de Imunização e Doenças Transmissíveis. Coordenação-Geral do Programa Nacional de Imunizações. \u003cb\u003eNota Técnica Nº 31/2022\u003c/b\u003e. Informações técnicas e recomendações sobre a vigilância epidemiológica da Influenza no Brasil. Disponível em:",
          },
        ],
        tipo: "bibliografia",
      },
    ],
    subTitulo: "",
    titulo: "Alunos da escola de futebol estão com febre, tosse e coriza",
    tsPublicacao: 1.23456789e9,
    shortname: "Alunos da escola de futebol estão com febre, tosse e coriza",
  },
  {
    _id: ObjectId("630d355f41e46fab300115f8"),
    autor: ["Dóris Schuch", "Marcínia Bueno"],
    editores: ["Everton Fantinel", "Denise Silveira"],
    id: 9070.0,
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "41 anos",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "interdisciplinar",
    slides: [
      {
        conteudo: { texto: "", delay: "5" },
        titulo: "Introdução",
        tipo: "intro",
      },
      {
        conteudo: {
          descricaoCaso:
            '\u003cp\u003eNo dia 25 de abril, a Unidade Básica de Saúde da Vila das Flores, bairro do município de Aroeira, fez uma notificação de suspeita de surto de hepatite viral para a Vigilância Epidemiológica (VE) do município (Figura 1).\u003c/p\u003e\u003ch6\u003eFigura 1. Ficha do Ministério da Saúde para a Monitorização dos Casos de Doenças Diarreicas Agudas. SINAN, 2022.\u003c/h6\u003e\u003ctable\u003e\u003ctr\u003e\u003ctd\u003e\u003cimg src="img/caso11_figura1_1_HEPATITE.png"/\u003e\u003c/td\u003e\u003ctd\u003e\u003cimg src="img/caso11_figura1_2_HEPATITE.png"/\u003e\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003cp\u003eA notificação foi decorrente da observação de cinco pacientes atendidos na semana epidemiológica 16/2022, apresentando quadro clínico que consistia em diarreia, vômito, dor abdominal e fadiga. Destas cinco pessoas, duas apresentaram também icterícia e apenas 3 referiram febre. Segundo a fonte notificadora todos os pacientes moravam na Vila das Flores, eram do sexo masculino e com idades que variavam entre 13 a 21 anos de idade. Em razão da apresentação aguda dos sintomas, ficou estabelecida a suspeição de surto de hepatite A.\u003c/p\u003e',
        },
        titulo: "Descrição do Caso",
        tipo: "descricaocaso",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eOs casos de hepatites virais devem ser notificados em até sete dias seguindo o prazo da notificação compulsória regular. Portanto todos os casos confirmados e surtos devem ser notificados e registrados no Sistema de Informação de Agravos de Notificação (SINAN), utilizando a Ficha de Investigação das Hepatites Virais. As fichas devem ser encaminhadas ao nível hierarquicamente superior ou ao órgão responsável pela vigilância epidemiológica municipal, regional, estadual ou federal.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["7 dias", true],
            ["10 dias", false],
            ["14 dias", false],
            ["21 dias", false],
          ],
        },
        pergunta:
          "As hepatites virais são doenças de notificação compulsória regular que deve ocorrer em até:",
        titulo: "Questão 1",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eNo mesmo dia, a VE iniciou a investigação dos casos, utilizando a ficha de notificação individual do SINAN de cada um dos casos suspeitos de hepatite viral, e indicou a coleta de amostras de sangue para análise de hepatite A.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eO período de incubação é de 15 a 45, com média de 30 dias.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["30 dias", true],
            ["60 dias", false],
            ["2 dias", false],
            ["120 dias", false],
          ],
        },
        pergunta: "Qual é a média do período de incubação da hepatite A?",
        titulo: "Questão 2",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003ePrincipais características do vírus da hepatite A\u003c/h3\u003eAgente etiológico: Vírus da hepatite A (HAV)\u003c/br\u003eGenoma: RNA\u003c/br\u003eModos de Transmissão: Fecal-oral\u003c/br\u003ePeríodo de incubação: 15 a 45 dias (média de 30 dias)\u003c/br\u003ePeríodo de transmissibilidade: Duas semanas antes do início dos sintomas até o final da segunda semana da doença.\u003c/br\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eConcomitantemente, a VE também investigou a possibilidade de vínculos entre os cinco casos considerando o período de incubação a possibilidade de uma fonte em comum. Como resultado encontrou que todos tinham as residências em ruas próximas e participaram de um torneio de futebol realizado há cerca de 12 dias em um campo de futebol improvisado, que se localizava em um terreno baldio existente no bairro. Também foi identificado que dois pacientes eram irmãos e residiam com os pais.\u003c/p\u003e\u003cp\u003eApós tomar conhecimento sobre a data do referido torneio (09 de abril), a VE buscou então localizar outros participantes do torneio e identificou mais 14 indivíduos. Destes, sete apresentaram sintomas similares aos apresentados pelos casos já em investigação. \u003c/p\u003e\u003cp\u003eDurante as entrevistas, houve relatos de que após o torneio muitos dos participantes tomaram banho em um córrego existente atrás do campinho de futebol. A VE procedeu então à coleta de amostras destes novos casos encontrados e imediatamente determinou a busca ativa de casos suspeitos que tivessem sido atendidos nos serviços de saúde do município, mas não encontrou mais casos registrados nos serviços locais. No dia 29 de abril, a irmã de um dos casos sintomáticos apresentou sintomas semelhantes e foi coletada amostra para exame laboratorial.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eSe faz necessário a avaliação da qualidade da água, o que é uma atribuição da Vigilância Ambiental.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Vigilância Ambiental", true],
            ["Vigilância em Saúde do Trabalhador", false],
            ["Departamento de Doenças e Agravos Não Transmissíveis", false],
            ["Coordenação de Imunização", false],
          ],
        },
        pergunta:
          "Diante da informação de que muitos dos participantes do torneio de futebol haviam tomado banho em um córrego, a investigação da Vigilância Epidemiológica precisa contar com o apoio da:",
        titulo: "Questão 3",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eA VE solicitou avaliação da qualidade da água do córrego para a equipe da Vigilância Ambiental (VA) do município. Após inspeção, a VA constatou que o local recebia esgoto bruto oriundo de ligações irregulares de esgoto cloacal de imóveis localizados no bairro. Análises de água revelaram alta carga de coliformes fecais. Assim, a ocorrência de exposição de cada um dos casos investigados a água do córrego foi reexaminada pela VE.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA hepatite viral A é transmitida pela via fecal-oral e está relacionada às condições de saneamento básico, higiene pessoal, relação sexual desprotegida (contato boca-ânus) e qualidade da água e dos alimentos. A transmissão por via parenteral é rara, mas pode ocorrer se o doador estiver na fase de viremia do período de incubação. \u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["fecal-oral", true],
            ["sexual", false],
            ["percutânea", false],
            ["parenteral", false],
          ],
        },
        pergunta:
          "O resultado da análise da água reforça a hipótese de que a principal via de transmissão da hepatite A é:",
        titulo: "Questão 4",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eO caso confirmado de hepatite A é definido em um indivíduo com evidência laboratorial de Anti-HAV IgM reagente, a partir da suspeita clínica em indivíduo que apresente vínculo epidemiológico com caso confirmado laboratorialmente  (anti-HAV IgM reagente) de hepatite A e naquele indivíduo que evoluiu ao óbito e tenha Declaração de Óbito com indicação hepatite A ou ainda que, sem menção do diagnóstico de hepatite A na Declaração de Óbito, mas que essa patologia tenha sido confirmada por exame laboratorial durante a investigação.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["indivíduo com anti-HAV IgM reagente", true],
            [
              "indivíduo com suspeita clínica que apresente vínculo epidemiológico com caso confirmado laboratorialmente (anti-HAV IgM reagente) de hepatite A",
              true,
            ],
            [
              "indivíduo que evoluiu ao óbito com menção de hepatite A na Declaração de Óbito",
              true,
            ],
            [
              "indivíduo que evoluiu ao óbito com menção de hepatite sem etiologia especificada na Declaração de Óbito, mas que tem confirmação para hepatite A após investigação",
              true,
            ],
          ],
        },
        pergunta: "As definições de caso confirmado para hepatite A incluem:",
        titulo: "Questão 5",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eDiagnóstico da infecção pelo vírus da hepatite A.\u003c/h3\u003e\u003cp\u003eO diagnóstico da infecção pelo vírus da hepatite A é realizado por meio de imunoensaios que detectam anticorpos contra o vírus em amostras de soro. A detecção de anticorpos do tipo IgM sugere uma infecção recente. Esses testes são capazes de detectar o anti-HAV IgM entre cinco e dez dias após a infecção. A detectabilidade se mantém por um período entre quatro e seis meses após o contato com o vírus, quando os títulos destes anticorpos caem a níveis indetectáveis. Os imunoensaios para IgM anti-HAV apresentam sensibilidade de 100%, especificidade de 99% e valor preditivo positivo de 88%. Resultados falso-reagentes podem ocorrer e, portanto, o teste sorológico deve ser realizado apenas em indivíduos sintomáticos.\u003c/p\u003e\u003ch6\u003e(BRASIL, 2016)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eApós a identificação dos primeiros casos, devem-se estabelecer medidas de cuidado em relação à água de consumo, à manipulação de alimentos e às condições de higiene e de saneamento básico junto à comunidade e aos familiares. A solicitação de exames no pré-natal é aplicável como medida de controle para a transmissão das hepatites B e C.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "Lavagem e desinfecção dos alimentos consumidos crus com hipoclorito de sódio ",
              true,
            ],
            [
              "Afastamento do paciente, se necessário, de suas atividades de rotina",
              true,
            ],
            [
              "Desinfecção de objetos, bancadas e chão, com hipoclorito de sódio ou água sanitária",
              true,
            ],
            ["Uso de barreiras de látex durante o sexo oral-anal", true],
            ["Solicitação de exames no pré-natal", false],
          ],
        },
        pergunta:
          "São medidas de controle da hepatite A que devem implementadas pela VE:",
        titulo: "Questão 6",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eMedidas de controle:\u003c/h3\u003e\u003cp\u003eApós a identificação dos primeiros casos, devem-se estabelecer medidas de cuidado em relação à água de consumo, à manipulação de alimentos e às condições de higiene e de saneamento básico junto à comunidade e aos familiares.\u003c/p\u003e\u003cp\u003ePara evitar a transmissão fecal oral por relação sexual (contato boca-ânus), recomenda-se: higienização das mãos, genitália, períneo e região anal antes e após as relações sexuais, bem como higienização de vibradores, plugs anais e vaginais, além do uso de barreiras de látex durante o sexo oral-anal e luvas de látex para dedilhado ou “fisting”.\u003c/p\u003e\u003cp\u003eOrientação de instituições coletivas, como creches, pré-escolas e outras, sobre as medidas adequadas de higiene, desinfecção de objetos, bancadas e chão, utilizando-se hipoclorito de sódio a 2,5% ou água sanitária.\u003c/p\u003e\u003cp\u003eLavagem e desinfecção, com hipoclorito de sódio, dos alimentos consumidos crus.\u003c/p\u003e\u003cp\u003eAfastamento do paciente, se necessário, de suas atividades de rotina. Para os casos de hepatite A, essa situação deve ser reavaliada e prolongada em surtos, em instituições que abriguem crianças sem o controle esfincteriano (uso de fraldas), nas quais a exposição e o risco de transmissão são maiores.\u003c/p\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            '\u003cp\u003eOs dados da investigação e resultados das análises laboratoriais foram consolidados no Quadro 1. Assim, o surto de hepatite A encerrou com 13 casos confirmados por critério laboratorial. Entre estes, 12 participaram do torneio de futebol e tomaram banho no córrego.\u003c/p\u003e\u003cimg src="img/caso11_figura_2_HEPATITE.png"/\u003e\u003ch6\u003eQuadro 1. Consolidado de informações coletadas pela investigação de surto de Hepatite A.\u003c/h6\u003e\u003cp\u003eA equipe da VE enfrentou algumas \u003cb\u003ebarreiras para a realização da investigação epidemiológica\u003c/b\u003e tais como:\u003c/p\u003e\u003cul\u003e\u003cli\u003edificuldade em estabelecer o vínculo entre os casos suspeitos;\u003c/li\u003e\u003cli\u003eempecilhos ao identificar outras pessoas com sinais e sintomas semelhantes no período, através da busca ativa retrospectiva nos serviços de saúde local;\u003c/li\u003e\u003cli\u003elimitações na tentativa de coletar amostras dos casos para exames de laboratório;\u003c/li\u003e\u003cli\u003eidentificação da fonte de infecção para análise laboratorial.\u003c/li\u003e\u003c/ul\u003e',
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: [
          {
            urlExterno:
              "https://www.gov.br/aids/pt-br/centrais-de-conteudo/publicacoes/2018/2a-oficina-integrada-das-redes-nacionais-de-laboratorios-de-contagem-de-linfocitos-t-cd4-e-quantificacao-de-carga-viral-do-hiv-hbv-e-hcv-11/@@download/file/107_manual_tecnico_para_o_diagnostico_das_hepatites-12_12_18.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Vigilância, Prevenção e Controle das Infecções Sexualmente Transmissíveis, do HIV/Aids e das Hepatites Virais. \u003cb\u003eManual Técnico para o Diagnóstico das Hepatites Virais\u003c/b\u003e / Ministério da Saúde, Secretaria de Vigilância em Saúde, Departamento de Vigilância, Prevenção e Controle das Infecções Sexualmente Transmissíveis, do HIV/Aids e das Hepatites Virais. – Brasília: Ministério da Saúde, 2016. Disponível em:",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/guia_vigilancia_saude_5ed_rev_atual.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. \u003cb\u003eGuia de Vigilância em Saúde \u003c/b\u003e[recurso eletrônico] / Ministério da Saúde, Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. – 5. ed. rev. – Brasília: Ministério da Saúde, 2022. Disponível em:",
          },
        ],
        tipo: "bibliografia",
      },
    ],
    subTitulo: "",
    titulo: "Notificação de suspeita de surto de  hepatite viral",
    tsPublicacao: 1.23456789e9,
    shortname: "Notificação de suspeita de surto de  hepatite viral",
  },
  {
    _id: ObjectId("6339dc1741e46fdf39ff213c"),
    autor: ["José Rosa"],
    editores: ["Everton Fantinel", "Denise Silveira"],
    id: 9071.0,
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "41 anos",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "interdisciplinar",
    slides: [
      {
        conteudo: { texto: "", delay: "5" },
        titulo: "Introdução",
        tipo: "intro",
      },
      {
        conteudo: {
          contexto:
            '\u003cp\u003eO município em questão localiza-se na região serrana do Rio Grande do Sul e contava com cerca de 100.000 habitantes. O principal instrumento para sua investigação das doenças exantemáticas febris é uma ficha específica (Figura 1), na qual são notificados os casos com esse quadro clínico atendidos nos serviços de assistência à saúde do município (em todas as unidades básicas de saúde pública, na unidade de pronto atendimento público, no serviço de urgência hospitalar e em um serviço privado de atendimento ambulatorial).\u003c/p\u003e\u003ch6\u003eFigura 1. Ficha de investigação de doenças exantemáticas febris - sarampo/rubéola, SINAN, 2022.\u003ch6\u003e\u003ctable\u003e\u003ctr\u003e\u003ctd\u003e\u003cimg src="img/caso12_figura1_1_RUBEOLA.png"/\u003e\u003c/td\u003e\u003ctd\u003e\u003cimg src="img/caso12_figura1_2_RUBEOLA.png"/\u003e\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003cp\u003eA Vigilância Epidemiológica (VE) tem investigado todos os casos notificados de doença exantemática febril, de modo a monitorar a situação do sarampo e da rubéola no município. Além da revisão dos prontuários médicos dos pacientes, a investigação também inclui a realização de coleta de amostra de soro e envio das mesmas para o Laboratório Central do Estado (LACEN). O LACEN realiza a testagem sorológica para sarampo e rubéola e, complementarmente, para o diagnóstico de outras doenças exantemáticas, como parvovirose, dengue e, mais recentemente, a febre do zikavírus. Eventualmente, a testagem também é feita por laboratórios privados do município. Embora a testagem laboratorial seja o padrão-ouro para o diagnóstico dos casos, em algumas situações a confirmação acaba sendo realizada pelo critério clínico-epidemiológico.\u003c/p\u003e\u003cp\u003eComo rotina, em 2007, os técnicos da VE realizavam busca ativa de casos de doença exantemática notificados nos prontuários médicos do principal serviço público de urgência do município que, à época do surto, atendia cerca de 100 mil pacientes por ano. Com a finalidade de conhecer a situação vigente e intervir de forma oportuna a VE sistematicamente realizava avaliação e acompanhamento dos indicadores de qualidade da vigilância das doenças exantemáticas.\u003c/p\u003e',
        },
        titulo: "Descrição",
        tipo: "contexto",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eO acompanhamento dos indicadores proporciona a chance de conhecer adequadamente a situação vigente e de intervir oportunamente, no intuito de mudar uma situação insatisfatória existente, além de orientar os próximos passos. São oito os indicadores estabelecidos: (i) homogeneidade da cobertura vacinal; (ii) investigação epidemiológica oportuna dos casos suspeitos de sarampo e rubéola até 48 horas; (iii) coleta oportuna de amostras clínicas até 28 dias após o início do exantema; (iv) envio oportuno de amostras clínicas coletadas no município até o Laboratório Central do Estado (LACEN), em até cinco dias; (v) resultado dos exames laboratoriais liberados oportunamente pelo LACEN, em até quatro dias; (vi) casos notificados de sarampo e rubéola encerrados pelo critério laboratorial; (vii) notificação negativa de casos suspeitos de sarampo e rubéola; e (viii) investigação adequada dos casos suspeitos de sarampo e rubéola\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["taxa de investigação em até 48h", true],
            ["taxa de coleta das amostras com menos de 28 dias", true],
            ["notificação negativa semanal", true],
            [
              "completude das variáveis da ficha de investigação (investigação adequada)",
              true,
            ],
            [
              "envio das amostras para  o LACEN até cinco dias depois da coleta",
              true,
            ],
            [
              "resultados liberados até quatro dias após a entrada da amostra no LACEN",
              true,
            ],
            ["encerramento pelo critério laboratorial", true],
          ],
        },
        pergunta:
          "Assim, para avaliar a qualidade da vigilância do surto de rubéola de 2007 foram monitorados os seguintes indicadores:",
        titulo: "Questão 1",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cb\u003eIndicadores de qualidade do Sistema de Vigilância Integrada da rubéola*\u003c/b\u003e\u003ch6\u003e* Os indicadores, fórmulas e metas também se aplicam ao sarampo e à síndrome da rubéola congênita.\u003c/h6\u003e\u003cp\u003eIndicador: homogeneidade da cobertura vacinal (1)\u003c/br\u003eA homogeneidade das coberturas de vacinação, um indicador operacional, é medido pela proporção de municípios que alcançaram o índice adequado, ou seja, percentual igual ou maior que 95%. A análise do indicador homogeneidade permite a identificação de áreas com coberturas abaixo da estabelecida, mostrando uma realidade que não se explicita quando a avaliação é feita a partir de percentuais médios.\u003c/p\u003e\u003ctable class='table table-striped table-bordered table-sm table-responsive'\u003e\u003ctr\u003e\u003ctd\u003e\u003cb\u003eIndicador*\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eCálculo\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eMeta (%)\u003c/b\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e1. Homogeneidade da cobertura vacinal\u003c/td\u003e\u003ctd\u003eNº municípios com cobertura vacinal ≥ 95% em crianças com 12 meses de idade / Nº total de municípios X 100\u003c/td\u003e\u003ctd\u003e95\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003cp\u003eIndicadores: investigação oportuna (2) e investigação adequada (8)\u003c/br\u003eInvestigação oportuna e investigação adequada são indicadores que expressam a agilidade da vigilância epidemiológica em investigar um caso suspeito de sarampo ou rubéola notificado, de forma adequada e dentro das orientações preconizadas. O prazo estabelecido para a realização da investigação é de até 48 horas após a notificação do caso suspeito. A investigação é a base para que todas as ações sejam desencadeadas com o objetivo de romper a cadeia de transmissão, tais como: (i) o bloqueio para vacinação dos contatos do caso suspeito, de forma seletiva, a partir da avaliação da situação vacinal com verificação da caderneta no tocante ao registro da vacina tríplice viral; e (ii) a identificação de novos casos suspeitos que possam gerar novas cadeias de transmissão.\u003c/p\u003e\u003ctable class='table table-striped table-bordered table-sm table-responsive'\u003e\u003ctr\u003e\u003ctd\u003e\u003cb\u003eIndicador*\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eCálculo\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eMeta (%)\u003c/b\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e2. Investigação oportuna\u003c/td\u003e\u003ctd\u003eNº casos notificados investigados em até 48 horas / Total de casos notificados X 100\u003c/td\u003e\u003ctd\u003e80\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e8. Investigação adequada\u003c/td\u003e\u003ctd\u003e% de casos suspeitos com visita domiciliar até 48 horas após a notificação, com, pelo menos, 8 variáveis preenchidas\u003c/td\u003e\u003ctd\u003e80\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003cp\u003eIndicador: coleta oportuna (3)\u003c/br\u003ePara avaliar o indicador coleta de espécimes em tempo oportuno é necessário ter em conta que duas datas devem ser consideradas na fórmula de cálculo: (i) a data do início do exantema, variável de preenchimento obrigatório no SINAN; e (ii) a data da coleta de sangue, uma variável considerada essencial para o sistema de vigilância do sarampo e da rubéola.\u003c/p\u003e\u003ctable class='table table-striped table-bordered table-sm table-responsive'\u003e\u003ctr\u003e\u003ctd\u003e\u003cb\u003eIndicador*\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eCálculo\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eMeta (%)\u003c/b\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e3. Coleta oportuna\u003c/td\u003e\u003ctd\u003eNº casos notificados com amostras coletadas oportunamente (*) / Total casos notificados X 100\u003c/td\u003e\u003ctd\u003e80\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003cp\u003eIndicador: notificação negativa (7)\u003cbr/\u003eO indicador notificação negativa está estreitamente relacionado à responsabilidade das unidades de saúde em notificar semanalmente a não ocorrência de casos suspeitos de sarampo e rubéola. Essa notificação é feita mediante registro e encaminhamento, pelas unidades notificadoras, do Boletim de Notificação Semanal (BNS). As informações são consolidadas na esfera estadual e enviadas ao Ministério da Saúde para consolidação nacional, avaliação e informação à OPAS.\u003c/p\u003e\u003ctable class='table table-striped table-bordered table-sm table-responsive'\u003e\u003ctr\u003e\u003ctd\u003e\u003cb\u003eIndicador*\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eCálculo\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eMeta (%)\u003c/b\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e7. Notificação negativa\u003c/td\u003e\u003ctd\u003eNº municípios com notificação negativa oportuna / Total municípios notificantes X 100\u003c/td\u003e\u003ctd\u003e80\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003cp\u003eIndicadores: envio oportuno (4), resultado oportuno (5) e casos encerrados pelo critério laboratorial (6)\u003c/br\u003eComo a amostra deve chegar ao LACEN até cinco dias depois da coleta, os dados registrados apontam para a fragilidade da gestão da vigilância, em especial quanto à dificuldade no encaminhamento da amostra, muito embora se reconheça que a demora no envio das amostras não inviabiliza, por exemplo, a adoção das medidas de controle e prevenção, vez que são realizadas no momento da suspeita do caso. Já a qualidade da amostra pode ficar comprometida caso haja demora até sua chegada ao LACEN.\u003c/p\u003e\u003ctable class='table table-striped table-bordered table-sm table-responsive'\u003e\u003ctr\u003e\u003ctd\u003e\u003cb\u003eIndicador*\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eCálculo\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eMeta (%)\u003c/b\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e4. Envio oportuno\u003c/td\u003e\u003ctd\u003eNº amostras de sangue com envio oportuno (**) / Nº total de amostras recebidas no mesmo período X 100\u003c/td\u003e\u003ctd\u003e80\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e5. Resultado oportuno\u003c/td\u003e\u003ctd\u003eNº amostras com resultado oportuno (***) / Nº amostras recebidas no mesmo período X 100\u003c/td\u003e\u003ctd\u003e80\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e6. Casos encerrados por laboratório\u003c/td\u003e\u003ctd\u003eNº casos descartados ou confirmados por laboratório/ Nº total de casos encerrados por laboratório X 100\u003c/td\u003e\u003ctd\u003e100\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003cp\u003e\u003cb\u003eIndicadores de completude das variáveis da ficha de investigação (investigação adequada):\u003c/b\u003e\u003c/br\u003e3 - Data da Notificação\u003c/br\u003e31 - Data da Investigação\u003c/br\u003e34 - Data da Última Dose\u003c/br\u003e38 - Data de Início dos Sintomas\u003c/br\u003e46 - Data da Coleta da 1ª Amostra (S1)\u003c/br\u003e51 - Realizou Bloqueio Vacinal\u003c/br\u003e56 - Classificação final do caso descartado\u003c/br\u003e 57 - Local Provável da Fonte de Infecção (no período de 7 a 18 dias para sarampo e 12 a 23 dias para rubéola)\u003c/br\u003eOs campos listados acima apresentam as variáveis utilizadas para a avaliação da qualidade da investigação dos casos de doença exantemática febril:\u003c/p\u003e\u003ch6\u003e(BRASIL, 2010)\u003c/h6\u003e\u003cp\u003eNo município de Verdes-Altos, onde ocorreu o surto de rubéola em 2007 a taxa de investigação oportuna teve resultado em 96,5%, a taxa de coleta das amostras com menos de 28 dias foi de 95,8% dos casos investigados e a notificação negativa foi realizada semanalmente. A Investigação adequada baseava-se na qualidade de preenchimento e na completude de nove variáveis da ficha de investigação epidemiológica: (1) data de notificação; (2) data da investigação; (3) fonte de infecção; (4) data da vacina; (5) data do início do exantema; (6) outros sinais e sintomas; (7) data da 1ª coleta de sangue; (8) realização de bloqueio vacinal; e (9) classificação final. Todas as fichas digitadas no SINAN do município tinham essas nove variáveis devidamente preenchidas. Quanto ao envio oportuno das amostras ( Envio das amostras para  o LACEN até cinco dias depois da coleta), a grande maioria dos casos investigados no município tinha, ao menos, uma amostra de soro coletada e encaminhada ao LACEN no prazo estipulado. As exceções foram os casos encerrados por critério clínico-epidemiológico (três casos) e aqueles testados em laboratórios privados. Quanto ao resultado oportuno (resultados liberados até quatro dias após a entrada da amostra no LACEN), nenhum dos casos confirmados como sarampo ou rubéola no município teve seu laudo liberado pelo LACEN em quatro dias. O prazo para a liberação destes laudos variou de 13 a 176 dias.\u003c/p\u003e\u003cp\u003eO primeiro caso de rubéola no município de Verdes-Altos foi detectado no mês de setembro de 2007, cerca de 4 meses após a detecção do surto estadual. Era um homem de 23 anos com sintomas iniciados no dia 25/09 (semana epidemiológica 38), sem registro de vacinação contra a rubéola e sem histórico de viagem. Ele havia procurado atendimento em uma unidade de saúde da atenção primária no dia 28/09, ocasião em que foi notificado para a VE (por telefone). Estava apresentando quadro de febre, exantema, gânglios retroauriculares aumentados, conjuntivite, artralgia e tosse.\u003c/p\u003e\u003ch6\u003eFigura 2. Número de casos de doença exantemática febril e de rubéola por semana epidemiológica, Verdes-Altos, 2007.\u003c/h6\u003e\u003cimg src=\"img/caso12_figura_2_RUBEOLA.png\"/\u003e\u003ch6\u003eObs.: Os casos de doença exantemática não incluem os casos de rubéola.\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eApesar do paciente relatar outros sintomas, a definição de caso suspeito de rubéola requer a presença de febre e exantema maculopapular, acompanhado de linfoadenopatia retroauricular e/ou occipital e/ou cervical, independentemente da idade e da situação vacinal.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Febre", true],
            ["Exantema maculopapular", true],
            [
              "Linfadenopatia retroauricular e/ou occipital e/ou cervical",
              true,
            ],
            ["Artralgia", false],
            ["Todos os sinais e sintomas apresentados", false],
          ],
        },
        pergunta:
          "Quais sinais e sintomas do caso-índice fazem parte da definição de caso suspeito de rubéola?",
        titulo: "Questão 2",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eRubéola\u003c/h3\u003e\u003cp\u003eA rubéola é uma doença exantemática aguda imunoprevenível de etiologia viral. Ela apresenta alta transmissibilidade e tem sua importância epidemiológica relacionada à síndrome da rubéola congênita (SRC).\u003c/p\u003e\u003cp\u003eA rubéola caracteriza-se por apresentar discreto exantema róseo, maculopapular e puntiforme difuso, com distribuição crânio-caudal, ou seja, se inicia na face, no couro cabeludo e no pescoço, espalhando-se, posteriormente, para todo corpo. O exantema apresenta máxima intensidade no segundo dia e desaparece até o sexto dia, durando em média de 5 a 10 dias, coincidindo, geralmente, com o início da febre, que é baixa. Observa-se linfadenopatia, principalmente retroauricular, cervical e occipital, que aparecem cinco a 10 dias antes do exantema. Esses sinais colaboram para o diagnóstico diferencial frente a outras doenças exantemáticas.\u003c/p\u003e\u003cp\u003ePara o diagnóstico diferencial é importante considerar que na rubéola não há descamação e que o período prodrômico, de maneira geral, não é observado na criança. Adolescentes e adultos podem apresentar um período prodrômico com febre baixa, cefaleia, dores generalizadas (artralgias e mialgias), conjuntivite, coriza e tosse. Cerca de 25% a 50% das infecções pelo vírus da rubéola são subclínicas, ou seja, infecções que se desenvolvem sem apresentar sinais e sintomas clínicos característicos da doença.\u003c/p\u003e\u003cp\u003eO diagnóstico laboratorial é realizado por meio de sorologia para detecção de anticorpos IgM específicos, soroconversão ou aumento na titulação de anticorpos IgG. O vírus também pode ser identificado pela técnica de reação em cadeia da polimerase precedida de transcrição reversa (RT-PCR), em amostras de orofaringe, nasofaringe, urina, líquor ou em tecidos do corpo (óbito).\u003c/p\u003e\u003cp\u003eÉ importante ressaltar que resultados não reagentes para IgM não descartam a possibilidade de infecção recente pelo vírus da rubéola.\u003c/p\u003e\u003cp\u003eA infecção na gravidez acarreta inúmeras complicações. Se ela ocorrer durante o primeiro trimestre de gestação, há um risco de até 90% de aborto, natimorto ou de malformações congênitas, que incluem surdez, cegueira, malformações cardíacas e retardo mental.\u003c/p\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eDe acordo com a compilação dos dados sobre o perfil dos doentes de Verdes-Altos, os casos de rubéola se caracterizaram por ser população predominantemente masculina (91,3%), na faixa etária dos 20 a 29 anos de idade (73,9%). A conjuntivite (65,2%), artralgia (73,9%) e o aumento dos gânglios retroauriculares (65,2%) foram os sinais e sintomas prevalentes entre os doentes. Todos apresentaram exantema e febre. Não houve a ocorrência de hospitalizações e de mortes associadas à rubéola, e nenhum caso de rubéola em gestantes foi detectado, durante o surto municipal.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA confirmação por critério laboratorial necessita resultados reagentes para os anticorpos específicos IgM e IgG na primeira e segunda amostra. O vínculo epidemiológico depende do contato com pelo menos um caso de rubéola confirmado por critério laboratorial. Já a confirmação por critério clínico só é aceitável em surtos de grande magnitude, não sendo recomendada como rotina. A associação temporal com a vacinação é requisito para confirmação de caso de rubéola, mas para qualificá-lo como caso descartado.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "Com o exame da sorologia de anticorpos IgM e IgG contra rubéola",
              true,
            ],
            ["Pelo vínculo epidemiológico com outros casos confirmados", false],
            [
              "Pelo critério clínico, já que todos os sinais e sintomas necessários estão presentes",
              false,
            ],
            ["Pela associação temporal com a vacinação ", false],
          ],
        },
        pergunta: "Como é possível fazer a confirmação deste caso suspeito?",
        titulo: "Questão 3",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eDefinição de Caso Confirmado\u003c/h3\u003e\u003cp\u003e\u003cul\u003e\u003cli\u003eCritério laboratorial: quando o paciente apresenta resultados de exame de sorologia de anticorpos específicos IgM e IgG reagente na primeira e segunda amostra, ou quando apresenta IgM reagente com soroconversão de IgG na segunda amostra.\u003c/li\u003e\u003cli\u003eVínculo epidemiológico: quando o caso suspeito teve contato com um ou mais casos de rubéola, confirmados por laboratório, e apresentou os primeiros sintomas da doença entre 12 e 23 dias após o contato com o(s) caso(s).\u003c/li\u003e\u003cli\u003eCritério clínico: caso suspeito que apresente febre e exantema maculopapular, acompanhado de linfadenopatia retroauricular e/ou occipital e/ou cervical, independentemente da idade e da situação vacinal. A confirmação do caso suspeito pelo critério clínico não é recomendada na rotina; contudo, em situações de surto de grande magnitude, esse critério poderá ser utilizado.\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e\u003ch3\u003eDefinição de Caso Descartado\u003c/h3\u003e\u003cp\u003e\u003cul\u003e\u003cli\u003eCritério laboratorial: quando, na pesquisa de anticorpos específicos IgM e IgG, os resultados são não reagentes, ou quando IgM não reagente e IgG reagente.\u003c/li\u003e\u003cli\u003eVínculo epidemiológico: quando o caso tiver como fonte de infecção um ou mais casos descartados pelo critério laboratorial ou quando, na localidade, estiverem ocorrendo outros casos, surtos ou epidemia de outra doença exantemática febril, confirmada por diagnóstico laboratorial.\u003c/li\u003e\u003cli\u003eCritério clínico: considera-se como descartado caso suspeito cuja avaliação clínica e epidemiológica detectou sinais e sintomas compatíveis com outro diagnóstico diferente da rubéola. O descarte do caso suspeito pelo critério clínico não é recomendado na rotina; contudo, em situações de surto de grande magnitude, esse critério poderá ser utilizado.\u003c/li\u003e\u003cli\u003eCom associação temporal à vacina: quando a avaliação clínica e epidemiológica indicar associação temporal entre a data do início dos sintomas e a data do recebimento da última dose da vacina, mesmo que não tenha sido realizada coleta de amostra. Os critérios para descarte, como associação temporal à vacina contendo o componente rubéola, são os seguintes:\u003cul\u003e\u003cli\u003efebre com temperatura que pode chegar a 39,5°C ou mais, com início entre o 5º e o 12º dia após a vacinação e duração de um a dois dias, podendo chegar a até cinco dias;249 Rubéola\u003c/li\u003e\u003cli\u003eexantema que dura de um a dois dias, sendo geralmente benigno, e que surge entre o 7º e o 14º dia após a administração da vacina;\u003c/li\u003e\u003cli\u003ecefaleia ocasional, irritabilidade, conjuntivite ou manifestações catarrais observadas entre o 5º e o 12º dia após a vacinação;\u003c/li\u003e\u003cli\u003elinfadenopatias que se instalam entre o 7º e o 21º dia após a data de vacinação.\u003c/li\u003e\u003c/ul\u003e\u003c/li\u003e\u003c/ul\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eA primeira coleta de sorologia para rubéola foi realizada no dia 01/10, encaminhada para o LACEN e agendada a segunda coleta. O laudo da primeira sorologia foi reagente e foi recebido pela VE municipal no dia 18/10.\u003c/p\u003e\u003cp\u003eO caso-índice informou que não sabia se tinha entrado em contato com outra pessoa com sintomas de rubéola, e que não havia ninguém doente na sua residência. Entretanto, ele era estudante de uma universidade do município, onde fazia curso de Administração no turno da noite. Por essa razão, não se podia descartar a hipótese dele ter entrado em contato com uma pessoa doente no ambiente universitário.\u003c/p\u003e\u003cp\u003eDiante desta situação, a VE decidiu iniciar a vacinação de bloqueio contra  o sarampo e a rubéola (vacina dupla viral) para os estudantes da universidade, priorizando os colegas de sala de aula do caso-índice.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cP\u003eUma das ações para tentar reduzir a circulação viral da rubéola é o chamado bloqueio vacinal que consiste na vacinação seletiva dos contatos dos casos suspeitos ou confirmados de rubéola. Ele deve ser operacionalizado até 72 horas após a identificação do caso suspeito ou confirmado, uma vez que esse é o período máximo em que é possível interromper a cadeia de transmissão da doença e evitar a ocorrência de casos secundários. A vacinação seletiva dos contatos de caso suspeito ou confirmado de rubéola, deve ser aplicada a partir dos 6 meses de idade, exceto gestantes e pessoas com sinais e sintomas de rubéola. As pessoas a partir dos 6 meses de idade deverão ter a situação vacinal avaliada e atualizada, conforme situação vacinal encontrada: não vacinada, vacinada com esquema incompleto, vacinada com esquema completo. As pessoas imunocomprometidas ou portadoras de condições clínicas especiais deverão ser avaliadas nos Centros de Referência para Imunobiológicos Especiais (Crie) antes da vacinação.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "os contatos a partir de 6 meses de idade, exceto gestantes e pessoas com sinais e sintomas de rubéola.",
              true,
            ],
            [
              "as pessoas a partir dos 6 meses de idade conforme situação vacinal encontrada.",
              true,
            ],
            [
              "as pessoas imunocomprometidas ou portadoras de condições clínicas especiais.",
              true,
            ],
            [
              "apenas os estudantes da sala de aula, na faixa etária do caso-índice",
              false,
            ],
          ],
        },
        pergunta:
          "A população–alvo da vacinação de bloqueio na universidade deve incluir:",
        titulo: "Questão 4",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003ePara a vacinação de bloqueio na universidade, a Secretaria da Saúde disponibilizou sua Unidade Móvel de Vacina com uma equipe de vacinadores no campus durante três dias seguidos. Nesse período, foi possível vacinar 353 pessoas (alunos e funcionários).Além disso, para reduzir o número de casos de rubéola em Verdes-Altos, foram estabelecidas as seguintes medidas:\u003c/p\u003e\u003cul\u003e\u003cli\u003eFornecimento de vacinas contra a rubéola para o hospital local destinadas à imunização dos profissionais suscetíveis (principalmente equipes de saúde do pronto atendimento e serviços de diagnóstico);\u003c/li\u003e\u003cli\u003eVacinação dos profissionais de saúde da Secretaria da Saúde, com ênfase naqueles que atuavam nas Unidade Básica de Saúde, pronto atendimento e laboratório público municipal;\u003c/li\u003e\u003cli\u003eVisitação de empresas e vacinação com tríplice viral/dupla viral dos trabalhadores da indústria, comércio e serviços;\u003c/li\u003e\u003cli\u003eVacinação dos profissionais de turismo, hotelaria, taxistas, empresas de transporte e exportação, viajantes para áreas de risco e motoristas de caminhão;\u003c/li\u003e\u003cli\u003ebloqueio vacinal com  tríplice viral/dupla viral em empresas, escolas e residências, quando da ocorrência de casos suspeitos de sarampo ou rubéola.\u003c/li\u003e\u003c/ul\u003e\u003cp\u003eAssim, em Verdes-Altos durante o surto de 2007, foram aplicadas 2.119 doses de vacina dupla viral em ações de bloqueio vacinal em 29 locais (empresas, escolas, faculdades, serviços de saúde, restaurantes, hotéis, etc.). A grande maioria dos vacinados era do sexo masculino (67,7%). Para cada caso suspeito ou confirmado do município foram aplicadas cerca de 92 doses da vacina contra a rubéola. O extensivo esforço de vacinação mobilizou as equipes da Vigilância Epidemiológica e da Atenção Básica para a vacinação extramuros de milhares de contatos em escolas, empresas e domicílios. Além disso, foram reforçadas as medidas para a orientação e vacinação dos profissionais com mais probabilidade de exposição a essas doenças, principalmente os das áreas de saúde, turismo, transporte e hotelaria.\u003c/p\u003e\u003cp\u003eLogo após a confirmação do caso-índice, outros dois casos de rubéola foram registrados no município. Eram dois irmãos, residentes na mesma casa, com 22 e 24 anos, respectivamente, sem histórico de vacinação e de viagem. Eles não sabiam se tinham entrado em contato com alguma pessoa doente, no período anterior ao surgimento dos seus sintomas. Assim, de acordo com a definição de surto de rubéola vigente em 2007, isto é, dois casos ou mais da doença, o município de Verdes-Altos também passou a ser considerado área de circulação viral e de surto.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eDevido à eliminação da circulação do vírus da rubéola no País, a partir de 2009, um caso confirmado de rubéola é considerado um surto, independentemente da localidade ou do período de sua ocorrência.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["1", true],
            ["2", false],
            ["3", false],
            ["4", false],
          ],
        },
        pergunta:
          "Para caracterizar um surto de rubéola, atualmente é (são) necessário(s) quanto(s) caso(s)?",
        titulo: "Questão 5",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA taxa de ataque é a incidência de casos, obtida a partir da divisão do número de casos pela população exposta. Ela é utilizada em substituição ao coeficiente de incidência quando se trata de surtos de pequenas dimensões em que as populações de expostos são pequenas. taxas de ataque específicas de acordo com exposições diferentes, por exemplo, taxa de ataque entre os que comeram um determinado alimento e os que não comeram, entre vacinados e não vacinados, entre outros. A diferença significativa entre os dois grupos reforça a hipótese de que a exposição determinou ou potencializou a epidemia/surto.\u003c/p\u003e\u003cp\u003eIncidência: é a medida do número de casos novos, chamados casos incidentes, de uma doença, originados de uma população em risco de sofrê-la, durante um período de tempo determinado A incidência é um indicador da velocidade de ocorrência de uma doença ou outro evento de saúde na população e, consequentemente, é um estimador do risco absoluto de vir a padecer da mesma\u003c/p\u003e\u003cimg src='img/caso12_figura_4_RUBEOLA.png'/\u003e\u003cp\u003eÉ necessário destacar que as fórmulas sobre incidência que acabamos de apresentar nesse exemplo correspondem especificamente ao que se denomina incidência acumulada.\u003c/p\u003e\u003cp\u003eCalculando-se como o quociente entre o número de casos novos e o tamanho da população em risco em um período de tempo, a incidência acumulada assume que todos os indivíduos da população em risco estiveram efetivamente em risco de apresentar a doença durante todo o período de tempo observado. Intuitivamente, sabemos que isso raramente acontece, a princípio porque no momento que apresenta a doença, a pessoa deixa de estar em risco (por exemplo, deixa de “pertencer ao denominador”), pois passa a ser um caso (por exemplo, “passa ao numerador”).\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["2,29; 3,26; 10,6", true],
            ["0,43; 0,42; 0,09", false],
            ["3,63; 26,7; 36,1", false],
            ["4,61; 25,15; 21,75", false],
          ],
        },
        pergunta:
          'Utilizando os dados do quadro abaixo, calcule o risco relativo (RR) de adoecer por rubéola entre os sexos no ano de 2007, para o Brasil, para o Rio Grande do Sul e para Verdes-Altos.\u003cp\u003e\u003ctable class=\'table table-bordered table-sm table-responsive text-center\'\u003e\u003ctr\u003e\u003ctd\u003e\u003cb\u003eLocal\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eSexo\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eNº Casos\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eIncidência por 100.000 habitantes\u003c/b\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd rowspan="2"\u003eBrasil\u003c/td\u003e\u003ctd\u003eMasculino\u003c/td\u003e\u003ctd\u003e6.051\u003c/td\u003e\u003ctd\u003e6,43\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eFeminino\u003c/td\u003e\u003ctd\u003e2.688\u003c/td\u003e\u003ctd\u003e2,80\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd rowspan="2"\u003eRio Grande do Sul\u003c/td\u003e\u003ctd\u003eMasculino\u003c/td\u003e\u003ctd\u003e2.088\u003c/td\u003e\u003ctd\u003e38,5\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eFeminino\u003c/td\u003e\u003ctd\u003e665\u003c/td\u003e\u003ctd\u003e11,8\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd rowspan="2"\u003eVerdes-Altos\u003c/td\u003e\u003ctd\u003eMasculino\u003c/td\u003e\u003ctd\u003e21\u003c/td\u003e\u003ctd\u003e39,8\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eFeminino\u003c/td\u003e\u003ctd\u003e2\u003c/td\u003e\u003ctd\u003e3,7\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003c/p\u003eO risco relativo de adoecer por rubéola dos homens em relação às mulheres referente ao Brasil, Rio Grande do Sul e Verdes-Altos, respectivamente, é:',
        titulo: "Questão 6",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eA equipe da VE enfrentou algumas \u003cb\u003ebarreiras para a realização da investigação epidemiológica \u003c/b\u003etais como:\u003cul\u003e\u003cli\u003eA falta de notificação oportuna das doenças exantemáticas à Vigilância Epidemiológica dos municípios é um obstáculo para a identificação precoce de casos de sarampo e de rubéola, tornando possível prevenir a ocorrência de surtos dessas doenças. Isso se deve, em parte, ao fato da grande maioria dos profissionais que atendem os doentes em serviços de saúde (seja nas emergências ou nas unidades da atenção primária) desconhecer a necessidade de notificar os casos, bem como, não perceber os potenciais danos que estas doenças podem causar aos doentes e seus contatos (imunodeprimidos, bebês, gestantes, por exemplo) e de não reconhecer os eventuais riscos de surtos e suas consequências para a Saúde Pública. Por não reconhecerem esses riscos, os profissionais não orientam os doentes sobre o isolamento e o afastamento das suas atividades sociais e laborais, fazendo com que entrem em contato com outras pessoas e colocando-as em risco de serem infectadas. Do mesmo modo, os profissionais não costumam verificar se os doentes mantêm contato com pessoas suscetíveis ao sarampo e à rubéola (família, ambiente de trabalho, escola, etc.), razão pela qual também não se imbuem de orientar quanto a necessidade de se vacinarem contra estas doenças.\u003c/li\u003e\u003cli\u003eAs campanhas de vacinação contra o sarampo e a rubéola até a data da ocorrência deste surto não se destinavam à população masculina adulta, acabou criando um grupo significativo de suscetíveis que culminou no surto de rubéola descrito nesta investigação.\u003c/li\u003e\u003cli\u003eNeste aspecto, para tentar conter o surto no município foi necessário realizar a vacinação de bloqueio contra o sarampo e a rubéola em diferentes locais e por um longo período.\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: [
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/guia_vigilancia_saude_5ed_rev_atual.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. \u003cb\u003eGuia de Vigilância em Saúde\u003c/b\u003e [recurso eletrônico] / Ministério da Saúde, Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. – 5. ed. rev. – Brasília: Ministério da Saúde, 2022. Disponível em:",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/relatorio_verificacao_criterios_eliminacao_sarampo.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Vigilância Epidemiológica. \u003cb\u003eRelatório da verificação dos critérios de eliminação da transmissão dos vírus endêmicos do sarampo e rubéola e da síndrome da rubéola congênita (SRC) no Brasil.\u003c/b\u003e Brasília: Ministério da Saúde, 2010. Disponível",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/modulo_principios_epidemiologia_3.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "Organização Pan-Americana da Saúde. \u003cb\u003eMódulos de Princípios de Epidemiologia para o Controle de Enfermidades.\u003c/b\u003e Módulo 3: medida das condições de saúde e doença na população / Organização Pan-Americana da Saúde. Brasília: Organização Pan-Americana da Saúde; Ministério da Saúde, 2010. Disponível em:",
          },
        ],
        tipo: "bibliografia",
      },
    ],
    subTitulo: "",
    titulo: "Sistema de vigilância da rubéola",
    tsPublicacao: 1.23456789e9,
    shortname: "Sistema de vigilância da rubéola",
  },
  {
    _id: ObjectId("633ad71f41e46f8f531c95d1"),
    autor: ["Dóris Schuch", "Marcínia Bueno"],
    editores: ["Everton Fantinel", "Denise Silveira"],
    id: 9072.0,
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "41 anos",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "interdisciplinar",
    slides: [
      {
        conteudo: { texto: "", delay: "5" },
        titulo: "Introdução",
        tipo: "intro",
      },
      {
        conteudo: {
          descricaoCaso:
            "\u003cp\u003eA Vigilância Epidemiológica do município de Vista Alegre recebeu no final da manhã do dia 14 de abril de 2022 a notificação oriunda da Unidade de Saúde do bairro Estrela que informava o atendimento naquela semana de três pessoas, da mesma residência, que apresentaram sintomas de diarreia, cefaleia e dor abdominal. As pessoas acometidas seriam pai e filha e uma diarista que presta serviços duas vezes por semana para a família.\u003c/p\u003e\u003cp\u003eA Vigilância Epidemiológica (VE) iniciou a organização para a investigação no dia seguinte à notificação, ao mesmo tempo que comunicou a ocorrência de suspeita de surto de Doença de Transmissão Hídrica e Alimentar (DTHA) para a Vigilância Sanitária e a Vigilância Ambiental em Saúde, compondo assim uma equipe de investigação do evento. \u003c/p\u003e",
        },
        titulo: "Descrição do Caso",
        tipo: "descricaoCaso",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eSurto de DTHA é o evento em que duas ou mais pessoas apresentam sinais e sintomas semelhantes após ingerirem alimentos e/ou água da mesma origem exceto para botulismo e cólera, em que a identificação de apenas um caso já configura um surto. As DTHA são uma síndrome geralmente constituída por sinais e sintomas gastrointestinais, porém afecções extra intestinais também podem ocorrer em diferentes órgãos, como rins, fígado, sistema nervoso central, entre outros. Muitas vezes a etiologia da doença é difícil de ser estabelecida, pois os surtos comumente são produzidos por vários agentes etiológicos e se expressam por variadas manifestações clínicas. Por esse motivo, não há definições de caso preestabelecidas, com exceção das doenças que constam na Lista de Notificação Compulsória, cujos casos devem ser notificados individualmente. A investigação deverá ser realizada pelas vigilâncias epidemiológica, sanitária, ambiental, laboratorial, atenção à saúde, com a participação, sempre que possível e necessário, de profissionais de outros setores da agricultura, pecuária e abastecimento.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "surto de DTHA é o evento em que duas ou mais pessoas apresentam sinais e sintomas semelhantes após ingerirem alimentos e/ou água da mesma origem",
              true,
            ],
            [
              "a etiologia da doença é difícil de ser estabelecida, mas os surtos comumente são produzidos por poucos tipos de agentes etiológicos",
              false,
            ],
            [
              "as DTHA são uma síndrome geralmente constituída apenas por sinais e sintomas gastrointestinais",
              false,
            ],
            [
              "a investigação do surto é de responsabilidade apenas da Vigilância Epidemiológica",
              false,
            ],
          ],
        },
        pergunta: "Sobre as DTHA está correto afirmar:",
        titulo: "Questão 1",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eNotificação e investigação\u003c/h3\u003e\u003cp\u003eA vigilância de surtos de doenças de transmissão hídrica e alimentar (DTHA) foi implantada no País em 1999 e está regulamentada pela Portaria de Consolidação GM/MS n.º 4, de 28 de setembro de 2017. Dessa forma, a ocorrência de surtos de DTHA considerados “Eventos de Saúde Pública que constituem ameaça à saúde pública” deve ser comunicada imediatamente à vigilância epidemiológica dos três níveis de gestão da saúde, pelo meio mais rápido, e, além disso, deve ser notificada e registrada no Sinan em até sete dias.\u003c/p\u003e\u003cp\u003eA investigação deverá ser realizada pelas vigilâncias epidemiológica, sanitária, ambiental, laboratorial, atenção à saúde, com a participação, sempre que possível e necessário, de profissionais de outros setores da agricultura, pecuária e abastecimento.\u003c/p\u003e\u003cp\u003eA ocorrência de surto causado por doenças que constem na Lista de Doenças de Notificação Compulsória (exemplos: cólera, botulismo, febre tifoide, rotavírus, toxoplasmose adquirida na gestação ou congênita), além do preenchimento da Ficha de Investigação de Surto – DTA, deverá ser investigada e registrada no Sinan – na ficha de investigação individual específica da doença ou, quando não houver, na ficha individual de notificação/conclusão, conforme preconizado no “Módulo 3 – Notificação e investigação de casos e surtos de DTHA”.\u003c/p\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eCom a fonte notificadora a VE resgatou as respectivas datas e horários de início dos sintomas de cada uma das três pessoas:\u003c/br\u003e• M.F (filha de J.F. e moradora na mesma casa): início dos sintomas no dia 11 de abril às 16:30 horas. Pai e filha haviam comparecido para consulta na unidade de saúde na manhã do dia 12 de abril.\u003c/br\u003e• J.F. (morador): início dos sintomas no dia 11 de abril às 17 horas.\u003c/br\u003e• D.S. (funcionária diarista da família): início dos sintomas na madrugada do dia 12 de abril (por volta das 6 horas) e compareceu na unidade de saúde às 12 horas.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA suspeita de uma fonte comum pode surgir de: a)  Notificação por parte de um ou mais médicos ou qualquer outro profissional de saúde da ocorrência inusitada e recente de “alguns” ou “vários” casos de uma doença, possivelmente a mesma, entre os quais provavelmente exista alguma relação; b) Descoberta de uma relação aparente entre casos em termos de sexo, idade, lugar de residência ou trabalho, sobrenomes, data de início, etc. após a revisão e análise dos relatórios de notificação ou morbidade. A data de início de uma doença costuma constituir um dado muito útil para identificar a fonte comum de um surto; c) Presença de conglomerados espaciais, ou seja, o agrupamento inusitado de casos em um espaço territorial muito circunscrito, ao mapear sistematicamente os dados da notificação de casos; d) Rumores gerados na comunidade, em particular sobre a possível presença de uma doença após a celebração de um determinado evento social (festas, reuniões cívicas, comemorações religiosas, velórios, enterros, etc.). Os demais tipos de fonte apresentados na resposta não existem.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Fonte comum", true],
            ["Fonte específica", false],
            ["Fonte independente", false],
            ["Fonte colateral", false],
          ],
        },
        pergunta:
          "Com as informações sobre as datas e horários de início dos sintomas, a equipe de VE foi até a residência da família na manhã do dia 15 de abril com uma hipótese sobre a fonte de contaminação do surto. Qual seria esta hipótese?",
        titulo: "Questão 2",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eHipótese\u003c/h3\u003e\u003cp\u003eO levantamento de hipóteses que expliquem exposições específicas que podem ter causado a doença, testando-as por meio da aplicação de métodos estatísticos apropriados, é um passo importante para confirmar ou descartar as hipóteses levantadas. A investigação de campo, representa uma excelente oportunidade para compreender o surto e ter uma percepção geral da fonte e do modo de transmissão mais prováveis. Entretanto, a exposição que causa a doença deve ser determinada e, devido aos desafios desta fase, os epidemiologistas de campo devem revisar os dados cuidadosamente, avaliar os dados clínicos, laboratoriais e epidemiológicos característicos da doença e levantar possíveis exposições plausíveis de causar a doença. Em outras palavras, deve-se estar muito atento à história de exposições do paciente.\u003c/p\u003e\u003cp\u003eNeste sentido, as entrevistas realizadas durante a busca ativa se diferenciam das entrevistas iniciais, realizadas com os primeiros casos notificados, e entrevistas durante a busca ativa de casos.\u003cbr/\u003eVeja a seguir as principais diferenças:\u003c/p\u003e\u003cul\u003e\u003cli\u003eEntrevistas iniciais: são amplas e abertas. Normalmente, não se utiliza formulário estruturado. São direcionadas aos expostos, têm como objetivo coletar o máximo de dados sobre os casos, permitindo relacioná-los no tempo e no espaço, formulando hipóteses a respeito das fontes de contaminação e de transmissão, além de auxiliar na elaboração da definição de caso.\u003c/li\u003e\u003cli\u003eEntrevistas durante a busca ativa de casos: são objetivas, utilizam formulários com questões estruturadas (a fim de facilitar a precisão da resposta e a tabulação dos dados); são direcionadas aos casos captados (geralmente, uma amostragem), têm como objetivo coletar informações adicionais dos casos suspeitos (ou que atendam a alguma das definições de caso).\u003c/li\u003e\u003c/ul\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eA VE constatou que residiam no endereço três pessoas: o Sr. J.F. (50 anos, comerciante), sua esposa A.F (46 anos, dona de casa) e a filha do casal M.F. (20 anos, estudante). A família confirmou data e horário de início dos sintomas do pai e da filha e informaram uma refeição comum naquele dia, que seria o almoço confeccionado pela Sra A.F.. Além deles, a diarista da família Sra. D.S. (35 anos), também havia almoçado na residência no dia 11 de abril. No momento da investigação, decorridos quatro dias do início dos sintomas, nenhum dos acometidos ainda apresentava o sintoma de diarreia, o que impossibilitou coleta de amostras de fezes para análise laboratorial. O cardápio da refeição suspeita consistia em:\u003c/p\u003e\u003cul\u003e\u003cli\u003eArroz\u003c/li\u003e\u003cli\u003eFeijão preto com bacon\u003c/li\u003e\u003cli\u003eCouve refogada\u003c/li\u003e\u003cli\u003eOvos fritos\u003c/li\u003e\u003cli\u003eSalada de tomates e alface.\u003c/li\u003e\u003c/ul\u003e\u003cp\u003ePor meio da entrevista de cada um dos comensais foi então padronizado o cardápio suspeito:\u003c/p\u003e\u003cul\u003e\u003cli\u003eO Sr. J.F. almoçou às 12 horas e comeu arroz, feijão e ovos fritos.\u003c/li\u003e\u003cli\u003eA Sra. A.F. almoçou no mesmo horário e comeu arroz, couve e salada de tomate e alface. A sra A.F. não apresentou nenhum sintoma.\u003c/li\u003e\u003cli\u003eA filha M.F. almoçou às 12:30 e comeu arroz, feijão, ovos fritos e couve.\u003c/li\u003e\u003cli\u003eA funcionária D.S. almoçou às 13:30 horas e comeu arroz, feijão, ovos fritos, couve e salada de tomate e alface. \u003c/li\u003e\u003c/ul\u003e\u003cp\u003eA VE não conseguiu amostras dos alimentos servidos na refeição para análise laboratorial. A Vigilância Sanitária então entrevistou a senhora A.F. para resgatar com ela a identificação das matérias-primas utilizadas na confecção dos pratos servidos no  almoço, bem como todos os procedimentos em cada etapa de preparação dos pratos.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003ePara identificar a qualidade e segurança dos alimentos é necessário colher informações detalhadas sobre a produção do alimento, assim como as condições de conservação e consumo. Portanto, todas as alternativas estão corretas.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["origem do alimento, marca e fornecedor", true],
            ["data da compra do alimento", true],
            ["lote e validade do alimento", true],
            ["origem da água utilizada no preparo", true],
            ["como os alimentos são conservados", true],
            ["como os alimentos são armazenados", true],
          ],
        },
        pergunta:
          "Na identificação das matérias-primas utilizadas na confecção dos pratos servidos em qualquer refeição suspeita devemos estar atentos para:",
        titulo: "Questão 3",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eA identificação das matérias-primas e o detalhamento do preparo dos alimentos deste surto foram realizadas na própria cozinha da família de forma que as vigilâncias pudessem observar possíveis pontos críticos implicados com riscos à saúde. Assim verificaram alguns problemas:\u003c/p\u003e\u003cul\u003e\u003cli\u003eA geladeira estava com as borrachas de vedação da porta desgastadas, o que compromete a manutenção da temperatura adequada dos alimentos.\u003c/li\u003e\u003cli\u003eO corte dos alimentos foi realizado em tábua de madeira que apresentava mofo e também encontrava-se bastante desgastada\u003c/li\u003e\u003cli\u003eAs colheres usadas no preparo dos alimentos eram de madeira e estavam em condição similar à da tábua.\u003c/li\u003e\u003cli\u003eO almoço no dia 11/4 começou a ser preparado às 10 horas da manhã. O feijão que ficou pronto às 11 horas e permaneceu na panela sobre o fogão enquanto os demais pratos eram preparados.\u003c/li\u003e\u003c/ul\u003e\u003cp\u003eQuanto à procedência dos alimentos utilizados na confecção da refeição suspeita os técnicos encontraram a seguinte situação:\u003c/p\u003e\u003cul\u003e\u003cli\u003eArroz da marca “Saboroso” com data de validade agosto de 2022 adquirido no macroatacado “Rancho Bom” em 09/4/21. O pacote foi aberto pela Sra. A.F. para a confecção da refeição, que não verificou nenhum rompimento na embalagem original.\u003c/li\u003e\u003cli\u003eFeijão preto, marca “Caboclo”, pacote de 1 kg, que foi adquirido no mesmo macroatacado (Rancho Bom), foi aberto pela Sra. A.F e não apresentava qualquer evidência de estar danificado.\u003c/li\u003e\u003cli\u003eBacon embalado a vácuo em apresentação de 200gr e data de validade até 20/4/22.\u003c/li\u003e\u003cli\u003eOvos da marca “Aves do Campo” em embalagem com meia dúzia e data de validade até julho de 2022.\u003c/li\u003e\u003cli\u003eVerduras (alface e couve) adquiridos na fruteira , assim como o tomate.\u003c/li\u003e\u003c/ul\u003e\u003cp\u003eNão havia restos de alimentos para que a Vigilância Sanitária pudesse fazer coletas para exames laboratoriais. Assim, foram então coletadas amostras de bacon em estoque (a dona de casa havia comprado três unidades do bacon e ainda tinha duas parcialmente usadas).\u003c/p\u003e\u003cp\u003eA vigilância Ambiental verificou os registros de qualidade da água de consumo humano fornecida pelo serviço de saneamento que atende o município, constatando que a água que chegava até a residência estava dentro dos parâmetros de potabilidade. Assim, o passo seguinte foi a análise dos reservatórios de água e da água na torneira da cozinha por amostragem e envio ao laboratório de referência, cujo resultado mostrou que também se encontravam aptas para consumo.\u003c/p\u003e\u003cp\u003eA amostra do bacon coletada na cozinha da Sra. A.F. demonstrou \u003ci\u003eListeria monocytogenes\u003c/i\u003e somou-se aos problemas identificados durante o preparo dos alimentos da refeição e reforçou a necessidade de medidas orientativas a respeito do preparo e conservação dos alimentos.\u003c/p\u003e\u003cp\u003eA equipe da VE enfrentou algumas \u003cb\u003ebarreiras para a realização da investigação epidemiológica\u003c/b\u003e tais como:\u003cbr/\u003e⎼\u0009O tempo entre o início dos sintomas dos casos e a data da notificação, o que contribuiu para a ausência de restos dos alimentos suspeitos no dia da investigação in loco e impossibilitou a coleta de amostras para exame.\u003cbr/\u003e⎼ Ter iniciado a investigação decorridos quatro dias do início dos sintomas implicou na realização das entrevistas, quando nenhum dos acometidos ainda apresentava diarreia, o que impediu a coleta de amostras de fezes para análise laboratorial.",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: [
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/guia_investigacao_surtos_epidemias.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Vigilância das Doenças Transmissíveis. \u003cb\u003eGuia para Investigações de Surtos ou Epidemias\u003c/b\u003e / Ministério da Saúde, Secretaria de Vigilância em Saúde, Departamento de Vigilância das Doenças Transmissíveis – Brasília: Ministério da Saúde, 2018. Disponível em: ",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/guia_vigilancia_saude_5ed_rev_atual.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. \u003cb\u003eGuia de Vigilância em Saúde\u003c/b\u003e [recurso eletrônico] / Ministério da Saúde, Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. – 5. ed. rev. – Brasília: Ministério da Saúde, 2022. Disponível em: ",
          },
        ],
        tipo: "bibliografia",
      },
    ],
    subTitulo: "",
    titulo: "Três casos de diarreia na mesma residência",
    tsPublicacao: 1.23456789e9,
    shortname: "Três casos de diarreia na mesma residência",
  },
  {
    _id: ObjectId("633ae23241e46fbd641c95d1"),
    autor: ["José Rosa"],
    editores: ["Everton Fantinel", "Denise Silveira"],
    id: 9073.0,
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "41 anos",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "interdisciplinar",
    slides: [
      {
        conteudo: { texto: "", delay: "5" },
        titulo: "Introdução",
        tipo: "intro",
      },
      {
        conteudo: {
          contexto:
            "\u003cp\u003eO município de Flores Brancas localiza-se na região serrana do Rio Grande do Sul  e contava com 102.451 habitantes em 2005. Neste município, a vigilância das meningites é uma das atividades desenvolvidas pela Vigilância Epidemiológica (VE) municipal até os dias atuais.\u003c/p\u003e\u003cp\u003eEm 2005, o principal instrumento para a VE das meningites era a Ficha de Investigação de Meningite (Figura 1), na qual eram notificados os casos de meningite atendidos nos serviços de assistência à saúde do município (em todas as unidades básicas de saúde pública, na unidade de pronto atendimento público, no serviço de urgência hospitalar e em um serviço privado de atendimento ambulatorial). Os profissionais destes serviços realizavam a notificação dos casos suspeitos de meningite dentro das primeiras 24 horas do atendimento. Após a notificação do caso suspeito, os técnicos da VE procuravam iniciar a investigação dentro do prazo de 48 horas.\u003c/p\u003e\u003ch6\u003eFigura 1. Ficha de Investigação de Meningite. Brasil, 2022.\u003c/h6\u003e\u003ctable\u003e\u003ctr\u003e\u003ctd\u003e\u003cimg src='img/caso09_figura_1_1_MENINGITE.png'/\u003e\u003c/td\u003e\u003ctd\u003e\u003cimg src='img/caso09_figura_1_2_MENINGITE.png'/\u003e\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003cp\u003eDurante o primeiro semestre de 2005, houve aumento do número de notificações de meningites virais no município de Flores Brancas, chegando a 4 casos notificados até junho do referido ano. Em 2004, no mesmo período, havia sido registrado apenas um caso e o total  deste ano foi de 4 casos de meningite viral. No segundo semestre de 2005, outras 15 novas notificações foram realizadas, encerrando o ano com um total de 19 casos, o que representou um aumento de  475% em relação a 2004. Durante o ano de 2006, o número de notificações permaneceu elevado, chegando a 20 casos de meningite viral (Figura 2).\u003c/p\u003e\u003ch6\u003eFigura 2. Número de casos de meningites virais notificados entre 2004 e 2006, Flores Brancas.\u003c/h6\u003e\u003cimg src='img/caso09_figura_2_MENINGITE.png'/\u003e",
        },
        titulo: "Descrição",
        tipo: "contexto",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eCrianças acima de 1 ano de idade e adultos com febre, cefaleia, vômitos, rigidez da nuca, sinais de irritação meníngea (Kernig, Brudzinski), convulsões e/ou manchas vermelhas no corpo para que possam ser definidos como caso suspeito.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["febre, cefaleia, vômitos, rigidez da nuca", true],
            [
              "sinais de irritação meníngea (Kernig, Brudzinski), convulsões e/ou manchas vermelhas no corpo",
              true,
            ],
            ["dispneia, tonturas e inapetência", false],
            ["perda do paladar, dores articulares e febre baixa", false],
          ],
        },
        pergunta:
          "As notificações foram realizadas a partir de casos suspeitos de meningite. Para levantar essa hipótese em indivíduos adultos, espera-se que apresentem quais sinais e/ou sintomas?",
        titulo: "Questão 1",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eDefinição, etiologia e importância das meningites\u003c/h3\u003e\u003cp\u003eA meningite é caracterizada por um processo inflamatório das meninges, membranas que revestem o encéfalo e a medula espinhal. Causada, principalmente, a partir da infecção por vírus ou bactérias, estes de maior relevância na saúde pública, pela magnitude, capacidade de produzir surtos e letalidade (no caso das bacterianas). Outros agentes etiológicos também podem causar meningite, como fungos e parasitos. As meningites virais e bacterianas são as de maior importância para a saúde pública, considerando a magnitude de sua ocorrência e o potencial de produzir surtos.\u003c/p\u003e\u003cp\u003eA distribuição da meningite e a suscetibilidade são universais e a incidência varia conforme região. A doença está relacionada à existência de aglomerados, aspectos climáticos, circulação do agente no ambiente e características socioeconômicas. A Organização Mundial da Saúde (OMS), estima que ocorram, aproximadamente, 1,2 milhões de casos e 135 mil mortes por meningite a cada ano, no mundo.\u003c/p\u003e\u003cp\u003eNo Brasil, a meningite é considerada uma doença endêmica. Casos da doença são esperados ao longo de todo o ano, com a ocorrência de surtos e epidemias ocasionais. A ocorrência das meningites bacterianas é mais comum no outono-inverno e das virais na primavera-verão. O sexo masculino também é o mais acometido pela doença.\u003c/p\u003e\u003cp\u003eRessalta-se que, apesar de ser habitualmente causada por microrganismos, a meningite também pode ter origem em processos inflamatórios, como câncer (metástases para meninges), lúpus, reação a algumas drogas, traumatismo craniano e cirurgias cerebrais.\u003c/p\u003e\u003ch6\u003e(RIO GRANDE DO SUL, 2017)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eEm 2006, o pico máximo de casos de meningite viral aconteceu no primeiro trimestre do ano. O número de casos em 2004 foi o menor dos três anos. Houve um aumento de 475% no número de casos em 2005 em relação ao total de casos de 2004. Sabe-se que a sazonalidade das meningites virais se concentra nos meses quentes, no período de outubro a abril – do início da primavera até o final do verão. Em 2005, constatou-se uma mudança de comportamento do agravo, com aumento de casos a partir do mês de junho (outono-inverno). Segundo a Secretaria Estadual da Saúde, este aumento de casos, nesta época do ano, poderia ser atribuído às alterações climáticas observadas no inverno de 2005, quando foram registradas altas temperaturas durante vários dias. Assim, é possível que o surto de Flores Brancas tenha seguido a mesma tendência do estado no ano de 2005. Em 2006, a maior frequência de casos voltou a ocorrer no 1º e no 4º trimestres (primavera e verão), período em que os meses costumam ser naturalmente mais quentes.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "No ano de 2005, o número de casos de meningite alcançou seu pico no terceiro trimestre do ano",
              true,
            ],
            [
              "em 2006, a curva dos casos de meningite foi semelhante à de 2005, mas o pico máximo aconteceu no quarto trimestre",
              false,
            ],
            [
              "O número de casos em 2004 sugere que também ocorreu um surto de meningite viral",
              false,
            ],
            [
              "em cada um dos três anos a sazonalidade dos casos costuma ocorrer no segundo trimestre de cada ano",
              false,
            ],
          ],
        },
        pergunta: "Analisando a Figura 2, verifica-se que:",
        titulo: "Questão 2",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eAssim, diante da hipótese levantada de surto de meningite viral a equipe da VE decidiu elaborar um gráfico com a série histórica da incidência de meningite viral no município incluindo os dados de todos os anos disponíveis.\u003c/p\u003e\u003ch6\u003eFigura 3. Incidência das meningites virais por 100.000 habitantes por ano de ocorrência para o período 1990 a 2021, Flores Brancas, 2021.\u003c/h6\u003e\u003cimg src='img/caso09_figura_3_MENINGITE.png'/\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eConforme pode ser observado no gráfico existem vários anos que a incidência é elevada, mas os maiores valores são nos anos 2005 e 2006. A incidência das meningites virais, que era de 4,1 casos por 100.000 habitantes em 2004, subiu para 18,5 casos por 100.000 em 2005 e para 19,2 casos por 100.000 em 2006, quase quatro vezes maior do que a esperada.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "a incidência das meningites virais não apresenta variações anuais no município de Flores Brancas",
              false,
            ],
            [
              "os anos em que ocorreram as maiores incidências de meningites virais no município de Flores Brancas foram 2005 e 2006",
              true,
            ],
            [
              "a incidência anual das meningites virais em Flores Brancas costuma elevar-se acima da média a cada três anos, sendo uma característica sazonal da doença neste município",
              false,
            ],
            [
              "as meningites virais são um grande problema de saúde pública neste município porque frequentemente ocorre elevação do número de casos",
              false,
            ],
          ],
        },
        pergunta:
          "A partir das informações do Figura 3, é possível afirmar que:",
        titulo: "Questão 3",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eA série histórica apresentada no Figura 3 permitiu verificar que a doença apresenta um dado padrão de variação em Flores Brancas, repetindo-se de intervalo a intervalo, com valores máximos e mínimos ao longo de um período. Assim, contribuiu para diferenciar a ocorrência de variações esperadas no número de casos de uma doença da  real ocorrência de surtos e epidemias na população.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eOs principais exames laboratoriais para confirmação laboratorial das meningites virais são o isolamento viral em cultura celular a partir do líquor, das fezes ou outras amostras; o exame quimiocitológico do líquor; ou a reação em cadeia da polimerase utilizando uma amostra de líquido cefalorraquidiano ou soro. A aglutinação pelo látex é empregada para confirmação do diagnóstico das meningites bacterianas, mas não daquelas de etiologia viral.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "Isolamento viral em cultura celular a partir do líquor ou das fezes",
              true,
            ],
            [
              "Reação em cadeia da polimerase com amostra de líquido cefalorraquidiano ou soro",
              true,
            ],
            ["Exame quimiocitológico do líquido cefalorraquidiano", true],
            ["Aglutinação pelo látex", false],
          ],
        },
        pergunta:
          "Quais os principais exames para definição laboratorial de um caso suspeito de meningite viral?",
        titulo: "Questão 4",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eAgentes etiológicos da meningite viral\u003c/h3\u003e\u003cp\u003eA meningite viral caracteriza-se por um quadro clínico de alteração neurológica, que, em geral, evolui de forma benigna. Alguns poucos casos apresentam um comportamento mais grave, incluindo comprometimento sistêmico. Os casos podem ocorrer isoladamente, embora o aglomerado de casos (surtos) seja comum. Indivíduos de todas as idades são suscetíveis, porém a faixa etária de maior risco é a de menores de cinco anos.\u003c/p\u003e\u003cp\u003eOs principais causadores das meningites virais são os vírus do gênero Enterovírus. Nesse grupo, estão incluídos os três tipos de poliovírus, 28 tipos antigênicos do vírus echo, 23 tipos do vírus Coxsackie A, seis do vírus Coxsackie B, e cinco outros enterovírus. Entretanto, outros vírus também podem causar meningite viral. Os Enterovírus têm comportamento sazonal, predominando na primavera e verão, podendo ocorrer em número menor nas outras estações do ano.\u003c/p\u003e\u003cp\u003eA transmissão ocorre através de secreções do trato respiratório (saliva, escarro, secreção nasal) e fezes. Em creches, a transmissibilidade ocorre, principalmente, pela contaminação das mãos com fezes durante a troca de fraldas de uma criança infectada (6). No Brasil, em média, são notificados 11.500 casos/ano de meningite de provável etiologia viral. Entretanto, para a maioria dos casos não há identificação do agente etiológico.\u003c/p\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eNo município de Flores Brancas, por exemplo, do total de meningites virais notificadas até 2021, 95,2% foram classificadas com base na citoquímica do líquor dos doentes, restando um pequeno percentual em que a confirmação foi realizada através de outros exames, como o PCR, ou sorologias. O líquor cefalorraquidiano de um caso de meningite viral apresentará na análise quimiocitológica um aspecto límpido, incolor ou opalescente, com glicose entre 45 e 100 mg/dL, proteínas totais levemente aumentadas, globulinas podem ou não estar presentes e a celularidade geralmente ficará entre 5 a 500 linfócitos/mm\u003csup\u003e3\u003c/sup\u003e.\u003c/p\u003e\u003cp\u003eNo surto de 2005-2006, foram encaminhadas amostras de líquor apenas de 56,4% dos doentes para o LACEN, mas não foram realizadas testagens de enterovírus, ou de outros vírus, para nenhuma das amostras, razão pela qual, não se conseguiu determinar um possível agente etiológico. Apesar disso, há a probabilidade do surto estar associado a enterovírus, isso porque eles são responsáveis por 85% das meningites virais. Para corroborar esta hipótese, os doentes do surto apresentaram evoluções clínicas compatíveis com esse tipo de infecção, isto é, autolimitada e benigna (semelhantes às viroses em geral) e com manejo apenas de terapia de suporte.\u003c/p\u003e\u003cp\u003eEm outubro de 2005, a Secretaria Estadual da Saúde do Rio Grande do Sul emitiu um boletim epidemiológico alertando sobre um aumento de 37% nos casos de meningite viral em relação à média do período de 1999 a 2004 para o Estado como um todo. Os casos estavam concentrados na 1ª Coordenadoria Regional de Saúde, sendo que Porto Alegre, capital do Rio Grande do Sul, foi responsável por 63% do total de notificações do estado (466 casos). Em 2006, 46,5% do total de meningites notificadas foi classificada como sendo de etiologia viral (Figura 3).\u003c/p\u003e\u003ch6\u003eFigura 4. Número de casos de meningites virais para o período 1996 a 2005, Flores Brancas, 2021.\u003c/h6\u003e\u003cimg src='img/caso09_figura_4_MENINGITE.png'/\u003e\u003cp\u003eNo intuito de identificar grupo de risco por faixa etária foi realizada a frequência do número de casos  segundo a idade das pessoas com meningite viral em 2005 e 2006 (Tabela 1).\u003c/p\u003e\u003ch6\u003eTabela 1. Casos de Meningite Viral por Faixa Etária, Flores Brancas, 2005-2006 (N= 39).\u003c/h6\u003e\u003cimg src='img/caso_09_figura_5_MENINGITE.png'/\u003e\u003cp\u003eNo município de Flores Brancas, não foi possível determinar a existência de uma fonte de exposição comum a todos os doentes notificados entre 2005 e 2006. Entretanto, é possível que muitos casos de meningite viral estariam associados a situações de surto de gastrenterite por enterovírus em comunidades fechadas, como escolas de educação infantil e de ensino fundamental. Essa seria uma hipótese plausível para o surto de meningite viral, considerando que a maioria dos casos estava em idade escolar, isto é, de 1 a 19 anos de idade.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA transmissão das meningites virais ocorre, predominantemente, por contaminação fecal-oral, embora também possa acontecer por via respiratória. As ações para prevenção e controle consistem em medidas de higienização adequada das mãos, dos alimentos  e do ambiente, bem como a ventilação do ambiente.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "Recomendar higiene adequada das mãos, dos alimentos  e do ambiente especialmente em escolas.",
              true,
            ],
            [
              "Aumentar o nível de risco em saúde pública, alertando pais e escolas sobre a doença e suas complicações.",
              false,
            ],
            [
              "Isolar todas as crianças em casa, afastando-as do convívio escolar por tempo indeterminado.",
              false,
            ],
            [
              "Fazer testagem na comunidade infantil, a fim de identificar uma possível circulação de enteroviroses.",
              false,
            ],
          ],
        },
        pergunta:
          "Quais seriam as medidas a serem recomendadas para conter a dispersão da doença no município de Flores Brancas?",
        titulo: "Questão 5",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eA equipe da VE enfrentou algumas \u003cb\u003ebarreiras para a realização da investigação epidemiológica\u003c/b\u003e tais como:\u003cbr/\u003e • Não foram encaminhadas amostras de líquor para o LACEN em 43,6 % dos casos de meningite viral.\u003cbr/\u003e• Não realização de testagens de enterovírus ou de outros vírus nas amostras enviadas.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: [
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/guia_vigilancia_saude_5ed_rev_atual.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. \u003cb\u003eGuia de Vigilância em Saúde\u003c/b\u003e [recurso eletrônico] / Ministério da Saúde, Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. – 5. ed. rev. – Brasília: Ministério da Saúde, 2022. Disponível em: ",
          },
          {
            urlExterno:
              "https://www.cevs.rs.gov.br/upload/arquivos/201803/02145050-informe-epidemiologico-das-meningites-2010-2017.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "RIO GRANDE DO SUL. Secretaria Estadual de Saúde. Centro de Vigilância Epidemiológica - CEVS. \u003cb\u003eInforme Epidemiológico das meningites 2010-2027\u003c/b\u003e. CEVS: 2017. Disponível em: ",
          },
        ],
        tipo: "bibliografia",
      },
    ],
    subTitulo: "",
    titulo: "Aumento das notificações de meningite viral",
    tsPublicacao: 1.23456789e9,
    shortname: "Aumento das notificações de meningite viral",
  },
  {
    _id: ObjectId("635bd84341e46f0207fcaaf8"),
    autor: ["Denise Silveira", "Everton Fantinel"],
    editores: ["Deisi Cardoso", "Mirelle Saes"],
    id: 9074.0,
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "41 anos",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "interdisciplinar",
    slides: [
      {
        conteudo: { texto: "", delay: "5" },
        titulo: "Introdução",
        tipo: "intro",
      },
      {
        conteudo: {
          descricaoCaso:
            "\u003cp\u003eNo dia 27 de julho a Vigilância Epidemiológica (VE), de um município de médio porte do Sul do país foi notificada por uma unidade básica de saúde (UBS), por telefone, a respeito de uma paciente com suspeita de varíola dos macacos.\u003c/p\u003e\u003cp\u003eO caso se refere a uma mulher de 18 anos, apresentando lesões de pele muito pruriginosas, quadro que já se prolongava há cerca de 14 dias quando resolveu buscar atendimento, basicamente devido à intensidade do prurido. Cronologicamente, inicialmente foram acometidos os membros inferiores, seguindo-se o tronco e membros superiores. No momento da consulta na UBS, as lesões eram inicialmente vesiculares, passando a crostosas.\u003c/p\u003e",
        },
        titulo: "Descrição do Caso",
        tipo: "descricaocaso",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eÉ considerado caso suspeito de Monkeypox todo indivíduo de qualquer idade que apresenta início súbito de lesão em mucosas E/OU erupção cutânea aguda sugestiva (lesões profundas e bem circunscritas, muitas vezes com umbilicação central; e progressão da lesão através de estágios sequenciais específicos – máculas, pápulas, vesículas, pústulas e crostas) de Monkeypox, única ou múltipla, em qualquer parte do corpo (incluindo região genital/perianal, oral) E/OU proctite (por exemplo, dor anorretal, sangramento), E/OU edema peniano, podendo estar associada a outros sinais e sintomas. A escabiose é uma parasitose da pele causada por um ácaro cuja penetração deixa lesões em forma de vesículas, pápulas ou pequenos sulcos, nos quais ele deposita seus ovos.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Monkeypox", true],
            ["Escabiose", false],
            ["Dermatite alérgica", false],
            ["Molusco contagioso", false],
          ],
        },
        pergunta:
          "A partir do quadro clínico de J.N.S é possível inferir que trata-se de um caso suspeito de:",
        titulo: "Questão 1",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eHistoricidade da Monkeypox\u003c/h3\u003e\u003cp\u003eO primeiro caso de monkeypox fora da África no surto de 2022 foi identificado em Londres, em 5 de maio de 2022. Uma semana depois, um paciente que morava em Londres desenvolveu lesões na pele ao voltar de uma viagem à Nigéria. No dia seguinte houve a confirmação de um novo caso na capital inglesa.\u003c/p\u003e\u003cp\u003eEm 23 de julho de 2022 o diretor-geral da Organização Mundial da Saúde (OMS), Tedros Adhanom Ghebreyesus, declarou que a Monkeypox constitui uma Emergência de Saúde Pública de Importância Internacional. Em 29 de julho de 2022 o Ministério da Saúde confirmou a primeira morte por Monkeypox no Brasil. A vítima era de Uberlândia (MG).\u003c/p\u003e\u003cp\u003eConforme o protocolo , a unidade deve coletar exame complementar para Monkeypox e realizar a notificação. \u003c/p\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "Por definição, a confirmação de um caso suspeito depende de um resultado laboratorial “Positivo/Detectável” para Monkeypox vírus (MPXV) por diagnóstico molecular, seja por PCR em Tempo Real e/ou Sequenciamento).",
            tipo: "texto",
          },
          opcoes: [
            [
              "resultado laboratorial “Positivo/Detectável” para Monkeypox vírus (MPXV) por diagnóstico molecular (PCR em Tempo Real e/ou Sequenciamento)",
              true,
            ],
            [
              "quadro clínico que cumpra os requisitos para confirmação pelo critério clínico-epidemiológico",
              false,
            ],
            [
              "agravamento dos sinais e sintomas com necessidade de hospitalização contemplando a confirmação segundo o critério clínico",
              false,
            ],
            [
              "exposição próxima e prolongada, sem proteção respiratória, OU contato físico direto, incluindo contato sexual, com parcerias múltiplas e/ou desconhecidas nos 21 dias anteriores ao início dos sinais e sintomas",
              false,
            ],
          ],
        },
        pergunta:
          "Para classificar J.N.S como caso confirmado de Monkeypox a partir das informações obtidas é necessário:",
        titulo: "Questão 2",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eDefinição de caso\u003c/h3\u003e\u003cp\u003e\u003cb\u003eCaso provável:\u003c/b\u003e Caso que atende à definição de caso suspeito, que apresenta um OU mais dos seguintes critérios listados abaixo, com investigação laboratorial de Monkeypox não realizada ou inconclusiva e cujo diagnóstico de Monkeypox não pode ser descartado apenas pela confirmação clínico laboratorial de outro diagnóstico:\u003cul\u003e\u003cli\u003eExposição próxima e prolongada, sem proteção respiratória, OU contato físico direto, incluindo contato sexual, com parcerias múltiplas e/ou desconhecidas nos 21 dias anteriores ao início dos sinais e sintomas; \u003c/li\u003e\u003cli\u003eExposição próxima e prolongada, sem proteção respiratória, OU história de contato íntimo, incluindo sexual, com caso provável ou confirmado de Monkeypox nos 21 dias anteriores ao início dos sinais e sintomas; \u003c/li\u003e\u003cli\u003eContato com materiais contaminados, como roupas de cama e banho ou utensílios de uso comum, pertencentes a caso provável ou confirmado de Monkeypox nos 21 dias anteriores ao início dos sinais e sintomas; \u003c/li\u003e\u003cli\u003eTrabalhadores de saúde sem uso adequado de equipamentos de proteção individual (óculos de proteção ou protetor facial, avental, máscara cirúrgica, luvas de procedimentos) com história de contato com caso provável ou confirmado de Monkeypox nos 21 dias anteriores ao início dos sinais e sintomas. \u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e\u003cp\u003e\u003cb\u003eCaso confirmado:\u003c/b\u003e Caso suspeito com resultado laboratorial “Positivo/Detectável” para Monkeypox vírus (MPXV) por diagnóstico molecular (PCR em Tempo Real e/ou Sequenciamento).\u003c/p\u003e\u003cp\u003e\u003cb\u003eCaso descartado:\u003c/b\u003e Caso suspeito com resultado laboratorial “Negativo/Não Detectável” para Monkeypox vírus (MPXV) por diagnóstico molecular (PCR em Tempo Real e/ou Sequenciamento) OU sem resultado laboratorial para MPXV E realizado diagnóstico complementar que descarta monkeypox como a principal hipótese de diagnóstico.\u003c/p\u003e\u003ch6\u003e(UFRGS, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eDe acordo com o relato da paciente, ela tinha um companheiro, que apresentou quadro clínico semelhante com início em período anterior, mas que não apresentava prurido no momento e tinha raras lesões crostosas. O companheiro também foi submetido a coleta de swab para Monkeypox.\u003c/p\u003e\u003cp\u003eO casal passou a residir no município poucos dias antes da mulher apresentar os primeiros sintomas e negou contato ou conhecer alguém que tivesse sintomas semelhantes. Dois meses antes estavam em relacionamentos com outras parcerias sexuais. \u003c/p\u003e\u003cp\u003eO homem teve resultado negativo e, na recoleta, o resultado permaneceu o mesmo, mas a mulher apresentou resultado positivo.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eÉ fundamental a investigação clínica e/ou laboratorial para descartar as doenças que se enquadram como diagnóstico diferencial, que incluem: varicela zoster, herpes zoster, herpes simples, infecções bacterianas da pele, infecção gonocócica disseminada, sífilis primária ou secundária, cancroide, linfogranuloma venéreo, granuloma inguinal, molusco contagioso, reação alérgica e quaisquer outras causas de erupção cutânea papular ou vesicular). Como há relatos de pacientes coinfectados com o vírus monkeypox e outros agentes infecciosos, pacientes com erupção cutânea característica devem ser investigados mesmo que outros testes sejam positivos.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Monkeypox", true],
            ["Varicela", true],
            ["Herpes zoster", true],
            ["Herpes simples", true],
            ["Impetigo", true],
            ["Sífilis", true],
          ],
        },
        pergunta:
          "Que doenças devem ser consideradas no diagnóstico diferencial de J.N.S?",
        titulo: "Questão 3",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eEstágios evolutivos do exantema da Monkeypox\u003c/h3\u003e\u003ch6\u003eFigura 1. Descrição dos estágios evolutivos do exantema da Monkeypox.TELESSAÚDE, 2022.\u003c/h6\u003e\u003cimg src='img/caso14_figura_1_MONKEYPOX.png'/\u003e\u003ch6\u003eFigura 2. Evolução das lesões cutâneas. TELESSAÚDERS, 2022.\u003c/h6\u003e\u003cimg src='img/caso14_figura_2_MONKEYPOX.png'/\u003e\u003ch6\u003e(UFRGS, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eDiante de um caso suspeito de Monkeypox, o profissional deve primeiramente notificar o caso. As notificações podem ser realizadas através do Sistema de Informação de Agravos de Notificação (E-sus Sinan), disponível em: \u003ca href='https://esussinan.saude.gov.br/login'\u003ehttps://esussinan.saude.gov.br/login\u003c/a\u003e. Na sequência, deve comunicar o caso à vigilância epidemiológica municipal e/ou estadual, de acordo com os fluxos locais.\u003c/p\u003e\u003cp\u003eUm dos profissionais que participou do atendimento de J.N.S. notificou a suspeita de se tratar de um caso suspeito de Monkeypox, utilizando  o formulário preconizado via online.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Realizar a notificação de forma imediata, em até 24 horas", true],
            [
              "Comunicar o caso às vigilâncias epidemiológica, sanitária e ambiental",
              false,
            ],
            [
              "Solicitar a coleta de exames para diagnóstico e diagnósticos diferenciais",
              false,
            ],
            [
              "Iniciar tratamento específico de acordo com o resultado dos exames.",
              false,
            ],
          ],
        },
        pergunta:
          "Qual a primeira ação que deve ser realizada pelo profissional que atende um caso semelhante ao de J.N.S.?",
        titulo: "Questão 4",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eNo contexto atual, de acordo com a OPAS e a OMS, todas as respostas estão corretas.  \u003c/p\u003e\u003cp\u003eEm seu primeiro contato via telefone com J.N.S. a VE orientou medidas preventivas e acordou como iria acontecer seu monitoramento.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "identificar rapidamente os casos e clusters para fornecer atendimento clínico ideal",
              true,
            ],
            ["isolar os casos para evitar transmissão adicional", true],
            [
              "identificar, gerenciar e acompanhar os contatos de modo a reconhecer sinais precoces de infecção",
              true,
            ],
            ["proteger os profissionais de saúde da linha de frente", true],
            ["adaptar medidas efetivas de controle e prevenção", true],
          ],
        },
        pergunta:
          "Quais são os principais objetivos da vigilância e da investigação de casos de Monkeypox:",
        titulo: "Questão 5",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "Neste caso clínico, em seu primeiro contato via telefone com J.N.S. a VE orientou medidas preventivas e acordou como iria acontecer seu monitoramento.",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eAs principais medidas de prevenção contra a monkeypox são voltadas a evitar que casos suspeitos ou confirmados transmitam a doença para outras pessoas.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["isolamento imediato até completar 21 dias de lesões", true],
            ["não compartilhar objetos e material de uso pessoal", true],
            ["evitar contato íntimo com pessoas", true],
            ["evitar contato com lama ou água de enchentes", false],
          ],
        },
        pergunta:
          "Quais são as orientações preventivas que J.N.S. deve seguir  para  evitar a transmissão da monkeypox aos seus contatos:",
        titulo: "Questão 6",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eMedidas Preventivas\u003c/h3\u003e\u003cp\u003eA principal forma de proteção contra a monkeypox é a prevenção. A varíola dos macacos é uma infecção zoonótica que pode ser transmitida de animais para humanos, de humanos para humanos e possivelmente de humanos para animais. As evidências atuais sugerem que o surto de 2022 não envolve múltiplos eventos zoonóticos e a transmissão é sustentada por meio da disseminação de humano para humano.\u003c/p\u003e\u003cp\u003eA transmissão de pessoa para pessoa pode ocorrer por meio do contato direto com lesões infecciosas da pele ou membranas mucosas ou fluidos corporais dessas lesões, incluindo contato face a face, pele a pele, boca a boca ou boca a pele e gotículas respiratórias (e possivelmente aerossóis de curto alcance que exigem contato próximo prolongado). O vírus então entra no corpo através de soluções de continuidade da pele, superfícies mucosas (por exemplo, oral, faríngea, ocular, genital ou anal), ou via trato respiratório. O período infeccioso pode variar, mas geralmente os pacientes são considerados infecciosos a partir do momento do início dos sintomas até que as lesões cutâneas tenham crostas, as crostas tenham caído e uma nova camada de pele tenha se formado por baixo.\u003c/p\u003e\u003cp\u003eA transmissão também pode ocorrer do ambiente para os seres humanos a partir de roupas ou lençóis contaminados que contenham partículas infecciosas da pele (também descritas como transmissão por fômites). Se agitadas, essas partículas podem se dispersar no ar e ser inaladas, pousar em soluções de continuidade da pele ou nas membranas mucosas e levar à transmissão e à infecção; uma infecção documentada em profissionais de saúde foi publicada sugerindo que a varíola dos macacos foi adquirida através do contato com roupas de cama contaminadas. Outros dois casos ocorridos em profissionais de saúde, na França e em Portugal (notificados à OMS), foram infectados por uma picada acidental de agulha contaminada.\u003c/p\u003e\u003cp\u003ePara haver transmissão respiratória, parece ser necessário haver proximidade e exposição prolongada, embora o vírus tenha sido encontrado no sêmen de pacientes afetados, o papel da transmissão sexual através dos fluidos seminais ainda não é bem compreendido.\u003c/p\u003e\u003cp\u003eDurante a gravidez, o vírus pode atravessar a placenta causando exposição intrauterina do feto e infecção congênita do bebê.\u003c/p\u003e\u003cp\u003ePortanto, pessoas com suspeita ou confirmação da doença devem cumprir isolamento imediato, não compartilhar objetos e material de uso pessoal, tais como toalhas, roupas, lençóis, escovas de dente, talheres, até o término do período de transmissão.\u003c/p\u003e\u003cp\u003ePara as demais pessoas, prováveis contatos, aconselha-se:\u003cul\u003e\u003cli\u003eEvitar o contato direto com pessoas com suspeita ou confirmação da doença. E no caso da necessidade de contato (por exemplo: cuidadores, profissionais da saúde, familiares próximos e parceiros, etc.) utilizar luvas, máscaras, avental e óculos de proteção.\u003c/li\u003e\u003cli\u003eLavar regularmente as mãos com água e sabão ou utilizar álcool em gel, principalmente após o contato com a pessoa infectada, suas roupas, lençóis, toalhas e outros itens ou superfícies que possam ter entrado em contato com as erupções e lesões da pele ou secreções respiratórias (por exemplo, utensílios, pratos).\u003c/li\u003e\u003cli\u003eLavar as roupas de cama, roupas, toalhas, lençóis, talheres e objetos pessoais da pessoa com água morna e detergente. \u003c/li\u003e\u003cli\u003eLimpar e desinfetar todas as superfícies contaminadas e descartando os resíduos contaminados (por exemplo, curativos) de forma adequada.\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "A organização do monitoramento de J.N.S. foi baseada nas recomendações do Ministério da Saúde.",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eFazem parte dos indivíduos com alto risco de desenvolver as formas graves as crianças, as gestantes e as pessoas imunossuprimidas.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["crianças", true],
            ["gestantes", true],
            ["imunossuprimidos", true],
            ["idosos", false],
          ],
        },
        pergunta:
          "De acordo o Ministério da Saúde, a vigilância dos casos suspeitos/confirmados de Monkeypox deve ser direcionada para:",
        titulo: "Questão 7",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eFormas graves de Monkeypox\u003c/h3\u003e\u003cp\u003eNa maioria dos casos, os sintomas da varíola dos macacos desaparecem sozinhos em poucas semanas, mas em algumas pessoas podem provocar complicações médicas e até mesmo a morte. Recém-nascidos, crianças e pessoas com imunodepressão pré-existente correm risco de sintomas mais graves e de morte por varíola dos macacos.\u003c/p\u003e\u003cp\u003eAs possíveis complicações de casos graves de varíola dos macacos são infecções de pele, pneumonia, confusão mental e infecções oculares que podem levar à perda da visão. Recentemente, cerca de 3% a 6% dos casos notificados provocaram morte em países endêmicos, frequentemente entre crianças ou pessoas com alguma condição crônica de saúde. É importante levar em conta que essa porcentagem pode estar subestimada, pois a vigilância em países endêmicos é limitada.\u003c/p\u003e\u003ch6\u003e(NAÇÕES UNIDAS, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eRecomenda-se o monitoramento diário dos indivíduos com alto risco de desenvolver as formas graves (crianças, gestantes e imunossuprimidos), alertando para os sinais de gravidade e a necessidade de retornar para avaliação presencial.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["diariamente", true],
            ["a cada dois dias", false],
            ["a cada três dias", false],
            ["a cada 7 dias", false],
          ],
        },
        pergunta:
          "Caso o indivíduo portador de Monkeypox se enquadre no grupo de indivíduos com alto risco de desenvolver formas graves, seu monitoramento deve acontecer:",
        titulo: "Questão 8",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eComo J.N.S. não se enquadrou no grupo de indivíduos com alto risco seu monitoramento foi organizado para acontecer a cada dois dias com o objetivo de coletar informações clínicas (sinais e sintomas) e epidemiológicas. \u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eTodas as respostas trazem ações que devem ser realizadas no monitoramento dos contatos de casos suspeitos / confirmados de varíola dos macacos.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "monitorar os contatos por um período de 21 dias desde o último contato com o caso suspeito/confirmado",
              true,
            ],
            [
              "orientar que a temperatura seja verificada pelo menos duas vezes ao dia e que o contato comunique a UBS em caso de alterações",
              true,
            ],
            [
              "orientar aos contatos assintomáticos que não doem sangue, células, tecidos, órgãos, leite materno ou sêmen durante o período de monitoramento",
              true,
            ],
            [
              "orientar aos contatos assintomáticos que não precisam ser isolados enquanto não apresentarem sintomas",
              true,
            ],
          ],
        },
        pergunta:
          "No monitoramento dos contatos de casos suspeitos / confirmados cabe à VE:",
        titulo: "Questão 9",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cb\u003eAções da VE para os contatos assintomáticos que apresentarem sintomas durante o monitoramento:\u003c/b\u003e\u003cul\u003e\u003cli\u003eIsolar e monitorar contatos que apresentarem quaisquer sintomas por 7 dias em busca das erupções cutâneas.  Se não aparecerem, dispensar do isolamento;\u003c/li\u003e\u003cli\u003eisolar e avaliar como caso suspeito o contato que desenvolver erupção cutânea OU febre OU adenopatia. Deve ser  e uma amostra deve ser coletada para análise laboratorial para detecção da Monkeypox.\u003c/li\u003e\u003c/ul\u003e\u003ch6\u003e(OPAS, 2022)\u003c/h6\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003ePara dar continuidade à vigilância de J.N.S., a VE realizou uma reunião e definiu a estratégia de monitoramento de seus contatos. Considerando a disponibilidade dos recursos locais, a VE optou por adotar o monitoramento ativo dos contatos a cada três dias. No intervalo, os contatos realizam o monitoramento passivo diário.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eO monitoramento depende dos recursos disponíveis. Os contatos podem ser monitorados passivamente, ativamente ou diretamente. Em monitoramento passivo, os contatos identificados recebem informações sobre os sinais e sintomas a serem monitorados, atividades permitidas e como entrar em contato com a vigilância local, se surgirem sinais ou sintomas. O monitoramento ativo é quando vigilâncias locais são responsáveis por verificar pelo menos uma vez por dia se uma pessoa sob monitoramento apresenta sinais/sintomas auto-relatados. O monitoramento direto é uma variação do monitoramento ativo que envolve pelo menos visita presencial diária ou que o paciente seja examinado visualmente por meio de vídeo para averiguar a presença de sinais de doença.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "a VE local verifica se os contatos apresentam quaisquer sinais/sintomas, de acordo com o cronograma definido",
              true,
            ],
            [
              "a VE local verifica se os contatos apresentam quaisquer sinais/sintomas graves, de acordo com o cronograma definido",
              false,
            ],
            [
              "a VE local aguarda que os contatos comuniquem se apresentam quaisquer sinais/sintomas, de acordo com o cronograma definido",
              false,
            ],
            [
              "a VE local aguarda que os contatos comuniquem se apresentam sinais/sintomas graves, de acordo com o cronograma definido",
              false,
            ],
          ],
        },
        pergunta: "No monitoramento ativo:",
        titulo: "Questão 10",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eNo caso apresentado a equipe da VE não enfrentou barreiras para a realização da investigação epidemiológica:\u003cul\u003e\u003cli\u003eA resistência do caso em identificar todos os contactantes.\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: [
          {
            urlExterno:
              "https://www.gov.br/saude/pt-br/composicao/svs/resposta-a-emergencias/coes/monkeypox/plano-de-contingencia/plano-de-contingencia",
            acessoEm: "12 Out 2022.",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Centro de Operações de Emergência em Saúde Pública: COE Monkeypox. \u003cb\u003ePlano de Contingência Nacional para Monkeypox.\u003c/b\u003e Ministério da Saúde. Disponível em:",
          },
          {
            urlExterno:
              "https://www.ufrgs.br/telessauders/perguntas/monkeypox-o-que-e-e-quando-notificar/",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "UNIVERSIDADE FEDERAL DO RIO GRANDE DO SUL. Programa de Pós-Graduação em Epidemiologia. TelessaúdeRS (TelessaúdeRS-UFRGS). \u003cb\u003eMonkeypox: o que é e quando notificar?\u003c/b\u003e Porto Alegre: TelessaúdeRS-UFRGS; 31 Maio 2022 [atualizado em 14 Out. 2022]. Disponível em: ",
          },
          {
            urlExterno:
              "https://www.ufrgs.br/telessauders/perguntas/monkeypox-qual-o-quadro-clinico-e-os-diagnosticos-diferenciais/",
            acessoEm: "29 Agosto 2022",
            urlLocal: "",
            linkTitulo:
              "UNIVERSIDADE FEDERAL DO RIO GRANDE DO SUL. Programa de Pós-Graduação em Epidemiologia. TelessaúdeRS (TelessaúdeRS-UFRGS). \u003cb\u003eMonkeypox: qual o quadro clínico e os diagnósticos diferenciais?\u003c/b\u003e Porto Alegre: TelessaúdeRS-UFRGS; 9 Ago 2022 [atualizado em 03 Out. 2022, citado em “dia, mês abreviado e ano”]. Disponível em:",
          },
          {
            urlExterno:
              "https://www.paho.org/pt/documentos/vigilancia-investigacao-casos-e-rastreamento-contatos-da-variola-dos-macacos-orientacao",
            acessoEm: "Acesso em 10 out 2022",
            urlLocal: "",
            linkTitulo:
              "ORGANIZAÇÃO PANAMERICANA DA SAÚDE. \u003cb\u003eVigilância, investigação de casos e rastreamento de contatos da varíola dos macacos: Orientação provisória.\u003c/b\u003e",
          },
          {
            urlExterno:
              "https://brasil.un.org/pt-br/192014-variola-dos-macacos-ou-monkeypox-tudo-o-que-voce-precisa-saber",
            acessoEm: "Acesso em: 5 out 2022.",
            urlLocal: "",
            linkTitulo:
              "NAÇÕES UNIDAS. \u003cb\u003eVaríola dos macacos ou Monkeypox: \u003c/b\u003etudo o que você precisa saber. Disponível em: ",
          },
          {
            urlExterno:
              "https://butantan.gov.br/noticias/variola-dos-macacos-sintomas-transmissao-origem-e-numero-de-casos-sao-atualizados-pela-oms",
            acessoEm: "Acesso em: 2 out 2022.",
            urlLocal: "",
            linkTitulo:
              "INSTITUTO BUTANTAN. \u003cb\u003eVaríola dos macacos:\u003c/b\u003e sintomas, transmissão, origem e número de casos são atualizados pela OMS. Disponível:",
          },
        ],
        tipo: "bibliografia",
      },
    ],
    subTitulo: "",
    titulo: "Adulto com suspeita de varíola os macacos",
    tsPublicacao: 1.23456789e9,
    shortname: "Adulto com suspeita de varíola os macacos",
  },
  {
    _id: ObjectId("63658eb741e46f062ffeb744"),
    autor: ["Dóris Schuch", "Marcínia Bueno"],
    editores: ["Everton Fantinel", "Denise Silveira"],
    id: 9075.0,
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "41 anos",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "interdisciplinar",
    slides: [
      {
        conteudo: { texto: "", delay: "5" },
        titulo: "Introdução",
        tipo: "intro",
      },
      {
        conteudo: {
          descricaoCaso:
            "\u003cp\u003eNa tarde do dia 31 de janeiro a médica da equipe ESF de Lagoa dos Ventos, zona rural do Município de Jacarandá, entrou em contato com a Vigilância Epidemiológica (VE) municipal em razão de dois atendimentos feitos no último dia 28. Segundo a profissional, duas pessoas da mesma família haviam procurado atendimento médico na unidade apresentando queixa de febre, cefaleia intensa e mialgia. Tratava-se de uma dona de casa de 35 anos, S.L.C., e sua mãe de 67 anos, M.L., que residia no mesmo domicílio.\u003c/p\u003e\u003cp\u003eA médica informou que sua hipótese inicial ao atender S.L.C. era de síndrome gripal, mas ao exame físico percebeu que as cadeias de linfonodos cervicais apresentavam-se com volume muito aumentado e dolorosos a palpação. Ao ser questionada sobre estes achados a paciente informou que percebeu o aumento dos linfonodos e a dor local concomitantemente ao aparecimento da febre. M.L. também apresentava aumento dos linfonodos cervicais ainda que não fosse tão expressivo quanto os de sua filha. A médica relatou que outros familiares viviam com as pacientes na residência: o esposo da S.L.C.,  L.A.C. (40 anos) e os filhos R.L.C. (6 anos), C.L.C. (9 anos), P.L.C. (12 anos) e M.L.C. (14 anos).\u003c/p\u003e\u003cp\u003eA médica prescreveu alguns medicamentos para controle dos sintomas e solicitou retorno na semana seguinte para reavaliação do quadro. Mas, na manhã do dia 31/01, S.L.C. retornou a unidade de saúde e relatou que estava bastante preocupada, porque no final de semana seu filho de 9 anos apresentara febre, dor e inchaço no pescoço e ela percebeu que ele também tinha “aumento de gânglio” no local. Seu esposo havia levado o menino para atendimento no Pronto Socorro na cidade, de onde retornaram com receita de alguns medicamentos para febre e dor. \u003c/p\u003e",
        },
        titulo: "Descrição do Caso",
        tipo: "descricaocaso",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA toxoplasmose adquirida após o nascimento é uma infecção muito comum, mas de manifestação clínica rara, ou seja, a maioria das pessoas infectadas não apresenta sintomas. Quando ocorrem sintomas, o quadro mais característico da fase aguda é a linfadenopatia localizada, em geral envolvendo os nódulos linfáticos cervicais posteriores (mais raramente, linfadenopatia generalizada), podendo ser acompanhado por febre. Eventualmente, pode haver acometimento pulmonar, cardíaco, hepático ou cerebral – especialmente em imunocomprometidos.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "linfadenopatia localizada, em geral envolvendo os nódulos linfáticos cervicais posteriores",
              true,
            ],
            [
              "vômito persistente associado a febre baixa e linfadenopatia generalizada",
              false,
            ],
            [
              "diarreia prolongada, juntamente com febre moderada, cefaleia e mialgia intensas",
              false,
            ],
            [
              "mialgia em membros inferiores e linfadenopatia localizada em região inguinal",
              false,
            ],
          ],
        },
        pergunta:
          "A maioria dos casos de toxoplasmose é assintomática. No entanto, quando ocorrem sintomas, o quadro mais característico da fase aguda é:",
        titulo: "Questão 1",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eCaracterísticas gerais da toxoplasmose\u003c/h3\u003e\u003cp\u003eA toxoplasmose é uma zoonose causada por um protozoário. Sua distribuição geográfica é mundial, sendo uma das zoonoses mais difundidas. No Brasil, a infecção apresenta alta prevalência.\u003c/p\u003e\u003cp\u003eO agente etiológico é o \u003ci\u003eToxoplasma gondii\u003c/i\u003e, cujos reservatórios (hospedeiros definitivos)  são os gatos e outros felídeos. Todos os outros animais de sangue quente, assim como o ser humano, são hospedeiros intermediários. Em humanos, o período de incubação é estimado em 10 a 23 dias após a ingestão de cistos teciduais, e de 5 a 20 dias após a ingestão de oocistos.(BRASIL, 2022)\u003c/p\u003e\u003cp\u003eS.L.C. então buscou orientação com a médica da ESF Lagoa dos Ventos, sobre a possibilidade de transmissão aos demais irmãos, bem como se poderiam ela e a mãe também estarem com a mesma doença. A médica verificou no prontuário da família que as crianças estavam com as doses da tríplice viral e dos outros imunizantes do calendário vacinal em dia. Passou então a avaliar com mais detalhamento os casos na perspectiva de estar frente a um surto intrafamiliar e, neste momento, considerou a possibilidade de infecção por \u003ci\u003eToxoplasma Gondii\u003c/i\u003e, protozoário que é o agente etiológico da Toxoplasmose. Neste sentido agendou visita domiciliar para avaliar as crianças e demais familiares e contatou a Vigilância Epidemiológica relatando sua suspeita.\u003c/p\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA toxoplasmose adquirida deve ser diferenciada das síndromes mononucleose-símiles e síndromes febris tais como as causadas pelos vírus Epstein-Barr, HIV, citomegalovírus, herpesvírus humano 6, arboviroses, herpes simplex tipo 1, adenovírus e vírus da hepatite B.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Epstein-Barr", true],
            ["HIV", true],
            ["Citomegalovírus", true],
            ["da hepatite B", true],
            ["da varicela", false],
          ],
        },
        pergunta:
          "Alguns casos de infecção aguda da toxoplasmose podem se manifestar com sintomas bastante inespecíficos, que são comuns a outras doenças. São exemplos, as doenças causadas pelos vírus:",
        titulo: "Questão 2",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eDiagnóstico diferencial de outras formas de toxoplasmose:\u003c/h3\u003e\u003cp\u003e\u003cul\u003e\u003cli\u003eToxoplasmose congênita: infecções do grupo TORCH (citomegalovírus, rubéola, herpes simples), sífilis, arboviroses, sepse bacteriana, varicela congênita e processos não infecciosos, como isoimunização Rh e malformações congênitas.\u003c/li\u003e\u003cli\u003eToxoplasmose ocular: além das infecções do grupo TORCH, o diagnóstico diferencial inclui toxocaríase, tuberculose, aids, retinoblastoma, persistência de corpo vítreo primário hiperplásico e colobomas\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e\u003ch6\u003e(BRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eNa tarde do dia 31/01 a equipe da VE acompanhou a médica e a enfermeira da ESF na visita domiciliar, iniciando a investigação. Verificaram que a família residia em uma pequena propriedade rural onde cultivavam hortaliças, legumes e frutas e também criavam galinhas para produção de ovos. Estes eram utilizados para consumo da família e comercialização. Tinham algumas vacas leiteiras cujo leite era utilizado para consumo e produção de queijos e doces. Além disso, a família criava suínos, também para consumo próprio. A propriedade era abastecida por água oriunda de um poço (solução alternativa). Na propriedade havia ainda seis cães e dois felinos, que ficavam restritos ao ambiente externo e galpão, não circulando na residência. \u003c/p\u003e\u003cp\u003eNa visita domiciliar foi avaliada a evolução clínica de C.L.C., S.L.C. e da M.L., que ainda apresentavam sintomas de mialgia e linfadenopatia cervical. Na entrevista com M.L.C. foi constatado que ele também estava com linfadenopatia cervical dolorosa, queixava de falta de apetite e de ter tido calafrios na noite anterior (30/01). Os demais familiares foram examinados e negaram sintomas. A  partir destas primeiras informações, a VE conferiu a data de início da doença de cada caso e quais foram os sintomas apresentados até aquela data (Tabela 1).\u003c/p\u003e\u003cimg src='img/caso15_figura_1_TOXOPLASMOSE.png'/\u003e\u003cH6\u003eTabela 1. Informações sobre os casos suspeitos de toxoplasmose. Jacarandá, 2021.\u003c/H6\u003e\u003cp\u003eApós esta etapa, foi realizada coleta de amostras (sangue) para pesquisa de toxoplasmose e realizada a notificação de suspeita do surto aos níveis hierárquicos superiores do sistema de VE. Tais amostras foram encaminhadas para análise no laboratório de saúde pública de referência.\u003c/p\u003e\u003cp\u003eAo mesmo tempo, a VE também comunicou a suspeita de surto para as Vigilâncias Ambiental (VA) e Sanitária (VS), que iniciaram a investigação conjunta sobre a possível fonte de infecção, verificando as possibilidades de infecção por via hídrica e/ou alimentar. \u003c/p\u003e\u003cp\u003eA VE também iniciou a busca ativa de outros casos com sintomas similares que pudessem ter sido atendidos nos serviços de saúde locais, mas não foi encontrado qualquer registro compatível.\u003c/p\u003e\u003cp\u003eConsiderando a hipótese de surto de toxoplasmose aguda e tendo em vista o período de incubação (entre 10 a 23 dias) a equipe de Vigilância em Saúde procedeu a investigação retrospectiva para avaliar a provável data de exposição.\u003c/p\u003e\u003cp\u003eA VS fez então avaliação referente aos alimentos quanto à origem, formas de preparo, manipulação e conservação. Foi realizada coleta de amostras de água utilizada para consumo da família e preparo de alimentos, além de coletas de amostras do salame, da linguiça e da carne suína (esta se encontrava congelada para consumo posterior, no momento da investigação) e de hortaliças produzidas pela família, sendo encaminhadas para os laboratórios de análise da água de consumo humano e de pesquisa bromatológica do laboratório de saúde pública de referência.\u003c/p\u003e\u003cp\u003eNa busca retrospectiva sobre produção e consumo de produtos cárneos na propriedade  ingeridos no período imediatamente anterior ao compreendido pelo período de incubação dos casos, S.L.C. referiu que o último abate de suíno teria sido no final do ano anterior, para um churrasco. Além da carne utilizada nesta refeição, foram produzidos salame e linguiça. Parte da produção de linguiça se encontrava armazenada na banha e alguns salames ainda estavam estocados para aprimorar a cura, em uma cozinha externa contígua à residência. Participaram desta refeição do final de ano a família de seu irmão que residia na cidade de Plátanos, distante 120 km de Jacarandá: irmão R.L. (39 anos), sua esposa A.L. (32 anos), e seus filhos, P.L. de 10 anos, J.O.L. de 12 anos, J.A.L. de 9 meses e a babá E.B. (30 anos). O irmão retornou para a cidade de residência no dia 05 de janeiro e levou consigo parte da carne suína, do salame e da linguiça na banha, além de ovos, hortaliças, e doces produzidos pela família (ambrosia, doce de pêssego e geléia de uva).\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA forma mais amplamente difundida de diagnóstico e mais empregada na prática clínica é a pesquisa de anticorpos. As quatro alternativas estão corretas.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "entre 15 e 40 dias após a infecção é possível detectar anticorpos contra o parasita principalmente das classes IgM e IgA",
              true,
            ],
            [
              "entre uma e quatro semanas após o início da produção dos anticorpos das classes IgM e IgA, se inicia a produção dos anticorpos da classe  IgG",
              true,
            ],
            [
              "inicialmente, são produzidos anticorpos da classe IgG de baixa avidez e, após cerca de três a quatro meses, são produzidos os de alta avidez",
              true,
            ],
            [
              "os anticorpos da classe IgG costumam permanecer detectáveis pelo restante da vida dos indivíduos",
              true,
            ],
          ],
        },
        pergunta:
          "O diagnóstico da toxoplasmose é realizado pela identificação de anticorpos específicos contra o parasito. Com relação ao diagnóstico sorológico da toxoplasmose é correto afirmar que:",
        titulo: "Questão 3",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eDiagnóstico laboratorial da Toxoplasmose\u003c/h3\u003e\u003cp\u003eEntre 15 e 40 dias, aproximadamente, após a infecção, já é possível detectar anticorpos dirigidos contra o parasita no soro obtido de sangue periférico. Nesse primeiro momento, os anticorpos são principalmente das classes IgM e IgA, e, embora essa produção não pudesse ser documentada com as técnicas usadas no passado, elas ocorrem e perduram por muitos meses e até anos após a infecção aguda. Essa é a razão pela qual, em face de um resultado de IgM ou IgA positivo, a principal preocupação deve ser determinar se elas representam episódio recente ou a continuidade de produção (durante meses ou anos) após a infecção original.\u003c/p\u003e\u003cp\u003eEntre uma e quatro semanas após o início da produção dos anticorpos das classes IgM e IgA, ocorre o chamado switch de isótipo e se inicia a produção de IgG. Inicialmente, são produzidos anticorpos IgG de baixa avidez e, após cerca de três a quatro meses, os anticorpos da classe IgG produzidos são de alta avidez na ligação com os antígenos. A avidez de anticorpos IgG contra toxoplasmose baseia-se na crescente avidez que os anticorpos apresentam pelo antígeno ao longo do tempo. É um auxiliar valioso para o diagnóstico de infecção antiga: quando são encontrados anticorpos específicos da classe IgG com alta avidez (maior do que 60%), a infecção ocorrida já data de, pelo menos, 3 meses. O resultado do teste com avidez baixa (menor do que 30%) sugere que a infecção seja recente, com menos de 3 meses, mas, em alguns casos, a avidez pode permanecer baixa por vários meses, o que impede uma interpretação segura. Os anticorpos da classe IgG costumam permanecer detectáveis pelo restante da vida dos indivíduos, embora eles possam, em determinadas situações, atingir níveis muito baixos e não serem mais detectados por uma ou outra metodologia.\u003c/p\u003e\u003cp\u003eCasos suspeitos com resultado de anticorpos da classe IgM positivo e IgG negativo necessitam de uma segunda coleta de exame cerca de duas semanas após a primeira para diferenciar infecção aguda de IgM falso-positivo. Apesar da detecção de anticorpos IgM específicos ser o teste mais utilizado para o diagnóstico da infecção aguda, estes podem permanecer detectáveis por um longo período. Sorologias para citomegalovírus, mononucleose, sífilis e Coxsackie podem ser solicitadas para afastar a reação cruzada de IgM. Em municípios sem disponibilidade para esta segunda coleta, os casos suspeitos que apresentem anticorpos da classe IgM positivo e IgG negativo serão considerados casos confirmados. citomegalovírus, mononucleose, sífilis e \u003ci\u003eCoxsackie\u003c/i\u003e\u003c/p\u003e\u003ch6\u003eQuadro 1. Interpretação do resultado segundo o resultado da sorologia IgG e IgM para toxoplasmose.\u003c/h6\u003e\u003cp\u003e\u003ctable class='table table-striped table-bordered table-sm table-responsive text-justify'\u003e\u003ctr\u003e\u003ctd\u003e\u003cb\u003eIgG\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eIgM\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eInterpretação\u003c/b\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eNegativo\u003c/td\u003e\u003ctd\u003eNegativo\u003c/td\u003e\u003ctd\u003eAusência de contato com o \u003ci\u003eT. gondii\u003c/i\u003e ou infecção muito recente, dentro do prazo de poucos dias em que a resposta imunológica ainda não está detectável.\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eNegativo\u003c/td\u003e\u003ctd\u003eDuvidosa\u003c/td\u003e\u003ctd\u003ePossivelmente infecção precoce ou resultado de IgM falso-positivo\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eNegativo\u003c/td\u003e\u003ctd\u003ePositivo\u003c/td\u003e\u003ctd\u003eO resultado deve ser interpretado com cautela porque pode ser decorrente de uma infecção aguda na fase inicial, em que ainda não positivou a IgG (o que é raro) ou um IgM falso-positivo (o que é mais comum). Será necessário coletar nova amostra depois de duas semanas e a interpretação do resultado da segunda coleta será a seguinte:\u003cul\u003e\u003cli\u003eIgM positivo e IgG positivo = infecção aguda\u003c/li\u003e\u003cli\u003eIgM positivo e IgG negativo = IgM falso-positivo.\u003c/li\u003e\u003c/ul\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eDuvidosa\u003c/td\u003e\u003ctd\u003eNegativo\u003c/td\u003e\u003ctd\u003eIndeterminado\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eDuvidosa\u003c/td\u003e\u003ctd\u003eDuvidosa\u003c/td\u003e\u003ctd\u003eIndeterminado\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eDuvidosa\u003c/td\u003e\u003ctd\u003ePositivo\u003c/td\u003e\u003ctd\u003ePossivelmente infecção aguda\u003c/td\u003e\u003c/tr\u003e \u003ctr\u003e\u003ctd\u003ePositivo\u003c/td\u003e\u003ctd\u003eNegativo\u003c/td\u003e\u003ctd\u003eInfecção por ≥ 6 meses\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003ePositivo\u003c/td\u003e\u003ctd\u003eDuvidosa\u003c/td\u003e\u003ctd\u003eInfecção provavelmente por \u003e 1 ano ou resultado de IgM falso-positivo\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003ePositivo\u003c/td\u003e\u003ctd\u003ePositivo\u003c/td\u003e\u003ctd\u003eEste resultado é sugestivo de infecção recente nos últimos 12 meses ou resultado IgM falso positivo. A confirmação deve ser feita com o teste da avidez.\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003c/p\u003e\u003ch6\u003e(GRANATO, 2014; CDC, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eNo dia 4 de fevereiro saíram os resultados das sorologias das amostras coletadas em 31/01/2021:  anticorpos da classe IgG e IgM de todos e teste de avidez para IgG para os casos suspeitos resultados reagentes na pesquisa de anticorpos da classe IgM e IgG  (Tabela 2). \u003c/p\u003e\u003ch6\u003eTabela 2. Resultado da sorologia para toxoplasmose dos primeiros casos. Jacarandá, 2022.\u003c/h6\u003e\u003cimg src='img/caso15_figura_3_TOXOPLASMOSE.png'/\u003e\u003cp\u003eMediante o resultado destes exames, confirmou-se a infecção por toxoplasmose aguda em S.L.C. e C.L.C. Como M.L. e M.L.C. apresentaram anticorpos da classe IgM reagente para \u003ci\u003eT. gondii\u003c/i\u003e e anticorpos da classe IgG não reagente foi necessário a coleta de segunda amostra de IgM e IgG em duas semanas para fazer a distinção entre infecção aguda ou resultado de IgM falso-positivo. Com dois casos confirmados de toxoplasmose e dois possíveis casos na família de S.L.C., a VE de Jacarandá comunicou-se com a VE Estadual para discutir sobre a necessidade de averiguar os familiares de S.L.C., que residiam no município de Plátanos, em busca de possíveis casos de toxoplasmose. \u003c/p\u003e\u003cp\u003eAssim, de imediato, a equipe da VE do município de Plátanos iniciou esta etapa da investigação e, ao contatar a família de S.L.C. por telefone para agendamento de visita, foi informada que R.L., irmão de S.L.C., vinha apresentando forte cefaleia, dor nos olhos, dor nos braços e pernas, um cansaço muito intenso e visão turva desde o dia 25 de janeiro. A visita à família foi então agendada para o dia seguinte (05/02/2021). \u003c/p\u003e\u003cp\u003eDurante a entrevista domiciliar A.L., esposa de R.L., referiu que vinha apresentando cefaleia, muita dor no corpo e febre desde o dia 04/02/021, mas que não havia realizado consulta. Também relatou que nenhum dos filhos apresentou sintomas de doença. Neste mesmo dia, a equipe da VE de Plátanos tomou conhecimento pela VE de Jacarandá sobre o surto de toxoplasmose na família da irmã de R.L. Consequentemente, foi levantada a hipótese de que os sintomas apresentados por R.L. e A.L. fossem decorrentes também de uma possível infecção pelo mesmo protozoário. Informaram ainda que alguns alimentos e água já haviam sido coletados e que as análises laboratoriais estavam sendo aguardadas. Então, por ora, estava recomendado que não fossem consumidos eventuais estoques de produtos trazidos da casa de S.L.C. R.L. e A.L. concordaram com a coleta de amostra de sangue deles e dos demais membros da família, o que foi realizado em 07/02/2021. \u003c/p\u003e\u003cp\u003eA família não tinha informações sobre E.B., babá de J.A.L., já que a mesma se encontrava em férias desde 10 de janeiro, mas forneceram o telefone e endereço de E.B. para a equipe de vigilância. Em contato com E.B., a mesma foi informada sobre o motivo da investigação e questionada sobre a apresentação de algum sintoma. E.B. relatou apresentar febre, dor de cabeça, intensa dor localizada nos joelhos e aumento de gânglios no pescoço que eram muito dolorosos desde o dia 01/02/2021, mas que não havia buscado atendimento médico por acreditar tratar-se de gripe. Sobre o consumo de carne suína e seus produtos, no final de ano na casa de familiares de seus patrões, em Jacarandá, E.B. informou que consumiu salame e carne assada (lombinho de porco). Na semana antes das férias, também consumiu salame na casa onde trabalhava. Foi realizada a coleta de amostra sanguínea para sorologia no dia 07/02/2021. \u003c/p\u003e\u003cp\u003eNo município de Jacarandá, L.A.C., filho de S.L.C., apresentou sintomas suspeitos de toxoplasmose (febre e linfadenomegalia) no dia 07/02/2021 e realizou coleta de amostra para pesquisa laboratorial de anticorpos no mesmo dia do início do quadro clínico.\u003c/p\u003e\u003cp\u003eNo dia 14/02/2021 foram disponibilizados os resultados das sorologias das amostras coletadas em 07/01/2021 (Tabela 3). \u003c/p\u003e\u003ch6\u003eTabela 3. Resultado da sorologia para toxoplasmose da família de R.L.  e E.B. Jacarandá, 2022.\u003c/h6\u003e\u003cimg src='img/caso15_figura_4_TOXOPLASMOSE.png'/\u003e\u003cp\u003eDe acordo com os resultados dos exames da família de R.L. e de E.B., três pessoas estavam com toxoplasmose e uma necessitou realizar segunda coleta de sangue para definir sua situação (P.L.).  Em contato com a VE de Jacarandá para comunicar estes resultados, a VE de Plátano soube do resultado de L.A.C.: anticorpos da classe IgM e IgG reagentes e baixa avidez para IgG. Todos os casos com coleta de segunda amostra duas semanas após a primeira resultaram em IgM reagente e IgG reagente.\u003c/p\u003e\u003cp\u003eAo fim da investigação a VE contabilizou nove casos cuja fonte provável eram alimentos produzidos e consumidos na residência (Figura 1).\u003c/p\u003e\u003cp\u003eA análise das amostras da água de consumo humano, das hortaliças e as que estavam no refrigerador da família de S.L.C. não detectou presença de oocistos de Toxoplasma gondii. Por outro lado, a análise das amostras dos produtos cárneos detectou o protozoário em alimentos no salame curado, na linguiça crua (na banha) e na carne suína crua (congelada). Desta maneira foi estabelecido o nexo causal com a fonte de infecção.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003elavagem das mãos completamente após o manuseio da carne crua e a higienização adequada dos utensílios e bancadas evita a contaminação cruzada de outros alimentos. Esse tipo de cuidado deve se estender a utilização de água fervida ou filtrada para a lavagem dos utensílios e superfícies que têm contato com alimentos e carnes cruas. O leite e outros produtos lácteos elaborados com leite não pasteurizado podem conter taquizoítos de \u003ci\u003eT. gondii\u003c/i\u003e, devendo ser evitados por este motivo. As carnes vermelhas e frutos do mar devem ser cozidos adequadamente para garantir sua segurança. Provar estes alimentos antes do processo de cocção estar completo também pode permitir que sejam ingeridos cistos de \u003ci\u003eT. gondii\u003c/i\u003e.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "Lavar as mãos com água tratada e sabão após o manuseio da carne, das tábuas de corte, pratos, bancadas e utensílios",
              true,
            ],
            [
              "Ferver ou filtrar a água para lavar alimentos e utensílios de cozinha",
              true,
            ],
            [
              "Evitar beber leite e produtos lácteos elaborados com leite não pasteurizado",
              true,
            ],
            [
              "As carnes vermelhas devem ser cozidas até perder completamente a cor avermelhada",
              true,
            ],
            ["Frutos do mar, incluindo mariscos, devem ser bem cozidos", true],
          ],
        },
        pergunta:
          "Diante da ocorrência do surto de toxoplasmose transmitido por alimentos contaminados, as seguintes orientações para prevenção devem ser recomendadas:",
        titulo: "Questão 4",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eMedidas de prevenção e controle\u003c/h3\u003e\u003cp\u003eA promoção de ações de educação em saúde é a principal medida de prevenção da toxoplasmose. Os grupos prioritários destas ações são as mulheres em idade fértil e pessoas com imunidade comprometida. Cabe aos serviços de saúde promover essa educação informando a população sobre as formas de evitar a  contaminação por \u003ci\u003eT. gondii\u003c/i\u003e, o que inclui a higiene alimentar, o consumo de água filtrada ou fervida e o controle da exposição a fontes ambientais contaminadas.\u003c/p\u003e\u003cp\u003eAs medidas coletivas com iniciativas do poder público visam apoiar a prevenção primária por meio do provimento de água tratada livre de oocistos do parasito. A indústria da carne deve empregar boas práticas de produção para reduzir a presença de \u003ci\u003eT. gondii\u003c/i\u003e na carne, tais como manter gatos e roedores fora das áreas de produção de alimentos e usar fonte de água limpa ou adequadamente tratada para os animais. A indústria agrícola deve empregar boas práticas de produção para reduzir a contaminação de culturas por oocistos. O governo deve encorajar, ajudar e apoiar pesquisas sobre métodos para reduzir a contaminação do meio ambiente com oocistos e cistos de \u003ci\u003eT. gondii\u003c/i\u003e na carne.\u003c/p\u003e\u003cp\u003ePara a prevenção primária por meio de medidas individuais é necessário:\u003cul\u003e\u003cli\u003eGarantir a higiene alimentar,\u003c/li\u003e\u003cli\u003eConsumir todos os tipos de carnes bem cozidos, incluindo carne suína, frangos e outros. Carnes vermelhas devem ser cozidas até perderem a cor vermelha. O congelamento inativa cistos teciduais. A produção dos embutidos curados e ou defumados não inativa cistos teciduais.\u003c/li\u003e\u003cli\u003eEvitar contaminação cruzada de carne crua com outros alimentos, fazendo higienização adequada das mãos, bancadas, utensílios e recipientes usados no manuseio de carnes cruas.\u003c/li\u003e\u003cli\u003eBeber água filtrada ou fervida e não consumir bebidas, sucos e alimentos produzidos com água não fervida ou filtrada\u003c/li\u003e\u003cli\u003eOnde não há saneamento básico filtrar e ferver a água, não só para uso em alimentos e bebidas, mas também para higienização de legumes, verduras e frutas utilizados in natura bem como para higiene pessoal (p. ex.: escovar dentes)\u003c/li\u003e\u003cli\u003eEvitar consumir leite e produtos lácteos in natura porque podem conter taquizoítos (forma rápida de multiplicação do \u003ci\u003eT. gondii\u003c/i\u003e)\u003c/li\u003e\u003cli\u003eNão alimentar gatos com carne crua ou mal passada.\u003c/li\u003e\u003cli\u003eGarantir a higiene na produção de animais suínos com o fornecimento de água de qualidade e alimentação controlada de contaminação aos animais.\u003c/li\u003e\u003cli\u003eGarantir o manejo do ambiente de criação de suínos evitando contaminação por fezes de animais e presença de roedores e outras espécies animais.\u003c/li\u003e\u003cli\u003ePrevenir a exposição de gestantes e indivíduos imunocomprometidos a alimentos potencialmente contaminados, que não sofreram cocção adequada, bem como evitando manuseio de areia e jardinagem sem proteção das mãos e realizando a higienização com água e sabão após a manipulação de produtos cárneos crus\u003c/li\u003e\u003cli\u003eNão “experimentar” produtos cárneos antes da cocção estar completa.\u003cli\u003eInutilização e descarte adequado de alimentos cárneos de suíno armazenados que foram produzidos no sítio da família no final do ano.\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e\u003ch6\u003eBRASIL, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eA equipe da Vigilância em Saúde (VE, VA e VS) não enfrentou barreiras para a realização desta investigação.\u003c/p\u003e\u003ch6\u003eFigura 1. Relatório final da investigação epidemiológica de DTA. SINAN, 2022.\u003c/h6\u003e\u003cimg src='img/caso15_figura_5_TOXOPLASMOSE.png'/\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: [
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/guia_vigilancia_saude_5ed_rev_atual.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. \u003cb\u003eGuia de Vigilância em Saúde\u003c/b\u003e [recurso eletrônico] / Ministério da Saúde, Secretaria de Vigilância em Saúde. Departamento de Articulação Estratégica de Vigilância em Saúde. – 5. ed. – Brasília: Ministério da Saúde, 2022.",
          },
          {
            urlExterno: "https://www.cdc.gov/dpdx/toxoplasmosis/index.html",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "CDC. Centers for Disease Control and Prevention. \u003cb\u003eToxoplasmosis\u003c/b\u003e. 2022. Disponível",
          },
          {
            urlExterno: "",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "GRANATO, C.F.H., and PAULINI JUNIOR, I.J. Diagnóstico Laboratorial da Toxoplasmose. In: SOUZA, W., and BELFORT JR., R., comp. \u003cb\u003eToxoplasmose \u0026 Toxoplasma gondii\u003c/b\u003e [online]. Rio de Janeiro: Editora Fiocruz, 2014",
          },
          {
            urlExterno:
              "https://www.ufrgs.br/telessauders/documentos/telecondutas/tc_toxoplasmosegestacao.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "UNIVERSIDADE FEDERAL DO RIO GRANDE DO SUL. Faculdade de Medicina. Programa de Pós-Graduação em Epidemiologia. TelessaúdeRS (TelessaúdeRS-UFRGS). \u003cb\u003eTelecondutas: toxoplasmose na gestação:\u003c/b\u003e versão digital 2022. Porto Alegre: TelessaúdeRS-UFRGS, 10 out 2022. Disponível",
          },
        ],
        tipo: "bibliografia",
      },
    ],
    subTitulo: "",
    titulo: "Duas pessoas da mesma família com linfadenopatia",
    tsPublicacao: 1.23456789e9,
    shortname: "Duas pessoas da mesma família com linfadenopatia",
  },
  {
    _id: ObjectId("6369412741e46f1a322f6a06"),
    autor: ["José Rosa"],
    editores: ["Everton Fantinel", "Denise Silveira"],
    id: 9076.0,
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "41 anos",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "interdisciplinar",
    slides: [
      {
        conteudo: { texto: "", delay: "5" },
        titulo: "Introdução",
        tipo: "intro",
      },
      {
        conteudo: {
          descricaoCaso:
            "\u003cp\u003eNa manhã do dia 25/01/2021, o pronto socorro municipal de Flor da Serra notificou a Vigilância Epidemiológica (VE) por telefone sobre o atendimento de duas mulheres com diarreia e vômito, ambas cozinheiras em uma empresa de móveis do município. Ambas relataram, que outros funcionários da empresa estavam doentes, com os mesmos sintomas.\u003c/p\u003e\u003cp\u003eA partir da notificação verbal foi necessário confirmar a informação de que havia outros funcionários com diarreia aguda ou em absenteísmo por esse motivo.\u003c/p\u003e",
        },
        titulo: "Identificação do surto",
        tipo: "descricaocaso",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA presença de diarreia e vômitos, sintomas de doença diarreica aguda, direcionam a suspeita sobre agentes etiológicos de transmissão fecal-oral, configurando-se na suspeita de surto de doença de transmissão hídrica alimentar (DTHA).\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["endemia de doença de transmissão hídrica e alimentar", false],
            ["surto de doença de transmissão hídrica e alimentar", true],
            ["epidemia de doença de transmissão hídrica e alimentar", false],
            ["pandemia de doença de transmissão hídrica e alimentar", false],
          ],
        },
        pergunta:
          "Com base nestas informações preliminares, presume-se tratar-se de um(a) provável:",
        titulo: "Questão 1",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eDoenças de transmissão hídrica e alimentar\u003c/h3\u003e\u003cp\u003eAs Doenças de Transmissão Hídrica e Alimentar (DTHA) são aquelas causadas pela ingestão de água e/ou alimentos contaminados. Existem mais de 250 tipos de DTHA no mundo, e a maioria delas é infecções causadas por bactérias e suas toxinas, vírus e parasitos intestinais oportunistas, além das intoxicações exógenas causadas pelo consumo de substâncias químicas presentes nos alimentos.\u003c/p\u003e\u003cp\u003eA VE-DTHA é realizada a partir do monitoramento de casos e surtos e compreende a VE de algumas doenças de notificação compulsória como cólera, botulismo, febre tifoide, toxoplasmose adquirida na gestação e congênita, surtos DTHA e das de notificação em unidades sentinelas, como doenças diarreicas agudas, rotavírus e síndrome hemolítico-urêmica. Além dessas, há alguns eventos de saúde pública (ESPs) que se constituem ameaça à saúde pública e, devido à transmissibilidade por água/alimentos, à presença de sinais e sintomas gastrointestinais ou à transversalidade das ações de prevenção e controle, estão diretamente relacionadas com a VE-DTHA e devem ser monitorados em conjunto, como é o caso daqueles relacionados à doença de Chagas (transmissão oral), brucelose e intoxicação exógena.\u003c/p\u003e\u003ch3\u003eDefinição de surto de DTHA\u003c/h3\u003e\u003cp\u003eÉ considerado surto de DTHA quando duas ou mais pessoas apresentam doença ou sinais e sintomas semelhantes após ingerirem alimentos e/ou água da mesma origem, normalmente em um mesmo local.\u003c/p\u003e\u003ch3\u003eNotificação de surto de DTHA\u003c/h3\u003e\u003cp\u003eA notificação de um surto de DTHA deve ser feita diante da evidência epidemiológica de exposição a uma fonte comum de água ou alimento. Qualquer unidade de saúde pode realizar a notificação e a comunicação à Secretaria Municipal de Saúde, assim que tomar conhecimento.\u003c/p\u003e\u003cp\u003eA notificação do surto de DTHA é formalmente realizada através do preenchimento da Ficha de Investigação de Surto – DTA (Figura 1).\u003c/p\u003e\u003ch6\u003eFigura 1.  Ficha de Investigação de Surto - DTA/Sistema de Informação de Agravos de Notificação. Brasil, 2021.\u003c/h6\u003e\u003ctable\u003e\u003ctr\u003e\u003ctd\u003e\u003cimg src='img/caso8_figura1_DTA.png'/\u003e\u003c/td\u003e\u003ctd\u003e\u003cimg src='img/caso8_figura1_1_DTA.png'/\u003e\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003cp\u003eA vigilância das DTHA deve incluir todos os serviços que realizam o diagnóstico clínico ou laboratorial de doentes (como hospitais, emergências, laboratórios de análises clínicas, serviços de saúde públicos ou privados), bem como, a detecção de alimentos ou água contaminados (laboratórios de análises bromatológicas, concessionárias de água, agricultura e meio ambiente). Locais de maior risco, como internatos, escolas, creches, presídios, clínicas geriátricas e quartéis, por exemplo, também devem ser considerados como potenciais fontes de notificação de surtos de DTHA.\u003c/p\u003e\u003cp\u003eInformações prestadas por outras fontes não convencionais como pessoas da comunidade, rumores, notícias, ou reclamações sobre alimentos suspeitos devem ser avaliadas quanto à possibilidade de estarem associadas à ocorrência de surtos de DTHA.É imprescindível que a notificação seja imediata ao setor municipal de saúde responsável pela vigilância epidemiológica. Devem-se usar os meios de comunicação mais rápidos e disponíveis (Ex.: telefone, fax, correio eletrônico, telegrama).\u003c/p\u003e\u003cp\u003eA investigação segue seu curso identificando os comensais (doentes e não doentes), o local, a data e a hora de exposição e os alimentos envolvidos (origem, preparo, manipuladores, etc.) e a fonte de água.\u003c/p\u003e\u003ch6\u003e(BRASIL 2010, 2018, 2022)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eDando andamento à investigação, um dos técnicos da VE iniciou o preenchimento da Ficha de Investigação de Surto - DTA campos “Dados Gerais”, “Notificação de Surto” e “Dados de Ocorrência” (Figura 2), seguindo o protocolo, e acionou a equipe de segurança do trabalho da referida empresa, por telefone e por e-mail, bem como as equipes da Vigilância Sanitária (VS) e da Vigilância Ambiental (VA) da Secretaria Municipal da Saúde, coordenando os passos iniciais da investigação.\u003c/p\u003e\u003ch6\u003eFigura 2. Ficha de Investigação de Surto - DTA, preenchida. Brasil, 2022.\u003c/h6\u003e\u003cimg src='img/caso8_figura2_DTA.png'/\u003e\u003cp\u003eComo resposta, a técnica de enfermagem da empresa de móveis e responsável pelo ambulatório, enviou à VE a lista dos atendimentos ocorridos entre os dias 24 e 25 de janeiro. Estavam registrados 50 funcionários que apresentaram diarreia e vômito, mas nenhum havia referido febre. Haviam doentes tanto no período diurno quanto no noturno. A  empresa disponibilizava uma refeição coletiva em cada turno. A técnica de enfermagem também informou que o almoço e o jantar eram servidos no refeitório localizado dentro da própria empresa. No entanto, o preparo dos alimentos ficavam a cargo de um serviço de cozinha industrial terceirizado.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA investigação requer a coleta de dados sobre os casos, busca de evidências que subsidiem hipóteses, busca ativa de casos, processamento e análises parciais dos dados e a produção do relatório final e outros documentos para comunicação sobre o evento estudado.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["coleta e processamento de dados", true],
            ["análise e interpretação dos dados processados", true],
            [
              "indicação e promoção das medidas de prevenção e controle apropriadas",
              true,
            ],
            ["avaliação da eficácia e efetividade das medidas adotadas", true],
            ["divulgação de informações pertinentes", true],
          ],
        },
        pergunta:
          "As ações da Vigilância Epidemiológica para operacionalização de uma investigação incluem pelo menos:",
        titulo: "Questão 2",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eDando seguimento à investigação, parte dos técnicos da VE solicitaram à nutricionista responsável pelo preparo das refeições na cozinha da empresa o envio do cardápio, descrevendo todos os alimentos servidos no almoço e jantar nos dias 22, 23 e 24 de janeiro, já que o início do surto ocorreu no dia 24. Ao mesmo tempo, os demais integrantes da equipe de vigilância organizavam a lista de comensais para aplicação do Inquérito Coletivo de Surto de DTHA (Figuras 3 e 4). No preenchimento do inquérito é realizada uma entrevista individual com os comensais que permite o registro das informações de identificação dos doentes, dos alimentos consumidos, data e horário de cada refeição suspeita, sinais e sintomas além da data de início do quadro clínico.\u003c/p\u003e\u003ch6\u003eFigura 3. Formulário de Inquérito Coletivo de Surto de Doenças de Transmissão Hídrica e Alimentar. Brasil, 2021\u003c/h6\u003e\u003cimg src='img/caso8_figura3_DTA.png'/\u003e\u003ch6\u003eFigura 4. Complementação do Formulário de Inquérito Coletivo de Surto de Doenças de Transmissão Hídrica e Alimentar. Brasil, 2021.\u003c/h6\u003e\u003cimg src='img/caso8_figura4_DTA.png'/\u003e\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003e A equipe da Vigilância Epidemiológica deve identificar o início dos sintomas e melhor caracterizar o quadro clínico dos comensais e alimentos consumidos, o que irá permitir construir tabelas e calcular as medidas de resumo de uma distribuição.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "fazer o inquérito com os comensais doentes e não doentes, caracterizar os principais sinais e sintomas entre os doentes, estimar o período de incubação entre a ingesta dos alimentos e o início dos sintomas, calcular as taxas de ataque dos alimentos ingeridos.",
              true,
            ],
            [
              "avaliar as condições de saúde dos manipuladores, fazer o inquérito da linha de produção dos alimentos e emitir autos de infração.",
              false,
            ],
            [
              "coletar amostras de água, avaliar a potabilidade da água, definir pontos críticos do abastecimento de água.",
              false,
            ],
            [
              "inspecionar matérias-primas, definir pontos críticos na linha de produção dos alimentos.",
              false,
            ],
          ],
        },
        pergunta:
          " A principal característica da vigilância das DTHA é a necessidade do trabalho em conjunto da vigilância epidemiológica, vigilância sanitária, vigilância ambiental, assistência em saúde, defesa e inspeção agropecuária, laboratório e outras áreas e instituições parceiras para controlar e prevenir os casos e surtos de doenças transmitidas por alimentos. Numa investigação de surto de DTHA, cabe a Vigilância Epidemiológica:",
        titulo: "Questão 3",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eMedidas de resumo de uma distribuição\u003c/h3\u003e\u003cp\u003eMuitas vezes é necessário utilizar um valor resumo que represente a série de valores em seu conjunto, isso é, sua distribuição. Para os dados de variáveis qualitativas e as quantitativas discretas, a proporção ou porcentagem, a razão e as taxas são algumas medidas típicas de resumo. Para os dados de variáveis quantitativas contínuas, no entanto, há medidas que resumem sua tendência para um valor médio (medidas de tendência central) e outras que resumem seu grau de variabilidade (medidas de dispersão). Cada uma proporciona informação complementar e útil para a análise epidemiológica.\u003c/p\u003e\u003ch6\u003eBRASIL 2010,2018,2021)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eNo preenchimento do inquérito de investigação, foi realizada uma entrevista individual com os comensais que permitiu o registro das informações de identificação dos doentes, dos alimentos consumidos, data e horário de cada refeição suspeita, sinais e sintomas além da data de início do quadro clínico. Dessa forma foi possível realizar o cálculo da mediana do período de incubação, das taxas de ataque e do risco relativo de cada alimento, das taxas de prevalência por sexo e faixa etária dos doentes, das taxas de prevalência dos principais sinais e sintomas dos doentes e a distribuição temporal dos casos (entre o primeiro e o último doente).\u003cp\u003eNo preenchimento do inquérito foi realizada uma entrevista individual com os comensais que permitiu o registro das informações de identificação dos doentes, dos alimentos consumidos, data e horário de cada refeição suspeita, sinais e sintomas além da data de início do quadro clínico. Dessa forma foi possível realizar o cálculo da mediana do período de incubação, das taxas de ataque e do risco relativo de cada alimento, das taxas de prevalência por sexo e faixa etária dos doentes, das taxas de prevalência dos principais sinais e sintomas dos doentes e a distribuição temporal dos casos (entre o primeiro e o último doente).\u003c/p\u003e\u003cp\u003eAs Fichas de Inquérito Coletivo foram compiladas na Ficha de Investigação de Surto de Doenças Transmitida por Alimento (Figura 5). Ao final desta etapa, a VE entrevistou 361 pessoas, das quais 219 apresentaram sinais ou sintomas da doença. \u003c/p\u003e\u003ch6\u003eFigura 5.  Ficha de Investigação de Surto - DTA com campos da investigação preenchidos. Flor da Serra, 2021.\u003c/h6\u003e\u003cimg src='img/caso8_figura5_DTA.png'/\u003e\u003cp\u003eVerificou-se que o primeiro doente entre os entrevistados apresentou sinais e sintomas (náusea, vômito, cólica abdominal, diarreia, febre e dor de cabeça) na madrugada do dia 23/01/2021, por volta das 2 horas da manhã. O último caso de doença foi registrado no dia 28/01/2021, com sintomas iniciados às 14 horas. Entre seu início e seu término, o surto durou um período de 6 dias (Figura 6). A mediana do período de incubação foi calculada utilizando as informações relativas ao tempo entre a data da exposição aos alimentos e a data do início dos sintomas, considerando os 219 doentes entrevistados durante o inquérito. Como resultado, a mediana do período de incubação foi de 67 horas e 25 minutos (mínimo: 3 horas e 15 minutos; máximo: 146 horas). É importante ressaltar que o surto foi notificado para o VE com mais de 48 horas de início do primeiro caso (25/01), quando já existiam cerca de 77 doentes na empresa.\u003c/p\u003e\u003ch6\u003eFigura 6. Distribuição dos casos de gastroenterite aguda segundo tempo de incubação. Flor da Serra, 2021.\u003c/h6\u003e\u003cimg src='img/caso8_figura6_DTA.png'/\u003e\u003cp\u003eA \u003cb\u003efigura 7\u003c/b\u003e apresenta o histograma com a distribuição dos casos (doentes) de acordo com o dia do início dos sintomas e o turno de trabalho (diurno ou noturno). De acordo com o histograma a curva apresenta-se com rápida ascensão e descenso gradual, indicando que os casos tiveram exposição a uma fonte comum de infecção ou “fonte pontual”.\u003c/p\u003e\u003ch6\u003eFigura 7. Distribuição dos doentes de acordo com a data de início dos sintomas e turno de trabalho. Flor da Serra, 2021.\u003c/h6\u003e\u003cimg src='img/caso8_figura7_DTA.png'/\u003e\u003cp\u003ePartindo ainda dos sinais e sintomas relatados pelos casos e que foram sintetizados na Ficha de Inquérito Coletivo (Figura 5) o quadro clínico dos doentes demonstrou a predominância de diarreia (68,5%), cólica abdominal (62,6%), náusea (60,7%), cefaleia (55,7%) e distensão abdominal (53,9%). A faixa etária com a maior frequência de doentes foi a de 20 a 49 anos (95,4%), sendo que 52,5% eram do sexo masculino.\u003c/p\u003e\u003cp\u003eNa avaliação dos alimentos consumidos, ressalta-se que a informação da nutricionista foi fundamental para detalhar o cardápio servido em cada refeição suspeita. De acordo com a nutricionista os alimentos servidos incluíram:\u003c/p\u003e\u003cp\u003e22/janeiro\u003c/p\u003e\u003cul\u003e\u003cli\u003eAlmoço (15 pratos): coxa a dorê, salsicha com molho, penne com presunto, arroz, feijão, alface, chicória, repolho, chuchu, mousse de limão, pudim de baunilha, estrogonofe, batata chips, sanduíche, suco.\u003c/li\u003e\u003cli\u003eJantar (11 pratos): coxa à dorê, salsicha com molho, penne com presunto, arroz, feijão, alface, chicória, repolho, chuchu, mousse de limão, suco.\u003c/li\u003e\u003c/ul\u003e\u003cp\u003e23/janeiro\u003c/p\u003e\u003cul\u003e\u003cli\u003eAlmoço (15 pratos): canja, churrasco, farofa, arroz, feijão, alface, cenoura ralada, maionese, gelatina, tortei, espaguete, rigatone, molho de frango, molho branco, suco.\u003c/li\u003e\u003cli\u003eJantar (10 pratos): canja, churrasco, farofa, arroz, feijão, alface, cenoura ralada, maionese, gelatina, suco.\u003c/li\u003e\u003c/ul\u003e\u003cp\u003e24/janeiro\u003c/p\u003e\u003cul\u003e\u003cli\u003eAlmoço (15 pratos): pernil de porco, refogado de legumes, brócolis, arroz, feijão, alface, tomate, grelhado de carne bovina, bolinho de queijo, bolo, suco.\u003c/li\u003e\u003cli\u003eJantar (9 pratos): pernil de porco, polenta, refogado de legumes, arroz, feijão, alface, tomate, suco.\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eOs cálculos das taxas de ataque de cada alimento entre os comensais doentes e não doentes e entre não comensais  doentes e não doentes e, em seguida, da diferença  percentual entre ambas e do risco relativo permitem definir quais alimentos podem estar implicados ou não como  provável responsável pelo surto. \u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            [
              "taxas de ataque de cada alimento entre os comensais doentes e não doentes",
              true,
            ],
            [
              "taxa de ataque para cada alimento entre não comensais  doentes e não doentes",
              true,
            ],
            [
              "diferença percentual entre a taxa de ataque dos comensais e a taxa de ataque dos não comensais",
              true,
            ],
            [
              "razão entre a taxa de ataque dos comensais e a taxa de ataque dos não comensais (risco relativo)",
              true,
            ],
            [
              "coeficiente de correlação das taxas de ataque entre os comensais e não comensais",
              false,
            ],
          ],
        },
        pergunta:
          "As análises estatísticas dos alimentos consumidos devem incluir",
        titulo: "Questão 4",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eOs resultados das análises estatísticas de todos os alimentos consumidos nas refeições servidas (almoço e jantar) dos dias 22/01, 23/01 e 24/01, na empresa de móveis são apresentados no Quadro 1.\u003c/p\u003e\u003cimg src='img/caso8_figura8_DTA.png'/\u003e\u003cimg src='img/caso8_figura9_DTA.png'/\u003e\u003cimg src='img/caso8_figura10_DTA.png'/\u003e\u003ch6\u003eQuadro 1. Taxa de ataque segundo o dia e tipo de alimento consumido. Flor da Serra, 2021.\u003c/h6\u003e\u003cp\u003eA síntese dos resultados das análises estatística mostra que nenhum dos alimentos apresentou simultaneamente as duas medidas que o caracterizariam como provável causador do surto, isto é, maior diferença percentual positiva e maior risco relativo.\u003c/p\u003e\u003cp\u003eAssim, segundo os dados preliminares baseados, exclusivamente, no inquérito epidemiológico com os comensais, o surto apresentava as seguintes características:\u003c/p\u003e\u003cp\u003e\u003cul\u003e\u003cli\u003elongo período de incubação (mediana de 67 horas e 25 minutos) e grande diferença entre o período de incubação mínimo e máximo (3 horas e 15 minutos a 146 horas);\u003c/li\u003e\u003cli\u003elonga duração do surto (6 dias);\u003c/li\u003e\u003cli\u003emaior prevalência de sintomas gastrintestinais (diarreia, cólica abdominal, náuseas) do que sistêmicos;\u003c/li\u003e\u003cli\u003emaior prevalência de cefaleia (55,7%) do que de febre (19,2%);\u003c/li\u003e\u003cli\u003eimpossibilidade de incriminar estatisticamente um dos alimentos consumidos como provável causador do surto.\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eEm uma investigação, para confirmar ou definir o agente etiológico que determinou o surto, geralmente é necessária a coleta de material dos doentes, dos manipuladores de alimentos, que estão envolvidos no preparo, além da análise dos alimentos e da água.\u003c/p\u003e ",
            tipo: "texto",
          },
          opcoes: [
            [
              "coprocultura dos comensais doentes, coprocultura e swab subungueal dos manipuladores de alimentos, análise bromatológica dos alimentos, análise de contaminação e potabilidade da água.",
              true,
            ],
            [
              "coprocultura e swab subungueais dos comensais doentes, coprocultura e swab subungueal dos manipuladores de alimentos, análise bromatológica dos alimentos, análise de contaminação e potabilidade da água.",
              false,
            ],
            [
              "coprocultura e hemocultura dos comensais doentes, coprocultura, hemocultura e swab subungueal dos manipuladores de alimentos, análise bromatológica dos alimentos, análise de contaminação e potabilidade da água.",
              false,
            ],
            [
              "coprocultura dos comensais doentes, coprocultura, hemocultura e swab subungueal dos manipuladores de alimentos, análise bromatológica dos alimentos, análise de contaminação e potabilidade da água.",
              false,
            ],
          ],
        },
        pergunta:
          "Para identificação do agente etiológico que causou este surto pode ser necessária a realização de exames laboratoriais que incluem:",
        titulo: "Questão 5",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eAtividades de campo durante a investigação\u003c/h3\u003e\u003cp\u003eDurante a investigação epidemiológica podem ser necessárias atividade de campo que no caso da  Vigilância Epidemiológica incluem:\u003c/p\u003e\u003cul\u003e\u003cli\u003eOrientar a realização de coletas de amostra biológica(s) em comensais e manipuladores disponíveis, quando for o caso.\u003c/li\u003e\u003cli\u003eAcionar o laboratório, quando for necessária a coleta de amostras específicas.\u003c/li\u003e\u003cli\u003eEncaminhar ao laboratório amostra(s) biológica(s) acompanhada(s) das fichas de notificação/investigação de surto – DTA com as informações disponíveis (casos por faixa etária, período de incubação e principais sintomas) relativas ao surto, de modo a direcionar e facilitar a identificação do agente etiológico.\u003c/li\u003e\u003c/ul\u003e\u003cp\u003ePor outro lado cabe a Vigilância Sanitária:\u003cul\u003e\u003cli\u003eProceder à atividade de campo/ inspeção sanitária no local de origem do surto, identificando os fatores de risco, pontos críticos e intervenção.\u003c/li\u003e\u003cli\u003eColetar e transportar amostras de água e alimentos, conforme metodologia estabelecida pelo laboratório.\u003c/li\u003e\u003cli\u003eAcionar o laboratório, quando for necessária a coleta de amostras específicas.\u003c/li\u003e\u003cli\u003eEncaminhar ao laboratório amostra(s) do(s) alimento(s) suspeito(s) acompanhada(s) de termo legal apropriado contendo informações relativas às condições de coleta e de transporte da(s) amostra(s); e, se possível, período de incubação e principais sintomas (cópia da ficha de investigação).\u003c/li\u003e\u003cli\u003e Independente das equipes envolvidas é imperativo que a comunicação seja assertiva com constante troca de informações com as demais áreas integrantes da investigação epidemiológica. \u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e\u003ch6\u003e(BRASIL, 2021)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eSegundo o Manual de Vigilância das DTA do Ministério da Saúde (2010), entre os agentes microbiológicos cujo período de incubação e cujo quadro clínico mais se aproximariam aos encontrados neste surto poderiam ser incriminados: \u003ci\u003eVibrio cholerae, Escherichia coli patogênica, Salmonella spp, Shigella, Vibrio parahaemolyticus, Vibrio vulnificus, Campylobacter spp, Plesiomonas shigelloides e Aeromonas hidrophila.\u003c/i\u003e\u003c/p\u003e\u003cp\u003eA exposição pessoa-a-pessoa observada em surtos de diarreia mais prolongados e que costumam estar associados a ação de agentes virais como o rotavírus e o norovírus foi inicialmente descartada, devido à baixa prevalência de febre, que é comum nos quadros clínicos causados por estes agentes. A longa duração do surto, bem como, a dificuldade de incriminar estatisticamente um alimento específico suscitou a possibilidade de exposição continuada (por longo período) a uma fonte comum nesta empresa de móveis e que não era necessariamente alimentar. Levando em conta apenas estas considerações e diante da inexistência de dados laboratoriais (análise da água, bromatologia dos alimentos, coprocultura dos doentes e a anamnese dos manipuladores), que ainda estavam em processo de investigação, foi levantada a hipótese da água ser a provável fonte de exposição deste surto.\u003cp\u003eNo dia 25 de janeiro, as equipes da Vigilância Sanitária (VS) e da Vigilância Ambiental (VA) deslocaram-se até a empresa de móveis para realizarem as averiguações necessárias.\u003cp\u003eOs fiscais da VS se dirigiram até a empresa no dia 25/01 a fim de:\u003cul\u003e\u003cli\u003eFazer o levantamento dos ingredientes usados nas refeições, bem como, o inquérito do “passo a passo” do preparo de cada alimento servido, conforme descrito nos Registro das Condições de Preparo e/ou Consumo do(s) Alimento(s) Suspeito(s). Neste processo foram verificados alguns problemas no preparo dos alimentos:\u003cul\u003e\u003cli\u003eausência de registros de controle temperatura dos alimentos na linha de distribuição (buffet) e na sua produção (não havia descrição do horário e/ou turno das temperaturas);\u003c/li\u003e\u003cli\u003efalta de registros sobre os fornecedores, marcas e condições de transporte para a maioria dos alimentos e ingredientes usados, devido à alta “rotatividade” de fornecedores e marcas;\u003c/li\u003e\u003cli\u003eentrega da carne de gado na cozinha em veículo sem refrigeração, estando disposta em sacos plásticos no interior de caixas plásticas;\u003c/li\u003e\u003cli\u003ehigienização dos alimentos “in natura” (vegetais) com água corrente das torneiras da cozinha, mesmo diante da constatação da alteração da sua turbidez.\u003c/li\u003e\u003c/ul\u003e\u003c/li\u003e\u003cli\u003eRealizar a coleta de amostras das refeições servidas nos almoços e jantares dos dias 22 a 24/01. No entanto, não haviam mais amostras disponíveis das refeições servidas no dia 22/01. As amostras coletadas foram enviadas ao LACEN. Das 42 amostras de alimentos enviadas, 19 não foram analisadas. O critério para análise considerou os alimentos que apresentaram as maiores taxas de ataque. Os resultados das análises laboratoriais dos alimentos não detectaram a presença de nenhum dos agentes microbiológicos testados (\u003ci\u003eSalmonella\u003c/i\u003e spp; \u003ci\u003eEscherichia coli\u003c/i\u003e, Estafilococos coagulase positiva, Clostrídios sulfito redutores e \u003ci\u003eBacillus cereus\u003c/i\u003e).\u003c/li\u003e\u003cli\u003eRealizar coprocultura dos funcionários - foi possível coletar amostras de apenas três comensais.\u003cli\u003eRealizar pesquisa de rotavirus nas fezes - foi possível coletar amostras de apenas cinco comensais. As coproculturas foram realizadas em laboratório privado do município de Flor da Serra e os laudos foram disponibilizados no mês de fevereiro. A pesquisa de rotavírus foi realizada no Laboratório Central do Estado (LACEN) e os laudos foram disponibilizados no mês de maio.\u003c/li\u003e\u003cli\u003eRealizar coprocultura e swab subungueal de todos os manipuladores, num total de 12 pessoas envolvidas no preparo dos alimentos servidos no almoço e no jantar. Em relação aos laudos das coproculturas, não houve crescimento de enterobactérias patogênicas nas amostras de nenhum dos manipuladores. Todos os swabs subungueais resultaram negativos para \u003ci\u003eStaphylococcus\u003c/i\u003e coagulase positiva. Presença de \u003ci\u003eStreptococcus\u003c/i\u003e beta hemolítico em uma manipuladora de alimentos e de diversos cocos gram-positivos em outra - a VS solicitou o afastamento imediato dessas duas manipuladoras. Elas deveriam ser tratadas e um novo exame, pós-tratamento, deveria ser feito. Os novos resultados dos exames das manipuladoras não acusaram enfermidades graves, de modo que elas obtiveram autorização para retornar às suas atividades.\u003c/li\u003e\u003cli\u003eSolicitar os alvarás sanitários e outros documentos de adequação à legislação sanitária aos responsáveis da empresa que produzia as refeições dentro de um prazo de 24 horas. A demanda foi atendida pela empresa dentro do prazo, sendo lavrado um Termo de Vistoria, atestando a entrega dos documentos. Após análise da documentação, observou-se que nem todos os documentos entregues estavam de acordo com a legislação, como por exemplo, a formulação dos Procedimentos Operacionais Padronizados.\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e\u003cp\u003eNo dia 25/01, durante a vistoria inicial da cozinha e do refeitório, a nutricionista responsável informou aos fiscais sanitários que a água proveniente do encanamento da empresa de móveis apresentava-se turva. Ela também mostrou aos fiscais três copos contendo água, antes e após a fervura. Por essa razão, a cozinha passou a utilizar água mineral no preparo das refeições. \u003c/p\u003e\u003cp\u003ePor conseguinte, as ações dos técnicos da VA foram focadas no abastecimento de água da empresa, coletando e analisando as amostras da água. Em síntese, foram realizadas coletas de água na empresa em três dias diferentes: em 25/01 (durante a vigência do surto) e em 05/02 pelo laboratório privado contratado pela empresa; e, em 30/01, pelos técnicos da Vigilância Ambiental da Secretaria Municipal de Saúde (análise feita pelo LACEN). As coletas dos dias 30/01 e 05/02 foram realizadas após a limpeza das caixas d’água.\u003c/p\u003e\u003cp\u003eOs achados das análises do laboratório privado foram disponibilizados no dia 06/02/2021 e as alterações constatadas na água foram fundamentais para as equipes de Vigilância em Saúde do município redefinirem as hipóteses sobre as fontes de exposição e sobre os agentes etiológicos do surto. Eles também ajudaram a direcionar as ações de controle e prevenção que deveriam ser orientadas e tomadas para garantir a qualidade da água servida na empresa. O achado microbiológico mais relevante das amostras coletadas no dia 25/01, foi a constatação da presença de Escherichia coli em três bebedouros: do vestiário dos funcionários, da Fábrica 2 e do setor de administração e recepção. Nestes dois últimos setores a concentração de Escherichia coli foi maior que 2.419,6 NMP/ml. Além disso, não foram encontrados coliformes totais em 5 pontos de coleta: do bebedouro e da torneira do vestiário dos funcionários, do bebedouro da Fábrica 2, do bebedouro do setor de administração e recepção e da caixa d’água de 10 mil litros e foram encontradas bactérias heterotróficas acima dos parâmetros 500 UFC/ml nas amostras de água do bebedouro da Fábrica 2, do bebedouro do setor de administração e recepção e da torneira da cozinha (3 pontos de coleta). Relativo às amostras dos cinco pontos de coleta do dia 05/02 (torneira antes do filtro da caixa d’água, caixa d'água de 10 mil litros inferior,  caixa d'água de 20 mil litros inferior, filtro antes das caixas d’água e bebedouro do setor administrativo/recepção) havia coliformes totais em quatro amostras, Escherichia coli  em uma amostra e bactérias heterotróficas acima dos parâmetros aceitáveis também em uma amostra.\u003c/p\u003e\u003cp\u003eNas análises da Vigilância Ambiental foram obtidas amostras d’água em 33 pontos de abastecimento da empresa no dia 30/01/2021, após a limpeza das caixas d’água da empresa. A análise qualitativa dessas amostras for realizada pelo LACEN sendo isolados coliformes totais em 11 amostras e Escherichia coli em 10 amostras. \u003c/p\u003e\u003cp\u003eOs técnicos da Vigilância Ambiental inquiriram o técnico de Segurança do Trabalho da empresa a respeito da utilização das duas caixas d’água. Foi observado que a alternância de uso entre as caixas d’água de 10.000 litros e de 20.000 litros não seria frequente, e que a empresa, normalmente, utilizava apenas a caixa de 20.000 litros para o abastecimento de água. Por essa razão, a água da caixa de 10.000 litros ficava “parada” por longos períodos de tempo, sem ser utilizada para o abastecimento. Ele também informou que, na semana em que o surto iniciou, estariam ocorrendo faltas frequentes no abastecimento de água por parte da concessionária, o que teria provocado o rápido esvaziamento da caixa de 20.000 litros, levando à necessidade de utilizar a água (“parada”) da caixa de 10.000 litros, a fim de manter o abastecimento da empresa. Não havia registro da última vez que a água desta caixa havia sido utilizada.\u003c/p\u003e\u003cp\u003eEstas informações levaram cogitar que a origem da contaminação da água poderia estar associada à subutilização da caixa de 10.000 litros e a consequente perda de cloro por evaporação, o que teria favorecido o crescimento da carga microbiológica, em particular, da Escherichia coli e das bactérias heterotróficas, encontradas em diferentes pontos de consumo da empresa. Além disso, a falta de água também poderia estar ocasionando influxos de solo na rede de distribuição.\u003c/p\u003e\u003cp\u003eFoi pontuado que a presença de bactérias heterotróficas na água é um importante indicativo de que ela estaria contaminada por matéria orgânica, uma vez que essas bactérias a utilizam como fonte de carbono para o seu desenvolvimento e multiplicação. \u003cp\u003eDentro desse grupo de bactérias, estão inclusos os coliformes fecais, como a Escherichia coli e as demais enterobactérias (\u003ci\u003eCitrobacter e Serratia\u003c/i\u003e, por exemplo). Os técnicos da Vigilância Ambiental orientaram o funcionário responsável a utilizar e alternar diariamente as duas caixas d’água para que este fato não ocorresse, novamente.\u003c/p\u003e\u003cp\u003eDurante a vigência do surto e após o seu término, as equipes das VS, VA e VE da Secretaria Municipal de Saúde reuniram-se e compartilharam informações entre si e com a coordenação da Vigilância das DTHA do Centro Estadual de Vigilância em Saúde. Vale ressaltar que a elaboração das hipóteses sobre as prováveis fontes de exposição e os possíveis agentes etiológicos deste surto foram rediscutidas pelas equipes da Vigilância em Saúde do município, a medida em que os dados das avaliações in loco, bem como, as evidências laboratoriais (exames da água, dos alimentos, dos manipuladores e dos doentes) foram sendo disponibilizados.\u003c/p\u003e\u003cp\u003eO surto foi encerrado no mês de julho de 2021, após a avaliação das evidências e da discussão entre os técnicos do município com os da Secretaria Estadual da Saúde considerando:\u003cul\u003e\u003cli\u003eas análises laboratoriais da água que mostraram a presença de \u003ci\u003eEscherichia coli\u003c/i\u003e , coliformes totais e bactérias heterotróficas em diversos pontos de consumo da empresa;\u003c/li\u003e\u003cli\u003eo quadro clínico dos doentes que indicou a prevalência de sinais e sintomas compatíveis com a infecção pela \u003ci\u003eEscherichia coli \u003c/i\u003e;\u003c/li\u003e\u003cli\u003eo longo período de incubação, compatível com a infecção pela \u003ci\u003eEscherichia coli\u003c/i\u003e ;\u003c/li\u003e\u003cli\u003ea longa duração do surto (6 dias), que sugeriu a exposição continuada (e não única) dos funcionários a fatores de risco que permaneceram “ativos” por alguns dias;\u003c/li\u003e\u003cli\u003ea utilização da água de um reservatório da empresa (caixa de 10.000 litros) que não era usado com frequência e que conteria água “parada” e que apresentou contaminação por coliformes totais, tanto antes, quanto depois da sua limpeza.\u003c/li\u003e\u003c/ul\u003e\u003cp\u003eConcluiu-se que o provável agente etiológico do surto seria a Escherichia coli , e a fonte de exposição a água proveniente do reservatório (caixa d´água de 10.000 litros) da empresa (Figura 9). Embora o consumo de água contaminada por Escherichia coli tenha sido considerado a causa deste surto, o inquérito feito pelos fiscais sanitários também encontrou inconformidades na linha de produção dos alimentos servidos, bem como, manipuladores doentes e com infecção nas mãos, o que pode ter contribuído para a extensão do surto. Isso reforça a importância de manter as ações de fiscalização sanitária, independente da existência dos fatores de risco estarem, necessariamente, associados aos alimentos.\u003c/p\u003e\u003cp\u003eTambém é oportuno mencionar que a não realização de exames de bromatologia nas amostras dos alimentos servidos in natura (como o alface e outros vegetais) deixou uma lacuna na investigação, uma vez que não foi descartada uma possível contaminação destes produtos que, segundo o inquérito da VS, estavam sendo higienizados com água de aspecto turvo.\u003c/p\u003e\u003ch6\u003eFigura 8.  Ficha de Investigação de Surto - DTA com campos da conclusão da investigação. Flor da Serra, 2021.\u003c/h6\u003e\u003cimg src='img/caso8_figura11_DTA.png'/\u003e\u003cp\u003eA equipe da VE enfrentou algumas \u003cb\u003ebarreiras para a realização da investigação epidemiológica\u003c/b\u003e tais como:\u003cul\u003e\u003cli\u003eA necessidade de entrevistar um grande número de comensais, que demanda à a equipe da VE um número compatível de investigadores ou que o período de entrevistas se estenda por mais tempo.\u003c/li\u003e\u003cli\u003eDificuldades logísticas e limitações de recursos humanos e financeiros para a coleta dos exames laboratoriais.\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: [
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/manual_integrado_vigilancia_doencas_alimentos.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Vigilância Epidemiológica. \u003cb\u003eManual integrado de vigilância, prevenção e controle de doenças transmitidas por alimentos\u003c/b\u003e. Brasília, 2010.",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/guia_investigacao_surtos_epidemias.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Vigilância das Doenças Transmissíveis. \u003cb\u003eGuia para Investigações de Surtos ou Epidemias\u003c/b\u003e / Ministério da Saúde, Secretaria de Vigilância em Saúde, Departamento de Vigilância das Doenças Transmissíveis – Brasília : Ministério da Saúde, 2018.",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/bvs/publicacoes/guia_vigilancia_saude_5ed_rev_atual.pdf",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Coordenação-Geral de Desenvolvimento da Epidemiologia em Serviços. \u003cb\u003eGuia de Vigilância em Saúde\u003c/b\u003e. 5. ed., Brasília, 2021. ",
          },
          {
            urlExterno:
              "https://www.gov.br/saude/pt-br/centrais-de-conteudo/publicacoes/publicacoes-svs/doencas-transmitidas-por-alimentos-dta/manual_dtha_2021_web.pdf/view",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Imunizações e Doenças Transmissíveis. \u003cb\u003eVigilância epidemiológica das doenças de transmissão hídrica e alimentar : manual de treinamento\u003c/b\u003e / Ministério da Saúde, Secretaria de Vigilância em Saúde, Departamento de Imunização e Doenças Transmissíveis. – Brasília : Ministério da Saúde, 2021. Disponível em",
          },
        ],
        tipo: "bibliografia",
      },
    ],
    subTitulo: "",
    titulo: "Duas cozinheiras da mesma empresa com diarreia e vômito",
    tsPublicacao: 1.23456789e9,
    shortname: "Duas cozinheiras da mesma empresa com diarreia e vômito",
  },
  {
    _id: ObjectId("6369617241e46f14322f6a06"),
    autor: ["Dóris Schuch", "Marcínia Bueno"],
    editores: ["Everton Fantinel", "Denise Silveira"],
    id: 9077.0,
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "41 anos",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "interdisciplinar",
    slides: [
      {
        conteudo: { texto: "", delay: "5" },
        titulo: "Introdução",
        tipo: "intro",
      },
      {
        conteudo: {
          descricaoCaso:
            "\u003cp\u003eNo dia 12 de abril, pela manhã, a Vigilância Sanitária (VS) municipal recebeu uma denúncia anônima, que informava sobre a ocorrência do adoecimento de algumas pessoas que consumiram alimentos na Lancheria Fantasia, bastante conhecida no pequeno município de Montes Verdes.\u003c/p\u003e",
        },
        titulo: "Descrição do caso",
        tipo: "descricaocaso",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eComentário sobre a resposta: A notificação de um surto de doença de transmissão hídrica e alimentar pode ser realizada por qualquer cidadão, não sendo necessário que seja profissional da vigilância em saúde ou que atue em um serviço de saúde ou tenha vinculação ao serviço público ou privado.\u003c/p\u003e\u003cp\u003eA denúncia relatava que duas pessoas de uma mesma família apresentaram diarreia aguda após fazerem uma refeição no estabelecimento e buscaram atendimento no pronto socorro da cidade, sendo que uma delas necessitou permanecer em observação pela severidade dos sintomas.\u003c/p\u003e\u003cp\u003eA VS informou imediatamente a Vigilância Epidemiológica (VE) e a Ambiental (Vigilância da Água de Consumo Humano - VIGIÁGUA) e constituiu uma equipe para dar início à verificação da denúncia. Em um primeiro momento, a VS dirigiu-se a Lancheria Fantasia, enquanto a VE ficou encarregada da verificação dos dois casos junto ao pronto socorro.\u003c/p\u003e\u003cp\u003eNo pronto socorro, a VE pode identificar os registros destes dois casos de diarreia aguda, mãe e filha, que haviam jantado no Lancheria Fantasia dois dias antes (10 de abril). O quadro clínico teve início durante a madrugada do dia 11 de abril. Ambas apresentaram diarreia intensa, cefaleia, dor abdominal e distensão abdominal e a filha apresentou ainda náuseas e vômitos.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["profissional de saúde da rede pública", true],
            ["funcionário da vigilância sanitária", true],
            ["profissional de saúde da rede privada", true],
            ["qualquer cidadão", true],
          ],
        },
        pergunta:
          "Diante de uma suspeita de surto de doença de transmissão hídrica e alimentar a notificação pode ser realizada por:",
        titulo: "Questão 1",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eA denúncia relatava que duas pessoas de uma mesma família apresentaram diarreia aguda após fazerem uma refeição no estabelecimento e buscaram atendimento no pronto socorro da cidade, sendo que uma delas necessitou permanecer em observação pela severidade dos sintomas. A VS informou imediatamente a Vigilância Epidemiológica (VE) e a Ambiental (Vigilância da Água de Consumo Humano - VIGIÁGUA) e constituiu uma equipe para dar início à verificação da denúncia. Em um primeiro momento, a VS dirigiu-se a Lancheria Fantasia, enquanto a VE ficou encarregada da verificação dos dois casos junto ao pronto socorro. No pronto socorro, a VE pode identificar os registros destes dois casos de diarreia aguda, mãe e filha, que haviam jantado no Lancheria Fantasia dois dias antes (10 de abril). O quadro clínico teve início durante a madrugada do dia 11 de abril. Ambas apresentaram diarreia intensa, cefaleia, dor abdominal e distensão abdominal e a filha apresentou ainda náuseas e vômitos.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA realização de busca ativa de casos de doenças diarreicas agudas associada à ampliação da coleta de amostras clínicas também deve ser realizada, pois é importante para a detecção oportuna da transmissão sustentada e para determinação da extensão da área de transmissão. Devido à contaminação ter ocorrido na Lancheria Fantasia, a forma mais plausível de encontrar mais casos é buscar por sintomáticos na rede de saúde. Os pontos de comércio não realizam listas de clientes e neste momento, ter a lista de fornecedores em nada iria contribuir para localizar casos.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Busca ativa de pessoas com diarreia na rede de saúde", true],
            [
              "Busca ativa nos vizinhos mais próximos dos casos notificados",
              false,
            ],
            ["Lista de clientes da lancheria dos dias 10 a 12 de abril", false],
            [
              "Avaliação da eficácia e efetividade das medidas adotadas.",
              false,
            ],
            [
              "Lista de fornecedores dos alimentos servidos na lancheria",
              false,
            ],
          ],
        },
        pergunta:
          "Qual a melhor estratégia a ser adotada pelo técnico da VE para identificar a ocorrência de outros casos de diarreia por ingestão de alimento e/ ou água da Lancheria Fantasia, no mesmo período que os dois casos notificados?",
        titulo: "Questão 2",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eO que é busca ativa e busca passiva?\u003c/h3\u003e\u003cp\u003eA busca ativa permite a identificação de casos que ainda não foram notificados, casos oligossintomáticos que não procuraram atendimento médico ou assintomáticos de grupos de alto risco (manipuladores de alimentos, cuidadores de crianças ou idosos, trabalhadores de creches e escolas, e profissionais de saúde), que podem continuar transmitindo a doença. Por essa razão, é importante utilizar todas as informações coletadas dos primeiros casos para melhor definir possíveis vínculos epidemiológicos e estabelecer uma área de busca adequada. A busca passiva ocorre quando os cidadãos, espontaneamente, entram em contato com o setor responsável para avisar da ocorrência de casos. Ademais, a busca pode apresentar uma direção temporal do tipo retrospectivo ou prospectivo, em que há a busca de registros de dados anterior e posterior ao evento/surto, respectivamente.\u003c/p\u003e\u003ch6\u003e(BRASIL  2018, 2021)\u003c/h6\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eAo efetuar a busca ativa de outros casos suspeitos ocorridos no mesmo período na rede de atenção à saúde, tanto nas unidades básicas de saúde como no pronto socorro, a VE detectou mais nove casos. Todos os casos tinham em comum refeições feitas na Lancheria Fantasia no dia 10 de abril. Diante destas informações foi realizado o preenchimento da Ficha de Investigação de Surto DTA (Figura 1).\u003c/p\u003e\u003ch6\u003eFigura 1. Ficha de investigação de surto - DTA, SINAN, 2022.\u003c/h6\u003e\u003ctable\u003e\u003ctr\u003e\u003ctd\u003e\u003cimg src='img/caso7_figura_1_LANCHERIA.png'/\u003e\u003c/td\u003e\u003ctd\u003e\u003cimg src='img/caso7_figura_1_1_LANCHERIA.png'/\u003e\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003cp\u003eA seguir, as equipes da Vigilância em Saúde do município organizaram o plano de trabalho para a investigação do surto.\u003c/p\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eDe acordo com a Política Nacional de Vigilância em Saúde, a Vigilância em Saúde compreende a articulação dos saberes, processos e práticas relacionados à vigilância epidemiológica, vigilância em saúde ambiental, vigilância em saúde do trabalhador e vigilância sanitária e alinha-se com o conjunto de políticas de saúde no âmbito do SUS, considerando a transversalidade das ações de vigilância em saúde sobre a determinação do processo saúde doença.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["vigilância epidemiológica", true],
            ["vigilância em saúde ambiental", true],
            ["vigilância em saúde do trabalhador", true],
            ["vigilância sanitária", true],
          ],
        },
        pergunta:
          "A Vigilância em Saúde compreende a articulação dos saberes, processos e práticas relacionados a:",
        titulo: "Questão 3",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eA equipe de investigação elaborou uma planilha com todos os casos a partir da identificação dos sintomáticos e definição da data e horário do início dos sintomas. Com estas informações foi possível construir uma Curva Epidêmica com a distribuição dos casos de acordo com a data de início dos primeiros sinais e sintomas (Figura 2).\u003c/p\u003e\u003ch6\u003eFigura 2. Distribuição dos casos segundo a data de início dos sintomas dos casos no surto. Montes Verdes, 2022 (n=11).\u003c/h6\u003e\u003cimg src='img/caso7_figura_2_LANCHERIA.png'/\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA curva epidêmica é o instrumento básico para caracterizar um surto no tempo, o que envolve o estabelecimento da duração do surto (que variará de acordo com a infectividade do agente etiológico, o modo de transmissão, a população exposta, o período de incubação da doença e a efetividade das medidas de controle imediato) e a definição da sua natureza (surtos de fonte comum – pontual ou contínua – ou propagada – pessoa a pessoa. A depender das características do surto, a data de início dos sintomas dos casos identificados pode ser expressa na curva epidêmica em horas, dias ou meses. Em uma curva epidêmica de fonte comum, a figura demonstra uma curva com aclive rápido e declive gradual, pois os casos ocorrem repentinamente depois do período de incubação mínimo e continuam por um breve período relacionado com a variabilidade do tempo de incubação. Na transmissão de fonte pessoa a pessoa a curva é irregular, podendo apresentar vários picos e intervalos correspondentes ao período de incubação da doença, indicando uma exposição a uma fonte propagada, em que a transmissão geralmente ocorre de pessoa a pessoa. O contato dos casos com o agente etiológico se dá em períodos diversos e sucessivos.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["fonte comum", true],
            ["pessoa a pessoa", false],
            ["fonte cruzada", false],
            ["fonte independente", false],
          ],
        },
        pergunta:
          "A análise dos dados do histograma com as datas e horários de início dos sintomas permitiu à VE formular a hipótese de transmissão do tipo:",
        titulo: "Questão 4",
        tipo: "questaoSimples",
      },
      {
        conteudo: {
          saibaCont:
            '\u003cp\u003eNa investigação deste surto, de acordo com o plano de trabalho estabelecido pelas equipes de Vigilância em Saúde:\u003c/p\u003e\u003cp\u003e\u003cul\u003e\u003cli\u003eA Vigilância Epidemiológica procedeu a investigação dos casos, coletando informações sobre a data e horário do início de sintomas de cada caso, bem como a coleta de amostras para análise laboratorial, coleta das informações sobre as refeições em comum (mesmo local, refeição ou procedência de refeição) e estabelecimento da mediana de tempo entre o consumo de alimentos e manifestação de sintomas. A partir do cardápio padronizado elaborado pela Vigilância Sanitária foram realizadas as entrevistas com comensais que estavam no estabelecimento durante o período em investigação.\u003c/li\u003e\u003cli\u003eA Vigilância Sanitária  procedeu à inspeção sanitária na lancheria, com base nas informações sobre refeições realizadas pelos casos e aquelas prestadas pelo estabelecimento, montar um cardápio padronizado de todas as refeições que a lancheria ofereceu nos dias apontados pelos casos que adoeceram. Foram coletadas amostras de matéria-prima utilizada na confecção dos pratos servidos, bem como de restos de alimentos preparados que ficaram armazenados nas geladeiras da lancheria. O estabelecimento era administrado e atendido pela própria família (casal, três filhos e uma nora). As mulheres e um dos filhos preparavam as refeições e os demais faziam atendimento aos clientes.\u003c/li\u003e\u003cli\u003eA Vigilância Ambiental identificou que a água de consumo humano utilizada no estabelecimento era fornecida pela rede pública de saneamento e o local possuía um reservatório de água. Foram coletadas amostras de água da ponta de rede (antes de chegar ao estabelecimento) e das torneiras da cozinha e do reservatório, que também foi inspecionado.\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e\u003cp\u003eOs alimentos servidos na refeição suspeita foram:\u003cul\u003e\u003cli\u003e\u003cli\u003eBatatas fritas\u003c/li\u003e\u003cli\u003eMaionese "da casa"\u003c/li\u003e\u003cli\u003eSanduíche tipo "bauru" de carne bovina\u003c/li\u003e\u003cli\u003eSanduíche tipo "bauru" de coração de frango\u003c/li\u003e\u003cli\u003eSanduíche tipo "bauru" de estrogonofe de carne \u003c/li\u003e\u003cli\u003eCachorro quente simples\u003c/li\u003e\u003cli\u003eCachorro quente completo\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e\u003cp\u003eA matéria-prima utilizada nos lanches foi adquirida de fornecedores locais: Padaria do João (pães) e Supermercado Facilidades (batatas, cebolas, sal, condimentos, ervilhas enlatadas em conserva, milho enlatado em conserva, queijo ralado, queijo lanche, frango congelado, carne bovina in natura, coração de frango congelado, salsichas industrializada, óleo de soja, molho de tomate industrializado, mostarda amarela industrializada, refrigerantes e água mineral e cervejas), e do sítio dos proprietários da lancheria (alface e os ovos).\u003c/p\u003e',
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eNo desenvolvimento de uma inspeção sanitária busca-se a identificação de perigos e pontos críticos de controle, onde as falhas podem ter ocasionado a contaminação do alimento ou da preparação alimentícia. Todas as alternativas estão corretas. Atentar para a identificação da data de estocagem e prazo de validade dos alimentos da geladeira e do freezer.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["capacidade de armazenamento", true],
            ["borrachas de vedação.", true],
            ["como os alimentos estão estocados", true],
            ["termômetro de controle da temperatura", true],
            ["excesso de gelo", true],
          ],
        },
        pergunta:
          "Durante a inspeção sanitária na Lancheria Fantasia os investigadores precisam averiguar nas geladeiras e freezer:",
        titulo: "Questão 5",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            "\u003ch3\u003eRoteiro de Inspeção em Estabelecimentos da Área de Alimentos e respectivos Critérios de Avaliação:\u003c/h3\u003e\u003cp\u003e \u003cul\u003e\u003cli\u003eSituações e condições de conservação e higiene das instalações/locais onde ocorrem a produção, armazenamento, transporte, comercialização e consumo de alimentos:\u003cul\u003e\u003cli\u003e condições de higiene e organização das instalações hidro-sanitárias e vestuários utilizados pelos manipuladores de alimento, registro de controle de vetores e roedores;\u003c/li\u003e \u003cli\u003edestino adequado dos dejetos;\u003c/li\u003e \u003cli\u003eacondicionamento e destino adequado dos resíduos sólidos; \u003cli\u003econdições de conservação, limpeza e desinfecção de bancadas, equipamentos e utensílios que entram em contato com os alimentos.\u003c/li\u003e\u003c/ul\u003e\u003c/li\u003e \u003cli\u003eCondições do vestuário, asseio pessoal, hábitos higiênicos e estado de saúde dos manipuladores:\u003cul\u003e\u003cli\u003e utilização de equipamento de proteção individual (EPI); o observar se os mesmos foram treinados para as boas práticas de produção de alimentos, em especial nos pontos críticos de controle.\u003c/li\u003e\u003c/ul\u003e\u003c/li\u003e \u003cli\u003eCuidados em relação à matéria prima/insumos:\u003cul\u003e\u003cli\u003e procedência: registro e controle da origem (pecuária, agricultura, pesca, extração de sal), registros de controle na utilização de agrotóxicos, condições de captura, abate e aquisição (seleção de fornecedores);\u003c/li\u003e \u003cli\u003equalidade da água potável utilizada na produção de alimentos e higiene dos manipuladores, equipamentos e utensílios e água utilizada na limpeza de superfícies. Observação da desinfecção periódica dos reservatórios por empresas especializadas; controle na utilização de produtos para o tratamento da água (princípio ativo, registro no Ministério da Saúde, prazo de validade, modo de usar);\u003c/li\u003e \u003cli\u003eutilização de aditivos e coadjuvantes de tecnologia: identificação dos produtos com seus princípios ativos, registro no MS, lote, validade, modo de usar, limites estabelecidos.\u003c/li\u003e\u003c/ul\u003e\u003c/li\u003e \u003cli\u003eCuidados no fluxo de produção:\u003cul\u003e\u003cli\u003e controle sanitário dos alimentos a serem consumidos crus;\u003c/li\u003e \u003cli\u003eregistros de controle do tempo e temperatura dos alimentos submetidos a tratamento térmico (calor ou frio);\u003c/li\u003e \u003cli\u003eeliminação da contaminação cruzada;\u003c/li\u003e \u003cli\u003econtrole do descarte das sobras, impedindo reaproveitamento.\u003c/li\u003e\u003c/ul\u003e\u003c/li\u003e \u003cli\u003eControle do produto final:\u003cul\u003e\u003cli\u003e embalagem: tipo, qualidade, limpeza e conservação do material;\u003c/li\u003e \u003cli\u003earmazenamento: controle das condições sanitárias do ambiente interno e externo (uso e guarda de produtos domissanitários para desinfecção, controle de roedores e proteção de vetores), umidade relativa do ar, temperatura, tempo de armazenamento, empilhamento (peso das pilhas) e descarte de perdas por danificação de embalagem;\u003c/li\u003e \u003cli\u003etransporte: controle das condições higiênico-sanitárias, da umidade relativa, proteção dos alimentos, registro de temperaturas, tempo de transporte por tipo de alimento;\u003c/li\u003e \u003cli\u003ecomercialização: registros do tempo e temperatura dos equipamentos para exposição e conservação dos alimentos (estufas, balcões térmicos, frios ou quentes, gôndolas);\u003c/li\u003e \u003cli\u003econtrole de qualidade de alimentos importados (rotulagem no idioma português, análise de controle e deferimento da importação no Sistema Integrado de Comércio Exterior – SISCOMEX).\u003c/li\u003e\u003c/ul\u003e\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e",
        },
        titulo: "Saiba mais",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          saibaCont:
            "\u003cp\u003eA inspeção sanitária realizada na geladeira e freezer no estabelecimento apontou algumas irregularidades:\u003cul\u003e\u003cli\u003e duas geladeiras de uso doméstico com capacidade de armazenamento acima do limite de segurança para sanidade dos alimentos, apresentando borrachas de vedação da porta com perda das características de vedação, com alimentos estocados desprotegidos (sem tampas, mantidos nos recipientes originais, tais como latas de ervilha e milho, e com colheres dentro) e sem termômetro para controle de temperatura de conservação dos alimentos; \u003c/li\u003e \u003cli\u003eum freezer com excesso de gelo e alimentos fracionados estocados sem proteção adequada e sem identificação da data de estocagem e prazo de validade; \u003c/li\u003e \u003cli\u003eutensílios de cozinha em estado precário (panelas amassadas dificultando a higienização das mesmas), uso de tábuas de madeira para corte de carnes que já apresentavam elevado desgaste;\u003c/li\u003e \u003cli\u003ea cozinha não apresentava separação das áreas de processamento dos alimentos representando elevado risco de contaminação cruzada; \u003cli\u003earmazenamento de matéria-prima (despensa) sem organização, com alimentos fracionados e estocados em potes plásticos sem identificação da data de validade, carnes, pães e alimentos adquiridos no mercado local tinham comprovantes de procedência, que foram imediatamente apresentados.\u003c/li\u003e \u003cli\u003eNenhum dos trabalhadores no local apresentava lesões visíveis nas mãos ou sinais/sintomas visíveis de doença transmissível, entretanto a Vigilância Sanitária não procedeu à coleta de amostras dos manipuladores/trabalhadores no local.\u003c/li\u003e\u003c/ul\u003e",
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: {
          resposta: {
            texto:
              "\u003cp\u003eA contaminação cruzada é uma das principais causas de ocorrência de surtos de doenças de origem alimentar e se associa com práticas inadequadas nas distintas etapas da cadeia produtiva. Entre estas podemos citar: higiene deficitária do ambiente e dos alimentos, contaminação dos alimentos na produção e/ou via manipuladores, contato dos alimentos com superfícies contaminadas (equipamentos, utensílios), e processamento ou armazenamento inadequado dos alimentos. Todas as respostas estão corretas.\u003c/p\u003e",
            tipo: "texto",
          },
          opcoes: [
            ["Separar carnes e peixes crus de outros alimentos.", true],
            [
              "Utilizar diferentes equipamentos e utensílios, como facas ou tábuas de corte para alimentos crus e para alimentos cozidos",
              true,
            ],
            [
              "Guardar os alimentos em embalagens ou recipientes fechados, para que não haja contato entre alimentos crus e cozidos",
              true,
            ],
            [
              "Lavar bem os utensílios e as mãos depois de manipular alimentos crus",
              true,
            ],
            [
              "Guardar na geladeira os alimentos preparados no fogão, mesmo que ainda estejam quentes",
              true,
            ],
          ],
        },
        pergunta:
          "Quais são os cuidados para evitar contaminação cruzada no ambiente de produção ou processamento de alimentos?",
        titulo: "Questão 6",
        tipo: "questaoMulti",
      },
      {
        conteudo: {
          saibaCont:
            '\u003cp\u003eApós a inspeção sanitária, foi lavrado Auto de Infração Sanitária e efetuada a interdição cautelar do estabelecimento, além da coleta de amostras de alimentos encontrados na geladeira e despensa, para análise laboratorial (Tabela 1).\u003c/p\u003e\u003ch6\u003eTabela 1. Resultado da análise laboratorial das amostras de alimentos. Montes Verdes, 2021.\u003c/h6\u003e\u003ctable class="table"\u003e\u003ctr\u003e\u003ctd\u003e\u003cb\u003eALIMENTOS:\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eTIPO DE EXAME\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eRESULTADO\u003c/b\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eMaionese da casa\u003c/td\u003e\u003ctd\u003eAnálise bromatológica(microbiologia)\u003c/td\u003e\u003ctd\u003e\u003ci\u003eSalmonella spp\u003c/i\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eEstrogonofe de carne\u003c/td\u003e\u003ctd\u003eAnálise bromatológica(microbiologia)\u003c/td\u003e\u003ctd\u003e\u003ci\u003eSalmonella spp\u003c/i\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eMolho de cachorro quente\u003c/td\u003e\u003ctd\u003eMolho de cachorro quente\u003c/td\u003e\u003ctd\u003enegativa\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003eÁgua reservatório cozinha e alojamento\u003c/td\u003e\u003ctd\u003eAnálise Microbiológica\u003c/td\u003e\u003ctd\u003esem contaminação patogênica\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003cp\u003eA Vigilância Epidemiológica entrevistou 11 pessoas (comensais) e coletou amostras de oito pessoas sintomáticas que haviam realizado refeição no local (Tabela 2).\u003c/p\u003e\u003ch6\u003eTabela 2. Resultado da análise laboratorial das amostras dos comensais. Montes Verdes, 2021.\u003c/h6\u003e\u003ctable class="table"\u003e\u003ctr\u003e\u003ctd\u003e\u003cb\u003eDOENTES\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eTIPO DE EXAME\u003c/b\u003e\u003c/td\u003e\u003ctd\u003e\u003cb\u003eRESULTADO\u003c/b\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e1\u003c/td\u003e\u003ctd\u003ecoprocultura swab retal\u003c/td\u003e\u003ctd\u003e\u003ci\u003eSalmonella spp\u003c/i\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e2\u003c/td\u003e\u003ctd\u003ecoprocultura swab retal\u003c/td\u003e\u003ctd\u003e\u003ci\u003eSalmonella spp\u003c/i\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e3\u003c/td\u003e\u003ctd\u003ecoprocultura swab retal\u003c/td\u003e\u003ctd\u003e\u003ci\u003eSalmonella spp\u003c/i\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e4\u003c/td\u003e\u003ctd\u003ecoprocultura swab retal\u003c/td\u003e\u003ctd\u003e\u003ci\u003eSalmonella spp\u003c/i\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e5\u003c/td\u003e\u003ctd\u003ecoprocultura swab retal\u003c/td\u003e\u003ctd\u003enão identificado agente etiológico patogênico\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e6\u003c/td\u003e\u003ctd\u003esem coleta\u003c/td\u003e\u003ctd\u003enão se aplica\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e7\u003c/td\u003e\u003ctd\u003ecoprocultura swab retal\u003c/td\u003e\u003ctd\u003e\u003ci\u003eSalmonella spp\u003c/i\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e8\u003c/td\u003e\u003ctd\u003ecoprocultura swab retal\u003c/td\u003e\u003ctd\u003e\u003ci\u003eSalmonella spp\u003c/i\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e9\u003c/td\u003e\u003ctd\u003ecoprocultura swab retal\u003c/td\u003e\u003ctd\u003e\u003ci\u003eSalmonella spp\u003c/i\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e10\u003c/td\u003e\u003ctd\u003ecoprocultura swab retal\u003c/td\u003e\u003ctd\u003e\u003ci\u003eSalmonella spp\u003c/i\u003e\u003c/td\u003e\u003c/tr\u003e\u003ctr\u003e\u003ctd\u003e11\u003c/td\u003e\u003ctd\u003esem coleta\u003c/td\u003e\u003ctd\u003enão se aplica\u003c/td\u003e\u003c/tr\u003e\u003c/table\u003e\u003ch6\u003eFigura 03: Ficha de Registro das Condições Higiênico-sanitárias no preparo dos alimentos\u003c/h6\u003e\u003cimg src=\'img/caso7_figura_5_LANCHERIA.png\'/\u003e\u003cp\u003eApós o processo de investigação medidas de controle e prevenção foram recomendadas:\u003cul\u003e \u003cli\u003eEscolher alimentos, matéria-prima e ingredientes com procedência comprovada (inspeção sanitária) e  processados de forma higiênica;\u003c/li\u003e \u003cli\u003eVerificar a data de validade dos alimentos;\u003c/li\u003e \u003cli\u003eManutenção de equipamentos para garantia dos alimentos e matéria-prima perecíveis estocados;\u003c/li\u003e \u003cli\u003eManter termômetros para aferição de temperaturas nos equipamentos de frio e de calor (geladeiras, buffets e estufas) bem como o registro de temperatura durante o dia;\u003c/li\u003e \u003cli\u003eGarantir a refrigeração adequada dos alimentos no armazenamento, no tempo preconizado de estoque do mesmo;\u003c/li\u003e\u003cli\u003eGarantir uso de técnica adequada de descongelamento:\u003cul\u003e \u003cli\u003eEvitar manter em temperatura ambiente por mais de duas horas, produtos de origem animal;\u003c/li\u003e \u003cli\u003eManter em refrigeração até 5°C, alimentos perecíveis;\u003c/li\u003e \u003cli\u003eDescongelamento dentro da geladeira por 48 horas, temperatura até 5°C, uso de cocção direta, uso de microondas;\u003c/li\u003e \u003cli\u003eGarantir a manipulação higiênica dos alimentos e o menor tempo possível de exposição dos mesmos em bancada, desde preparação, cocção até o consumo;\u003c/li\u003e\u003c/ul\u003e\u003c/li\u003e \u003cli\u003eNão servir alimentos à base de ovos sem cocção adequada;\u003c/li\u003e \u003cli\u003eCozinhar bem os alimentos;\u003c/li\u003e \u003cli\u003eConsumir imediatamente os alimentos cozidos;\u003c/li\u003e \u003cli\u003eArmazenar os alimentos cozidos fora da temperatura de risco;\u003c/li\u003e \u003cli\u003eReaquecer suficientemente os alimentos cozidos;\u003c/li\u003e \u003cli\u003eManter planilha de controle de tempo e temperatura do buffet de serviço no refeitório ( 5° C para os resfriados e 60° C para os aquecidos;\u003c/li\u003e \u003cli\u003eEvitar o contato entre os alimentos crus e cozidos – Evitar contaminação cruzada entre os alimentos em todos os processos;\u003c/li\u003e \u003cli\u003eLavar as mãos frequentemente, garantir as boas práticas de manipulação;\u003c/li\u003e \u003cli\u003eCapacitar os manipuladores quanto a higiene adequada: pessoal, dos alimentos, utensílios e superfícies.\u003c/li\u003e \u003cli\u003eUso de EPIs adequadamente conforme normas da Vigilância Sanitária.\u003c/li\u003e \u003cli\u003eManter criteriosamente limpas todas as superfícies da cozinha;\u003c/li\u003e \u003cli\u003eManter os alimentos fora do alcance de insetos, roedores e outros animais.\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e\u003cp\u003eA equipe da VE enfrentou algumas \u003cb\u003ebarreiras para a realização da investigação epidemiológica\u003c/b\u003e tais como:\u003cul\u003e\u003cli\u003eNão ter havido coleta de amostras dos manipuladores/trabalhadores da lancheria..\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e',
        },
        titulo: "",
        tipo: "saibaMais",
      },
      {
        conteudo: [
          {
            urlExterno: "",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "ANVISA. RDC Nº 216, de 15 de Setembro de 2004. Estabelece procedimentos de boas práticas para serviço de alimentação, garantindo as condições higiênico-sanitárias do alimento preparado. Diário Oficial da União, Brasília, DF, 17 setembro de 2004. BRASIL.",
          },
          {
            urlExterno: "",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Secretaria de Vigilância em Saúde. Departamento de Imunizações e Doenças Transmissíveis. Vigilância epidemiológica das doenças de transmissão hídrica e alimentar : manual de treinamento / Ministério da Saúde, Secretaria de Vigilância em Saúde, Departamento de Imunização e Doenças Transmissíveis. – Brasília : Ministério da Saúde, 2021.",
          },
          {
            urlExterno:
              "https://www.gov.br/saude/pt-br/assuntos/saude-de-a-a-z/p/politica-nacional-de-vigilancia-em-saude-1",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Biblioteca Virtual em Saúde. Dia Mundial da Segurança dos Alimentos (07/06): Segurança dos Alimentos, responsabilidade de todos! Disponível em:",
          },
          {
            urlExterno: "",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "BRASIL. Ministério da Saúde. Conselho Nacional de Saúde. Resolução MS/CNS nº 588, de 12 de julho de 2018. Fica instituída a Política Nacional de Vigilância em Saúde (PNVS), aprovada por meio desta resolução. Diário Oficial da República Federativa do Brasil, Brasília (DF), 2018 ago 13; Seção 1:87.",
          },
          {
            urlExterno:
              "https://bvsms.saude.gov.br/07-6-seguranca-dos-alimentos-responsabilidade-de-todos-dia-mundial-da-seguranca-dos-alimentos/",
            acessoEm: "",
            urlLocal: "",
            linkTitulo:
              "POLÍTICA NACIONAL DE VIGILÂNCIA EM SAÚDE. \u003cb\u003eBrasil\u003c/b\u003e. Ministério da Saúde. Disponível em:",
          },
        ],
        tipo: "bibliografia",
      },
    ],
    subTitulo: "",
    titulo: "Clientes da lancheria com diarreia",
    tsPublicacao: 1.23456789e9,
    shortname: "Clientes da lancheria com diarreia",
  },
]);
db.casos.insertMany([
  {
    _id: ObjectId("638b54bd41e46f2b2b9a5387"),
    autor: [],
    editores: [],
    id: 9080.0,
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "0",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "Interdisciplinar",
    slides: [
      {
        tipo: "questaoSimples",
        titulo: "Questão 1",
        conteudo: {
          opcoes: [
            [
              "Surto é o aparecimento súbito ou ocorrência maior do que a esperada de um evento ou doença, em uma área ou entre um grupo específico de pessoas, em determinado período. Epidemias são múltiplos surtos em uma ampla área geográfica",
              true,
            ],
            [
              "Surto é a ocorrência de múltiplas doenças em uma ampla área geográfica. Epidemia é o aparecimento súbito e/ou aumento não esperado na ocorrência de um evento ou doença, em uma área ou entre um grupo específico de pessoas, em determinado período",
              false,
            ],
            [
              "Surto é a presença contínua de uma enfermidade ou de um agente infeccioso em uma zona geográfica determinada. Epidemias são múltiplos surtos em uma ampla área geográfica",
              false,
            ],
            [
              "Surto é o aparecimento não esperado na ocorrência de uma doença, em uma área ou entre um grupo específico de pessoas, em determinado período. Epidemia é a presença contínua de uma enfermidade ou de um agente infeccioso em uma zona geográfica determinada",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta: "Qual a diferença entre surto e epidemia?",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 2",
        conteudo: {
          opcoes: [
            [
              "conjunto de ações que proporciona o conhecimento, a detecção ou prevenção de qualquer mudança nos fatores determinantes e condicionantes de saúde individual ou coletiva, com a finalidade de recomendar e adotar as medidas de prevenção e controle das doenças ou agravos",
              true,
            ],
            [
              "conjunto de passos que intermediam a identificação de qualquer mudança nos fatores determinantes e condicionantes de saúde individual ou coletiva, com a finalidade de gerar conhecimento científico",
              false,
            ],
            [
              "conjunto de avaliações que proporciona a prevenção de qualquer mudança nos fatores determinantes e condicionantes de saúde coletiva, com a finalidade de recomendar e adotar as medidas de distanciamento social e controle das doenças ou agravos",
              false,
            ],
            [
              "conjunto de atividades que proporciona detectar qualquer mudança nos fatores determinantes e condicionantes de saúde individual ou coletiva, com a finalidade de recomendar e adotar medidas de tratamento de doenças ou agravos",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "De acordo com a Lei 8080/90 vigilância epidemiológica é definida como:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 3",
        conteudo: {
          opcoes: [
            ["Quando a doença não é prioritária", false],
            ["Quando a doença parece tem diversas fontes", false],
            [
              "Quando a doença parece ter uma severidade menor do que a usual",
              false,
            ],
            [
              "Quando a doença é nova, emergente ou “desconhecida” na área",
              true,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta: "Quando devemos iniciar uma investigação de surto?",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 4",
        conteudo: {
          opcoes: [
            [
              "Interromper a fonte/forma de transmissão e eliminar o risco da doença/agravo se disseminar para outras pessoas, assim como, oportunizar a prevenção de futuros surtos",
              true,
            ],
            [
              "Interromper a fonte/forma de transmissão da doença/agravo assim como, oportunizar a prevenção de futuros surtos",
              false,
            ],
            [
              "Eliminar o risco da doença/agravo se disseminar para outras pessoas, assim como, oportunizar a revisão do conhecimento sobre a nova doença",
              false,
            ],
            [
              "Eliminar o risco da doença/agravo se disseminar para outras pessoas, assim como, oportunizar a reavaliação de toda população envolvida e seu entorno",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "Qual o objetivo das medidas de prevenção e controle adotadas diante de uma situação de surto?",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 5",
        conteudo: {
          opcoes: [
            [
              "obter mais informações sobre a interação entre o hospedeiro humano, o agente e o ambiente",
              true,
            ],
            [
              "fiscalizar o cumprimento das normas sanitárias rotineiramente nos estabelecimentos cadastrados",
              false,
            ],
            [
              "mapear o risco ocupacional e identificar agentes químicos e físicos implicados em cada ambiente",
              false,
            ],
            [
              "desenvolver políticas públicas que contribuam para as ações da vigilância em saúde",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta: "Um dos propósitos da investigação de um surto é:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 6",
        conteudo: {
          opcoes: [
            ["77,0 por 100.000 habitantes", true],
            ["4,0 por 10.000 habitantes", false],
            ["225 por 10.000 habitantes", false],
            ["26 por 100.000 habitantes", false],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "Durante a investigação de um surto de diarreia aguda em um município foram diagnosticados 26 casos no período de 30 dias, sendo que existem 33.750 habitantes nesse mesmo período. Qual é a incidência de diarreia aguda:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 7",
        conteudo: {
          opcoes: [
            [
              "a data do início dos sintomas e quais sinais e sintomas estão incluídos",
              true,
            ],
            [
              "a data do fim dos sintomas e grupo de pessoas próximas ao local do evento",
              false,
            ],
            [
              "os grupos de risco, conforme o sexo e a idade, e a data do início dos sintomas",
              false,
            ],
            [
              "o cardápio da refeição suspeita e o resultado da inspeção sanitária ",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "A definição de caso em um surto de doença diarreica aguda deve incluir:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 8",
        conteudo: {
          opcoes: [
            [
              "notificar imediatamente (24 horas) e investigar em até 48h da notificação",
              true,
            ],
            [
              "notificar imediatamente (24 horas) e realizar bloqueio vacinal seletivo em até 15 dias após a notificação",
              false,
            ],
            [
              "notificar imediatamente (48 horas) e realizar busca retrospectiva de casos suspeitos, nos últimos 30 dias, a partir da data do exantema do primeiro caso confirmado.",
              false,
            ],
            [
              "notificar imediatamente (48 horas) e investigar em até 15 dias da notificação",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "Diante de um caso de doença exantemática, com suspeita de sarampo, quais condutas devem ser adotadas:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 9",
        conteudo: {
          opcoes: [
            [
              "a informação clínica e características das pessoas afetadas",
              true,
            ],
            ["o local de ocorrência e o agente etiológico", false],
            ["o tempo de incubação e o período em que ocorreu o surto", false],
            ["os resultados laboratoriais e o alimento suspeito", false],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta: "São componentes da definição de caso:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 10",
        conteudo: {
          opcoes: [
            ["Por sala ou setor", true],
            ["Por tipo de atividade profissional", false],
            ["Por bairro de moradia", false],
            ["Por atividades recreativas", false],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "O mapeamento dos casos visa identificar a extensão geográfica dos eventos e a concentração de casos ou padrões. Em casos relatados em ambientes fechados, como deverá ser realizado o mapeamento?",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 11",
        conteudo: {
          opcoes: [
            ["Pão de queijo", true],
            ["Palitos de cenoura", false],
            ["Bolo de fubá", false],
            ["Pizza caseira", false],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          'A partir das informações da tabela a seguir, qual alimento pode ser suspeito como a fonte do surto nessa investigação?\u003cimg src="img/preteste_figura1.png"/\u003e',
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 12",
        conteudo: {
          opcoes: [
            [
              "homogeneidade da cobertura vacinal e coleta oportuna de amostras clínicas até 24h após o início do exantema",
              false,
            ],
            [
              "investigação epidemiológica oportuna dos casos suspeitos de sarampo e rubéola até 48 horas e coleta oportuna de amostras clínicas até 24h após o início do exantema",
              false,
            ],
            [
              "homogeneidade da cobertura vacinal e investigação epidemiológica oportuna dos casos suspeitos de sarampo e rubéola até 48 horas",
              true,
            ],
            [
              "resultado dos exames laboratoriais liberados oportunamente, em até quatro dias e coleta oportuna de amostras clínicas até 24h após o início do exantema",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "O acompanhamento dos indicadores proporciona a chance de conhecer adequadamente a situação vigente e de intervir oportunamente, no intuito de mudar uma situação insatisfatória existente, além de orientar os próximos passos. Na vigilância de sarampo e rubéola, temos oito indicadores de qualidade, entre eles:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 13",
        conteudo: {
          opcoes: [
            [
              "\u003ci\u003eSalmonella spp., Escherichia coli, Staphylococcus aureus\u003c/i\u003e, rotavírus, norovírus e adenovírus",
              true,
            ],
            [
              "\u003ci\u003eEscherichia coli, Staphylococcus saprophyticus, Pseudomonas aeruginosa\u003c/i\u003e, rotavírus, norovírus e Arbovírus",
              false,
            ],
            [
              "\u003ci\u003eStaphylococcus aureus, Yersinia pestis, Chlamydia trachomatis\u003c/i\u003e, rotavírus, Citomegalovírus e adenovírus",
              false,
            ],
            [
              "\u003ci\u003eChlamydia trachomatis, Staphylococcus pyogenes, Klebsiella pneumoniae\u003c/i\u003e, Coxsackie A, norovírus e adenovírus",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "O período de incubação de uma Doença Diarreica Aguda (DDA) varia conforme o agente etiológico causador, mas usualmente é curto, variando de um a sete dias. Os agentes mais frequentes são os de origem bacteriana e viral, tais como:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 14",
        conteudo: {
          opcoes: [
            [
              "os sinais e sintomas e achados laboratoriais anteriores a condição investigada",
              false,
            ],
            [
              "o período, local ou região em que a condição ocorreu e as características da pessoa com a condição",
              true,
            ],
            [
              "características do local e as condições de saúde pré-existentes",
              false,
            ],
            [
              "informações relacionadas a outras doenças pré-existentes no local",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta: "Para definição de casos os elementos fundamentais são:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 15",
        conteudo: {
          opcoes: [
            ["um surto ou epidemia de fonte pontual ou de ponto", true],
            [
              "um surto ou epidemia por exposição contínua com duração prolongada",
              false,
            ],
            [
              "um surto ou epidemia em situações de transmissão pessoa a pessoa",
              false,
            ],
            ["um surto ou epidemia por múltiplas fontes", false],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "Na investigação de casos de surtos ou epidemias, a epidemiologia descritiva é um componente importante, caracterizando a fonte, o modo de propagação e os fatores de risco. Para a descrição do surto, utiliza-se a curva epidêmica ou histograma.  Esta fornece diversas informações, a partir do formato encontrado. Um formato com aclive rápido e declive gradual poderá indicar:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 16",
        conteudo: {
          opcoes: [
            [
              "o agente e a fonte e o tamanho e características da população em risco",
              true,
            ],
            ["o agente e a fonte e as características do local", false],
            [
              "modo de propagação e os interesses políticos e da comunidade",
              false,
            ],
            [
              "o agente e a fonte e interesses políticos e da comunidade",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "A investigação possibilita adotar ações oportunas e efetivas, para determinar que tipos de respostas e medidas de controle e prevenção serão requeridos. Estas medidas serão indicadas de acordo com:",
      },
    ],
    subTitulo: "",
    titulo: "Teste Inicial - Investigação de surtos e epidemias",
    tsPublicacao: 1.23456789e9,
  },
  {
    _id: ObjectId("638b648341e46f6f089a5387"),
    autor: [],
    editores: [],
    id: 9081.0,
    paciente: {
      iniciais: "",
      sexo: "",
      cor: "",
      ocupacao: "",
      idade: "0",
      queixa: { tempoGeral: "\u003e 3", evolucaoGeral: "" },
    },
    profissional: "Interdisciplinar",
    slides: [
      {
        tipo: "questaoSimples",
        titulo: "Questão 1",
        conteudo: {
          opcoes: [
            [
              "coqueluche, febre amarela, leptospirose, sarampo, rubéola e tétano",
              true,
            ],
            [
              "coqueluche, febre amarela, varicela, sarampo, rubéola e tétano",
              false,
            ],
            [
              "coqueluche, febre amarela, leptospirose, sarampo, tuberculose e tétano",
              false,
            ],
            [
              "coqueluche, febre amarela, leptospirose, sarampo, rubéola e leishmaniose",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta: "São doenças de notificação imediata:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 2",
        conteudo: {
          opcoes: [
            ["a razão das incidências entre expostos e não expostos", true],
            [
              "a diferença entre a prevalência nos não expostos e a prevalência nos expostos",
              false,
            ],
            ["o percentual de doentes entre os comensais", false],
            [
              "a proporção de casos que apresentaram sintomas nas primeiras 24 horas da investigação",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta: " Por definição o risco relativo é:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 3",
        conteudo: {
          opcoes: [
            ["2", false],
            ["3", false],
            ["4", false],
            ["1", true],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "Para caracterizar um surto de sarampo atualmente são necessários quantos casos?",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 4",
        conteudo: {
          opcoes: [
            [
              "exposição a enchentes, alagamentos, lama, fossas, lixo e entulho; vínculo epidemiológico com um caso confirmado por critério laboratorial",
              true,
            ],
            [
              "exposição a enchentes, alagamentos, lama, fossas, lixo e entulho; Residência ou local de trabalho em área de risco para leishmaniose",
              false,
            ],
            [
              "vínculo epidemiológico com um caso confirmado por critério laboratorial; Residência ou local de trabalho em área de risco para leishmaniose",
              false,
            ],
            [
              "vínculo epidemiológico com um caso confirmado por sintomas; Residência ou local de trabalho em área de risco para doenças",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "Na definição de caso suspeito de leptospirose, o indivíduo com Síndrome Febril Aguda (febre, cefaleia e mialgia) deve apresentar pelo menos um dentre os seguintes critérios epidemiológicos:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 5",
        conteudo: {
          opcoes: [
            ["busca passiva", true],
            ["coleta de dados", false],
            ["rastreamento", false],
            ["captação ativa", false],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "Quando os cidadãos entram em contato espontaneamente com a vigilância em saúde para informar sobre a ocorrência de casos é chamada:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 6",
        conteudo: {
          opcoes: [
            ["1 a 7 dias", true],
            ["5 a 10 dias", false],
            ["2 a 14 dias", false],
            ["1 a 14 dias", false],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "As Doenças Diarreicas Agudas (DDA) correspondem à síndrome causada por diferentes agentes etiológicos, por isso seu período de incubação é variável, no entanto curto, variando de:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 7",
        conteudo: {
          opcoes: [
            ["o início dos sintomas até 3 dias após a recuperação", true],
            ["o início dos sintomas até 7 dias após a recuperação", false],
            ["o início dos sintomas até 5 dias após a recuperação", false],
            ["o início dos sintomas até 14 dias após a recuperação", false],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "A norovirose é uma das causas mais comuns de gastroenterite cujo período médio de incubação é de 24 a 48 horas. O quadro clínico é caracterizado por: vômito de início agudo, diarreia não sanguinolenta, dor abdominal, febre, cefaleia, dores musculares e cansaço. Uma pessoa infectada pode transmitir desde:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 8",
        conteudo: {
          opcoes: [
            ["na primavera e verão", true],
            ["no outono e no inverno", false],
            ["na primavera e outono", false],
            ["no outono e verão", false],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "A meningite viral caracteriza-se por um quadro clínico de alteração neurológica, que, em geral, evolui de forma benigna. Os principais causadores são os vírus do gênero Enterovírus. Os Enterovírus têm comportamento sazonal, predominando:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 9",
        conteudo: {
          opcoes: [
            ["coorte e caso controle", true],
            ["caso controle e transversal", false],
            ["coorte e experimental", false],
            ["caso controle e descritivo", false],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "Para realizar a investigação de surtos e epidemias são indicados 10 passos. O passo 7 trata da comparação das hipóteses com os fatos estabelecidos, para isso o investigador se utilizará da epidemiologia analítica para testar as hipóteses, através de estudos como:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 10",
        conteudo: {
          opcoes: [
            [
              "organizar os serviços de saúde para detecção e prevenção de casos e detectar se a doença é endêmica ou epidêmica",
              true,
            ],
            [
              "organizar os serviços de saúde para detecção e identificar e relatar novas doenças ou eventos",
              false,
            ],
            [
              "prevenção de casos e detectar se a doença é endêmica ou epidêmica e reafirmar que as estações de verão e inverno são as mais suscetíveis a doenças",
              false,
            ],
            [
              "identificar e relatar novas doenças ou eventos e reafirmar que as estações de verão e inverno são as mais suscetíveis a doenças",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "A sazonalidade é um fator importante na investigação de doenças, pois muitos agravos apresentam aumento no número de casos em determinados meses do ano. Conhecer a sazonalidade de uma doença possibilita:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 11",
        conteudo: {
          opcoes: [
            [
              "Profissionais de saúde, imprensa, dados da vigilância epidemiológica e comunidade",
              true,
            ],
            [
              "Profissionais de saúde, dados da vigilância epidemiológica e aglomerações festivas",
              false,
            ],
            [
              "Profissionais de segurança, dados da vigilância epidemiológica e comunidade",
              false,
            ],
            [
              "Profissionais em geral, imprensa, dados da vigilância epidemiológica e aumento da densidade populacional",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "Quais as principais fontes de comunicação de ocorrência de surtos?",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 12",
        conteudo: {
          opcoes: [
            [
              "agente, fonte, modo de propagação e características da população",
              true,
            ],
            [
              "agente, fonte, modo de propagação e condições sociais da população",
              false,
            ],
            [
              "agente, fonte, aspectos culturais e características da população",
              false,
            ],
            [
              "agente, fômites, modo de propagação e características da população",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "Uma investigação de surtos e epidemias, é essencial para estabelecer estratégias de prevenção, no entanto estas podem variar de acordo com:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 13",
        conteudo: {
          opcoes: [
            [
              "individuo com características clínicas típicas, mas sem confirmação laboratorial",
              true,
            ],
            [
              "individuo sem características clínicas típicas, mas moradora da área de investigação",
              false,
            ],
            [
              "pessoa sem características clínicas típicas, mas com confirmação laboratorial",
              false,
            ],
            [
              "pessoa com características clínicas típicas, mas moradora da área de investigação",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "No contexto dos surtos, a definição de caso é um conjunto específico de critérios aos quais o indivíduo suspeito deve atender para ser considerado um caso sob investigação. Neste sentido assinale a definição de caso provável:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 14",
        conteudo: {
          opcoes: [
            ["número de expostos por alimento x100/total de expostos", true],
            [
              "número de expostos por alimento x100/total de não expostos",
              false,
            ],
            [
              "número de não expostos por alimento x100/total de expostos",
              false,
            ],
            ["número de expostos por alimento x100/total de sadios", false],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "A taxa de ataque (TA) da doença é uma medida de incidência que se refere a populações específicas, em períodos de tempo limitados, como por exemplo, durante surtos e epidemias. A fórmula para cálculo de taxa de ataque em expostos é:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 15",
        conteudo: {
          opcoes: [
            [
              "pessoas com risco elevado de complicações não vacinadas ou vacinadas há menos de duas semanas, após exposição a caso suspeito ou confirmado de inﬂuenza",
              true,
            ],
            [
              "pessoas com risco elevado de complicações não vacinadas ou vacinadas há menos de 30 dias, após exposição a caso suspeito ou confirmado de inﬂuenza",
              false,
            ],
            [
              "pessoas com risco elevado de complicações não vacinadas ou vacinadas há menos de duas semanas, sem exposição a caso suspeito ou confirmado de inﬂuenza",
              false,
            ],
            [
              "pessoas com risco elevado de complicações não vacinadas ou vacinadas há menos de oito semanas, após exposição a caso suspeito ou confirmado de inﬂuenza",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "A quimioprofilaxia com antivirais para prevenção de Influenza não é recomendada, mas existem indicações específicas, tais como:",
      },
      {
        tipo: "questaoSimples",
        titulo: "Questão 16",
        conteudo: {
          opcoes: [
            [
              "infecções de pele, pneumonia, confusão mental e infecções oculares que podem levar à perda da visão",
              true,
            ],
            [
              "infecções de pele, pneumonia, confusão mental e infecções de ouvido que podem levar à perda auditiva",
              false,
            ],
            [
              "infecções de pele, pancreatite, demência e infecções oculares que podem levar à perda da visão",
              false,
            ],
            [
              "infecções de pele, pneumonia, confusão mental e infecções óssea que podem levar à perda de movimentos",
              false,
            ],
          ],
          resposta: { tipo: "texto", texto: "" },
        },
        pergunta:
          "As possíveis complicações de casos graves de Monkeypox (varíola dos macacos) são:",
      },
    ],
    subTitulo: "",
    titulo: "Teste Final - Investigação de surtos e epidemias",
    tsPublicacao: 1.23456789e9,
  },
]);

db.createCollection("selecoes", { capped: false });
db.selecoes.insert({
  _id: ObjectId("638ce58070428362382f7506"),
  casos: [
    ObjectId("62f39ab641e46ff40a7cc73d"),
    ObjectId("62f968a141e46f53119d100b"),
    ObjectId("62f97d9041e46f60119d100b"),
    ObjectId("62fae14e41e46f423d2cfd67"),
    ObjectId("62faf42e41e46fb4652cfd67"),
    ObjectId("62fb004a41e46f607c2cfd67"),
    ObjectId("630cb5ca41e46fa01e0115f8"),
    ObjectId("630d355f41e46fab300115f8"),
    ObjectId("6339dc1741e46fdf39ff213c"),
    ObjectId("633ad71f41e46f8f531c95d1"),
    ObjectId("633ae23241e46fbd641c95d1"),
    ObjectId("635bd84341e46f0207fcaaf8"),
    ObjectId("63658eb741e46f062ffeb744"),
    ObjectId("6369412741e46f1a322f6a06"),
    ObjectId("6369617241e46f14322f6a06"),
  ],
  descricao:
    "Módulo de investigação de surtos e epidemias - Casos Clínicos Unidade",
  instituicao: "publica",
  titulo: "Módulo de investigação de surtos e epidemias",
  unidade: 2,
});
db.selecoes.insert({
  _id: ObjectId("638ce4c870428362382f7501"),
  casos: [
    ObjectId("638b54bd41e46f2b2b9a5387"),
    ObjectId("638b648341e46f6f089a5387"),
  ],
  descricao: "Módulo de investigação de surtos e epidemias - Testes",
  instituicao: "publica",
  titulo: "Módulo de investigação de surtos e epidemias",
  unidade: 2,
});
db = db.getSiblingDB("modulos");
db.createCollection("materiais", { capped: false });
db.materiais.insertMany([
  {
    _id: ObjectId("638041b0014ea877b6f547e8"),
    modulo: "63758ed55ebc0215731f6c36",
    filesize: "147 Kb",
    tipo: "Material",
    nome: "Definição de Termos - Investigação de Surtos e Epidemias",
    url: "investigacao_surtos_definicao_de_termos.pdf",
  },
  {
    _id: ObjectId("638041d9014ea877b6f547e9"),
    modulo: "63758ed55ebc0215731f6c36",
    filesize: "132 Kb",
    tipo: "Material",
    nome: "10 Passos da Investigação de Surtos e Epidemias",
    url: "investigacao_surtos_10_passos_da_investigacao_de_surtos_e_epidemias.pdf",
  },
]);
db.createCollection("modulos", { capped: false });
db.modulos.insert({
  _id: ObjectId("63758ed55ebc0215731f6c36"),
  components: [
    {
      folder: "intro",
      short: "Introduz",
      title: "Abertura do App",
      categories: ["infraestrutura"],
      hidemenu: true,
    },
    {
      folder: "badge",
      short: "Badge",
      title: "Modais de Badge",
      categories: ["infraestrutura"],
      hidemenu: true,
    },
    {
      folder: "local-storage",
      short: "Local Storage",
      title: "Local Data Storage",
      categories: ["infraestrutura"],
      hidemenu: true,
    },
    {
      folder: "store-manager",
      short: "Manager",
      title: "Store Manager",
      categories: ["infraestrutura"],
      hidemenu: true,
    },
    {
      folder: "progresso",
      short: "Progresso",
      title: "Monitor Progresso",
      categories: ["infraestrutura"],
      hidemenu: true,
    },
    {
      folder: "lti",
      short: "LTI",
      title: "Recurso LTI",
      categories: ["infraestrutura"],
      hidemenu: true,
    },
    {
      folder: "websocket",
      short: "Socket",
      title: "WebSocket Connection Component",
      categories: ["infraestrutura"],
      hidemenu: true,
    },
    {
      folder: "teste-progresso",
      short: "Teste Progresso",
      title: "Um Teste com Progresso",
      categories: ["infraestrutura"],
      hidemenu: true,
    },
    {
      folder: "idle-warn",
      short: "Inatividade",
      title: "Controle de Inatividade",
      categories: ["infraestrutura"],
      hidemenu: true,
    },
    {
      folder: "saiba-mais",
      short: "Siaba Mais",
      title: "Siaba Mais",
      categories: ["ferramenta"],
      hidemenu: true,
    },
    {
      folder: "caso-progresso",
      short: "Caso Interativo",
      title: "Um Caso",
      categories: ["ferramenta"],
      hidemenu: true,
    },
    {
      folder: "materiais",
      short: "Materiais de Apoio",
      title: "Materiais de Apoio ao Aprendizado",
      categories: ["material-apoio"],
      externalResources: true,
      ref: "materiais",
      match: { modulo: ObjectId("63758ed55ebc0215731f6c36") },
    },
    {
      folder: "bibliografia",
      short: "Bibliografia",
      title: "Bibliografia Geral",
      categories: ["material-apoio"],
      externalResources: true,
      ref: "bibliografias",
      match: { modulo: ObjectId("63758ed55ebc0215731f6c36") },
    },
    {
      folder: "home",
      short: "Inicie por aqui",
      title: "Página inicial",
      categories: ["indice"],
    },
    {
      folder: "cadastro",
      short: "cadastro",
      title: "cadastro",
      categories: ["infraestrutura"],
      hidemenu: true,
    },
    {
      folder: "selecao-progresso",
      short: "Casos Interativos",
      title: "Casos Interativos",
      categories: ["indice"],
      sources: [],
      externalResources: true,
      ref: "selecoes",
      oid: "638ce58070428362382f7506",
    },
    {
      folder: "listatestes",
      short: "Testes",
      title: "Testes",
      categories: ["indice"],
      sources: [],
      externalResources: true,
      ref: "selecoes",
      oid: "638ce4c870428362382f7501",
    },
    {
      folder: "video-player",
      short: "video player",
      title: "",
      categories: ["infraestrutura"],
      sources: [
        {
          filename: "apresentacao_surtos_epidemias",
          resolution: "1080p",
          extension: "mp4",
          mime: "video/mp4",
          mediaQuery: "all and (min-width: 991px)",
        },
      ],
      poster: "investigacao_surtos_capa_apresentacao.png",
    },
    {
      folder: "video-player",
      short: "video player",
      title: "Por que investigar surtos e pandemias ?",
      categories: ["infraestrutura"],
      sources: [
        {
          filename: "investigacao_surtos_aula_1",
          resolution: "1080p",
          extension: "mp4",
          mime: "video/mp4",
          mediaQuery: "all and (min-width: 991px)",
        },
        {
          filename: "investigacao_surtos_aula_1",
          resolution: "720p",
          extension: "mp4",
          mime: "video/mp4",
          mediaQuery: "all and (max-width: 990px)",
        },
      ],
      poster: "investigacao_surtos_aula_1_capa.png",
    },
    {
      folder: "video-player",
      short: "video player",
      title: "Como realizar a investigação de surtos e pandemias",
      categories: ["infraestrutura"],
      sources: [
        {
          filename: "investigacao_surtos_aula_2",
          resolution: "1080p",
          extension: "mp4",
          mime: "video/mp4",
          mediaQuery: "all and (min-width: 991px)",
        },
        {
          filename: "investigacao_surtos_aula_2",
          resolution: "720p",
          extension: "mp4",
          mime: "video/mp4",
          mediaQuery: "all and (max-width: 990px)",
        },
      ],
      poster: "investigacao_surtos_aula_2_capa.png",
    },
    {
      folder: "video-player",
      short: "video player",
      title: "10 passos para a investigação de surtos e pandemias",
      categories: ["infraestrutura"],
      sources: [
        {
          filename: "investigacao_surtos_aula_3",
          resolution: "1080p",
          extension: "mp4",
          mime: "video/mp4",
          mediaQuery: "all and (min-width: 991px)",
        },
        {
          filename: "investigacao_surtos_aula_3",
          resolution: "720p",
          extension: "mp4",
          mime: "video/mp4",
          mediaQuery: "all and (max-width: 990px)",
        },
      ],
      poster: "investigacao_surtos_aula_3_capa.png",
    },
    {
      folder: "logout",
      short: "Sair",
      title: "Sair do App",
      categories: ["infraestrutura"],
      hidemenu: true,
    },
    {
      folder: "enquetes",
      short: "Enquete",
      title: "Enquetes",
      categories: ["infraestrutura"],
      hidemenu: true,
    },
    {
      folder: "investigacao-surtos-ficha-tecnica",
      short: "Créditos",
      title: "Ficha técnica",
      categories: ["conteudo"],
    },
    {
      folder: "dashboard",
      short: "dashboard",
      title: "Dashboard",
      categories: ["conteudo"],
    },
  ],
  name: "Investigação de surtos e epidemias",
  navigateOnStart: "comp/home",
  shortname: "investigacao_surtos",
  corPadraoMenu: "eaf9f8",
  corPadraoMenuDestaque: "cbe8e5",
  url_publica: "/investigacao_surtos",
  corPadrao: "1961AC",
  customMenu: [
    { path: "#comp/home", name: "Inicial" },
    { path: "#comp/listatestes", name: "Testes" },
    { path: "#comp/selecao-progresso", name: "Casos Interativos" },
    { path: "#comp/materiais", name: "Material de Apoio" },
    { path: "#comp/bibliografia", name: "Bibliografia" },
    { path: "#comp/investigacao-surtos-ficha-tecnica", name: "Ficha Técnica" },
    { path: "#comp/enquetes", name: "Enquetes" },
  ],
  fl_unidades: true,
  img_video_apresentacao: "investigacao_surtos_capa_apresentacao.png",
  showComponentMenu: false,
  skipIntro: false,
  style: {
    "dropdown-menu>li>a": ["color: inherit!important"],
    "mdi-home": ["color: inherit!important", "margin-bottom: 5px"],
  },
  fl_layout_alternativo: true,
  videos_extra: [
    {
      col: "col-md-4 col-12",
      videos: [
        {
          title: "",
          subtitle: "",
          tip: "",
          img: "investigacao_surtos_aula_1_capa.png",
          source: "investigacao_surtos_aula_1",
        },
        {
          title: "",
          subtitle: "",
          tip: "",
          img: "investigacao_surtos_aula_2_capa.png",
          source: "investigacao_surtos_aula_2",
        },
        {
          title: "",
          subtitle: "",
          tip: "",
          img: "investigacao_surtos_aula_3_capa.png",
          source: "investigacao_surtos_aula_3",
        },
      ],
    },
  ],
  subtitle: "Curso de Autoaprendizagem",
  corPadraoCurso: "3C9687",
  intro_img_2: "marcas/Logos coloridos - curso ITPS-01-ITPS.svg",
  intro_img_2_alt: "Instituto Todos Pela Saúde",
  intro_img_3: "marcas/Logos coloridos - curso ITPS-02-Abrasco.svg",
  intro_img_3_alt: "Abrasco",
});

db = db.getSiblingDB("arouca");
db.createCollection("ofertas", { capped: false });
db.ofertas.insertMany([
  {
    _id: ObjectId("637f9709014ea877b6f547df"),
    apelido: "investigacao-surtos-1",
    conteudo: "interdisciplinar",
    createdAt: ISODate("2022-11-24T03:00:00Z"),
    curso_arouca: "46784",
    data_fim: ISODate("2034-02-29T23:59:59Z"),
    data_fim_matricula: ISODate("2034-01-31T23:59:59Z"),
    data_inicio: ISODate("2022-11-21T03:00:00Z"),
    id_arouca: "419412",
    modulo: ObjectId("63758ed55ebc0215731f6c36"),
    nome: "Investigação de surtos e epidemias",
    updatedAt: ISODate("2024-02-29T03:00:00Z"),
  },
]);
print("mongo init end --------------------");
/*

*/
