package gmod.libs;


/**
    The drive library is for adding custom control modes to the new "remote control" entity piloting system in Garry's Mod 13.
**/
@:native("_G.drive")extern class DriveLib {
    
    /**
        ***INTERNAL** 
		
		Destroys players current driving method.
		
		Name | Description
		--- | ---
		`ply` | The player to affect
    **/
    @:deprecated("INTERNAL")
    public static function DestroyMethod(ply:Player):Void;
    
    
    /**
        ***INTERNAL** 
		
		The move is finished. Copy mv back into the target.
		
		Name | Description
		--- | ---
		`ply` | The player
		`mv` | The move data
		
		
		`**Returns:** true if succeeded
    **/
    @:deprecated("INTERNAL")
    public static function FinishMove(ply:Player, mv:CMoveData):Bool;
    
    
    /**
        Stops the player from driving anything. ( For example a prop in sandbox )
		
		Name | Description
		--- | ---
		`ply` | The player to affect
    **/
    
    public static function PlayerStopDriving(ply:Player):Void;
    
    
    /**
        ***INTERNAL** 
		
		Clientside, the client creates the cmd (usercommand) from their input device (mouse, keyboard) and then it's sent to the server. Restrict view angles here.
		
		Name | Description
		--- | ---
		`cmd` | The user command
		
		
		`**Returns:** true if succeeded
    **/
    @:deprecated("INTERNAL")
    public static function CreateMove(cmd:CUserCmd):Bool;
    
    
    /**
        Called when the player first starts driving this entity
		
		Name | Description
		--- | ---
		`ply` | The player
		`ent` | The entity
    **/
    
    public static function Start(ply:Player, ent:Entity):Void;
    
    
    /**
        ***INTERNAL** 
		
		The move is executed here.
		
		Name | Description
		--- | ---
		`ply` | The player
		`mv` | The move data
		
		
		`**Returns:** true if succeeded
    **/
    @:deprecated("INTERNAL")
    public static function Move(ply:Player, mv:CMoveData):Bool;
    
    
    /**
        ***INTERNAL** 
		
		The user command is received by the server and then converted into a move. This is also run clientside when in multiplayer, for prediction to work.
		
		Name | Description
		--- | ---
		`ply` | The player
		`mv` | The move data
		`cmd` | The user command
		
		
		`**Returns:** true if succeeded
    **/
    @:deprecated("INTERNAL")
    public static function StartMove(ply:Player, mv:CMoveData, cmd:CUserCmd):Bool;
    
    
    /**
        ***INTERNAL** 
		
		Optionally alter the view.
		
		Name | Description
		--- | ---
		`ply` | The player
		`view` | The view, see ViewData structure
		
		
		`**Returns:** true if succeeded
    **/
    @:deprecated("INTERNAL")
    public static function CalcView(ply:Player, view:ViewData):Bool;
    
    
    /**
        Player has stopped driving the entity.
		
		Name | Description
		--- | ---
		`ply` | The player
		`ent` | The entity
    **/
    
    public static function End(ply:Player, ent:Entity):Void;
    
    
    /**
        ***INTERNAL** 
		
		Returns ( or creates if inexistent ) a driving method.
		
		Name | Description
		--- | ---
		`ply` | The player
		
		
		`**Returns:** A method object.
    **/
    @:deprecated("INTERNAL")
    public static function GetMethod(ply:Player):AnyTable;
    
    
    /**
        Starts driving for the player.
		
		Name | Description
		--- | ---
		`ply` | The player to affect
		`ent` | The entity to drive
		`mode` | The driving mode
    **/
    
    public static function PlayerStartDriving(ply:Player, ent:Entity, mode:String):Void;
    
    
    /**
        Registers a new entity drive.
		
		Name | Description
		--- | ---
		`name` | The name of the drive.
		`data` | The data required to create the drive. This includes the functions used by the drive.
		`base` | The base of the drive.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds a noclip drive type.
		
		```lua 
		drive.Register( "drive_noclip", 
		{
		    --
		    -- Called before each move. You should use your entity and cmd to 
		    -- fill mv with information you need for your move.
		    --
		    StartMove =  function( self, mv, cmd )
		
		        --
		        -- Update move position and velocity from our entity
		        --
		        mv:SetOrigin( self.Entity:GetNetworkOrigin() )
		        mv:SetVelocity( self.Entity:GetAbsVelocity() )
		
		    end,
		
		    --
		    -- Runs the actual move. On the client when there's 
		    -- prediction errors this can be run multiple times.
		    -- You should try to only change mv.
		    --
		    Move = function( self, mv )
		
		        --
		        -- Set up a speed, go faster if shift is held down
		        --
		        local speed = 0.0005 * FrameTime()
		        if ( mv:KeyDown( IN_SPEED ) ) then speed = 0.005 * FrameTime() end
		
		        --
		        -- Get information from the movedata
		        --
		        local ang = mv:GetMoveAngles()
		        local pos = mv:GetOrigin()
		        local vel = mv:GetVelocity()
		
		        --
		        -- Add velocities. This can seem complicated. On the first line
		        -- we're basically saying get the forward vector, then multiply it
		        -- by our forward speed (which will be > 0 if we're holding W, < 0 if we're
		        -- holding S and 0 if we're holding neither) - and add that to velocity.
		        -- We do that for right and up too, which gives us our free movement.
		        --
		        vel = vel + ang:Forward() * mv:GetForwardSpeed() * speed
		        vel = vel + ang:Right() * mv:GetSideSpeed() * speed
		        vel = vel + ang:Up() * mv:GetUpSpeed() * speed
		
		        --
		        -- We don't want our velocity to get out of hand so we apply
		        -- a little bit of air resistance. If no keys are down we apply
		        -- more resistance so we slow down more.
		        --
		        if ( math.abs(mv:GetForwardSpeed()) + math.abs(mv:GetSideSpeed()) + math.abs(mv:GetUpSpeed()) < 0.1 ) then
		            vel = vel * 0.90
		        else
		            vel = vel * 0.99
		        end
		
		        --
		        -- Add the velocity to the position (this is the movement)
		        --
		        pos = pos + vel
		
		        --
		        -- We don't set the newly calculated values on the entity itself
		        -- we instead store them in the movedata. These get applied in FinishMove.
		        --
		        mv:SetVelocity( vel )
		        mv:SetOrigin( pos )
		
		    end,
		
		    --
		    -- The move is finished. Use mv to set the new positions
		    -- on your entities/players.
		    --
		    FinishMove =  function( self, mv )
		
		        --
		        -- Update our entity!
		        --
		        self.Entity:SetNetworkOrigin( mv:GetOrigin() )
		        self.Entity:SetAbsVelocity( mv:GetVelocity() )
		        self.Entity:SetAngles( mv:GetMoveAngles() )
		
		        --
		        -- If we have a physics object update that too. But only on the server.
		        --
		        if ( SERVER && IsValid( self.Entity:GetPhysicsObject() ) ) then
		
		            self.Entity:GetPhysicsObject():EnableMotion( true )
		            self.Entity:GetPhysicsObject():SetPos( mv:GetOrigin() );
		            self.Entity:GetPhysicsObject():Wake()
		            self.Entity:GetPhysicsObject():EnableMotion( false )
		
		        end
		
		    end,
		
		    --
		    -- Calculates the view when driving the entity
		    --
		    CalcView =  function( self, view )
		
		        --
		        -- Use the utility method on drive_base.lua to give us a 3rd person view
		        --
		        local idealdist = math.max( 10, self.Entity:BoundingRadius() ) * 4
		
		        self:CalcView_ThirdPerson( view, idealdist, 2, { self.Entity } )
		
		    end,
		
		}, "drive_base" );
		```
    **/
    
    public static function Register(name:String, data:AnyTable, base:String):Void;
    
    

}



