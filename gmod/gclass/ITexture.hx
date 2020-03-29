package gmod.gclass;


/**
    An object representing game texture, like a .vtf file. Do not confuse with IMaterial. Returned by IMaterial:GetTexture
**/
extern class ITexture {
    
    /**
        Returns the modified width of the texture, this value may be affected by mipmapping and other factors.
		
		`**Returns:** width
    **/
    
    public function Width():Float;
    
    
    /**
        Returns the name of the texture, in most cases the path.
		
		`**Returns:** name
    **/
    
    public function GetName():String;
    
    
    /**
        Returns the modified height of the texture, this value may be affected by mipmapping and other factors.
		
		`**Returns:** height
    **/
    
    public function Height():Float;
    
    
    /**
        Invokes the generator of the texture. Reloads file based textures from disk and clears render target textures.
    **/
    
    public function Download():Void;
    
    
    /**
        Returns whenever the texture is valid. (i.e. was loaded successfully or not)
		
		**Note:** The "error" texture is a valid texture, and therefore this function will return false when used on it. Use ITexture:IsErrorTexture, instead.
		
		`**Returns:** Whether the texture was loaded successfully or not.
    **/
    
    public function IsError():Bool;
    
    
    /**
        Returns the true unmodified height of the texture.
		
		`**Returns:** height
    **/
    
    public function GetMappingHeight():Float;
    
    
    /**
        Returns whenever the texture is the error texture (pink and black checkers).
		
		`**Returns:** Whether the texture is the error texture or not.
    **/
    
    public function IsErrorTexture():Bool;
    
    
    /**
        Returns the true unmodified width of the texture.
		
		`**Returns:** width
    **/
    
    public function GetMappingWidth():Float;
    
    
    /**
        Returns the color of the specified pixel, only works for textures created from PNG files.
		
		**Bug:** BUG The returned color will not have the color metatable. Issue Tracker: #2407
		
		Name | Description
		--- | ---
		`x` | The X coordinate.
		`y` | The Y coordinate.
		
		
		`**Returns:** The color of the pixel as a Color structure.
    **/
    
    public function GetColor(x:Float, y:Float):Color;
    
    
}



