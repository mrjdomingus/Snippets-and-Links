var express = require("express");
var parseurl = require("parseurl");
var session = require("express-session");

// Instantiate a node-redis client
var redis = require("redis"),
  client = redis.createClient();

// Check if connection to server went right
client.on("error", function(err) {
  console.log("Error " + err);
});

// Create a string key
client.set("foo", "bar", redis.print);

// Promisify get method so we can use async / await
const {promisify} = require('util');
const getAsync = promisify(client.get).bind(client);

(async function myFunc(){
    const res = await getAsync('foo');
    console.log(res);
})();

// Create redis backing store for express sessions
var RedisStore = require("connect-redis")(session);

var app = express();

app.use(
  session({
    store: new RedisStore({ host: "localhost", port: 6379 }),
    secret: "keyboard cat",
    resave: false,
    saveUninitialized: true
  })
);

app.use(function(req, res, next) {
  if (!req.session.views) {
    req.session.views = {};
  }

  // get the url pathname
  var pathname = parseurl(req).pathname;

  // count the views
  req.session.views[pathname] = (req.session.views[pathname] || 0) + 1;

  next();
});

app.get("/foo", function(req, res, next) {
  res.send("you viewed this page " + req.session.views["/foo"] + " times");
});

app.get("/bar", function(req, res, next) {
  res.send("you viewed this page " + req.session.views["/bar"] + " times");
});

app.listen(3000, function () {
    console.log('App listening on port 3000!')
  });
