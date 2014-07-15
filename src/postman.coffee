querystring = require('querystring')

class Base
  constructor: (req, robot) ->
    @query = querystring.parse(req._parsedUrl.query)
    @json = JSON.parse(req.body.payload)
    @robot = robot

  room = ->
    @query.room || ""

  repository = ->
    "#{@json["repository"]["owner_name"]}/#{@json["repository"]["name"]}@#{@json["branch"]}"

  number = ->
    @json["number"]

  author_name = ->
    @json["author_name"]

  commit = ->
    @json["commit"].substr(0, 7)

  build_url = ->
    @json["build_url"]

  compare_url = ->
    @json["compare_url"]

  step = ->
    switch @json["status_message"]
      when "Pending"
        "Build started"
      else
        "Build #{@json["status_message"].toLowerCase()}"


class Common extends Base


class Slack extends Base
  color = ->
    switch @json["status_message"]
      when "Passed", "Fixed"
        "good"
      when "Broken", "Still Failing", "Errored"
        "danger"
      else
        "#E3E4E6"

  text = ->
    "#{step.call(@)} #{build_url.call(@)}|\##{number.call(@)} (#{compare_url.call(@)}|#{commit.call(@)}) of #{repository.call(@)} by #{author_name.call(@)}"

  payload: ->
    message:
      room: room.call(@)
    content:
      text: text.call(@)
      color: color.call(@)
      fallback: text.call(@)
      pretext: ""


class Postman
  @create: (req, robot) ->
    if robot.adapterName == 'slack'
      new Slack(req, robot)
    else
      new Common(req, robot)


module.exports = Postman
