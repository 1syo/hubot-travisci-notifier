chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect

process.env.HUBOT_AIRBRAKE_SUBDOMAIN = "test"
Postman = require '../src/postman'

valid_json = require './fixtures/valid.json'

describe 'Postman', ->
  beforeEach ->
    @req =
      body:
        payload: JSON.stringify(valid_json)
      _parsedUrl:
        query: "room=general"

  describe 'Common', ->
    beforeEach ->
      @robot =
        adapterName: "shell"
        send: sinon.spy()

      @postman = Postman.create(@req, @robot)

    it '#room', ->
      expect(@postman.room()).to.eq "general"

    it '#repository', ->
      expect(@postman.repository()).to.eq "svenfuchs/minimal@master"

    it '#number', ->
      expect(@postman.number()).to.eq "1"

    it '#author_name', ->
      expect(@postman.author_name()).to.eq "Sven Fuchs"

    it '#commit', ->
      expect(@postman.commit()).to.eq "62aae5f"

    it '#build_url', ->
      expect(@postman.build_url()).to.eq "https://travis-ci.org/svenfuchs/minimal/builds/1"

    it '#compare_url', ->
      expect(@postman.compare_url()).to.eq "https://github.com/svenfuchs/minimal/compare/master...develop"

    it '#text', ->
      expect(@postman.text()).to.eq """
        [Travis CI] Build passed #1 (62aae5f) of svenfuchs/minimal@master by Sven Fuchs
        https://travis-ci.org/svenfuchs/minimal/builds/1
      """

    it '#step', ->
      expect(@postman.step()).to.eq "Build passed"

    it "#deliver", ->
      @postman.deliver()
      expect(@robot.send).to.have.been.calledWith(
        {room: @postman.room()}, @postman.text()
      )

  describe 'Slack', ->
    beforeEach ->
      @robot =
        adapterName: "slack"
        emit: sinon.spy()

      @postman = Postman.create(@req, @robot)

    it '#text', ->
      expect(@postman.text()).to.eq """
        [Travis CI] Build passed https://travis-ci.org/svenfuchs/minimal/builds/1|#1 (https://github.com/svenfuchs/minimal/compare/master...develop|62aae5f) of svenfuchs/minimal@master by Sven Fuchs
      """

    it '#payload', ->
      expect(@postman.payload().message["room"]).to.eq "general"
      expect(@postman.payload().content["text"]).to.eq @postman.text()
      expect(@postman.payload().content["color"]).to.eq "good"

    it "#deliver", ->
      @postman.deliver()
      expect(@robot.emit).to.have.been.calledWith(
        'slack-attachment', @postman.payload()
      )
