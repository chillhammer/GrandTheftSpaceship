///instance_create_invis_obj(obj)
//will create another object if it is going off right/bottom borders
var obj = argument0;

if(abs(room_width-x)<sprite_width){
    instance_create(x-room_width,y,obj)
}

if(abs(room_height-y)<sprite_height){
    instance_create(x,y-room_height,obj)
}
