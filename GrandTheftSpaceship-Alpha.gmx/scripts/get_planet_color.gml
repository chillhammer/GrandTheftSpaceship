///get_planet_color(height[0-100])
//prints out color depending on elevation of tile
var height = argument0;
var h=0,s=55,v=0;

var pc = obj_planet_controller;
var wl = pc.water_level;

var min_value = 60;
var total_value = 160-min_value;
var shades_per_t = 8;
var value_div = total_value/shades_per_t;
var perc_value;

if(height < wl){
    h = pc.water_hue;
    perc_value = height / wl;
    
    v = min_value + ceil( perc_value * total_value / value_div) * value_div;
}else{
    h = pc.ground_hue;
    perc_value = (height - wl) / (MAX_HEIGHT-wl);
    
    v = min_value + floor( perc_value * total_value / value_div) * value_div;
}

return make_color_hsv(h,s,v);
