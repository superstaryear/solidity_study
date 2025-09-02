#!/usr/bin/env node

var program = require('commander');
var pkg = require('../package.json');

program
  .version(pkg.version)
  .command('copy <dir> [options]', 'Copy dependencies to specified directory')
  // .command('list [options]', 'List dependencies', {isDefault: true})
  .parse(process.argv);
