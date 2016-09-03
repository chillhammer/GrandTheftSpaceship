///warp()
//warp around the room
if( x > room_width || x < 0 || y > room_height || y < 0){ 
    
    x = warp_clamp(x,0,room_width);
    y = warp_clamp(y,0,room_height);
    return true;
}
return false;
