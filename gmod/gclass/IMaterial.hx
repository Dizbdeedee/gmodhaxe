package gmod.gclass;


/**
    A Material object. It represents a game material, similarly to how a .vmt file does. 
	
	It can be created with Material or CreateMaterial.
**/
extern class IMaterial {
    
    /**
        Returns the specified material linear color vector, or nil if the value is not set. 
		
		See https://en.wikipedia.org/wiki/Gamma_correction 
		
		 See also IMaterial:GetVector
		
		Name | Description
		--- | ---
		`materialVector` | The name of the material vector.
		
		
		`**Returns:** The linear color vector
    **/
    
    public function GetVectorLinear(materialVector:String):Vector;
    
    
    /**
        Returns the width of the member texture set for $basetexture.
		
		`**Returns:** width
    **/
    
    public function Width():Float;
    
    
    /**
        Returns the name of the material, in most cases the path.
		
		`**Returns:** Material name/path
    **/
    
    public function GetName():String;
    
    
    /**
        Returns the specified material value as a float, or nil if the value is not set.
		
		Name | Description
		--- | ---
		`materialFloat` | The name of the material value.
		
		
		`**Returns:** float
    **/
    
    public function GetFloat(materialFloat:String):Float;
    
    
    /**
        Recomputes the material's snapshot. This needs to be called if you have changed variables on your material and it isn't changing. 
		
		Be careful though - this function is slow - so try to call it only when needed!
    **/
    
    public function Recompute():Void;
    
    
    /**
        Unsets the value for the specified material value.
		
		Name | Description
		--- | ---
		`materialValueName` | The name of the material value to be unset.
    **/
    
    public function SetUndefined(materialValueName:String):Void;
    
    
    /**
        Sets the specified material vector to the specified vector, does nothing on a type mismatch.
		
		Name | Description
		--- | ---
		`MaterialVector` | The name of the material vector.
		`vec` | The new vector.
    **/
    
    public function SetVector(MaterialVector:String, vec:Vector):Void;
    
    
    /**
        Returns the height of the member texture set for $basetexture.
		
		`**Returns:** height
    **/
    
    public function Height():Float;
    
    
    /**
        Returns the specified material value as a int, rounds the value if its a float, or nil if the value is not set.
		
		Name | Description
		--- | ---
		`materialInt` | The name of the material integer.
		
		
		`**Returns:** int
    **/
    
    public function GetInt(materialInt:String):Float;
    
    
    /**
        Returns the specified material matrix as a int, or nil if the value is not set or is not a matrix.
		
		Name | Description
		--- | ---
		`materialMatrix` | The name of the material matrix.
		
		
		`**Returns:** matrix
    **/
    
    public function GetMatrix(materialMatrix:String):VMatrix;
    
    
    /**
        Returns the name of the materials shader.
		
		**Bug:** BUG This function does not work serverside on Linux SRCDS. Issue Tracker: #3256
		
		`**Returns:** shaderName
    **/
    
    public function GetShader():String;
    
    
    /**
        Returns whenever the material is valid, i.e. whether it was not loaded successfully from disk or not.
		
		`**Returns:** Is this material the error material? (___error)
    **/
    
    public function IsError():Bool;
    
    
    /**
        Sets the specified material float to the specified float, does nothing on a type mismatch.
		
		Name | Description
		--- | ---
		`materialFloat` | The name of the material float.
		`float` | The new float value.
    **/
    
    public function SetFloat(materialFloat:String, float:Float):Void;
    
    
    /**
        Returns the specified material string, or nil if the value is not set or if the value can not be converted to a string.
		
		Name | Description
		--- | ---
		`materialString` | The name of the material string.
		
		
		`**Returns:** The value as a string
    **/
    
    public function GetString(materialString:String):String;
    
    
    /**
        Returns the specified material vector, or nil if the value is not set. 
		
		See also IMaterial:GetVectorLinear
		
		Name | Description
		--- | ---
		`materialVector` | The name of the material vector.
		
		
		`**Returns:** The color vector
    **/
    
    public function GetVector(materialVector:String):Vector;
    
    
    /**
        Returns an ITexture based on the passed shader parameter.
		
		Name | Description
		--- | ---
		`param` | The shader parameter to retrieve. This should normally be $basetexture.
		
		
		`**Returns:** The value of the shader parameter. Returns nothing if the param doesn't exist.
    **/
    
    public function GetTexture(param:String):ITexture;
    
    
    /**
        Sets the specified material value to the specified matrix, does nothing on a type mismatch.
		
		Name | Description
		--- | ---
		`materialMatrix` | The name of the material int.
		`matrix` | The new matrix.
    **/
    
    public function SetMatrix(materialMatrix:String, matrix:VMatrix):Void;
    
    
    /**
        Sets the specified material texture to the specified texture, does nothing on a type mismatch.
		
		Name | Description
		--- | ---
		`materialTexture` | The name of the keyvalue on the material to store the texture on.
		`texture` | The new texture. This can also be a string, the name of the new texture.
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage of this function.
		
		```lua 
		local blur_mat = Material( "pp/bokehblur" )
		
		blur_mat:SetTexture( "$basetexture", render.GetScreenEffectTexture() )
		```
		
		#### Example 2
		Equivalent of Example 1, demonstrating the use of a texture's name.
		
		```lua 
		local blur_mat = Material( "pp/bokehblur" )
		
		blur_mat:SetTexture( "$basetexture", "_rt_fullframefb" )
		```
    **/
    
    public function SetTexture(materialTexture:String, texture:ITexture):Void;
    
    
    /**
        Returns the color of the specified pixel of the $basetexture, only works for materials created from PNG files. 
		
		Basically identical to ITexture:GetColor used on IMaterial:GetTexture( "$basetexture" ).
		
		**Bug:** BUG The returned color will not have the color metatable. Issue Tracker: #2407
		
		Name | Description
		--- | ---
		`x` | The X coordinate.
		`y` | The Y coordinate.
		
		
		`**Returns:** The color of the pixel as a Color structure.
		
		___
		### Lua Examples
		#### Example 1
		Identical functionality.
		
		```lua 
		local m = Material( "gui/colors_dark.png" )
		local t = m:GetTexture("$basetexture")
		
		PrintTable( t:GetColor( 5, 5 ) )
		PrintTable( m:GetColor( 5, 5 ) )
		```
		**Output:**
		
		Both printouts will return identical color, which at the time of testing is RGBA - 255, 244, 242, 255.
    **/
    
    public function GetColor(x:Float, y:Float):Color;
    
    
    /**
        Gets all the key values defined for the material.
		
		`**Returns:** The material's key values.
		
		___
		### Lua Examples
		#### Example 1
		Example output of this function
		
		```lua 
		PrintTable( Material( "pp/add" ):GetKeyValues() )
		```
		**Output:**
		
		$alpha=1 $alphatestreference=0 $basetexture=userdata: 0x2e13fc18 $basetexturetransform=[1.00000,0.00000,0.00000,0.00000] [0.00000,1.00000,0.00000,0.00000] [0.00000,0.00000,1.00000,0.00000] [0.00000,0.00000,0.00000,1.00000] $color=1.000000 1.000000 1.000000 $color2=1.000000 1.000000 1.000000 $depthblend=0 $depthblendscale=50 $detailblendfactor=1 $detailblendmode=0 $detailframe=0 $detailscale=4 $detailtexturetransform=[1.00000,0.00000,0.00000,0.00000] [0.00000,1.00000,0.00000,0.00000] [0.00000,0.00000,1.00000,0.00000] [0.00000,0.00000,0.00000,1.00000] $distancealpha=0 $distancealphafromdetail=0 $edgesoftnessend=0.5 $edgesoftnessstart=0.5 $envmapcontrast=0 $envmapframe=0 $envmapmaskframe=0 $envmapmasktransform=[1.00000,0.00000,0.00000,0.00000] [0.00000,1.00000,0.00000,0.00000] [0.00000,0.00000,1.00000,0.00000] [0.00000,0.00000,0.00000,1.00000] $envmapsaturation=1 $envmaptint=1.000000 1.000000 1.000000 $flags=32896 $flags2=262144 $flags_defined=32896 $flags_defined2=0 $flashlighttexture=userdata: 0x2e13fe68 $flashlighttextureframe=0 $frame=0 $gammacolorread=0 $glow=0 $glowalpha=1 $glowcolor=1.000000 1.000000 1.000000 $glowend=0 $glowstart=0 $glowx=0 $glowy=0 $hdrcolorscale=1 $linearwrite=0 $outline=0 $outlinealpha=1 $outlinecolor=1.000000 1.000000 1.000000 $outlineend0=0 $outlineend1=0 $outlinestart0=0 $outlinestart1=0 $phong=0 $phongalbedotint=0 $phongboost=0 $phongexponent=0 $phongfresnelranges=0.000000 0.000000 0.000000 $phongtint=0.000000 0.000000 0.000000 $receiveflashlight=0 $scaleedgesoftnessbasedonscreenres=0 $scaleoutlinesoftnessbasedonscreenres=0 $separatedetailuvs=0 $softedges=0 $srgbtint=1.000000 1.000000 1.000000 $vertexalphatest=0
    **/
    
    public function GetKeyValues():AnyTable;
    
    
    /**
        Sets the specified material value to the specified int, does nothing on a type mismatch.
		
		Name | Description
		--- | ---
		`materialInt` | The name of the material int.
		`int` | The new int value.
    **/
    
    public function SetInt(materialInt:String, int:Float):Void;
    
    
    /**
        Sets the specified material value to the specified string, does nothing on a type mismatch.
		
		Name | Description
		--- | ---
		`materialString` | The name of the material string.
		`string` | The new string.
    **/
    
    public function SetString(materialString:String, string:String):Void;
    
    
    /**
        ***Deprecated:** This function does nothing
		
		The functionality of this function was removed due to the amount of crashes it caused.
		
		Name | Description
		--- | ---
		`shaderName` | Name of the shader
    **/
    @:deprecated("This function does nothing")
    public function SetShader(shaderName:String):Void;
    
    
}



