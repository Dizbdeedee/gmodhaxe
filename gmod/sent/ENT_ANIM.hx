package gmod.sent;

class ENT_ANIM extends gmod.sent.ENT {
	
	public final TYPE = "anim";
	var self(default,never):gmod.gclass.Entity;
    #if server
    /**
        Called when the entity is blocked. 
		
		
		Name | Description
		--- | ---
		`other` | The entity that is blocking this entity.
		
		
		
    **/
    
    @:hook
    private function Blocked(other:Entity):Void {}
    #end
    #if client
    /**
        Called if and when the entity should be drawn opaquely, based on the Entity:GetRenderGroup of the entity. 
		
		See ENT structure and RENDERGROUP_ Enums for more information. 
		
		 See also ENTITY:DrawTranslucent. 
		
		 
		Name | Description
		--- | ---
		`flags` | The bit flags from STUDIO_ Enums
		
		
		___
		### Lua Examples
		#### Example 1
		Draws the model and makes a rotating text over the entity
		
		```lua 
		-- Draw some 3D text
		local function Draw3DText( pos, ang, scale, text, flipView )
		    if ( flipView ) then
		        -- Flip the angle 180 degrees around the UP axis
		        ang:RotateAroundAxis( Vector( 0, 0, 1 ), 180 )
		    end
		
		    cam.Start3D2D( pos, ang, scale )
		        -- Actually draw the text. Customize this to your liking.
		        draw.DrawText( text, "Default", 0, 0, Color( 0, 255, 0, 255 ), TEXT_ALIGN_CENTER )
		    cam.End3D2D()
		end
		
		function ENT:Draw()
		    -- Draw the model
		    self:DrawModel()
		
		    -- The text to display
		    local text = "Example Text"
		
		    -- The position. We use model bounds to make the text appear just above the model. Customize this to your liking.
		    local mins, maxs = self:GetModelBounds()
		    local pos = self:GetPos() + Vector( 0, 0, maxs.z + 2 )
		
		    -- The angle
		    local ang = Angle( 0, SysTime() * 100 % 360, 90 )
		
		    -- Draw front
		    Draw3DText( pos, ang, 0.2, text, false )
		    -- DrawDraw3DTextback
		    Draw3DText( pos, ang, 0.2, text, true )
		end
		```
		
		
    **/
    
    @:hook
    private function Draw(flags:Float):Void {}
    #end

    #if client
    /**
        Called when the entity should be drawn translucently. 
		
		
		Name | Description
		--- | ---
		`flags` | The bit flags from STUDIO_ Enums
		
		
		___
		### Lua Examples
		#### Example 1
		The default action for this hook is to call ENTITY:Draw.
		
		```lua 
		function ENT:DrawTranslucent()
		
		    -- This is here just to make it backwards compatible.
		    -- You shouldn't really be drawing your model here unless it's translucent
		
		    self:Draw()
		
		end
		```
		
		
    **/
    
    @:hook
    private function DrawTranslucent(flags:Float):Void {}
    #end

    #if server
    /**
        Called when the entity stops touching another entity. 
		
		
		Name | Description
		--- | ---
		`entity` | The entity which was touched.
		
		
		
    **/
    
    @:hook
    private function EndTouch(entity:Entity):Void {}
    #end

    #if client
    /**
        Called when a bullet trace hits this entity and allows you to override the default behavior by returning true. 
		
		
		Name | Description
		--- | ---
		`traceResult` | The trace that hit this entity as a TraceResult structure.
		`damageType` | The damage bits associated with the trace, see DMG_ Enums
		`customImpactName` | The effect name to override the impact effect with. Possible arguments are ImpactJeep, AirboatGunImpact, HelicopterImpact, ImpactGunship.
		
		
		**Returns:** Return true to override the default impact effects.
		
		___
		### Lua Examples
		#### Example 1
		Hides the original bullet impact effect and dispatches explosions instead.
		
		```lua 
		function ENT:ImpactTrace(trace,dmgtype,customimpactname)
		    local effectdata = EffectData()
		    effectdata:SetOrigin( trace.HitPos )
		    util.Effect( "Explosion", effectdata )
		    return true
		end
		```
		
		
    **/
    
    @:hook
    private function ImpactTrace(traceResult:AnyTable, damageType:Float, ?customImpactName:String):Bool {return null;}
    #end

    #if server
    /**
        Called when the entity is taking damage. 
		
		
		Name | Description
		--- | ---
		`damage` | The damage to be applied to the entity.
		
		
		___
		### Lua Examples
		#### Example 1
		All damage taken by this entity is applied twice. This will count the damage taken as two distinctive hits as opposed to just scaling it in GM:EntityTakeDamage.
		
		```lua 
		function ENT:OnTakeDamage( dmginfo )
		    -- Make sure we're not already applying damage a second time
		    -- This prevents infinite loops
		    if ( not self.m_bApplyingDamage ) then
		        self.m_bApplyingDamage = true
		        self:TakeDamageInfo( dmginfo )
		        self.m_bApplyingDamage = false
		    end
		end
		```
		
		
    **/
    
    @:hook
    private function OnTakeDamage(damage:CTakeDamageInfo):Void {}
    #end
    #if server
    /**
        Called when the entity collides with anything. The move type and solid type must be VPHYSICS for the hook to be called. 
		
		
		Name | Description
		--- | ---
		`colData` | Information regarding the collision. See CollisionData structure.
		`collider` | The physics object that collided.
		
		
		___
		### Lua Examples
		#### Example 1
		Play a sound when we hit something.
		
		```lua 
		function ENT:PhysicsCollide( data, phys )
		    if ( data.Speed > 50 ) then self:EmitSound( Sound( "Flashbang.Bounce" ) ) end
		end
		```
		
		
    **/
    
