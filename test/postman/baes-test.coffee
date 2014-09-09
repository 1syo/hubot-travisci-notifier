chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect

Base = require '../../src/postman/base'

describe 'Base', ->
  describe '#room', ->
    beforeEach ->
      @req = { body: { payload: JSON.stringify({}) }, params: { room: "general" } }
      @postman = new Base(@req, {})

    it 'should be general', ->
      expect(@postman.room()).to.eq "general"

  describe '#repository_owner_name', ->
    beforeEach ->
      @json = { repository: { owner_name: "svenfuchs" } }
      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Base(@req, {})

    it 'should be svenfuchs', ->
      expect(@postman.repository_owner_name()).to.eq "svenfuchs"

  describe '#repository_name', ->
    beforeEach ->
      @json = { repository: { name: "minimal" } }
      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Base(@req, {})

    it 'should be minimal', ->
      expect(@postman.repository_name()).to.eq "minimal"

  describe '#branch', ->
    beforeEach ->
      @json = { branch: "master" }
      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Base(@req, {})

    it 'should be master', ->
      expect(@postman.branch()).to.eq "master"

  describe '#number', ->
    beforeEach ->
      @json = { number: "1" }
      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Base(@req, {})

    it 'should be 1', ->
      expect(@postman.number()).to.eq "1"

  describe '#author_name', ->
    beforeEach ->
      @json = { author_name: "Sven Fuchs" }
      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Base(@req, {})

    it 'should be Sven Fuchs', ->
      expect(@postman.author_name()).to.eq "Sven Fuchs"

  describe '#commit', ->
    beforeEach ->
      @json = { commit: "62aae5f70ceee39123ef" }
      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Base(@req, {})

    it 'should be 62aae5f', ->
      expect(@postman.commit()).to.eq "62aae5f"

  describe '#build_url', ->
    beforeEach ->
      @json = { build_url: "https://travis-ci.org/svenfuchs/minimal/builds/1" }
      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Base(@req, {})

    it 'should be https://travis-ci.org/svenfuchs/minimal/builds/1', ->
      expect(@postman.build_url()).to.eq "https://travis-ci.org/svenfuchs/minimal/builds/1"

  describe '#compare_url', ->
    beforeEach ->
      @json = { compare_url: "https://github.com/svenfuchs/minimal/compare/master...develop" }
      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Base(@req, {})

    it 'should be https://github.com/svenfuchs/minimal/compare/master...develop', ->
      expect(@postman.compare_url()).to.eq "https://github.com/svenfuchs/minimal/compare/master...develop"

  describe '#repository', ->
    beforeEach ->
      @json =
        branch: "master"
        repository:
          name: "minimal"
          owner_name: "svenfuchs"

      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Base(@req, {})

    it 'should be svenfuchs/minimal@master', ->
      expect(@postman.repository()).to.eq "svenfuchs/minimal@master"

  describe '#status', ->
    it 'should be started', ->
      @json = { status_message: "Pending" }
      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Base(@req, {})
      expect(@postman.status()).to.eq "started"

    it 'should be passed', ->
      @json = { status_message: "Passed" }
      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Base(@req, {})
      expect(@postman.status()).to.eq "passed"

  describe '#notice', ->
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

      @req = { body: { payload: JSON.stringify(@json) } }
      @postman = new Base(@req, {})

    it 'should be notice', ->
      expect(@postman.notice()).to.eq """
        [Travis CI] Build passed #1 (62aae5f) of svenfuchs/minimal@master by Sven Fuchs (https://travis-ci.org/svenfuchs/minimal/builds/1)
      """
