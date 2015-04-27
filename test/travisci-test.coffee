chai = require 'chai'
expect = chai.expect

Travisci = require '../src/travisci'
json = require './fixtures/valid.json'

describe 'Travisci', ->
  describe 'JSON', ->
    beforeEach ->
      req = { body: { payload: JSON.stringify(json) } }
      @travisci = new Travisci(req.body)

    it '#repository_owner_name should be svenfuchs', ->
      expect(@travisci.repository_owner_name()).to.eq "svenfuchs"

    it '#repository_name should be minimal', ->
      expect(@travisci.repository_name()).to.eq "minimal"

    it '#branch should be master', ->
      expect(@travisci.branch()).to.eq "master"

    it '#number should be 1', ->
      expect(@travisci.number()).to.eq "1"

    it '#author_name should be Sven Fuchs', ->
      expect(@travisci.author_name()).to.eq "Sven Fuchs"

    it '#commit should be 62aae5f', ->
      expect(@travisci.commit()).to.eq "62aae5f"

    it '#build_url should be https://travis-ci.org/svenfuchs/minimal/builds/1', ->
      expect(@travisci.build_url()).to.eq "https://travis-ci.org/svenfuchs/minimal/builds/1"

    it '#compare_url should be https://github.com/svenfuchs/minimal/compare/master...develop', ->
      expect(@travisci.compare_url()).to.eq "https://github.com/svenfuchs/minimal/compare/master...develop"

    it '#repository should be svenfuchs/minimal@master', ->
      expect(@travisci.repository()).to.eq "svenfuchs/minimal@master"

  describe '#status', ->
    it 'should be started', ->
      json = { status_message: "Pending" }
      req = { body: { payload: JSON.stringify(json) } }
      travisci = new Travisci(req.body)

      expect(travisci.status()).to.eq "started"

    it 'should be passed', ->
      json = { status_message: "Passed" }
      req = { body: { payload: JSON.stringify(json) } }
      travisci = new Travisci(req.body)

      expect(travisci.status()).to.eq "passed"