    @:hook
    private function PhysicsCollide(colData:AnyTable, collider:PhysObj):Void {}
    #end
    /**
        Called from the Entity's motion controller to simulate physics. 
		
		This will only be called after using Entity:StartMotionController on a scripted entity of "anim" type. 
		
		 
		Name | Description
		--- | ---
		`phys` | The physics object of the entity.
		`deltaTime` | Time since the last call.
		
		
		Name | Description
		--- | ---
		`a` | Angular force
		`b` | Linear force
		`c` | One of the SIM_ Enums.
		
		
		
    **/
    
    @:hook
    private function PhysicsSimulate(phys:PhysObj, deltaTime:Float):Dynamic {return null;} //EntPhysicsSimulateReturn

    /**
        Called whenever the physics of the entity are updated. 
		
		
		Name | Description
		--- | ---
		`phys` | The physics object of the entity.
		
		
		
    **/
    
    @:hook
    private function PhysicsUpdate(phys:PhysObj):Void {}

    #if server
    /**
        Called when the entity starts touching another entity. 
		
		
		Name | Description
		--- | ---
		`entity` | The entity which is being touched.
		
		
		
    **/
    
    @:hook
    private function StartTouch(entity:Entity):Void {}
    #end

    /**
        Allows you to override trace result when a trace hits the entitys Bounding Box. 
		
		
		Name | Description
		--- | ---
		`startpos` | Start position of the trace
		`delta` | Offset from startpos to the endpos of the trace
		`isbox` | Is the trace a hull trace?
		`extents` | Size of the hull trace?
		`mask` | The CONTENTS_ Enums mask
		
		
		**Returns:** A table containing new HitPos, Fraction and Normal. Returning nothing allows the trace to ignore the entity completely.
		
		___
		### Lua Examples
		#### Example 1
		Example taken from lua/entities/widget_base.lua
		
		```lua 
		function ENT:TestCollision( startpos, delta, isbox, extents )
		
		        if ( isbox ) then return end
		        if ( !widgets.Tracing ) then return end
		        
		        -- TODO. Actually trace against our cube!
		        
		        return 
		        { 
		                HitPos                = self:GetPos(),
		                Fraction        = 0.5 * self:GetPriority()
		        }
		
		end
		```
		
		
    **/
    
    @:hook
    private function TestCollision(startpos:Vector, delta:Vector, isbox:Bool, extents:Vector, mask:Float):gmod.structs.TestCollisionData {return null;}

    #if server
    /**
        Called every tick for every entity being "touched". 
		
		See also ENTITY:StartTouch and ENTITY:EndTouch. 
		
		 
		Name | Description
		--- | ---
		`entity` | The entity that touched it.
		
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		function ENTITY:Touch(entity)
		    self:EmitSound("ambient/explosions/explode_" .. math.random(1, 9) .. ".wav")
		    self:Remove()
		end
		```
		
		
    **/
    
    @:hook
    private function Touch(entity:Entity):Void {}
    #end
    #if server
    /**
        Called whenever the transmit state should be updated. 
		
		
		**Returns:** Transmit state to set, see TRANSMIT_ Enums.
		
		___
		### Lua Examples
		#### Example 1
		Entity pickup example, stops the entity from being networked after it's been picked up, and restores it once it "respawns".
		
		```lua 
		function ENT:Touch( other )
		    if ( self.NextRespawn > CurTime() ) then return end
		    
		    self.NextRespawn = CurTime() + 5
		    self:AddEFlags( EFL_FORCE_CHECK_TRANSMIT )
		end
		
		function ENT:UpdateTransmitState()
		    if ( self.NextRespawn > CurTime() ) then
		        return TRANSMIT_NEVER
		    end
		    
		    return TRANSMIT_PVS
		end
		
		function ENT:Think()
		    if ( self.NextRespawn != -1 && self.NextRespawn < CurTime() ) then
		        self.NextRespawn = -1
		        self:AddEFlags( EFL_FORCE_CHECK_TRANSMIT )
		    end
		end
		```
		
		
    **/
    
    @:hook
    private function UpdateTransmitState():Float {return null;}
    #end

    #if server
    /**
        Called when another entity uses this entity, example would be a player pressing "+use" this entity. 
		
		To change how often the function is called, see Entity:SetUseType. 
		
		 
		Name | Description
		--- | ---
		`activator` | The entity that caused this input. This will usually be the player who pressed their use key
		`caller` | The entity responsible for the input. This will typically be the same as activator unless some other entity is acting as a proxy
		`useType` | Use type, see USE_ Enums.
		`value` | Any passed value.
		
		
		___
		### Lua Examples
		#### Example 1
		Kills any player that uses this entity.
		
		```lua 
		function ENT:Use( activator )
		
		    if activator:IsPlayer() then 
		
		        activator:Kill()
		
		    end
		
		end
		```
		
		
    **/
    
    @:hook
    private function Use(activator:Entity, caller:Entity, useType:Float, value:Float):Void {}
    #end


    
}

@:multiReturn extern class EntPhysicsSimulateReturn {
    var a:Vector;
    var b:Vector;
    var c:Float;
    
    }