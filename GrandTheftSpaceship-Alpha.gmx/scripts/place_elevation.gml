///place_elevation(x,y)
//will return elevation of block at those coordinates
var pc = obj_planet_controller;
var xx = argument0 div pc.block_size;
var yy = argument1 div pc.block_size;

return pc.terrain_grid[# xx,yy];
