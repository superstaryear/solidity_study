var program = require('commander');
var list = require('../lib/list');

program
  .option('-s, --scope <scope>', 'The specified scope of dependencies. Default is all')
  .option('-f, --format <format>', 'The ouput format: json or tree. Default is tree')
  .parse(process.argv);

var scope = program.scope || 'all';
var format = program.format;

// if (format === 'json') {
//   list.json(scopes);
// } else {
//   list.tree(scopes);
// }
