# hubot-travisci-notification
[![Build Status](http://img.shields.io/travis/1syo/hubot-travisci-notification.svg?style=flat)](https://travis-ci.org/1syo/hubot-travisci-notification)
[![Coverage Status](http://img.shields.io/coveralls/1syo/hubot-travisci-notification.svg?style=flat)](https://coveralls.io/r/1syo/hubot-travisci-notification)
[![Dependencies Status](http://img.shields.io/david/1syo/hubot-travisci-notification.svg?style=flat)](https://david-dm.org/1syo/hubot-travisci-notification)

A hubot script that notify about build results in Travis CI

See [`src/travisci-notification.coffee`](src/travisci-notification.coffee) for full documentation.

## Installation

Add **hubot-travisci-notification** to your package.json:

```json
{
  "dependencies": {
    "hubot-travisci-notification": "1syo/hubot-travisci-notification"
  }
}
```

Then add **hubot-travisci-notification** to your `external-scripts.json`:

```json
["hubot-travisci-notification"]
```
