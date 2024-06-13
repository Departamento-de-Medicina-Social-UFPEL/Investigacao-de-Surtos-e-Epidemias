
<div align="center" id="top"> 
  <img src="./data/img/marcas/logo_cursosintegrados_ITPS_verde.svg" alt="Curso de Autoaprendizagem - Investigação de surtos e epidemias" />

  &#xa0;

 </div>

<h1 align="center">Curso de Autoaprendizagem - Investigação de surtos e epidemias</h1>

<p align="center">
  <img alt="Idioma principal do Github" src="https://img.shields.io/github/languages/top/Departamento-de-Medicina-Social-UFPEL/Investigacao-de-Surtos-e-Epidemias?color=56BEB8">

  <img alt="Contagem de idiomas no Github" src="https://img.shields.io/github/languages/count/Departamento-de-Medicina-Social-UFPEL/Investigacao-de-Surtos-e-Epidemias?color=56BEB8">

  <img alt="Tamanho do repositório" src="https://img.shields.io/github/repo-size/Departamento-de-Medicina-Social-UFPEL/Investigacao-de-Surtos-e-Epidemias?color=56BEB8">


</p>


<p align="center">
  <a href="#sobre">Sobre</a> &#xa0; | &#xa0; 
  <a href="#requisitos">Requisitos</a> &#xa0; | &#xa0;
  <a href="#começando">Começando</a> &#xa0; | &#xa0;
  <a href="#licença">Licença</a> &#xa0; | &#xa0;
  <a href="https://github.com/Departamento-de-Medicina-Social-UFPEL" target="_blank">Author</a>
</p>

<br>

## Sobre ##

**Título:** Investigação de Surtos e Epidemias

**Público-alvo:** Profissionais com atuação no controle a pandemia do COVID-19

**Formato:** Ensino a Distância

**Nível:** Educação Profissional e Tecnológica

**Modalidade:** Qualificação Profissional

**Resumo:** A pandemia de covid-19 evidenciou a importância da área de vigilância em saúde. Entretanto, esta área costuma ter alta rotatividade de profissionais que nem sempre contam com formação específica. O objetivo é abordar os aspectos epidemiológicos que norteiam a investigação de surtos e epidemias, bem como as etapas da realização da investigação, com ênfase na investigação de surtos e epidemias de doenças respiratórias como a covid-19, de doenças diarreicas agudas e doenças transmitidas pela água, de doenças exantemáticas e outras doenças como a leptospirose, toxoplasmose e hepatite A. Serão abordados pelo curso temas como a importância da investigação de surtos e epidemias, como realizar a investigação, os 10 passos da investigação e as particularidades da investigação em diversas situações problema. O curso conta com vídeos, casos interativos, guias de consulta rápida e bibliografia para aprofundamento do assunto. O Curso de Investigação de Surtos e Epidemias oportunizará ao profissional ampliar seus conhecimentos sobre como identificar a existência de surtos ou epidemias, a fonte de transmissão, o modo de propagação e o agente causador, para que, com base nessas informações, sejam estabelecidas estratégias de prevenção ou mitigação. A formação de profissionais para realizar investigação de surtos e epidemias pode apoiar a detecção precoce de situações de surtos e epidemias e de estratégias de prevenção e mitigação.

## Requisitos para rodar localmente ##
- [Docker compose](https://docs.docker.com/get-docker/)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

Antes de começar você precisa ter [Git](https://git-scm.com) and [Docker compose](https://docs.docker.com/get-docker/) instalados.

## Começando ##
No terminal execute os comandos abaixo:

```bash
# Clone this project
$ git clone https://github.com/Departamento-de-Medicina-Social-UFPEL/Investigacao-de-Surtos-e-Epidemias.git

# Access
$ cd Investigacao-de-Surtos-e-Epidemias/src/

# Run the project
$ docker-compose up --remove-orphans

# O servidor será inicializado no seguinte endereço de seu navegador <http://localhost:21509/modulos/63758ed55ebc0215731f6c36>
# Para uma melhor experiência recomendamos o uso do navagador Mozila Firefox ou Chrome em suas versões mais recentes.

```
### Acesso a base dados local ###

Eventualmente você pode precisar acessar os dados da base de dados para manutenção. Segue abaixo os comandos.

```
$ docker exec -it mamongo bash
$ mongo mongodb://mamongo:mamongo@127.0.1.1:27017/admin?authSource=admin
```

## Licença ##

©2022. Universidade Federal de Pelotas

Alguns direitos reservados. É permitida a reprodução, disseminação e utilização dessa obra, em parte ou em sua totalidade, nos termos da licença para usuário final do Acervo de Recursos Educacionais em Saúde (ARES). Deve ser citada a fonte e é vedada sua utilização comercial.

&#xa0;
Desenvolvido por:

<div align="center" id="footer"> 
<img src="./data/img/autores.png">
</div>

&#xa0;


<a href="#top">Voltar ao topo</a>
