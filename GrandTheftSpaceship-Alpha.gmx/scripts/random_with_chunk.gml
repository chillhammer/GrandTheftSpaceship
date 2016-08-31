///random_with_chunk(num,x,y)
//this will get a random number but you must give the x and y value of the chunk
//must have planet controller in room

var randomNum = 4898; // this spices things up a bit- andrew's touch
var range = argument[0];
var chunk_x = argument[1];
var chunk_y = argument[2];
var chunk_z = argument[3];
var chunk_w = argument[4];

var range = argument[0];
var num = 0;
switch(argument_count){
    case 2:
        num = chunk_x;
        break;
    case 3:
        num = chunk_x + chunk_y * randomNum;
        break;
    case 4:
        num = chunk_x+ chunk_y * randomNum + chunk_z*randomNum*0.5;
        break;
    case 5:
        num = chunk_x + chunk_y * randomNum + chunk_z*randomNum*0.4 +chunk_w*randomNum*0.3;
        break;
}

//creates unique seed for that coordinates of the chunk
//var seed = obj_planet_controller.seed + (chunk_x + chunk_y*randomNum);
var seed = obj_planet_controller.seed + num;
random_set_seed(seed);
rand = irandom_range(0,range);

return round(rand);
