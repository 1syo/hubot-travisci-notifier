chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect

Slack = require '../../src/postman/slack'

describe 'Slack', ->
  describe '#color', ->
    it 'should be #E3E4E6', ->
      @json = { status_message: "Pending" }
      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Slack(@req, {})
      expect(@postman.color()).to.eq "#E3E4E6"

    it 'should be good', ->
      @json = { status_message: "Passed" }
      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Slack(@req, {})
      expect(@postman.color()).to.eq "good"

    it 'should be danger', ->
      @json = { status_message: "Broken" }
      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Slack(@req, {})
      expect(@postman.color()).to.eq "danger"

  describe '#text', ->
    beforeEach ->
      @json =
        branch: "master"
        build_url: "https://travis-ci.org/svenfuchs/minimal/builds/1"
        compare_url: "https://github.com/svenfuchs/minimal/compare/master...develop"
        commit: "62aae5f70ceee39123ef"
        status_message: "Passed"
        number: "1"
        author_name: "Sven Fuchs"
        repository:
          name: "minimal"
          owner_name: "svenfuchs"

      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Slack(@req, {})

    it 'should be text', ->
      expect(@postman.text()).to.eq """
        [Travis CI] Build passed https://travis-ci.org/svenfuchs/minimal/builds/1|#1 (https://github.com/svenfuchs/minimal/compare/master...develop|62aae5f) of svenfuchs/minimal@master by Sven Fuchs
      """

  describe '#payload', ->
    beforeEach ->
      @json =
        branch: "master"
        build_url: "https://travis-ci.org/svenfuchs/minimal/builds/1"
        compare_url: "https://github.com/svenfuchs/minimal/compare/master...develop"
        commit: "62aae5f70ceee39123ef"
        status_message: "Passed"
        number: "1"
        author_name: "Sven Fuchs"
        repository:
          name: "minimal"
          owner_name: "svenfuchs"

      @req = { body: { payload: JSON.stringify(@json) }, params: { room: "general" } }
      @postman = new Slack(@req, {})

    it '.message.room', ->
      expect(@postman.payload().message.room).to.eq "general"

    it '.content.text', ->
      expect(@postman.payload().content.text).to.eq @postman.text()

    it '.content.color', ->
      expect(@postman.payload().content.color).to.eq "good"

    it '.content.fallback', ->
      expect(@postman.payload().content.fallback).to.eq @postman.notice()

  describe '#payload', ->
    beforeEach ->
      @json =
        branch: "master"
        build_url: "https://travis-ci.org/svenfuchs/minimal/builds/1"
        compare_url: "https://github.com/svenfuchs/minimal/compare/master...develop"
        commit: "62aae5f70ceee39123ef"
        status_message: "Passed"
        number: "1"
        author_name: "Sven Fuchs"
        repository:
          name: "minimal"
          owner_name: "svenfuchs"

      @req = { body: { payload: JSON.stringify(@json) }, params: { room: "general" } }
      @robot = { emit: sinon.spy() }
      @postman = new Slack(@req, @robot)

    it "should call @robot#emit with args", ->
      @postman.notify()
      expect(@robot.emit).to.have.been.calledWith(
        'slack-attachment', @postman.payload()
      )
