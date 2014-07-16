require("blanket") {
  "data-cover-never": "node_modules"
  pattern: ["travisci-notification.coffee", "postman.coffee"]
  loader: "./node-loaders/coffee-script"
}
