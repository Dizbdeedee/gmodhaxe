package gmod.effects;


#if client

/**
    These hooks are used inside of a Lua effect. Lua effects are stored in either the /lua/effects directory or in a gamemode in /gamemodes/<gamemodename>/entities/effects. 
	
	Effects are entities with the class CLuaEffect, and as such, Entity functions are usable on them (using the self argument). 
	
	 An EFFECT is made using either a combination of the EFFECT:Init, EFFECT:Render and optionally the EFFECT:Think hook. Another way is to create all particles in one go in the Init hook and don't use the other hooks at all.
**/
class EFFECT {
    
    var self(default,never):gmod.gclass.Entity;
    
    /**
        
    **/
    
    @:hook
    function EndTouch():Void {}
    
    
    /**
        Called when the effect collides with anything.
		
		Name | Description
		--- | ---
		`colData` | Information regarding the collision. See CollisionData structure
		`collider` | The physics object of the entity that collided with the effect.
    **/
    
    @:hook
    function PhysicsCollide(colData:CollisionData, collider:PhysObj):Void {}
    
    
    /**
        
    **/
    
    @:hook
    function Touch():Void {}
    
    
    /**
        Called when the effect should think, return false to kill the effect.
		
		`**Returns:** Return false to remove this effect.
    **/
    
    @:hook
    function Think():Bool {return null;}
    
    
    /**
        
    **/
    
    @:hook
    function StartTouch():Void {}
    
    
    /**
        Called when the effect is created.
		
		Name | Description
		--- | ---
		`effectData` | The effect data used to create the effect.
    **/
    
    @:hook
    function Init(effectData:CEffectData):Void {}
    
    
    /**
        Called when the effect should be rendered.
    **/
    
    @:hook
    function Render():Void {}
    
    
    /**
        Used to get the "real" start position of a trace, for weapon tracer effects. 
		
		"real" meaning in 3rd person, the 3rd person position will be used, in first person the first person position will be used.
		
		**Note:** Please note that it is expected that the same attachment ID is used on both, the world and the view model.
		
		Name | Description
		--- | ---
		`pos` | Default position if we fail
		`ent` | The weapon to use.
		`attachment` | Attachment ID of on the weapon "muzzle", to use as the start position. NOTE Please note that it is expected that the same attachment ID is used on both, the world and the view model.
		
		
		`**Returns:** The "real" start position.
    **/
    
    @:hook
    function GetTracerShootPos(pos:Vector, ent:Weapon, attachment:Float):Vector {return null;}
    
    
}



#end