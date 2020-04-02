package gmod.gclass;


/**
    List of all possible functions available for effect data. This is the object returned by the EffectData function and is required for util.Effect function.
**/
extern class CEffectData {
    
    /**
        Returns the origin position of the effect.
		
		`**Returns:** The origin position of the effect.
    **/
    
    function GetOrigin():Vector;
    
    
    /**
        Returns the entity assigned to the effect.
		
		`**Returns:** The entity assigned to the effect
    **/
    
    function GetEntity():Entity;
    
    
    /**
        Sets the radius of the effect to be created with this effect data.
		
		**Note:** This is clamped internally from 0 to 1023.
		
		Name | Description
		--- | ---
		`radius` | Radius of the effect.
    **/
    
    function SetRadius(radius:Float):Void;
    
    
    /**
        Returns the angles of the effect.
		
		`**Returns:** The angles of the effect
    **/
    
    function GetAngles():Angle;
    
    #if server
    /**
        Returns the entity index of the entity set for the effect.
		
		`**Returns:** The entity index of the entity set for the effect.
    **/
    
    function GetEntIndex():Float;
    #end
    
    /**
        Sets the surface property index of the effect.
		
		Name | Description
		--- | ---
		`surfaceProperties` | The surface property index of the effect.
    **/
    
    function SetSurfaceProp(surfaceProperties:Float):Void;
    
    
    /**
        Returns the scale of the effect.
		
		`**Returns:** The scale of the effect
    **/
    
    function GetScale():Float;
    
    
    /**
        Returns the material ID of the effect.
		
		`**Returns:** The material ID of the effect.
    **/
    
    function GetMaterialIndex():Float;
    
    
    /**
        Sets the hit box index of the effect.
		
		**Note:** This is internally stored as an integer, but only the first 11 bits will be networked.
		
		Name | Description
		--- | ---
		`hitBoxIndex` | The hit box index of the effect.
    **/
    
    function SetHitBox(hitBoxIndex:Float):Void;
    
    
    /**
        Sets the flags of the effect.
		
		**Note:** This is internally stored as an integer, but only the first 8 bits will be networked.
		
		Name | Description
		--- | ---
		`flags` | The flags of the effect. Each effect has their own flags.
    **/
    
    function SetFlags(flags:Float):Void;
    
    
    /**
        Sets the origin of the effect to be created with this effect data.
		
		Name | Description
		--- | ---
		`origin` | Origin of the effect.
    **/
    
    function SetOrigin(origin:Vector):Void;
    
    
    /**
        Sets the damage type of the effect to be created with this effect data.
		
		Name | Description
		--- | ---
		`damageType` | Damage type, see DMG_ Enums.
    **/
    
    function SetDamageType(damageType:DMG):Void;
    
    
    /**
        Sets the attachment id of the effect to be created with this effect data.
		
		**Note:** This is internally stored as an integer, but only the first 5 bits will be networked.
		
		Name | Description
		--- | ---
		`attachment` | New attachment ID of the effect.
    **/
    
    function SetAttachment(attachment:Float):Void;
    
    
    /**
        Sets the normalized direction vector of the effect to be created with this effect data.
		
		Name | Description
		--- | ---
		`normal` | The normalized direction vector of the effect.
    **/
    
    function SetNormal(normal:Vector):Void;
    
    
    /**
        Sets the entity of the effect to be created with this effect data.
		
		Name | Description
		--- | ---
		`entity` | Entity of the effect, mostly used for parenting.
    **/
    
    function SetEntity(entity:Entity):Void;
    
    
    /**
        Returns the normalized direction vector of the effect.
		
		`**Returns:** The normalized direction vector of the effect.
    **/
    
    function GetNormal():Vector;
    
    #if server
    /**
        Sets the entity of the effect via its index.
		
		Name | Description
		--- | ---
		`entIndex` | The entity index to be set.
    **/
    
    function SetEntIndex(entIndex:Float):Void;
    #end
    
    /**
        Returns the hit box ID of the effect.
		
		`**Returns:** The hit box ID of the effect.
    **/
    
    function GetHitBox():Float;
    
    
    /**
        Sets the angles of the effect.
		
		Name | Description
		--- | ---
		`ang` | The new angles to be set.
    **/
    
    function SetAngles(ang:Angle):Void;
    
    
    /**
        Returns the attachment ID for the effect.
		
		`**Returns:** The attachment ID of the effect.
    **/
    
    function GetAttachment():Float;
    
    
    /**
        Sets the material index of the effect.
		
		**Note:** This is internally stored as an integer, but only the first 11 bits will be networked.
		
		Name | Description
		--- | ---
		`materialIndex` | The material index of the effect.
    **/
    
    function SetMaterialIndex(materialIndex:Float):Void;
    
    
    /**
        Sets the scale of the effect to be created with this effect data.
		
		Name | Description
		--- | ---
		`scale` | Scale of the effect.
    **/
    
    function SetScale(scale:Float):Void;
    
    
    /**
        Returns the radius of the effect.
		
		`**Returns:** The radius of the effect.
    **/
    
    function GetRadius():Float;
    
    
    /**
        Returns the damage type of the effect
		
		`**Returns:** Damage type of the effect, see DMG_ Enums
    **/
    
    function GetDamageType():DMG;
    
    
    /**
        Returns the magnitude of the effect.
		
		`**Returns:** The magnitude of the effect.
    **/
    
    function GetMagnitude():Float;
    
    
    /**
        Sets the start of the effect to be created with this effect data.
		
		Name | Description
		--- | ---
		`start` | Start of the effect.
    **/
    
    function SetStart(start:Vector):Void;
    
    
    /**
        Returns byte which represents the color of the effect.
		
		`**Returns:** The color of the effect
    **/
    
    function GetColor():Float;
    
    
    /**
        Returns the flags of the effect.
		
		`**Returns:** The flags of the effect.
    **/
    
    function GetFlags():Float;
    
    
    /**
        Returns the start position of the effect.
		
		`**Returns:** The start position of the effect
    **/
    
    function GetStart():Vector;
    
    
    /**
        Sets the magnitude of the effect.
		
		Name | Description
		--- | ---
		`magnitude` | The magnitude of the effect.
    **/
    
    function SetMagnitude(magnitude:Float):Void;
    
    
    /**
        Sets the color of the effect.
		
		Name | Description
		--- | ---
		`color` | Color represented by a byte.
    **/
    
    function SetColor(color:Float):Void;
    
    
    /**
        Returns the surface property index of the effect.
		
		`**Returns:** The surface property index of the effect
    **/
    
    function GetSurfaceProp():Float;
    
    
}



