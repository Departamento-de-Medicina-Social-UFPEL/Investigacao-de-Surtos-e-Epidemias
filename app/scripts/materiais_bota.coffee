Materiais = require '../models/materiais.coffee'

moduloDaVez = '5d8aab26afcdb9691fbbfdc0'
arr = [
  { "nome": "Diagnóstico sindrômico da dor pélvica", "tipo":"calculadora", "url":"ap2_algoritmo_para_o_diagnostico_sindromico_da_dor_pelvica.pdf", "filesize":"kB"},
  { "nome": "Vacina HPV", "url":"ap2_vacina_hpv_quadrivalente.pdf", "tipo":"Orientação", "filesize":"kB"}
  { "nome": "Exame clínico de mamas", "url":"ap2_exame_clinico_das_mamas.pdf", "tipo":"Orientação", "filesize":"kB"},
  { "nome": "Síndrome de down", "url":"ap2_acompanhamento_da_pessoa_com_sindrome_de_down_por_ciclo_de_vida.pdf", "tipo":"Orientação", "filesize":"kB"},
  { "nome": "Refeições lácteas para crianças desmamadas", "url":"ap2_cuidados_com_a_higiene_nas_refeicoes_lacteas.pdf", "tipo":"Orientação", "filesize":"kB"},
  { "nome": "Fontes de ferro", "url":"ap2_lista_de_alimentos_e_quantidade_de_ferro_fornecida.pdf", "tipo":"Orientação", "filesize":"kB"},
  { "nome": "Hipertensão Arterial Sistêmica", "url":"ap2_procedimentos_recomendados_para_a_medida_da_pressao_arterial.pdf", "tipo":"Orientação", "filesize":"kB"},
  { "nome": "Coleta do exame citopatológico do colo uterino", "url":"ap2_rotina_precancer_cartaz.pdf", "tipo":"Orientação", "filesize":"kB"},
  { "nome": "Avaliação das atividades instrumentais de vida diária", "url":"ap2_avaliacao_das_atividades_instrumentais_de_vida_diaria_(aivd).pdf", "tipo":"escala", "filesize":"kB"}, 
  { "nome": "Refeições lácteas para crianças desmamadas", "url":"ap2_esquema_alimentar_para_criancas_nao_amamentadas.pdf", "tipo":"Orientação", "filesize":"kB"},
  { "nome": "Refeições lácteas para crianças amamentadas com leite de vaca", "url":"ap2_esquema_alimentar_para_criancas_nao_amamentadas_e_alimentadas_com_leite_de_vaca.pdf", "tipo":"Orientação", "filesize":"kB"},
  { "nome": "Avaliação do risco de ulceras e de pressão", "url":"ap2_escala_de_braden_para_avaliacao_do_risco_de_ulceras_de_pressao.pdf", "tipo":"escala", "filesize":"kB"},
  { "nome": "Gripe", "url":"ap2_sindrome_gripal_srag.pdf", "tipo":"escala", "filesize":"kB"},
  { "nome": "Escore de Framingham em homens", "url":"framingham_homens.pdf", "tipo":"calculadora", "filesize":"kB"},
  { "nome": "Escore de Framingham em mulheres", "url":"framingham_mulheres.pdf", "tipo":"calculadora", "filesize":"kB"},
  { "nome": "Translactação relactação", "url":"#comp/video-player/aps2_translactacao_relactacao_video_poster.png", "tipo":"video", "filesize":"kB"}
]

for item in arr
  for prop of item
    if prop is 'url' and item[prop].match(/\s/im)
      console.log item[prop]
  nI = new Materiais
  nI.url = item.url.trim().toLowerCase()
  nI.nome = item.nome.trim()
  nI.tipo = item.tipo.trim()
  nI.filesize = item.filesize.trim().toUpperCase()
  nI.modulo = moduloDaVez

  do nI.save
console.log('talvez ok')
