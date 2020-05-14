package gmod.gclass;
#if client

/**
    List of all possible functions available for Lua particles. This is the object returned by the CLuaEmitter:Add function.
**/
extern class CLuaParticle {
    
    /**
        Returns the current velocity of the particle.
		
		`**Returns:** The current velocity of the particle.
    **/
    
    function GetVelocity():Vector;
    
    
    /**
        Sets the alpha value of the particle that it will reach when it dies.
		
		Name | Description
		--- | ---
		`endAlpha` | The new alpha value of the particle that it will reach when it dies.
    **/
    
    function SetEndAlpha(endAlpha:Float):Void;
    
    
    /**
        Sets the 'bounciness' of the the particle.
		
		Name | Description
		--- | ---
		`bounce` | New 'bounciness' of the particle 2 means it will gain 100% of its previous velocity, 1 means it will not lose velocity, 0.5 means it will lose half of its velocity with each bounce.
    **/
    
    function SetBounce(bounce:Float):Void;
    
    
    /**
        Sets the think function of the particle.
		
		Name | Description
		--- | ---
		`thinkFunc` | Think function. It has only one argument: CLuaParticle particle - The particle the think hook is set on
		
		
		___
		### Lua Examples
		#### Example 1
		Example on how to use a think function, randomizes the colors of a particle
		
		```lua 
		p:SetNextThink( 1e99 ) -- Makes sure the think hook is used on all particles of the particle emitter
		p:SetThinkFunction( function( pa )
		    pa:SetColor( math.random( 0, 255 ), math.random( 0, 255 ), math.random( 0, 255 ) ) -- Randomize it
		    pa:SetNextThink( 1e99 ) -- Makes sure the think hook is actually ran.
		end )
		```
    **/
    
    function SetThinkFunction(thinkFunc:Function):Void;
    
    
    /**
        Returns the size which the particle has when it's created.
		
		`**Returns:** The size which the particle has when it's created.
    **/
    
    function GetStartSize():Float;
    
    
    /**
        Sets the velocity of the particle.
		
		Name | Description
		--- | ---
		`vel` | The new velocity of the particle.
    **/
    
    function SetVelocity(vel:Vector):Void;
    
    
    /**
        Returns the length that the particle will reach on its death.
		
		`**Returns:** The length the particle will reach
    **/
    
    function GetEndLength():Float;
    
    
    /**
        Returns the air resistance of the particle.
		
		`**Returns:** The air resistance of the particle
    **/
    
    function GetAirResistance():Float;
    
    
    /**
        Returns the current orientation of the particle.
		
		`**Returns:** The angles of the particle
    **/
    
    function GetAngles():Angle;
    
    
    /**
        Returns the length which the particle has when it's created.
		
		`**Returns:** The length which the particle has when it's created.
    **/
    
    function GetStartLength():Float;
    
    
    /**
        Sets the whether the particle should collide with the world or not.
		
		Name | Description
		--- | ---
		`shouldCollide` | Whether the particle should collide with the world or not
    **/
    
    function SetCollide(shouldCollide:Bool):Void;
    
    
    /**
        Returns the amount of time in seconds after which the particle will be destroyed.
		
		`**Returns:** The amount of time in seconds after which the particle will be destroyed
    **/
    
    function GetDieTime():Float;
    
    
    /**
        Returns the alpha value that the particle will reach on its death.
		
		`**Returns:** The alpha value the particle will fade to
    **/
    
    function GetEndAlpha():Float;
    
    
    /**
        Returns the current rotation speed of the particle in radians, this should only be used for 2D particles.
		
		`**Returns:** The current rotation speed of the particle in radians
    **/
    
    function GetRollDelta():Float;
    
    
    /**
        Returns the 'life time' of the particle, how long the particle existed since its creation. 
		
		This value will always be between 0 and CLuaParticle:GetDieTime. It changes automatically as time goes. 
		
		 It can be manipulated using CLuaParticle:SetLifeTime. If the life time of the particle will be more than CLuaParticle:GetDieTime, it will be removed.
		
		`**Returns:** How long the particle existed, in seconds.
    **/
    
    function GetLifeTime():Float;
    
    
    /**
        Returns the absolute position of the particle.
		
		`**Returns:** The absolute position of the particle.
    **/
    
    function GetPos():Vector;
    
    
    /**
        Sets the size of the particle that it will reach when it dies.
		
		Name | Description
		--- | ---
		`endSize` | The new size of the particle that it will reach when it dies.
    **/
    
    function SetEndSize(endSize:Float):Void;
    
    
    /**
        Sets the 'life time' of the particle, how long the particle existed since its creation. 
		
		This value should always be between 0 and CLuaParticle:GetDieTime. It changes automatically as time goes. If the life time of the particle will be more than CLuaParticle:GetDieTime, it will be removed.
		
		Name | Description
		--- | ---
		`lifeTime` | The new life time of the particle.
    **/
    
    function SetLifeTime(lifeTime:Float):Void;
    
    
    /**
        Scales the velocity based on the particle speed.
		
		Name | Description
		--- | ---
		`doScale` | Use velocity scaling.
    **/
    
    function SetVelocityScale(?doScale:Bool):Void;
    
    
    /**
        Sets the function that gets called whenever the particle collides with the world.
		
		Name | Description
		--- | ---
		`collideFunc` | Collide callback, the arguments are: CLuaParticle particle - The particle itself Vector hitPos - Position of the collision Vector hitNormal - Direction of the collision, perpendicular to the hit surface
		
		
		___
		### Lua Examples
		#### Example 1
		Creates an explosion every time an particle collides with something.
		
		```lua 
		MyParticle:SetCollideCallback( function( part, hitpos, hitnormal ) --This is an in-line function
		    local efdata = EffectData() --Grab base EffectData table
		    efdata:SetOrigin( hitpos ) --Sets the origin of it to the hitpos of the particle
		    util.Effect( "Explosion", efdata ) --Create the effect
		end )
		```
    **/
    
    function SetCollideCallback(collideFunc:Function):Void;
    
    
    /**
        Sets whether the particle should be lighted.
		
		Name | Description
		--- | ---
		`useLighting` | Whether the particle should be lighted.
    **/
    
    function SetLighting(useLighting:Bool):Void;
    
    
    /**
        Sets the rotation speed of the particle in radians. This should only be used for 2D particles.
		
		Name | Description
		--- | ---
		`rollDelta` | The new rotation speed of the particle in radians.
    **/
    
    function SetRollDelta(rollDelta:Float):Void;
    
    
    /**
        Returns the size that the particle will reach on its death.
		
		`**Returns:** The size the particle will reach
    **/
    
    function GetEndSize():Float;
    
    
    /**
        Sets the initial size value of the particle.
		
		Name | Description
		--- | ---
		`startSize` | Initial size.
    **/
    
    function SetStartSize(startSize:Float):Void;
    
    
    /**
        Returns the current rotation of the particle in radians, this should only be used for 2D particles.
		
		`**Returns:** The current rotation of the particle in radians
    **/
    
    function GetRoll():Float;
    
    
    /**
        Sets the length of the particle that it will reach when it dies.
		
		Name | Description
		--- | ---
		`endLength` | The new length of the particle that it will reach when it dies.
    **/
    
    function SetEndLength(endLength:Float):Void;
    
    
    /**
        Sets the time where the particle will be removed.
		
		Name | Description
		--- | ---
		`dieTime` | The new die time.
    **/
    
    function SetDieTime(dieTime:Float):Void;
    
    
    /**
        Sets the roll of the particle in radians. This should only be used for 2D particles.
		
		Name | Description
		--- | ---
		`roll` | The new rotation of the particle in radians.
    **/
    
    function SetRoll(roll:Float):Void;
    
    
    /**
        Sets the air resistance of the the particle.
		
		Name | Description
		--- | ---
		`airResistance` | New air resistance.
    **/
    
    function SetAirResistance(airResistance:Float):Void;
    
    
    /**
        Sets the angles of the particle.
		
		Name | Description
		--- | ---
		`ang` | New angle.
    **/
    
    function SetAngles(ang:Angle):Void;
    
    
    /**
        Returns the angular velocity of the particle
		
		`**Returns:** The angular velocity of the particle
    **/
    
    function GetAngleVelocity():Angle;
    
    
    /**
        Sets the directional gravity aka. acceleration of the particle.
		
		Name | Description
		--- | ---
		`gravity` | The directional gravity.
    **/
    
    function SetGravity(gravity:Vector):Void;
    
    
    /**
        Returns the gravity of the particle.
		
		`**Returns:** The gravity of the particle.
    **/
    
    function GetGravity():Vector;
    
    
    /**
        Sets when the particles think function should be called next, this uses the synchronized server time returned by CurTime.
		
		Name | Description
		--- | ---
		`nextThink` | Next think time.
    **/
    
    function SetNextThink(nextThink:Float):Void;
    
    
    /**
        Sets the absolute position of the particle.
		
		Name | Description
		--- | ---
		`pos` | The new particle position.
    **/
    
    function SetPos(pos:Vector):Void;
    
    
    /**
        Sets the angular velocity of the the particle.
		
		Name | Description
		--- | ---
		`angVel` | New angular velocity.
    **/
    
    function SetAngleVelocity(angVel:Angle):Void;
    
    
    /**
        Sets the initial alpha value of the particle.
		
		Name | Description
		--- | ---
		`startAlpha` | Initial alpha.
    **/
    
    function SetStartAlpha(startAlpha:Float):Void;
    
    
    /**
        Sets the initial length value of the particle.
		
		Name | Description
		--- | ---
		`startLength` | Initial length.
    **/
    
    function SetStartLength(startLength:Float):Void;
    
    
    /**
        Returns the color of the particle.
		
		Name | Description
		--- | ---
		`a` | Red part of the color
		`b` | Green part of the color
		`c` | Blue part of the color
    **/
    
    function GetColor():CLuaParticleGetColorReturn;
    
    
    /**
        Returns the alpha value which the particle has when it's created.
		
		`**Returns:** The alpha value which the particle has when it's created.
    **/
    
    function GetStartAlpha():Float;
    
    
    /**
        Returns the 'bounciness' of the particle.
		
		`**Returns:** The 'bounciness' of the particle 2 means it will gain 100% of its previous velocity, 1 means it will not lose velocity, 0.5 means it will lose half of its velocity with each bounce.
    **/
    
    function GetBounce():Float;
    
    
    /**
        Sets the color of the particle.
		
		Name | Description
		--- | ---
		`r` | The red component.
		`g` | The green component.
		`b` | The blue component.
    **/
    
    function SetColor(r:Float, g:Float, b:Float):Void;
    
    
}


@:multiReturn extern class CLuaParticleGetColorReturn {
var a:Float;
var b:Float;
var c:Float;

}

#end