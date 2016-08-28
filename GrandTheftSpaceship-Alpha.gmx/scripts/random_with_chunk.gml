///random_with_chunk(num,x,y)
//this will get a random number but you must give the x and y value of the chunk
//must have planet controller in room

var randomNum = 48992; // this spices things up a bit- andrew's touch
var range = argument0;
var chunk_x = argument1;
var chunk_y = argument2;

//creates unique seed for that coordinates of the chunk
var seed = obj_planet_controller.seed + (chunk_x + chunk_y*randomNum);

random_set_seed(seed);

return floor(random(range));
