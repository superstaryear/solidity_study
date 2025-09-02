module.exports = list;

var fs = require('fs');
var path = require('path');
var read = require('read-package-json');
var jsonFormat = require('json-format');

function list(scope, cb) {
  var pkgFile = path.join(process.cwd(), 'package.json');
  var root = {};
  var packages = {};
  var reading = [];

  resolve(process.cwd(), root, scope, true);

  function resolve(basedir, depend, scope, root) {
    var pkgFile = null;
    if (root) {
      pkgFile = path.join(basedir, 'package.json');
      basedir = path.join(basedir, 'node_modules');
    } else {
      reading.push(depend.name);
      pkgFile = path.join(basedir, depend.name, 'package.json');
    }

    read(pkgFile, console.error, false, function(err, data) {
      if (err) throw new Error(err);
      
      depend.name = data.name;
      depend.version = data.version;

      function r(depends, scope) {
        if (depends && Object.keys(depends).length) {
          depend.dependencies = Object
            .keys(data.dependencies)
            .map(function(d) {
              if (packages[d]) {
                return packages[d];
              }

              var depend = packages[d] = {name: d, scope: scope};
              resolve(basedir, depend, scope);
              return depend;
            })
            .concat(depend.dependencies);
        }
      }

      if (scope === 'all' || scope.indexOf('prod') >= 0) {
        r(data.dependencies, 'production');
      }

      if (scope === 'all' || scope.indexOf('dev') >= 0) {
        r(data.dependencies, 'development');
      }

      reading = reading.filter(function(d) { return d !== depend.name; });
      if (!reading.length) {
        complete();
      }
    });
  }

  function complete() {
    if (cb) {
      cb(root, Object.keys(packages).map(function(d) { return packages[d]; }));
    }
  }
}

list.json = function json(scopes) {

}

list.tree = function tree(scopes) {

}
