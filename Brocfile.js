/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp();

app.import('vendor/game.js', {
  exports: {
   'Game': [
      'Game',
    ]
  }
});

module.exports = app.toTree();

console.dir(module.exports);
