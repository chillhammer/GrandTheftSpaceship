///draw_self_loop()
//will draw himself 4 times on other side of map
//used if interacting with border AKA movement
draw_self_position(x-room_width,y);
draw_self_position(x+room_width,y);

draw_self_position(x,y-room_height);
draw_self_position(x,y+room_height);
