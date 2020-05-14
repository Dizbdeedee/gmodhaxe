package gmod.structs;
/**
    Returned by [util](https://wiki.garrysmod.com/page/Category:util). [GetSunInfo](https://wiki.garrysmod.com/page/util/GetSunInfo).
**/
typedef SunInfo = {
    /**
        The suns direction relative to 0,0,0
    **/
    var direction : Vector;
    /**
        Indicates how obstructed the sun is, 1 not visible, 0 fully visible
    **/
    var obstruction : Float;
    
}
