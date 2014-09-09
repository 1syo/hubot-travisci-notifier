# Description
#   A Postman build and send message.
#
Base = require './base'
class Common extends Base
  notify: ->
    @robot.send {room: @room()}, @notice()

module.exports = Common
