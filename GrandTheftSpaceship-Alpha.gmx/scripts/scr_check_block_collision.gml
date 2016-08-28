///Checks to see if any blocks are colliding
with (obj_block)
    if (place_meeting(x,y,obj_block) || place_meeting(x,y,obj_floor) || place_meeting(x,y,obj_solid) || place_meeting(x,y,obj_player))
        return true;

return false;
