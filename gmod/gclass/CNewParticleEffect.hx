package gmod.gclass;
#if client

/**
    This object represents a .pcf ( Orange Box ) particle system. Created by Entity:CreateParticleEffect and CreateParticleSystem.
**/
extern class CNewParticleEffect {
    
    /**
        Sets a value for given control point.
		
		Name | Description
		--- | ---
		`cpID` | The control point ID, 0 to 63.
		`value` | The value to set for given control point.
    **/
    
    public function SetControlPoint(cpID:Float, value:Vector):Void;
    
    
    /**
        Returns the owner of the particle system, the entity the particle system is attached to.
		
		`**Returns:** The owner of the particle system.
    **/
    
    public function GetOwner():Entity;
    
    
    /**
        Starts the particle emission.
		
		Name | Description
		--- | ---
		`infiniteOnly` | 
    **/
    
    public function StartEmission(?infiniteOnly:Bool):Void;
    
    
    /**
        Returns the name of the particle effect this system is set to emit.
		
		`**Returns:** The name of the particle effect.
    **/
    
    public function GetEffectName():String;
    
    
    /**
        Essentially makes child control point follow the parent control point.
		
		Name | Description
		--- | ---
		`child` | The child control point ID, 0 to 63.
		`parent` | The parent control point ID, 0 to 63.
    **/
    
    public function SetControlPointParent(child:Float, parent:Float):Void;
    
    
    /**
        Sets the orientation for given control point.
		
		Name | Description
		--- | ---
		`cpID` | The control point ID, 0 to 63.
		`forward` | The forward direction for given control point
		`right` | The right direction for given control point
		`up` | The up direction for given control point
    **/
    
    public function SetControlPointOrientation(cpID:Float, forward:Vector, right:Vector, up:Vector):Void;
    
    
    /**
        
		
		Name | Description
		--- | ---
		`isViewModel` | 
    **/
    
    public function SetIsViewModelEffect(isViewModel:Bool):Void;
    
    
    /**
        Sets the forward direction for given control point.
		
		Name | Description
		--- | ---
		`cpID` | The control point ID, 0 to 63.
		`forward` | The forward direction for given control point
    **/
    
    public function SetControlPointForwardVector(cpID:Float, forward:Vector):Void;
    
    
    /**
        Returns the highest control point number for given particle system.
		
		`**Returns:** The highest control point number for given particle system, 0 to 63.
    **/
    
    public function GetHighestControlPoint():Bool;
    
    
    /**
        Essentially makes child control point follow the parent entity.
		
		Name | Description
		--- | ---
		`child` | The child control point ID, 0 to 63.
		`parent` | The parent entity to follow.
    **/
    
    public function SetControlPointEntity(child:Float, parent:Entity):Void;
    
    
    /**
        Returns whether the particle system is intended to be used on a view model?
		
		`**Returns:** 
    **/
    
    public function IsViewModelEffect():Bool;
    
    
    /**
        Sets the right direction for given control point.
		
		Name | Description
		--- | ---
		`cpID` | The control point ID, 0 to 63.
		`right` | The right direction for given control point.
    **/
    
    public function SetControlPointRightVector(cpID:Float, right:Vector):Void;
    
    
    /**
        
		
		`**Returns:** 
    **/
    
    public function GetAutoUpdateBBox():Bool;
    
    
    /**
        Returns whether the particle system has finished emitting particles or not.
		
		`**Returns:** Whether the particle system has finished emitting particles or not.
    **/
    
    public function IsFinished():Bool;
    
    
    /**
        Stops the particle emission.
		
		Name | Description
		--- | ---
		`infiniteOnly` | 
		`removeAllParticles` | 
		`wakeOnStop` | 
    **/
    
    public function StopEmission(?infiniteOnly:Bool, ?removeAllParticles:Bool, ?wakeOnStop:Bool):Void;
    
    
    /**
        Stops particle emission and destroys all particles instantly. Also detaches the particle effect from the entity it was attached to.
		
		**Note:** This function will work identically to CNewParticleEffect:StopEmission( false, true ) if CNewParticleEffect:GetOwner entity is not valid.
    **/
    
    public function StopEmissionAndDestroyImmediately():Void;
    
    
    /**
        Sets the sort origin for given particle system. This is used as a helper to determine which particles are in front of which.
		
		Name | Description
		--- | ---
		`origin` | The new sort origin.
    **/
    
    public function SetSortOrigin(origin:Vector):Void;
    
    
    /**
        Forces the particle system to render using current rendering context. 
		
		Can be used to render the particle system in vgui panels, etc. 
		
		 Used in conjunction with CNewParticleEffect:SetShouldDraw.
    **/
    
    public function Render():Void;
    
    
    /**
        Adds a control point to the particle system.
		
		**Note:** This function will not work if the CNewParticleEffect:GetOwner entity is not valid
		
		Name | Description
		--- | ---
		`cpID` | The control point ID, 0 to 63.
		`ent` | The entity to attach the control point to.
		`partAttachment` | See PATTACH_ Enums.
		`entAttachment` | The attachment ID on the entity to attach the particle system to
		`offset` | The offset from the Entity: GetPos of the entity we are attaching this CP to.
    **/
    
    public function AddControlPoint(cpID:Float, ent:Entity, partAttachment:PATTACH, ?entAttachment:Float, ?offset:Vector):Void;
    
    
    /**
        Sets the upward direction for given control point.
		
		Name | Description
		--- | ---
		`cpID` | The control point ID, 0 to 63.
		`upward` | The upward direction for given control point
    **/
    
    public function SetControlPointUpVector(cpID:Float, upward:Vector):Void;
    
    
    /**
        Forces the particle system to restart emitting particles.
    **/
    
    public function Restart():Void;
    
    
    /**
        Forces the particle system to stop automatically rendering. 
		
		Used in conjunction with CNewParticleEffect:Render.
		
		Name | Description
		--- | ---
		`should` | Whether to automatically draw the particle effect or not.
    **/
    
    public function SetShouldDraw(should:Bool):Void;
    
    
    /**
        Returns whether the particle system is valid or not.
		
		`**Returns:** Whether the particle system is valid or not.
    **/
    
    public function IsValid():Bool;
    
    
}



#end