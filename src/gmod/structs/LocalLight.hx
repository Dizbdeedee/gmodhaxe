package gmod.structs;
/**
    Table structure used for [render](https://wiki.garrysmod.com/page/Category:render). [SetLocalModelLights](https://wiki.garrysmod.com/page/render/SetLocalModelLights).
**/
typedef LocalLight = {
    /**
        The constant term of the light falloff. This will only be used if fiftyPercentDistance and zeroPercentDistance are not supplied, and allows finer control over light attenuation. 
		
		Default: 1
    **/
    var ?constantFalloff : Float;
    /**
        The quadratic term of the light falloff. This will only be used if fiftyPercentDistance and zeroPercentDistance are not supplied, and allows finer control over light attenuation. 
		
		Default: 0
    **/
    var ?quadraticFalloff : Float;
    /**
        The color of the light source (x is red, y is green, z is blue). Values are not restricted to a specific range, higher values will result in a brighter light. 
		
		Default: vector_origin
    **/
    var ?color : Vector;
    /**
        The inner cone angle for spot lights, in degrees. No angular falloff will occur inside that cone. 
		
		Default: 45
    **/
    var ?innerAngle : Float;
    /**
        The origin of the light in world coordinates. 
		
		Default: vector_origin
    **/
    var ?pos : Vector;
    /**
        The outer cone angle for spot lights, in degrees. 
		
		Default: 45
    **/
    var ?outerAngle : Float;
    /**
        Angular falloff exponent for spot lights. Higher values result in a sharper transition between the inner cone and the outer cone. 
		
		Default: 5
    **/
    var ?angularFalloff : Float;
    /**
        The distance at which the light will completely fade out.
    **/
    var zeroPercentDistance : Float;
    /**
        The type of the light source, see MATERIAL_LIGHT_ Enums. 
		
		Default: MATERIAL_LIGHT_POINT
    **/
    var ?type : MATERIAL_LIGHT;
    /**
        The distance at which the light will fade to 50% of its brightness.
    **/
    var fiftyPercentDistance : Float;
    /**
        The maximum range of the light source. Does not actually control light attenuation. Usually left at 0 for infinite range. 
		
		Default: 0
    **/
    var ?range : Float;
    /**
        The direction of the light. Only required for directional and spot lights. 
		
		Default: vector_origin
    **/
    var ?dir : Vector;
    /**
        The linear term of the light falloff. This will only be used if fiftyPercentDistance and zeroPercentDistance are not supplied, and allows finer control over light attenuation. 
		
		Default: 0
    **/
    var ?linearFalloff : Float;
    
}
