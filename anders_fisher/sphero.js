var sphero = require("sphero"),
    bb8 = sphero("cb157b931d5a4066bdc73de6080b794b"); // change BLE address accordingly

bb8.connect(function() {

  bb8.roll(150, 0);
  bb8.color("green");

  setInterval(function() {
    bb8.roll(0,0);
  }, 500);
  
  setInterval(function() {
    bb8.roll(150, 90);
    bb8.color("yellow");
  }, 1500);
  
  setInterval(function() {
    bb8.roll(0,90);
  }, 2000);

  setInterval(function() {
    bb8.roll(150, 180);
    bb8.color("blue");
  }, 3000);
  
  setInterval(function() {
    bb8.roll(0,180);
  }, 3500);

  setInterval(function() {
    bb8.roll(150, 270);
    bb8.color("orange");
  }, 4500);

  setInterval(function() {
    bb8.roll(0,270);
    process.exit();
  }, 5000);

});
