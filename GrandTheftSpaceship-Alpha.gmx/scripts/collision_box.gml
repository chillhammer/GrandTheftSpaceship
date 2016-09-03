///collision_box(x,y,w,h,obj)
var xx, yy, w, h, obj;
xx = argument0;
yy = argument1;
w = argument2;
h = argument3;
obj = argument4;

return collision_rectangle( xx, yy, xx+w, yy+h, obj, false, true);
