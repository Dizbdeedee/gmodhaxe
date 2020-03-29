package gmod.structs;
/**
    Structure for [DynamicLight](https://wiki.garrysmod.com/page/Global/DynamicLight). All members are case insensitive.
	
	**Note:** This is an actual class named dlight_t, not a table.
**/
typedef DynamicLight = {
    /**
        Flicker style, see this page for examples.
    **/
    var style : Float;
    /**
        The angle of the Dynamic Light. Requires Dir to be set. 
		
		Default: 0
    **/
    var ?outerangle : Float;
    /**
        Minimum light 
		
		Default: 0
    **/
    var ?minlight : Float;
    /**
        The closer this is to zero, the smoother the light will be. Requires Dir and OuterAngle to be set. 
		
		Default: 0
    **/
    var ?innerangle : Float;
    /**
        Radius of the light
    **/
    var size : Float;
    /**
        The green part of the color
    **/
    var g : Float;
    /**
        Position of the light
    **/
    var pos : Vector;
    /**
        The blue part of the color
    **/
    var b : Float;
    /**
        Time after which light will be removed. 
		
		This is relative to CurTime. If you put in a value that is less than or equal to CurTime, the light will not behave properly. 
		
		Note, that it does not affect fading out. Light will be removed regardless of it being fully faded out or not.
    **/
    var dietime : Float;
    /**
        Fade out speed. Here's a formula for calculating Decay for your light: 1000 / fadeOutTimeInSeconds. For example setting decay to 1000 would fade out the light in 1 second, 2000 - 0.5 seconds.
    **/
    var decay : Float;
    /**
        Don't light models 
		
		Default: false
    **/
    var ?nomodel : Bool;
    /**
        Don't light the world. Has no effect for elights since they never light the world. 
		
		Default: false
    **/
    var ?noworld : Bool;
    /**
        Makes the light brighter and flicker? Changing the value does not seem to affect anything.
    **/
    var key : Float;
    /**
        The red part of the color
    **/
    var r : Float;
    /**
        The light direction. Used with InnerAngle and OuterAngle. 
		
		Default: Vector( 0, 0, 0 )
    **/
    var ?dir : Vector;
    /**
        The brightness of the light.
    **/
    var brightness : Float;
    
}
