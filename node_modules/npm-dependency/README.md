# npm-dependency
npm dependency tool: list and copy module dependencies.

```
Usage: npm-dependency [command] [options]

  Commands:
    copy <dir> [options]  Copy dependencies to specified directory
    help [cmd]            display help for [cmd]

  Options:
    -h, --help     output usage information
    -V, --version  output the version number
```

## The copy command
```
Usage: npm-dependency copy <dest> [options]

  Options:
    -h, --help           output usage information
    -s, --scope <scope>  The specified scope of dependencies (production, development). Default is all

  Examples:
    $ npm-dependency copy --help
    $ npm-dependency copy -h
    $ npm-dependency copy ./build --scope prod
```
