package gmod.enums;
/**
    Enumerations used by AccessorFunc.
**/
@:native("_G")
extern enum abstract FORCE(Int) {
    /**
        Forces the function to take [booleans](https://wiki.garrysmod.com/page/Category:boolean) only
    **/
    var FORCE_BOOL;
    /**
        Forces the function to take [numbers](https://wiki.garrysmod.com/page/Category:number) only
    **/
    var FORCE_NUMBER;
    /**
        Forces the function to take [strings](https://wiki.garrysmod.com/page/Category:string) only
    **/
    var FORCE_STRING;
    
}