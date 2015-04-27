chai = require 'chai'
expect = chai.expect
sinon = require 'sinon'
sandbox = sinon.sandbox.create()

Message = require '../src/message'
Travisci = require '../src/travisci'
json = require './fixtures/valid.json'

describe 'Message', ->
  beforeEach ->
    process.env.HUBOT_TRAVISCI_TEMPLATE ||= ''

  describe 'exists HUBOT_TRAVISCI_TEMPLATE', ->
    beforeEach ->
      sandbox.stub(process.env, "HUBOT_TRAVISCI_TEMPLATE", 'Build {{ status }} #{{ number }}')
      req = { body: { payload: JSON.stringify(json) } }
      @message = new Message(new Travisci(req.body))

    afterEach ->
      sandbox.restore()

    it '#build', ->
      expect(@message.build()).to.eq "Build passed #1"

  describe 'not exists HUBOT_TRAVISCI_TEMPLATE', ->
    beforeEach ->
      req = { body: { payload: JSON.stringify(json) } }
      @message = new Message(new Travisci(req.body))

    it '#build', ->
      message = 'Build passed #1 (62aae5f) of svenfuchs/minimal@master by Sven Fuchs (https://travis-ci.org/svenfuchs/minimal/builds/1)'
      expect(@message.build()).to.eq message
