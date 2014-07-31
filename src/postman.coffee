# Description
#   A Postman build and send message.
#
class Base
  constructor: (req, @robot) ->
    @_room = req.params.room
    @json = JSON.parse(req.body.payload)

  room: ->
    @_room || ""

  repository: ->
    "#{@json["repository"]["owner_name"]}/#{@json["repository"]["name"]}@#{@json["branch"]}"

  number: ->
    @json["number"]

  author_name: ->
    @json["author_name"]

  commit: ->
    @json["commit"].substr(0, 7)

  build_url: ->
    @json["build_url"]

  compare_url: ->
    @json["compare_url"]

  step: ->
    switch @json["status_message"]
      when "Pending"
        "Build started"
      else
        "Build #{@json["status_message"].toLowerCase()}"

  message: ->
    """
    [Travis CI] #{@step()} \##{@number()} (#{@commit()}) of #{@repository()} by #{@author_name()}
    » #{@build_url()}
    """


class Common extends Base
  deliver: ->
    @robot.send {room: @room()}, @message()


class Slack extends Base
  color: ->
    switch @json["status_message"]
      when "Passed", "Fixed"
        "good"
      when "Pending"
        "#4183c4"
      else
        "danger"

  text: ->
    "[Travis CI] #{@step()} #{@build_url()}|\##{@number()} (#{@compare_url()}|#{@commit()}) of #{@repository()} by #{@author_name()}"

  payload: ->
    message:
      room: @room()
    content:
      text: @text()
      color: @color()
      fallback: @message()
      pretext: ""

  deliver: ->
    @robot.emit 'slack-attachment', @payload()


class Postman
  @create: (req, robot) ->
    if robot.adapterName == 'slack'
      new Slack(req, robot)
    else
      new Common(req, robot)


module.exports = Postman
