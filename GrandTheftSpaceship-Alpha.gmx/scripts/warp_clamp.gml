///warp_clamp(var,min,max)
//warp around set range

var variable = argument0;
var min_num = argument1;
var max_num = argument2;
if(variable > max_num) variable = variable%max_num;

if(variable < min_num) variable += max_num;


return variable;
