package gmod.structs;
/**
    Used for [render](https://wiki.garrysmod.com/page/Category:render). [Capture](https://wiki.garrysmod.com/page/render/Capture).
**/
typedef RenderCaptureData = {
    /**
        The quality of the capture. Affects jpeg only.
    **/
    var quality : Float;
    /**
        Set to false to capture an image with alpha channel set to fully opaque. Affects png only. 
		
		Default: true
    **/
    var ?alpha : Bool;
    /**
        Height of the capture
    **/
    var h : Float;
    /**
        X coordinate of the capture origin
    **/
    var x : Float;
    /**
        Y coordinate of the capture origin
    **/
    var y : Float;
    /**
        Format of the capture. Valid formats are: jpeg, png
    **/
    var format : String;
    /**
        Width of the capture
    **/
    var w : Float;
    
}
