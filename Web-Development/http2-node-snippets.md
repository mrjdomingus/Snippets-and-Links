# HTTP/2 + node +  express code sample using SPDY

Also see: [https://webapplog.com/http2-node/](https://webapplog.com/http2-node/)

```
const port = 443;
const spdy = require("spdy");
const express = require("express");
const path = require("path");
const fs = require("fs");

const app = express();

app.get("*", (req, res) => {
  res.status(200).json({ message: "ok" });
});
const options = {
  key: fs.readFileSync(__dirname + "/server.key"),
  cert: fs.readFileSync(__dirname + "/server.crt")
};

spdy.createServer(options, app).listen(port, error => {
  if (error) {
    console.error(error);
    return process.exit(1);
  } else {
    console.log("Listening on port: " + port + ".");
  }
});
```
