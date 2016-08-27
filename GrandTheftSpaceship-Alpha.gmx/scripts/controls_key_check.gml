///controls_key_check(cont_)
//keyboard check on controls
var key = argument0;

for (i=0; i<array_length_1d(key); i+=1)
{
    if( keyboard_check(key[i]) == true )
        return true;
};

return false;

