package gmod.enums;
/**
    Enumerations used by Panel:Dock.
	**Note:** These enumerations doesn't have DOCK_ prefix, this is an exception from all other enumerations.
**/
@:native("_G")
extern enum abstract DOCK(Int) {
    /**
        Dock to the left
    **/
    var LEFT;
    /**
        Dock to the bottom
    **/
    var BOTTOM;
    /**
        Don't dock
    **/
    var NODOCK;
    /**
        Dock to the right
    **/
    var RIGHT;
    /**
        Dock to the top
    **/
    var TOP;
    /**
        Fill parent
    **/
    var FILL;
    
}