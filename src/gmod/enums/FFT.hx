package gmod.enums;
#if client
/**
    Enumerations used by IGModAudioChannel:FFT. Clientside only.
**/

@:native("_G")
extern enum abstract FFT(Int) {
    /**
        512 levels
    **/
    var FFT_1024;
    /**
        8192 levels
    **/
    var FFT_16384;
    /**
        2048 levels
    **/
    var FFT_4096;
    /**
        1024 levels
    **/
    var FFT_2048;
    /**
        16384 levels
    **/
    var FFT_32768;
    /**
        4096 levels
    **/
    var FFT_8192;
    /**
        256 levels
    **/
    var FFT_512;
    /**
        128 levels
    **/
    var FFT_256;
    
}
#end