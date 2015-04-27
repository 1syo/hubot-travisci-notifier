require("blanket") {
  pattern: [
      "hubot-travisci-notifier/src/travisci-notifier.coffee",
      "hubot-travisci-notifier/src/travisci.coffee",
      "hubot-travisci-notifier/src/message.coffee"
    ]
  loader: "./node-loaders/coffee-script"
}
