# Description
#   A Postman build and send message.
#
Base = require './base'
class Slack extends Base
  color: ->
    switch @json["status_message"]
      when "Passed", "Fixed"
        "good"
      when "Pending"
        "#E3E4E6"
      else
        "danger"

  text: ->
    "[Travis CI] Build #{@status()} #{@build_url()}|\##{@number()} (#{@compare_url()}|#{@commit()}) of #{@repository()} by #{@author_name()}"

  payload: ->
    message:
      room: @room()
    content:
      text: @text()
      color: @color()
      fallback: @notice()
      pretext: ""

  notify: ->
    @robot.emit 'slack-attachment', @payload()

module.exports = Slack
