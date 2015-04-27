# Description
#   A hubot script that notify about build results in Travis CI
#
# Dependencies:
#   mustache
#
# Configuration:
#   None
#
# Commands:
#   None
#
# URLS:
#   POST /<hubot url>:<hubot port>/travisci/<room>
#
# Notes:
#  http://docs.travis-ci.com/user/notifications/#Webhook-notification
#
# Author:
#   TAKAHASHI Kazunari[takahashi@1syo.net]
#
Message = require "./message"
Travisci = require "./travisci"

module.exports = (robot) ->
  robot.router.post "/#{robot.name}/travisci/:room", (req, res) ->
    try
      message = new Message(new Travisci(req.body))
      robot.send { room: req.params.room }, message.build()

      res.end "[Travis CI] Sending message"
    catch e
      res.end "[Travis CI] #{e}"
