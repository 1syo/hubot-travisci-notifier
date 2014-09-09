# Description
#   A Postman build and send message.
#
Slack = require './postman/slack'
Common = require './postman/common'
class Postman
  @create: (req, robot) ->
    if robot.adapterName == 'slack'
      new Slack(req, robot)
    else
      new Common(req, robot)

module.exports = Postman
