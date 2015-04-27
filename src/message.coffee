# Description
#   A Message build message with Mustache.
#
Mustache = require 'mustache'

class Message
  constructor: (@travisci) ->

  template: ->
    process.env.HUBOT_TRAVISCI_TEMPLATE ||
      'Build {{ status }} #{{ number }} ({{ commit }}) of {{{ repository }}} by {{ author_name }} ({{{ build_url }}})'

  build: ->
    Mustache.render(@template(), @travisci)

module.exports = Message
