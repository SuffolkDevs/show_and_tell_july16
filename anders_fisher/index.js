var id = "cb157b931d5a4066bdc73de6080b794b";
var forward_time = 100;
require("./anders_sphero").setup(id, function(bb8){
  bb8
    .forward(forward_time).colour("green").turn(90)
    .wait(1000)
    .forward(forward_time).colour("yellow").turn(90)
    .wait(1000)
    .forward(forward_time).colour("blue").turn(90)
    .wait(1000)
    .forward(forward_time).colour("purple").turn(90)
    .wait(1000)
    .forward(forward_time).colour("green").turn(90)
    .wait(1000)
    .forward(forward_time).colour("yellow").turn(90)
    .wait(1000)
    .forward(forward_time).colour("blue").turn(90)
    .wait(1000)
    .forward(forward_time).colour("purple").turn(90)
    .run(function(){
      process.exit();
    });
});

