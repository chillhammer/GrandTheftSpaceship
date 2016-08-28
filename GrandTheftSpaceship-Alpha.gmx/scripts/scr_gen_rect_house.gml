///scr_gen_square_house(length,minx,max,miny,maxy,doors)
//Make a square house somewhere on the map
length = argument[0];
height = argument[1];
min_x = argument[2];
max_x = argument[3];
min_y = argument[4];
max_y = argument[5];
doors = argument[6];

var placed, doornum, olddoornum, attempts, max_attempts;
placed = false;
doornum = 0;
olddoornum = -1;
attempts = 0;
max_attempts = 20;

potential_doors = ds_list_create();

while (!placed && attempts < max_attempts)
{
    //Make the top left corner block
    cornerblock = instance_create(random_range(min_x,max_x), random_range(min_y,max_y), obj_block);
    
    //Make the other corners
    var crn2 = instance_create(cornerblock.x + (length-1)*cornerblock.sprite_width, cornerblock.y, obj_block);
    var crn3 = instance_create(cornerblock.x, cornerblock.y + (height-1)*cornerblock.sprite_height, obj_block);
    var crn4 = instance_create(cornerblock.x + (length-1)*cornerblock.sprite_width, cornerblock.y + (height-1)*cornerblock.sprite_height, obj_block);
    
    //Make the rest of the rect
    for (i = 1; i <= length - 2; i++)
    {
        ds_list_add(potential_doors, instance_create(cornerblock.x + cornerblock.sprite_width*i, cornerblock.y, obj_block));    
        ds_list_add(potential_doors, instance_create(cornerblock.x + cornerblock.sprite_width*i, crn3.y, obj_block));
    }
    for (i = 1; i <= height - 2; i++)
    {   
        ds_list_add(potential_doors, instance_create(cornerblock.x, cornerblock.y + cornerblock.sprite_height*i, obj_block));
        ds_list_add(potential_doors, instance_create(crn2.x, cornerblock.y + cornerblock.sprite_height*i, obj_block));
    }
    
    //Ensure the house is collision free, if not, start again!
    placed = true;
    if (/*collision_rectangle(cornerblock.x, cornerblock.y, crn4.x + crn4.sprite_width, crn4.y + crn4.sprite_height, obj_player, 1, 0) ||*/ scr_check_block_collision())
        {
            placed = false;
            with (cornerblock) instance_destroy(); with (crn2) instance_destroy(); with (crn3) instance_destroy(); with (crn4) instance_destroy();
            for (i = 0; i <= ds_list_size(potential_doors) - 1; i++)
            {
                with (ds_list_find_value(potential_doors,i))
                    instance_destroy();
            }
            ds_list_clear(potential_doors);
        }
        
    attempts++;      
}

//Throw a failure message
if (attempts == 20)
{
    show_debug_message("Attempted 20 times to place house with length of " + string(length) + " and height of " + string(height) + " and failed due to: couldn't find free placement.");
    exit;
}

attempts = 0;

//Remove doors and we're done!
for (i = 1; i <= doors; i++)
{
    do  {
    doornum = irandom(ds_list_size(potential_doors) - 1);
    }   until (olddoornum != doornum);
        
    with (ds_list_find_value(potential_doors, doornum))
    {  
        xprev = x;
        x = -32;
        
    }
    if (!mp_potential_path_object(pth_test, cornerblock.x+32, cornerblock.y+32, obj_player.move_spd, 4, obj_player))
    {
        with (ds_list_find_value(potential_doors, doornum))
            x = xprev;
            
        i --;
        attempts ++;
    }
    olddoornum = doornum;
    
    if (attempts == 20)
    {
        show_debug_message("We couldn't finnagle the doors to work.");
        exit;
    }
}

//Return the cornerblock in case you wanted to do something with it
return cornerblock;

//Kill the list
ds_list_destroy(potential_doors);
