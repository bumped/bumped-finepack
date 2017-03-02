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

> Lints your JSON Config files and keeps them readable.

This plugin is based on the [finepack](https://github.com/Kikobeats/finepack) library. It exposes an interface to setup such library in <code>.bumpedrc</code>:

```cson
files: [
  "package.json"
  "bower.json"
]

plugins:
  postrelease:
    'Lint config files':
      plugin: 'bumped-finepack'
```


## Install

> You don't need to install this module! Bumped automatically resolves the plugins dependencies. However, if you still want to do so, it must be globally accessible:

```bash
npm install bumped-finepack -g
```

## API

### opts

Type: `object`

Additional options to be passed to [finepack](https://github.com/Kikobeats/finepack).

## License

MIT © [Bumped]()
