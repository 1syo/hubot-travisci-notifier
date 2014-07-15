# Description
#   A hubot script that does the things
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   TAKAHASHI Kazunari[takahashi@1syo.net]
module.exports = (robot) ->
  robot.router.post "/#{robot.name}/travisci/:room", (req, res) ->
    try
      postman = Postman.create(req, robot)
      postman.deliver()
      res.end "[TravisCI] Sending message"
    catch e
      res.end "[Travis-CI] #{e}"
