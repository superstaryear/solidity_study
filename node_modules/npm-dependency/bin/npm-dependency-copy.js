var program = require('commander');
var copy = require('../lib/copy');

program
  .option('-s, --scope <scope>', 'The specified scope of dependencies (production, development). Default is all')
  .parse(process.argv);

program.on('--help', function(){
  console.log('  Examples:');
  console.log('    $ npm-dependency copy --help');
  console.log('    $ npm-dependency copy -h');
  console.log('    $ npm-dependency copy ./build --scope prod');
  console.log('');
});

if (!program.args.length) {
  program.help();
} else {
  copy(program.args[0], program.scope || 'prod');
}
