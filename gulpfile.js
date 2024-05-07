var Modulo, argv, cascaCompiler, concatCss, config, css, csslint, debug, fs, gulp, includes, includesBuilder, miniCss, out, pacotes, path, paths, pathsBuilder, readSpecFile, replace, rjs, spec, stripDebug, uglify;
require("coffee-script/register");
Modulo = require('./app/models/moduloModel.coffee');
const { series, parallel } = require("gulp");
path = require('path');

fs = require('fs');

gulp = require('gulp');

uglify = require('gulp-uglify');

rjs = require('gulp-requirejs');

replace = require('gulp-replace');

miniCss = require('gulp-clean-css');

csslint = require('gulp-csslint');

concatCss = require('gulp-concat-css');

debug = require('gulp-debug');

stripDebug = require('gulp-strip-debug');

argv = require('yargs').argv;

pathsBuilder = function (componentes, paths) {
  console.log(componentes);
  paths_temp = componentes.reduce((function (memo, comp) {
    //memo[comp.folder] = 'js/components/' + comp.folder;
    memo[comp.folder] = 'js/components/' + comp.folder + '/main';
    return memo;
  }), paths ? paths : {});
  // paths_temp["requireLib"] = "lib/requirejs/require";
  paths_temp["almond"] = 'lib/almond/almond';
  return paths_temp;
};

includesBuilder = function (componentes, fixes) {
  fixes = fixes === null || fixes === void 0 || (fixes ? fixes.length : 0) > 0 ? [] : fixes;
  return fixes.concat(componentes.map(function (p) {
    return p.folder + "/main";
  }));
};



spec = pacotes = paths = includes = config = out = css = void 0;
exit = require('gulp-exit');
const prepare_spec = function (cb) {

  var oid;
  console.log("prepare-spec", argv);
  oid = argv.oid || argv.id || argv._id;
  if (!oid) {
    return console.log('spec, id ???');
  }
  return Modulo.findOne({
    _id: oid
  }).lean().exec(function (err, doc) {
    if (!argv.out) {
      return console.log("destino ???");
    }

    pacotes = doc.components.map(function (p) {
      return { name: p.folder, location: 'js/components/' + p.folder + '/' }

    });
    paths = doc.components;
    includes = includesBuilder(doc.components, ["almond"]);
    out = argv.out;
    cb();
  })
}
readSpecFile = function (specPath) {
  return JSON.parse(fs.readFileSync(specPath, 'utf-8'));
};
const makejs = function (cb) {
  console.log(out, 'out');
  var requirejsOptimize = require("gulp-requirejs-optimize");
  let configFile = readSpecFile("build/config.json");
  return gulp.src("build/config.json")
    .pipe(requirejsOptimize(function () {
      paths.forEach(function (a) {
        configFile.shim.casca.deps.push(a.folder);
      });
      paths = pathsBuilder([], configFile.paths);
      console.log(paths);
      return {
        packages: pacotes,
        paths: paths,
        shim: configFile.shim,
        map: configFile.map,
        optimize: "uglify2",
        baseUrl: "public/",
        include: ["boot"],
        name: "casca",
        out: "libs/main.js",
        wrap: true,
        findNestedDependencies: true,
        preserveLicenseComments: false,
        removeCombined: false
      };
    }))
    .pipe(debug({ title: "jsMin:", }))
    .pipe(gulp.dest(out))
    .pipe(debug({ title: "jsBuild:", }, cb()))

};
//const scripts = series(prepare_spec, makejs);

const styles = function (cb) {
  css = [
    "lib/bootstrap/dist/css/bootstrap.min.css",
    "lib/bootstrap-material-design/dist/css/material.css",
    "lib/mdi/css/materialdesignicons.css",
    "lib/backbone-modal/backbone.modal.css",
    "lib/backbone-modal/backbone.modal.theme.css",
    "css/all.css",
  ];
  gulp
    .src(css, { cwd: "public" })
    .pipe(debug({ title: "css:" }))
    .pipe(concatCss("style.css"))
    .pipe(miniCss())
    .pipe(debug({ title: "cssConcat:" }))
    .pipe(replace(/\.\.\/\.\.\/\.\.\/mdi\//gim, "../"))
    .pipe(gulp.dest("" + out + "/css"))
    .pipe(debug({ title: "cssSave:" }, cb()))

}


exports.build = series(prepare_spec, styles, makejs, exit);
