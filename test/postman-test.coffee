chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect

process.env.HUBOT_AIRBRAKE_SUBDOMAIN = "test"
Postman = require '../src/postman'

json = require './fixtures/valid.json'

describe 'Postman', ->
  describe 'Common', ->
    beforeEach ->
      @robot =
        adapterName: "shell"
        send: sinon.spy()

      @req =
        body: json
        _parsedUrl:
          query: "room=general"

      @postman = Postman.create(@req, @robot)

    it '#room', ->
      expect(@postman.room()).to.eq "general"

    it '#url', ->
      expect(@postman.url()).to.eq \
        "https://test.airbrake.io/projects/1055/groups/37463546"

    it "#pretext", ->
      expect(@postman.pretext()).to.eq \
        "[Airbrake] #37463546 New alert for Airbrake: RuntimeError"

    it "#text", ->
      expect(@postman.text()).to.eq \
        "RuntimeError: You threw an exception for testing"

    it "#file", ->
      expect(@postman.file()).to.eq \
        "[PROJECT_ROOT]/app/controllers/pages_controller.rb:35"

    it "#last_occurred_at", ->
      expect(@postman.last_occurred_at()).to.eq "2012-03-21T08:37:15Z"

    it "#message", ->
      expect(@postman.message()).to.eq """
        [Airbrake] #37463546 New alert for Airbrake: RuntimeError
        RuntimeError: You threw an exception for testing
        [PROJECT_ROOT]/app/controllers/pages_controller.rb:35
        https://test.airbrake.io/projects/1055/groups/37463546
        2012-03-21T08:37:15Z
      """

    it "#deliver", ->
      @postman.deliver()
      expect(@robot.send).to.have.been.calledWith(
        {room: @postman.room()}, @postman.message()
      )


  describe 'Slack', ->
    beforeEach ->
      @robot =
        adapterName: "slack"
        emit: sinon.spy()

      @req =
        body: json
        _parsedUrl:
          query: "room=general"

      @postman = Postman.create(@req, @robot)

    it "#pretext", ->
      expect(@postman.pretext()).to.eq \
        "[Airbrake] #{@postman.url()}|#37463546 New alert for Airbrake: RuntimeError"

    it "#message", ->
      expect(@postman.message().message["room"]).to.eq "general"
      expect(@postman.message().content["pretext"]).to.eq @postman.pretext()
      expect(@postman.message().content["text"]).to.eq @postman.text()
      expect(@postman.message().content["color"]).to.eq "danger"

    it "#deliver", ->
      @postman.deliver()
      expect(@robot.emit).to.have.been.calledWith(
        'slack-attachment', @postman.message()
      )
