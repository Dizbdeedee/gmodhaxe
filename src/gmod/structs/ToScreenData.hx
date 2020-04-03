package gmod.structs;
/**
    Table returned by [Vector](https://wiki.garrysmod.com/page/Category:Vector): [ToScreen](https://wiki.garrysmod.com/page/Vector/ToScreen).
**/
typedef ToScreenData = {
    /**
        The coordinate is not behind the player. This does not mean the coordinate is on the screen. When this is false, it means that the coordinate would not be on the screen even if the player had a full 180 degree FOV.
    **/
    var visible : Bool;
    /**
        The x coordinate on the players screen
    **/
    var x : Float;
    /**
        The y coordinate on the players screen
    **/
    var y : Float;
    
}
