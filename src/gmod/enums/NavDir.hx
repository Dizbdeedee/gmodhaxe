package gmod.enums;
/**
    Enumerations used by CNavArea methods. These Enums correspond to each side of a CNavArea
	**Note:** These enumerations do not exist in game and are listed here only for reference!
**/
enum abstract NavDir(Int) {
    /**
        South from given [CNavArea](https://wiki.garrysmod.com/page/Category:CNavArea)
    **/
    var SOUTH = 2;
    /**
        East from given [CNavArea](https://wiki.garrysmod.com/page/Category:CNavArea)
    **/
    var EAST = 1;
    /**
        North from given [CNavArea](https://wiki.garrysmod.com/page/Category:CNavArea)
    **/
    var NORTH = 0;
    /**
        West from given [CNavArea](https://wiki.garrysmod.com/page/Category:CNavArea)
    **/
    var WEST = 3;
    
}