///point_to_mouse(x,y)
//points to GUI coords of the mouse
var xx = argument0;
var yy = argument1;

xx = window_get_width()*(xx-view_xview[VIEW_CAMERA])/view_wview[VIEW_CAMERA];
yy = window_get_height()*(yy-view_yview[VIEW_CAMERA])/view_hview[VIEW_CAMERA];

if(os_browser != browser_not_a_browser){
    xx += window_get_x();
    yy += window_get_y();
}

// the above code is just a fancier this 
//xx = window_get_width()*0.5;
//yy = window_get_height()*0.5;

return point_direction(xx,yy,window_mouse_get_x(),window_mouse_get_y());
