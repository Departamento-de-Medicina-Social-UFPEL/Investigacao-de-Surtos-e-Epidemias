Modulo = require('./app/models/moduloModel.coffee')
path = require('path')
fs = require('fs')
gulp = require('gulp')
uglify = require('gulp-uglify')
rjs = require('gulp-requirejs')
replace = require('gulp-replace')
miniCss = require('gulp-clean-css')
csslint = require('gulp-csslint')
concatCss = require('gulp-concat-css')
debug = require('gulp-debug')
stripDebug = require('gulp-strip-debug')
argv = require('yargs').argv

pathsBuilder = (componentes) ->
  componentes.reduce ((memo, comp) ->
    memo[comp.name] = comp.folder
    memo
  ), {}

includesBuilder = (componentes, fixes) ->
  fixes = if fixes == null or fixes == undefined or (if fixes then fixes.length else 0) > 0 then [] else fixes
  fixes.concat componentes.map((p) ->
    p.folder + '/main'
  )

readSpecFile = (specPath) -> JSON.parse fs.readFileSync(specPath, 'utf-8')

spec = pacotes = paths = includes = config = out = css = undefined

gulp.task 'scripts', ->
  # return console.log('data', spec, pacotes, paths, includes, config, out, css)
  rjs(
    packages: pacotes
    wrap: false
    path: paths
    mainConfigFile: config
    include: [ 'lib/almond/almond' ].concat(includes)
    out: '' + out + '/js/casca.min.js'
    baseUrl: 'public'
    removeCombined: false
    findNestedDependencies: true
    preserveLicenseComments: false
    optimize: 'uglify2' )
  .pipe debug title: 'js:'
  .pipe do stripDebug
  .pipe do uglify
  .pipe gulp.dest './'
  .pipe debug title: 'jsBuild:'
  return

gulp.task 'styles', ->
  # return console.log('data', spec, pacotes, paths, includes, config, out, css)
  gulp.src css, cwd: 'public'
  .pipe debug title: 'css:'
  .pipe concatCss 'style.css'
  .pipe do miniCss
  .pipe debug title: 'cssConcat:'
  .pipe replace /\.\.\/\.\.\/\.\.\/mdi\//gim, '../'
  .pipe gulp.dest '' + out + '/css'
  .pipe debug title: 'cssSave:'
  return

gulp.task 'prepare-spec', ->
  if !argv.spec
    oid = argv.oid or argv.id or argv._id
    if !oid
      return console.log('spec, id ???')
    return Modulo.findOne(_id: oid).exec((err, doc) ->
      console.log doc
      return
    )
  if !argv.out
    return console.log('destino ???')
  # console.log("Modulo", Modulo);
  spec = readSpecFile(argv.spec)
  pacotes = spec.components
  paths = pathsBuilder(pacotes)
  includes = includesBuilder(pacotes, spec.includes)
  config = spec.config
  out = argv.out
  css = spec.styles
  console.log '\n\nconfig', config
  console.log '\n\npacotes', pacotes
  console.log '\n\npaths', paths
  console.log '\n\nincludes', includes
  console.log '\n\nout', out
  console.log '\n\ncss', css
  return

cascaCompiler = (pacotes, includes, paths, out) ->

# gulp.task('dist', ['rjs'/*, 'images', 'lint'*/]);

gulp.task 'nothing', -> console.log 'bye!\n'; process.exit()

gulp.task 'done', ->
  process.exit()

gulp.task 'dist', [
  'prepare-spec'
  'styles'
  'scripts'
]

gulp.task 'dry-dist', [
  'prepare-spec'
  'styles'
  'scripts'
  'nothing'
]

gulp.task 'dry-spec', [
  'prepare-spec'
  'done'
]

# gulp.task 'default', [ 'nothing' ]

