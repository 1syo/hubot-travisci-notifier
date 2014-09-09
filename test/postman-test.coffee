chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect

Postman = require '../src/postman'

describe 'Postman', ->
  it 'should be Common', ->
    @req = { body: { payload: JSON.stringify({}) } }
    @postman = Postman.create(@req, { adapterName: "shell" })
    expect(@postman.constructor.name).to.equal 'Common'

  it 'should be Slack', ->
    @req = { body: { payload: JSON.stringify({}) } }
    @postman = Postman.create(@req, { adapterName: "slack" })
    expect(@postman.constructor.name).to.equal 'Slack'
