package gmod.structs;
/**
    Table used by [video](https://wiki.garrysmod.com/page/Category:video). [Record](https://wiki.garrysmod.com/page/video/Record).
**/
typedef VideoData = {
    /**
        The video codec. Valid options are: vp8, theora
    **/
    var video : String;
    /**
        The file name for the video
    **/
    var name : String;
    /**
        The video container format. Valid options are: webm, ogg
    **/
    var container : String;
    /**
        The video quality
    **/
    var quality : Float;
    /**
        The record bitrate
    **/
    var bitrate : Float;
    /**
        Frames per second
    **/
    var fps : Float;
    /**
        The audio codec. Valid options are: vorbis
    **/
    var audio : String;
    /**
        The videos height
    **/
    var height : Float;
    /**
        Lock the frame count per second
    **/
    var lockfps : Bool;
    /**
        The videos width
    **/
    var width : Float;
    
}
