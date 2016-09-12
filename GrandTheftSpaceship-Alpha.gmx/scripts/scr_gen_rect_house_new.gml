///scr_gen_rect_house_new(block_object,length,height)
//Creates a house somewhere
var block = argument0;
var length = argument1; //in blocks
var height = argument2;

var block_w, block_h, house_w, house_h, tl_x, tl_y, attempts, max_attempts, placed,  block_list, house_pad, cornerblock;

block_w = sprite_get_width(object_get_sprite(block));
block_h = sprite_get_height(object_get_sprite(block));

house_w = length*block_w;
house_h = height*block_h;

max_attempts = 20;
placed = false;
attempts = 0;

house_pad = 64;

block_list = ds_list_create();

////////////////////////////////////////////////////////////////////////
//  ATTEMPTING TO FIND HOUSE COORDINATES

while(attempts < max_attempts && !placed){
    tl_x = irandom(room_width); //top left coordinates
    tl_y = irandom(room_height);
    
    //check if it can place house [COLLISION CHECK 1]
    if( !collision_box(tl_x, tl_y, house_w, house_h, obj_entity) ){
        placed = true;
        
        
        //Check collision on left side of map[COLLISION CHECK 2]
        if( abs(room_width - (tl_x+house_w)) < house_w){
            if( collision_box(tl_x-room_width, tl_y, house_w, house_h, obj_entity) ){
                placed = false;
            }
        }
        //Check collision on top side of map[COLLISION CHECK 3]
        if( abs(room_height - (tl_y+house_h)) < house_h){
            if( collision_box(tl_x, tl_y-room_height, house_w, house_h, obj_entity) ){
                placed = false;
            }
        }
        
    }
    attempts++; //otherwise, repeat and try again
}
if(!placed){
    //cannot generate house. script has failed
    show_debug_message("Attempted 20 times to place house with length of " + string(length) + " and height of " + string(height) + " and failed.");
    return -1;
}
////////////////////////////////////////////////////////////////////

//  GENERATING ROWS AND COLUMNS

//corners
cornerblock = instance_create( tl_x, tl_y, block);
instance_create( tl_x+house_w-block_w, tl_y, block);

instance_create( tl_x, tl_y+house_h-block_h, block);
instance_create( tl_x+house_w-block_w, tl_y+house_h-block_h, block);

//rows minus corner
for (i=1; i<length-1; i+=1)
{
    ds_list_add( block_list, instance_create(tl_x+i*block_w, tl_y, block)); //top row
    
    if(house_w > block_h) //if house is tall enough to have another row
        ds_list_add( block_list, instance_create(tl_x+i*block_w, tl_y+house_h-block_h, block) ); //bottom row
};

//columns minus corner 
for (i=1; i<height-1; i+=1)
{
    ds_list_add( block_list, instance_create(tl_x, tl_y+i*block_h, block) ); //left column
    
    if(house_w > block_w) //if house is wide enough to have another column
        ds_list_add( block_list, instance_create(tl_x+house_w-block_w, tl_y+i*block_h, block) ); //right column
};

//////////////////////////////////////////////////////////////////////////////

//  DOORS and FLOORS
with( choose_ds_list_random( block_list ) )
    instance_destroy();
    
with(instance_create(tl_x-house_pad,tl_y-house_pad,obj_floor)){
    image_xscale = (house_w+house_pad*2);
    image_yscale = (house_h+house_pad*2);
    
    //Check collision on left side of map[COLLISION CHECK 2]
    if( abs(room_width - (bbox_right)) < image_xscale){
        with(instance_create(tl_x-house_pad-room_width,tl_y-house_pad,obj_floor)){
            image_xscale = (house_w+house_pad*2);
            image_yscale = (house_h+house_pad*2);
        }
    }
    //Check collision on top side of map[COLLISION CHECK 3]
    if( abs(room_height - (bbox_bottom)) < image_yscale){
        with(instance_create(tl_x-house_pad,tl_y-house_pad-room_height,obj_floor)){
            image_xscale = (house_w+house_pad*2);
            image_yscale = (house_h+house_pad*2);
        }
    }
}

//What faction resides here?
cornerblock.faction = choose_ds_list_random(global.factions);

//Other cornerblock vars
cornerblock.house_length = length;
cornerblock.house_height = height;

ds_list_destroy( block_list );

return cornerblock;






