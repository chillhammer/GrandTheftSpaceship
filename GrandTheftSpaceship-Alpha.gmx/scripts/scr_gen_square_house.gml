///Make a square house somewhere on the map
side_length = argument[0];
min_x = argument[1];
max_x = argument[2];
min_y = argument[3];
max_y = argument[4];
doors = argument[5];

var placed, doornum, olddoornum, attempts;
placed = false;
doornum = 0;
olddoornum = -1;
attempts = 0;

potential_doors = ds_list_create();

while (!placed && attempts < 19)
{
    //Make the top left corner block
    cornerblock = instance_create(random_range(min_x,max_x), random_range(min_y,max_y), obj_block);
    
    //Make the other corners
    var crn2 = instance_create(cornerblock.x + (side_length-1)*cornerblock.sprite_width, cornerblock.y, obj_block);
    var crn3 = instance_create(cornerblock.x, cornerblock.y + (side_length-1)*cornerblock.sprite_height, obj_block);
    var crn4 = instance_create(cornerblock.x + (side_length-1)*cornerblock.sprite_width, cornerblock.y + (side_length-1)*cornerblock.sprite_height, obj_block);
    
    //Make the rest of the square
    for (i = 1; i <= side_length - 2; i++)
    {
        //Start the array if this is the first one
        ds_list_add(potential_doors, instance_create(cornerblock.x + cornerblock.sprite_width*i, cornerblock.y, obj_block));    
        ds_list_add(potential_doors, instance_create(cornerblock.x, cornerblock.y + cornerblock.sprite_height*i, obj_block));
        ds_list_add(potential_doors, instance_create(crn2.x, cornerblock.y + cornerblock.sprite_height*i, obj_block));
        ds_list_add(potential_doors, instance_create(cornerblock.x + cornerblock.sprite_width*i, crn3.y, obj_block));
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
    show_debug_message("Attempted 20 times to place house with side_length of " + string(side_length) + "and failed.");
    exit;
}


//Remove doors and we're done!
for (i = 1; i <= doors; i++)
{
    do  {
    doornum = irandom(ds_list_size(potential_doors) - 1);
    }   until (olddoornum != doornum);
        
    with (ds_list_find_value(potential_doors, doornum))
        instance_destroy();
    olddoornum = doornum;
}

//Return the cornerblock in case you wanted to do something with it
return cornerblock;

//Kill the list
ds_list_destroy(potential_doors);