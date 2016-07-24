var sphero = require("sphero");
var exec = require('child_process').exec;

var schedule = [];
var angle = 0;
var bb8;

var setup = function(id, input_instructions){
  bb8 = sphero(id);
  schedule = [];
  bb8.connect(function() {
    input_instructions(fns);
  });
};

var say = function(phrase){
  exec("say " + phrase); 
  console.log(phrase);
};

var forward = function(duration){
  schedule.push({ 
    duration: duration,
    event: function(){
      bb8.roll(150, angle);
    }
  });
  return fns;
};

var turn = function(_angle){
  schedule.push({
    event: function(){
      say("turn " + _angle + " degrees");
      angle += _angle;
      angle %= 360;
    }
  })
  return fns;
};

var colour = function(name){
  schedule.push({
    event: function(){
      say(name);
      bb8.color(name);
    }
  });
  return fns;
};

var wait = function(duration){
  schedule.push({ 
    duration: duration,
    event: function(){
      bb8.roll(0, angle);
    }
  });
  return fns;
};

var run = function(complete){
  var running_total_duration = 0;

  schedule.forEach(function(thing, index){
    var _index = index;
    setTimeout(function(){
      thing.event();
      if(_index === schedule.length - 1){
        complete(running_total_duration);
      }
    }, running_total_duration);

    running_total_duration += (thing.duration)? thing.duration : 1000;
  });
};

var fns = {
  forward: forward,
  turn: turn,
  colour: colour,
  wait: wait,
  run: run
};

module.exports = {
  setup: setup
};
