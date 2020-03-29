package gmod.gclass;


/**
    
**/
extern class Color {
    
    /**
        Sets the r, g, b, and a of the color.
		
		Name | Description
		--- | ---
		`r` | 
		`g` | 
		`b` | 
		`a` | 
    **/
    
    public function SetUnpacked(r:Float, g:Float, b:Float, a:Float):Void;
    
    
    /**
        Returns the color as a table with four elements.
		
		`**Returns:** The table with elements 1 = r, 2 = g, 3 = b, 4 = a.
    **/
    
    public function ToTable():AnyTable;
    
    
    /**
        Returns the r, g, b, and a of the color.
		
		Name | Description
		--- | ---
		`a` | r
		`b` | g
		`c` | b
    **/
    
    public function Unpack():ColorUnpackReturn;
    
    
    /**
        Translates the Color structure into a Vector, losing the alpha channel. This will also range the values from 0 - 255 to 0 - 1 
		
		r / 255 -> x g / 255 -> y b / 255 -> z 
		
		 This is the opposite of Vector:ToColor
		
		`**Returns:** The created Vector
		
		___
		### Lua Examples
		#### Example 1
		Useful when setting player colors, since the function requires a vector as argument.
		
		```lua 
		Entity( 1 ):SetPlayerColor( Color( 220, 20, 60 ):ToVector() )
		```
		**Output:**
		
		Sets the player color for Player1 (only works if they are using a colorable player model)
    **/
    
    public function ToVector():Vector;
    
    
}


@:multiReturn extern class ColorUnpackReturn {
var a:Float;
var b:Float;
var c:Float;

}

