
<div align="center" id="top"> 
  <img src="./public/img/marcas/logo_cursosintegrados_ITPS_verde.svg" alt="Curso de Autoaprendizagem - Investigação de surtos e epidemias" />

  &#xa0;

  <!-- <a href="https://appname.netlify.app">Demo</a> -->
</div>

<h1 align="center">Curso de Autoaprendizagem - Investigação de surtos e epidemias</h1>

<p align="center">
  <img alt="Idioma principal do Github" src="https://img.shields.io/github/languages/top/Departamento-de-Medicina-Social-UFPEL/Investigacao-de-Surtos-e-Epidemias?color=56BEB8">

  <img alt="Contagem de idiomas no Github" src="https://img.shields.io/github/languages/count/Departamento-de-Medicina-Social-UFPEL/Investigacao-de-Surtos-e-Epidemias?color=56BEB8">

  <img alt="Tamanho do repositório" src="https://img.shields.io/github/repo-size/Departamento-de-Medicina-Social-UFPEL/Investigacao-de-Surtos-e-Epidemias?color=56BEB8">

 
  <!-- <img alt="Github issues" src="https://img.shields.io/github/issues/Departamento-de-Medicina-Social-UFPEL/Investigacao-de-Surtos-e-Epidemias?color=56BEB8" /> -->

  <!-- <img alt="Github forks" src="https://img.shields.io/github/forks/Departamento-de-Medicina-Social-UFPEL/Investigacao-de-Surtos-e-Epidemias?color=56BEB8" /> -->

  <!-- <img alt="Github stars" src="https://img.shields.io/github/stars/Departamento-de-Medicina-Social-UFPEL/Investigacao-de-Surtos-e-Epidemias?color=56BEB8" /> -->
</p>

<!-- Status -->

<!-- <h4 align="center"> 
	🚧  App Name 🚀 Under construction...  🚧
</h4> 

<hr> -->

<p align="center">
  <a href="#sobre">Sobre</a> &#xa0; | &#xa0; 
  <a href="#tecnologias">Tecnologias</a> &#xa0; | &#xa0;
  <a href="#requisitos">Requisitos</a> &#xa0; | &#xa0;
  <a href="#começando">Começando</a> &#xa0; | &#xa0;
  <a href="#licença">Licença</a> &#xa0; | &#xa0;
  <a href="https://github.com/Departamento-de-Medicina-Social-UFPEL" target="_blank">Author</a>
</p>

<br>
s
## Sobre ##

O curso de Investigação de Surtos e Epidemias é mais um módulo de autoaprendizagem encapsulado no framework chamado Casca que desenvolvido pelo Departamento de medicina Social da Universidade Federal de Pelotas para encapsular de forma genérica conteúdos de cursos de autoaprendizagem.

## Tecnologias ##

As seguintes ferramentas foram usadas neste projeto:

- [Node.js](https://nodejs.org/en/)
- [MongoDB](https://www.mongodb.com/docs/v5.0/)
- [Locomotivejs](https://www.mongodb.com/docs/v5.0/)
- [Mongoose ODM](https://mongoosejs.com/)
- [Less](https://lesscss.org/)
- [jQuery](https://jquery.com/)
- [Lo‑Dash](https://lodash.com/)
- [Async](https://github.com/caolan/async)
- [Backbone.js](https://backbonejs.org/)
- [Marionette.js](https://marionettejs.com/)
- [Twitter Bootstrap](https://getbootstrap.com)
- [Google Material icons](https://fonts.google.com/icons)
- [Material Design Icon](https://m2.material.io/design/iconography/system-icons.html)


## Requisitos ##
- [Docker compose](https://docs.docker.com/get-docker/)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

Antes de começar você precisa ter [Git](https://git-scm.com) and [Docker compose](https://docs.docker.com/get-docker/) instalados.

## Começando ##
No terminal execute os comandos abaixo:

```bash
# Clone this project
$ git clone https://github.com/Departamento-de-Medicina-Social-UFPEL/Investigacao-de-Surtos-e-Epidemias.git

# Access
$ cd Investigacao-de-Surtos-e-Epidemias

# Run the project
$ docker-compose up --remove-orphans

# O servidor será inicializado no seguinte endereço de seu navegador <http://localhost:21509/modulos/63758ed55ebc0215731f6c36>
# Para uma melhor experiência recomendamos o uso do navagador Mozila Firefox ou Chrome em suas versões mais recentes.

```
### Acesso a base dados ###

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
<img src="./public/img/autores.png">
</div>

&#xa0;


<a href="#top">Voltar ao topo</a>
