# Description
#   A hubot script that does the things
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


class Common extends Base
  text: ->
    """
      [Travis CI] #{this.step()} \##{this.number()} (#{this.commit()}) of #{this.repository()} by #{this.author_name()}
      #{this.build_url()}
    """

  deliver: ->
    @robot.send {room: this.room()}, this.text()

class Slack extends Base
  color: ->
    switch @json["status_message"]
      when "Passed", "Fixed"
        "good"
      when "Broken", "Still Failing", "Errored"
        "danger"
      else
        "#E3E4E6"

  text: ->
    "[Travis CI] #{this.step()} #{this.build_url()}|\##{this.number()} (#{this.compare_url()}|#{this.commit()}) of #{this.repository()} by #{this.author_name()}"

  payload: ->
    message:
      room: this.room()
    content:
      text: this.text()
      color: this.color()
      fallback: this.text()
      pretext: ""

  deliver: ->
    @robot.emit 'slack-attachment', this.payload()


class Postman
  @create: (req, robot) ->
    if robot.adapterName == 'slack'
      new Slack(req, robot)
    else
      new Common(req, robot)


module.exports = Postman
