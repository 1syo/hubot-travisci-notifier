# Description
#   A hubot script that notify about build results in Travis CI
#
# Dependencies:
#   mustache: 2.0.0
#
# Configuration:
#   Add your .travis.yml:
#
#   ```
#   notifications:
#     webhooks: <hubot host>:<hubot port>/<hubot name>/travisci/<room>
#     on_start: true
#   ```
#
#   See also:
#   http://docs.travis-ci.com/user/notifications/#Webhook-notification
#
# Commands:
#   None
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
