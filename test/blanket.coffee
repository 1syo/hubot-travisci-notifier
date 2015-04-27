require("blanket") {
  "data-cover-never": "node_modules"
  pattern: [
      "travisci-notifier.coffee",
      "travisci.coffee",
      "message.coffee"
    ]
  loader: "./node-loaders/coffee-script"
}
