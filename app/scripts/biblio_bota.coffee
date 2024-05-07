Biblio = require '../models/bibliografia.coffee'
arr = [
  {
    "ano": "2006. 140p."
    "autor": "BRASIL. Ministério da Saúde."
    "titulo": "Manual de Controle das Doenças Sexualmente Transmissíveis."
    "etc":"4ª ed. Brasília: Ministério da Saúde; 2006. 140p."
    "url": "manual_controle_das_dst.pdf"
  }


  {
    "ano": "2010"
    "autor": "BRASIL. Ministério da Saúde."
    "titulo": "Curso de vigilância epidemiológica das Doenças Sexualmente Transmissíveis de notificação compulsória: Sífilis e Síndrome do Corrimento Uretral Masculino"
    "etc":"Brasília – DF"
    "url": "cbve_corrimento_masc_2010_final_pdf_24822.pdf"
  }
  {
    "ano": "In: DUNCAN, Bruce B.; SCHMIDT, Maria Inês; GIUGLIANI, Elsa R. J. Medicina ambulatorial: condutas de atenção primária baseadas em evidências. Porto Alegre: Artmed,"
    "autor": "SAVARIS, Ricardo Francalacci."
    "titulo": "Doenças Sexualmente Transmissíveis: Abordagem Sindrômica."
    "etc":"4ª ed. Brasília: Ministério da Saúde; 2006. 140p."
    "url": "manual_controle_das_dst.pdf"
  }
  {
    "ano": "2006. 140p."
    "autor": "BRASIL. Ministério da Saúde."
    "titulo": "Manual de Controle das Doenças Sexualmente Transmissíveis."
    "etc":"4ª ed. Brasília: Ministério da Saúde; 2006. 140p."
    "url": "manual_controle_das_dst.pdf"
  }
  {
    "ano": "2006. 140p."
    "autor": "BRASIL. Ministério da Saúde."
    "titulo": "Manual de Controle das Doenças Sexualmente Transmissíveis."
    "etc":"4ª ed. Brasília: Ministério da Saúde; 2006. 140p."
    "url": "manual_controle_das_dst.pdf"
  }
  {
    "ano": "2006. 140p."
    "autor": "BRASIL. Ministério da Saúde."
    "titulo": "Manual de Controle das Doenças Sexualmente Transmissíveis."
    "etc":"4ª ed. Brasília: Ministério da Saúde; 2006. 140p."
    "url": "manual_controle_das_dst.pdf"
  }
  {
    "ano": "2006. 140p."
    "autor": "BRASIL. Ministério da Saúde."
    "titulo": "Manual de Controle das Doenças Sexualmente Transmissíveis."
    "etc":"4ª ed. Brasília: Ministério da Saúde; 2006. 140p."
    "url": "manual_controle_das_dst.pdf"
  }
  {
    "ano": "2006. 140p."
    "autor": "BRASIL. Ministério da Saúde."
    "titulo": "Manual de Controle das Doenças Sexualmente Transmissíveis."
    "etc":"4ª ed. Brasília: Ministério da Saúde; 2006. 140p."
    "url": "manual_controle_das_dst.pdf"
  }
]

for item in arr
  for prop of item
    if prop is 'url' and item[prop].match(/\s/im)
      console.log item[prop]
  nI = new Biblio

  nI.url = item.url.trim().toLowerCase()
  nI.autor = item.autor.trim()
  nI.ano = item.ano.trim()
  nI.titulo = item.titulo.trim()
  nI.modulo = '57DFE938E70643D3BF9999C9'

  do nI.save