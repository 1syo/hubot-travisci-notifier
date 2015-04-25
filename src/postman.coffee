# Description
#   A Postman build and send message.
#
class Postman
  constructor: (@req, @robot) ->
    @json = JSON.parse(@req.body.payload) if @req.body? # FIXME

  room: ->
    @req.params.room || ""

  repository_owner_name: ->
    @json.repository.owner_name

  repository_name: ->
    @json.repository.name

  branch: ->
    @json.branch

  number: ->
    @json.number

  author_name: ->
    @json.author_name

  commit: ->
    @json.commit.substr(0, 7)

  build_url: ->
    @json.build_url

  compare_url: ->
    @json.compare_url

  repository: ->
    "#{@repository_owner_name()}/#{@repository_name()}@#{@branch()}"

  status: ->
    switch @json["status_message"]
      when "Pending"
        "started"
      else
        "#{@json["status_message"].toLowerCase()}"

  notice: ->
    "[Travis CI] Build #{@status()} \##{@number()} (#{@commit()}) of #{@repository()} by #{@author_name()} (#{@build_url()})"

  notify: ->
    @robot.send {room: @room()}, @notice()

module.exports = Postman
