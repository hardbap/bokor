var zombie = require("zombie"),
    assert = require("assert");
/*
zombie.visit("http://localhost:3000/register/aefaac6ae7535605d59c", function(err, browser) {
  console.log(browser.html());
});
*/
zombie.listen(8091, function(err) { console.log('brains...'); });