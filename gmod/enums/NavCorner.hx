package gmod.enums;
/**
    Enumerations used by CNavArea methods. These Enums correspond to each corner of a CNavArea
	**Note:** These enumerations do not exist in game and are listed here only for reference!
**/

enum abstract NavCorner(Int) {
    /**
        North West Corner
    **/
    var NORTH_WEST = 0;
    /**
        South East Corner
    **/
    var SOUTH_EAST = 2;
    /**
        Represents all corners, only applicable to certain functions, such as [CNavArea](https://wiki.garrysmod.com/page/Category:CNavArea):[PlaceOnGround](https://wiki.garrysmod.com/page/CNavArea/PlaceOnGround).
    **/
    var NUM_CORNERS = 4;
    /**
        North East Corner
    **/
    var NORTH_EAST = 1;
    /**
        South West Corner
    **/
    var SOUTH_WEST = 3;
    
}