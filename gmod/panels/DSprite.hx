package gmod.panels;
#if client

/**
    A panel that draws a sprite on the player's HUD with the given IMaterial, Color and rotation. 
	
	A shortcut for this is CreateSprite().
**/
extern class DSprite extends DPanel {
    /**
        Sets the source material for the sprite.
		
		Name | Description
		--- | ---
		`material` | The material to use. This will ideally be an UnlitGeneric.
    **/
    
     
    function SetMaterial(material:IMaterial):Void;
    /**
        
		
		`**Returns:** 
    **/
    
     
    function GetHandle():Vector;
    /**
        Sets the 2D rotation angle of the sprite, in the plane of the screen.
		
		Name | Description
		--- | ---
		`ang` | The anti-clockwise rotation in degrees.
    **/
    
     
    function SetRotation(ang:Float):Void;
    /**
        Gets the material the sprite is using.
		
		`**Returns:** The material in use.
    **/
    
     
    function GetMaterial():IMaterial;
    /**
        Seems to be an unused feature. Does nothing.
		
		Name | Description
		--- | ---
		`vec` | 
    **/
    
     
    function SetHandle(vec:Vector):Void;
    /**
        Gets the 2D rotation angle of the sprite, in the plane of the screen.
		
		`**Returns:** The anti-clockwise rotation in degrees.
    **/
    
     
    function GetRotation():Float;
    /**
        Gets the color the sprite is using as a modifier.
		
		`**Returns:** The Color being used.
    **/
    
     
    function GetColor():AnyTable;
    /**
        Sets the color modifier for the sprite.
		
		Name | Description
		--- | ---
		`color` | The Color to use.
    **/
    
     
    function SetColor(color:AnyTable):Void;
    
}



#end