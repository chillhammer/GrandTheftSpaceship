///random_2d_smooth(x,y,amplitude,width,height)
//julian what are you doing here


var xx = argument0;
var yy = argument1;
var amp = argument2;

var width = argument3;
var height = argument4;

//make the borders seamless?
/*
var margin = 16;
var height_inc = MAX_HEIGHT*0.01;
var height_boost = 0.4;
*/

var frequency = 32; // 32 cells to new random point
var chunkSize = frequency; //this will reduced for more precise results


var result = 0;

amp = round(amp/2); // let's start reasonable

//border fix?
/*
if(abs(xx-width) < margin  || abs(xx) < margin){
    if(abs(xx-width) < margin ){
        amp += abs(margin-width+xx)*height_inc;
    }
    
    if(abs(xx) < margin){
        amp += abs(margin-xx)*height_inc;
    }
    amp = lerp(amp,MAX_HEIGHT,height_boost);
}else{
    if(abs(yy-height) < margin ){
        amp += abs(margin-height+yy)*height_inc;
        amp = lerp(amp,MAX_HEIGHT,height_boost);
    }
    
    if(abs(yy) < margin){
        amp += abs(margin-yy)*height_inc;
        amp = lerp(amp,MAX_HEIGHT,height_boost);
    }
}
*/


//32 pixels means it'll have 5 runs
while(chunkSize > 0)
{
    
    //which chunk are we on
    var index_x = xx div chunkSize;
    var index_y = yy div chunkSize;
    
    //percentage onto next chunk
    var perc_x = (xx % chunkSize) / chunkSize;
    var perc_y = (yy % chunkSize) / chunkSize;
    
    //getting initial random values and then finetuning
    /*
        r_00    r_10
        r_01    r_11
    */
    var r_00 = random_with_chunk(amp, index_x, index_y);
    var r_01 = random_with_chunk(amp, index_x, index_y+1);
    
    var r_10 = random_with_chunk(amp, index_x+1, index_y);
    var r_11 = random_with_chunk(amp, index_x+1, index_y+1);
    
    //now we combine the left collumn
    var r_0 = lerp(r_00, r_01, perc_y);

    //now we combine the right collumn
    var r_1 = lerp(r_10, r_11, perc_y);
    
    
    ///////////////////////////////////////////////////////////////////
    //   Now we combine the two collumns for the point in the middle
    ///////////////////////////////////////////////////////////////////
    
    result += lerp( r_0, r_1, perc_x);
    
    
    //lower freqency and height to make precise changes
    chunkSize = chunkSize div 2;
    amp = amp div 2;
    amp = max(1,amp);
} //repeat to finetune

result = clamp(result,0,argument2);
return round(result);




