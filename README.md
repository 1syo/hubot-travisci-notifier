# hubot-travisci-notifier
[![Build Status](https://travis-ci.org/1syo/hubot-travisci-notifier.svg?branch=master)](https://travis-ci.org/1syo/hubot-travisci-notifier)
[![Coverage Status](http://img.shields.io/coveralls/1syo/hubot-travisci-notifier.svg?style=flat)](https://coveralls.io/r/1syo/hubot-travisci-notifier)
[![Dependencies Status](http://img.shields.io/david/1syo/hubot-travisci-notifier.svg?style=flat)](https://david-dm.org/1syo/hubot-travisci-notifier)

A hubot script that notify about build results in Travis CI

See [`src/travisci-notifier.coffee`](src/travisci-notifier.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install git://github.com/1syo/hubot-travisci-notifier.git --save`

Then add **hubot-travisci-notifier** to your `external-scripts.json`:

```json
["hubot-travisci-notifier"]
```

## Travis CI configuration

Add your .travis.yml:

```
notifications:
  webhooks: <hubot host>:<hubot port>/<hubot name>/travisci/<room>
  on_start: true
```

See also:  
http://docs.travis-ci.com/user/notifications/#Webhook-notification
