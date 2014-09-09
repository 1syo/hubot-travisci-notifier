chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect

Common = require '../../src/postman/common'

describe 'Common', ->
  describe '#notify', ->
    beforeEach ->
      @json =
        branch: "master"
        build_url: "https://travis-ci.org/svenfuchs/minimal/builds/1"
        commit: "62aae5f70ceee39123ef"
        status_message: "Passed"
        number: "1"
        author_name: "Sven Fuchs"
        repository:
          name: "minimal"
          owner_name: "svenfuchs"

      @req =
        body:
          payload: JSON.stringify(@json)
        params: room: "general"

      @robot = { send: sinon.spy() }
      @postman = new Common(@req, @robot)

    it "should call @robot#msend with args", ->
      @postman.notify()
      expect(@robot.send).to.have.been.calledWith(
        {room: @postman.room()}, @postman.notice()
      )
