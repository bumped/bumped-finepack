# bumped-finepack

<h1 align="center">
  <br>
  <img src="http://i.imgur.com/DmMbFwL.png" alt="bumped">
  <br>
  <br>
</h1>

![Last version](https://img.shields.io/github/tag/Bumped/bumped-finepack.svg?style=flat-square)
[![Build Status](http://img.shields.io/travis/Bumped/bumped-finepack/master.svg?style=flat-square)](https://travis-ci.org/Bumped/bumped-finepack)
[![Dependency status](http://img.shields.io/david/Bumped/bumped-finepack.svg?style=flat-square)](https://david-dm.org/Bumped/bumped-finepack)
[![Dev Dependencies Status](http://img.shields.io/david/dev/Bumped/bumped-finepack.svg?style=flat-square)](https://david-dm.org/Bumped/bumped-finepack#info=devDependencies)
[![NPM Status](http://img.shields.io/npm/dm/bumped-finepack.svg?style=flat-square)](https://www.npmjs.org/package/bumped-finepack)
[![Donate](https://img.shields.io/badge/donate-paypal-blue.svg?style=flat-square)](https://paypal.me/kikobeats)

> Lints your JSON Config files and keep them readables.

## Install

You don't need to install it! Bumped automatically resolve the plugins dependencies. However if you still want to do so must be globally accessible:

```bash
npm install bumped-finepack -g
```

## Configuration

The plugin is based in the [finepack](https://github.com/Kikobeats/finepack) library. Basically the plugin expose a interface for setup the library in the .bumpedrc:

```cson
files: [
  "package.json"
  "bower.json"
]

plugins:
  postrelease:
    'Lint config files':
      plugin: 'bumped-finepack'
      options:
        lint: true # lint the JSON file before validate. by default is true.
        validate: true # Validate JSON rules. by default is true.
```

## License

MIT © [Bumped]()
