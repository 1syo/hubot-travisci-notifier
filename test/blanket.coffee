require("blanket") {
  "data-cover-never": "node_modules"
  pattern: [
    "travisci-notifier.coffee",
    "postman.coffee",
    "postman/common.coffee",
    "postman/slack.coffee",
    "postman/base.coffee"
    ]
  loader: "./node-loaders/coffee-script"
}
