///Checks to see if any blocks are colliding
with (obj_block)
    if (place_meeting(x,y,obj_block))
        return true;

return false;
