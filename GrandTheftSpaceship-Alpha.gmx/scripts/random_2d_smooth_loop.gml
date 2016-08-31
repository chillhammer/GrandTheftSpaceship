///random_2d_smooth_loop(x,y,amp,rep_width,rep_height);
//julian what are you doing here

var xx = argument0;
var yy = argument1;
var amp = argument2;

var rep_width = argument3;
var rep_height = argument4;

//Variables: xPi, yPi, xx, yy, zz, ww
//finds the x progress in radians
var xPi = (xx/rep_width)*2*pi;

//finds the y progress in radians
var yPi = (yy/rep_height)*2*pi;

//bends the 4d coordiantes [x,z] into 4d cylinder
var zz = (sin(xPi)+1)*0.5*rep_width;
xx = (cos(xPi)+1)*0.5*rep_width;

//bends the other 4d coordinates into orthogonal 4d cylinder
var ww = (sin(yPi)+1)*0.5*rep_height;
yy = (cos(yPi)+1)*0.5*rep_width;
///////////////////////////////////////////////////////////////

var frequency = 64; // <- cells to new random point (initial chunk size)
var chunkSize = frequency; //this will reduced for more precise results

var result = 0; //the result noise

amp = amp div 2;

while(chunkSize > 0){
    //index chunk
    var index_x = xx div chunkSize;
    var index_y = yy div chunkSize;
    var index_z = zz div chunkSize;
    var index_w = ww div chunkSize;
    
    //progress variables
    var t_x = (xx % chunkSize) / chunkSize;
    var t_y = (yy % chunkSize) / chunkSize;
    var t_z = (zz % chunkSize) / chunkSize;
    var t_w = (ww % chunkSize) / chunkSize;
    
    /////////////////////////////////////////////////////
    //  Retrieves noise from 16 points in 4d space.
    /////////////////////////////////////////////////////
    var r_0000 = random_with_chunk(amp,index_x,   index_y, index_z, index_w); //from 0 to 100
    var r_0100 = random_with_chunk(amp,index_x,   index_y+1, index_z, index_w);
    var r_1000 = random_with_chunk(amp,index_x+1, index_y, index_z, index_w);
    var r_1100 = random_with_chunk(amp,index_x+1, index_y+1, index_z, index_w);
    
    var r_0010 = random_with_chunk(amp,index_x,   index_y, index_z + 1, index_w); //from 0 to 100
    var r_0110 = random_with_chunk(amp,index_x,   index_y+1, index_z + 1, index_w);
    var r_1010 = random_with_chunk(amp,index_x+1, index_y, index_z + 1, index_w);
    var r_1110 = random_with_chunk(amp,index_x+1, index_y+1, index_z + 1, index_w);
    
    //4th dimension
    var r_0001 = random_with_chunk(amp,index_x,   index_y, index_z, index_w + 1); //from 0 to 100
    var r_0101 = random_with_chunk(amp,index_x,   index_y+1, index_z, index_w + 1);
    var r_1001 = random_with_chunk(amp,index_x+1, index_y, index_z, index_w + 1);
    var r_1101 = random_with_chunk(amp,index_x+1, index_y+1, index_z, index_w + 1);
    
    var r_0011 = random_with_chunk(amp,index_x,   index_y, index_z + 1, index_w + 1); //from 0 to 100
    var r_0111 = random_with_chunk(amp,index_x,   index_y+1, index_z + 1, index_w + 1);
    var r_1011 = random_with_chunk(amp,index_x+1, index_y, index_z + 1, index_w + 1);
    var r_1111 = random_with_chunk(amp,index_x+1, index_y+1, index_z + 1, index_w + 1);
    /////////////////////////////////////////////////
    
    /////////////////////////////////////////////////////
    //  Interpolating points [Reducing Dimensions]
    /////////////////////////////////////////////////////
    ////  Combining Y Axis
    var r_000 = lerp(r_0000,r_0100,t_y);
    var r_100 = lerp(r_1000,r_1100,t_y);
    var r_010 = lerp(r_0010,r_0110,t_y);
    var r_110 = lerp(r_1010,r_1110,t_y);
    //4th dimension
    var r_001 = lerp(r_0001,r_0101,t_y);
    var r_101 = lerp(r_1001,r_1101,t_y);
    var r_011 = lerp(r_0011,r_0111,t_y);
    var r_111 = lerp(r_1011,r_1111,t_y);
    
    ////  Combining X Axis
    var r_00 = lerp(r_000,r_100,t_x);
    var r_10 = lerp(r_010,r_110,t_x);
    //4th dimension
    var r_01 = lerp(r_001,r_101,t_x);
    var r_11 = lerp(r_011,r_111,t_x);
    
    ////  Combining Z Axis
    var r_0 = lerp(r_00,r_10,t_z);
    var r_1 = lerp(r_01,r_11,t_z);
    
    ////  Combining W Axis!!!!! (lol what)
    result += lerp(r_0,r_1,t_w); //adds noise onto result
    
    chunkSize = chunkSize div 2;
    amp = amp div 2;
    amp = max(1,amp);
}

return round(result);
