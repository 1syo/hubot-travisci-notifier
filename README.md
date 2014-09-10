# hubot-travisci-notifier
[![wercker status](https://app.wercker.com/status/71970c048305e901b515caed8e7f938b/s/master "wercker status")](https://app.wercker.com/project/bykey/71970c048305e901b515caed8e7f938b)
[![Coverage Status](http://img.shields.io/coveralls/1syo/hubot-travisci-notifier.svg?style=flat)](https://coveralls.io/r/1syo/hubot-travisci-notifier)
[![Dependencies Status](http://img.shields.io/david/1syo/hubot-travisci-notifier.svg?style=flat)](https://david-dm.org/1syo/hubot-travisci-notifier)

A hubot script that notify about build results in Travis CI

See [`src/travisci-notifier.coffee`](src/travisci-notifier.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install git://github.com/1syo/hubot-travisci-notifier.git --save`

Then add **hubot-jenkins-notifier** to your `external-scripts.json`:

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

## Notification examples

If you use slack adapter then your notice use Slack attachments.

### Slack Adapter

![](https://raw.githubusercontent.com/wiki/1syo/hubot-travisci-notifier/slack.png)

### Slack Adapter (fallback)

![](https://raw.githubusercontent.com/wiki/1syo/hubot-travisci-notifier/slack-fallback.png)

### Shell Adapter

![](https://raw.githubusercontent.com/wiki/1syo/hubot-travisci-notifier/shell.png)
