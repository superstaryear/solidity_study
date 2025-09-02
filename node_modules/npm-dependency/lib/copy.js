var cpr = require('cpr');
var path = require('path');
var list = require('./list');

module.exports = copy;

function copy(dest, scope) {
  list(scope, complete)

  function complete(json, list) {
    list.forEach(function(depend) {
      var s = path.join(process.cwd(), 'node_modules', depend.name);
      var d = path.join(dest, depend.name);
      cpr(s, d, {overwrite: true, confirm: false}, noop);
    });
  }
}


function noop() {}
