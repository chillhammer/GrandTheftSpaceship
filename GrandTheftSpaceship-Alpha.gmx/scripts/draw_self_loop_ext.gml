///draw_self_loop_ext(scale,rot)
//will draw himself 4 times on other side of map
//used if interacting with border AKA movement
if(abs(x-room_width)<sprite_width ||
    abs(x)<sprite_width ||
    abs(y-room_height)<sprite_height ||
    abs(y)<sprite_height){
        draw_self_position_ext(x-room_width,y,argument0,argument1);
        draw_self_position_ext(x+room_width,y,argument0,argument1);
        
        draw_self_position_ext(x,y-room_height,argument0,argument1);
        draw_self_position_ext(x,y+room_height,argument0,argument1);
}
