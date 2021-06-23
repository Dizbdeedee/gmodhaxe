package gmod.structs;
/**
    Structure of a color table, usually without the metatable functions.
    Table created by the [Color](https://wiki.garrysmod.com/page/Global/Color) function and used in various situations.
**/
typedef Color = {
    /**
        The red channel (0-255)
    **/
    var r : Float;
    /**
        The green channel (0-255)
    **/
    var g : Float;
    /**
        The blue channel (0-255)
    **/
    var b : Float;
    /**
        The alpha channel (0-255)
    **/
    var a : Float;
    
}
