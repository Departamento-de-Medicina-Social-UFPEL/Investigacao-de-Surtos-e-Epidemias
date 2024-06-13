({
  'baseUrl': './',
  'out': 'build/main.js',
  'include': ['main'],
  'wrap': true,
  'paths': {
    'underscore': '../../../lib/lodash/underscore',
    'jquery': '../../../lib/jquery/dist/jquery',
    'backbone': '../../../lib/backbone/backbone',
    'backbone.marionette': '../../../lib/backbone.marionette/lib/backbone.marionette',
    'backbone.modal': '../../../lib/backbone-modal/backbone.modal',
    'marionette.modals': '../../../lib/backbone-modal/backbone.marionette.modals',
    'text': '../../../lib/requirejs-text/text'
  }
})