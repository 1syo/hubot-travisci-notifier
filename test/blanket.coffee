require("blanket") {
  "data-cover-never": "node_modules"
  pattern: ["travisci-notifier.coffee", "postman.coffee"]
  loader: "./node-loaders/coffee-script"
}
