package gmod.gclass;
#if client

/**
    A client side projected texture, created by ProjectedTexture.
**/
extern class ProjectedTexture {
    
    /**
        Sets the distance at which the projected texture ends. 
		
		You must call ProjectedTexture:Update after using this function for it to take effect.
		
		Name | Description
		--- | ---
		`farZ` | 
    **/
    
    function SetFarZ(farZ:Float):Void;
    
    
    /**
        Returns the constant attenuation of the projected texture, which can also be set by ProjectedTexture:SetConstantAttenuation.
		
		`**Returns:** The constant attenuation
    **/
    
    function GetConstantAttenuation():Float;
    
    
    /**
        Removes the projected texture. After calling this, ProjectedTexture:IsValid will return false, and any hooks with the projected texture as the identifier will be automatically deleted.
    **/
    
    function Remove():Void;
    
    
    /**
        Sets the brightness of the projected texture. 
		
		You must call ProjectedTexture:Update after using this function for it to take effect.
		
		Name | Description
		--- | ---
		`brightness` | The brightness to give the projected texture.
    **/
    
    function SetBrightness(brightness:Float):Void;
    
    
    /**
        Returns the angle of the ProjectedTexture, which were previously set by ProjectedTexture:SetAngles
		
		`**Returns:** The angles of the ProjectedTexture.
    **/
    
    function GetAngles():Angle;
    
    
    /**
        Returns the linear attenuation of the projected texture, which can also be set by ProjectedTexture:SetLinearAttenuation.
		
		`**Returns:** The linear attenuation.
    **/
    
    function GetLinearAttenuation():Float;
    
    
    /**
        Returns the position of the ProjectedTexture, which was previously set by ProjectedTexture:SetPos
		
		`**Returns:** The position of the ProjectedTexture.
    **/
    
    function GetPos():Vector;
    
    
    /**
        Sets the angle of projection. 
		
		You must call ProjectedTexture:Update after using this function for it to take effect.
		
		Name | Description
		--- | ---
		`fov` | Must be higher than 0 and lower than 180
    **/
    
    function SetFOV(fov:Float):Void;
    
    
    /**
        Enable or disable shadows cast from the projected texture.
		
		**Note:** as with all types of projected textures (including the player's flashlight and env_projectedtexture), there can only be 8 projected textures with shadows enabled in total. This limit can be increased with the launch parameter: -numshadowtextures limit where limit is the new limit. Naturally, many projected lights with shadows enabled will drastically decrease framerate.
		
		Name | Description
		--- | ---
		`newState` | 
    **/
    
    function SetEnableShadows(newState:Bool):Void;
    
    
    /**
        Returns the NearZ value of the ProjectedTexture, which was previously set by ProjectedTexture:SetNearZ
		
		`**Returns:** NearZ of the ProjectedTexture.
    **/
    
    function GetNearZ():Float;
    
    
    /**
        Sets the distance at which the projected texture begins its projection. 
		
		You must call ProjectedTexture:Update after using this function for it to take effect.
		
		**Note:** Setting this to 0 will disable the projected texture completely! This may be useful if you want to disable a projected texture without actually removing it
		
		**Note:** This seems to affect the rendering of shadows - a higher Near Z value will have shadows begin to render closer to their casting object. Comparing a low Near Z value (like 1) with a normal one (12) or high one (1000) is the easiest way to understand this artifact
		
		Name | Description
		--- | ---
		`nearZ` | 
    **/
    
    function SetNearZ(nearZ:Float):Void;
    
    
    /**
        Returns whether shadows are enabled for this ProjectedTexture, which was previously set by ProjectedTexture:SetEnableShadows
		
		`**Returns:** Whether shadows are enabled.
    **/
    
    function GetEnableShadows():Bool;
    
    
    /**
        Updates the Projected Light and applies all previously set parameters.
    **/
    
    function Update():Void;
    
    
    /**
        Sets the vertical angle of projection without affecting the horizontal angle. 
		
		You must call ProjectedTexture:Update after using this function for it to take effect.
		
		Name | Description
		--- | ---
		`vFOV` | The new vertical Field Of View for the projected texture. Must be in range between 0 and 180.
    **/
    
    function SetVerticalFOV(vFOV:Float):Void;
    
    
    /**
        Returns the quadratic attenuation of the projected texture, which can also be set by ProjectedTexture:SetQuadraticAttenuation.
		
		`**Returns:** The quadratic attenuation
    **/
    
    function GetQuadraticAttenuation():Float;
    
    
    /**
        Returns the texture of the ProjectedTexture, which was previously set by ProjectedTexture:SetTexture
		
		`**Returns:** The texture of the ProjectedTexture.
    **/
    
    function GetTexture():ITexture;
    
    
    /**
        Sets the angles (direction) of the projected texture. 
		
		You must call ProjectedTexture:Update after using this function for it to take effect.
		
		Name | Description
		--- | ---
		`angle` | 
    **/
    
    function SetAngles(angle:Angle):Void;
    
    
    /**
        Returns the texture frame of the ProjectedTexture, which was previously set by ProjectedTexture:SetTextureFrame
		
		`**Returns:** The texture frame.
    **/
    
    function GetTextureFrame():Float;
    
    
    /**
        For animated textures, this will choose which frame in the animation will be projected. 
		
		You must call ProjectedTexture:Update after using this function for it to take effect.
		
		Name | Description
		--- | ---
		`frame` | The frame index to use.
    **/
    
    function SetTextureFrame(frame:Float):Void;
    
    
    /**
        Changes the current projected texture between orthographic and perspective projection. 
		
		You must call ProjectedTexture:Update after using this function for it to take effect.
		
		Name | Description
		--- | ---
		`orthographic` | When false, all other arguments are ignored and the texture is reset to perspective projection.
		`left` | The amount of units left from the projected texture's origin to project.
		`top` | The amount of units upwards from the projected texture's origin to project.
		`right` | The amount of units right from the projected texture's origin to project.
		`bottom` | The amount of units downwards from the projected texture's origin to project.
		
		
		___
		### Lua Examples
		#### Example 1
		Set the projected texture back to perspective projection.
		
		```lua 
		ProjectedTexture:SetOrthographic( false )
		ProjectedTexture:Update()
		```
    **/
    
    function SetOrthographic(orthographic:Bool, left:Float, top:Float, right:Float, bottom:Float):Void;
    
    
    /**
        Returns the brightness of the ProjectedTexture, which was previously set by ProjectedTexture:SetBrightness
		
		`**Returns:** The brightness of the ProjectedTexture.
    **/
    
    function GetBrightness():Float;
    
    
    /**
        Returns the projection distance of the ProjectedTexture, which was previously set by ProjectedTexture:SetFarZ
		
		`**Returns:** The projection distance of the ProjectedTexture.
    **/
    
    function GetFarZ():Float;
    
    
    /**
        Sets the texture to be projected. 
		
		You must call ProjectedTexture:Update after using this function for it to take effect.
		
		Name | Description
		--- | ---
		`texture` | The name of the texture. Can also be an ITexture.
    **/
    
    function SetTexture(texture:String):Void;
    
    
    /**
        Returns the vertical FOV of the ProjectedTexture, which was previously set by ProjectedTexture:SetVerticalFOV or ProjectedTexture:SetFOV
		
		`**Returns:** The vertical FOV of the ProjectedTexture.
    **/
    
    function GetVerticalFOV():Float;
    
    
    /**
        Returns the horizontal FOV of the ProjectedTexture, which was previously set by ProjectedTexture:SetHorizontalFOV or ProjectedTexture:SetFOV
		
		`**Returns:** The horizontal FOV of the ProjectedTexture.
    **/
    
    function GetHorizontalFOV():Float;
    
    
    /**
        Sets the constant attenuation of the projected texture. 
		
		See also ProjectedTexture:SetLinearAttenuation and ProjectedTexture:SetQuadraticAttenuation. 
		
		 You must call ProjectedTexture:Update after using this function for it to take effect.
		
		Name | Description
		--- | ---
		`constAtten` | 
    **/
    
    function SetConstantAttenuation(constAtten:Float):Void;
    
    
    /**
        Move the Projected Texture to the specified position. 
		
		You must call ProjectedTexture:Update after using this function for it to take effect.
		
		Name | Description
		--- | ---
		`position` | 
    **/
    
    function SetPos(position:Vector):Void;
    
    
    /**
        Returns the current orthographic settings of the Projected Texture. To set these values, use ProjectedTexture:SetOrthographic.
		
		Name | Description
		--- | ---
		`a` | Whether or not this projected texture is orthographic. When false, nothing else is returned.
		`b` | left
		`c` | top
		`d` | right
		`e` | bottom
    **/
    
    function GetOrthographic():ProjectedTextureGetOrthographicReturn;
    
    
    /**
        Sets the linear attenuation of the projected texture. 
		
		See also ProjectedTexture:SetConstantAttenuation and ProjectedTexture:SetQuadraticAttenuation. 
		
		 The default value of linear attenuation when the projected texture is created is 100. (others are 0, as you are not supposed to mix them) 
		
		 You must call ProjectedTexture:Update after using this function for it to take effect.
		
		Name | Description
		--- | ---
		`linearAtten` | 
    **/
    
    function SetLinearAttenuation(linearAtten:Float):Void;
    
    
    /**
        Returns the color of the ProjectedTexture, which was previously set by ProjectedTexture:SetColor.
		
		**Bug:** BUG The returned color will not have the color metatable. Issue Tracker: #2407
		
		`**Returns:** Color structure, the color of the ProjectedTexture.
    **/
    
    function GetColor():Color;
    
    
    /**
        Returns true if the projected texture is valid (i.e. has not been removed), false otherwise. 
		
		Instead of calling this directly it's a good idea to call IsValid in case the variable is nil.
		
		`**Returns:** Whether the projected texture is valid.
    **/
    
    function IsValid():Bool;
    
    
    /**
        Sets the color of the projected texture. 
		
		You must call ProjectedTexture:Update after using this function for it to take effect.
		
		Name | Description
		--- | ---
		`color` | Must be a Color structure. Unlike other projected textures, this color can only go up to 255.
    **/
    
    function SetColor(color:Color):Void;
    
    
    /**
        Sets the quadratic attenuation of the projected texture. 
		
		See also ProjectedTexture:SetLinearAttenuation and ProjectedTexture:SetConstantAttenuation. 
		
		 You must call ProjectedTexture:Update after using this function for it to take effect.
		
		Name | Description
		--- | ---
		`quadAtten` | 
    **/
    
    function SetQuadraticAttenuation(quadAtten:Float):Void;
    
    
    /**
        Sets the horizontal angle of projection without affecting the vertical angle. 
		
		You must call ProjectedTexture:Update after using this function for it to take effect.
		
		Name | Description
		--- | ---
		`hFOV` | The new horizontal Field Of View for the projected texture. Must be in range between 0 and 180.
    **/
    
    function SetHorizontalFOV(hFOV:Float):Void;
    
    
}


@:multiReturn extern class ProjectedTextureGetOrthographicReturn {
var a:Bool;
var b:Float;
var c:Float;
var d:Float;
var e:Float;

}

#end