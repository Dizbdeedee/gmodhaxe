package gmod.gclass;

/**
    This is a list of all methods only available for players. It is also possible to call Entity functions on the Player.
**/
extern class Player extends Entity {
    
    /**
        Returns a player's duck speed (in seconds)
		
		`**Returns:** duckspeed
		
		___
		### Lua Examples
		#### Example 1
		Gets player 1's duck speed in seconds, and prints it to console
		
		```lua 
		print( player.GetByID( 1 ):GetDuckSpeed() )
		```
		**Output:**
		
		0.3 in console (tested)
    **/
    
    public function GetDuckSpeed():Float;
    
    #if server
    /**
        Kills a player and calls GM:PlayerDeath.
		
		___
		### Lua Examples
		#### Example 1
		When the user types "/respawn" the user will be killed and then respawned.
		
		```lua 
		hook.Add( "PlayerSay", "RespawnCommand", function( ply, text, public )
		    if ( string.lower( text ) == "/respawn" ) then
		        ply:Kill()
		        ply:Spawn()
		        return ""
		    end
		end )
		```
    **/
    
    public function Kill():Void;
    #end
    
    /**
        Show/Hide the player's weapon's viewmodel.
		
		Name | Description
		--- | ---
		`draw` | Should draw
		`vm` | Which view model to show/hide, 0-2.
		
		
		___
		### Lua Examples
		#### Example 1
		Create a ConVar object on the client realm to enable/disable the viewmodel.
		
		```lua 
		local cvarObject = CreateClientConVar("nogun", "1", true, false, "Hide the current viewmodel.") -- Create the ConVar object
		
		hook.Add("HUDPaint", "draw_viewmodel", function()
		    LocalPlayer():DrawViewModel(cvarObject:GetBool()) -- Call ConVar:GetBool() inside the parameters of DrawViewModel
		end)
		```
    **/
    
    public function DrawViewModel(draw:Bool, ?vm:Float):Void;
    
    #if server
    /**
        Freeze the player. Frozen players cannot move, look around, or attack. Key bindings are still called. Similar to Player:Lock but the player can still take damage. 
		
		Adds or removes the FL_FROZEN flag from the player.
		
		**Bug:** BUG Frozen bots will still be able to look around.
		
		Name | Description
		--- | ---
		`frozen` | Whether the player should be frozen.
		
		
		___
		### Lua Examples
		#### Example 1
		Freezes all players
		
		```lua 
		for k, v in pairs(player.GetAll()) do
		    v:Freeze( true )
		end
		```
    **/
    
    public function Freeze(?frozen:Bool):Void;
    #end
    
    /**
        Returns true if the players' model is allowed to rotate around the pitch and roll axis.
		
		`**Returns:** Allowed
    **/
    
    public function GetAllowFullRotation():Bool;
    
    
    /**
        Translates ACT_ Enums according to the holdtype of players currently held weapon.
		
		Name | Description
		--- | ---
		`act` | The initial ACT_ Enums
		
		
		`**Returns:** Translated ACT_ Enums
    **/
    
    public function TranslateWeaponActivity(act:ACT):ACT;
    
    
    /**
        Returns the position of a Kinect bone.
		
		Name | Description
		--- | ---
		`bone` | Bone to get the position of. Must be from 0 to 19.
		
		
		`**Returns:** Position of the bone.
    **/
    
    public function MotionSensorPos(bone:Float):Vector;
    
    
    /**
        Sets how quickly a player un-ducks
		
		Name | Description
		--- | ---
		`UnDuckSpeed` | How quickly the player will un-duck
    **/
    
    public function SetUnDuckSpeed(UnDuckSpeed:Float):Void;
    
    
    /**
        Returns the last command which was sent by the specified player. Can only be used in a Predicted Hook.
		
		**Note:** When called clientside in singleplayer during WEAPON:Think, it will return nothing as the hook is not technically predicted in that instance. See the note on the page.
		
		**Bug:** BUG This will fail in GM:StartCommand. Issue Tracker: #3302
		
		`**Returns:** Last user commands
    **/
    
    public function GetCurrentCommand():CUserCmd;
    
    
    /**
        ***Deprecated:** This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.
		
		When used in a GM:SetupMove hook, this function will prevent the player from sprinting. 
		
		When +walk is engaged, the player will still be able to sprint to half speed (normal run speed) as opposed to full sprint speed without this function.
		
		___
		### Lua Examples
		#### Example 1
		Example usage, disables sprinting at all times.
		
		```lua 
		hook.Add( "SetupMove", "TestFunc", function( ply, mv, cmd )
		    ply:StopSprinting()
		end )
		```
    **/
    @:deprecated("This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.")
    public function StopSprinting():Void;
    
    #if server
    /**
        Returns the hitgroup where the player was last hit.
		
		`**Returns:** Hitgroup, see HITGROUP_ Enums
    **/
    
    public function LastHitGroup():HITGROUP;
    #end
    
    /**
        Gets whether a key is down. This is not networked to other players, meaning only the local client can see the keys they are pressing.
		
		Name | Description
		--- | ---
		`key` | The key, see IN_ Enums
		
		
		`**Returns:** isDown
		
		___
		### Lua Examples
		#### Example 1
		Prints whenever the first player is holding forward key
		
		```lua 
		hook.Add("Tick", "KeyDown_Test", function()
		    if (Entity(1):KeyDown(IN_FORWARD)) then
		        print("Player is pressing forward!")
		    end
		end)
		```
    **/
    
    public function KeyDown(key:IN):Bool;
    
    
    /**
        Sets the weight of the animation playing in the given gesture slot.
		
		Name | Description
		--- | ---
		`slot` | The gesture slot. See GESTURE_SLOT_ Enums
		`weight` | The weight this slot should be set to. Value must be ranging from 0 to 1.
    **/
    
    public function AnimSetGestureWeight(slot:GESTURE_SLOT, weight:Float):Void;
    
    
    /**
        Returns a player's unduck speed (in seconds)
		
		`**Returns:** unduck speed
		
		___
		### Lua Examples
		#### Example 1
		Gets player 1's unduck speed, and prints it to console
		
		```lua 
		print( player.GetByID( 1 ):GetUnDuckSpeed() )
		```
		**Output:**
		
		0.3 in console
    **/
    
    public function GetUnDuckSpeed():Float;
    
    #if server
    /**
        Creates the player's death ragdoll entity and deletes the old one. 
		
		This is normally used when a player dies, to create their death ragdoll. 
		
		 The ragdoll will be created with the player's properties such as Position, Angles, PlayerColor, Velocity and Model. 
		
		 You can retrieve the entity this creates with Player:GetRagdollEntity.
    **/
    
    public function CreateRagdoll():Void;
    #end
    
    /**
        Plays a sequence directly from a sequence number, similar to Player:AnimRestartGesture. This function has the advantage to play sequences that haven't been bound to an existing ACT_ Enums
		
		Name | Description
		--- | ---
		`slot` | Gesture slot using GESTURE_SLOT_ Enums
		`sequenceId` | The sequence ID to play, can be retrieved with Entity: LookupSequence.
		`cycle` | The cycle to start the animation at, ranges from 0 to 1.
		`autokill` | If the animation should not loop. true = stops the animation, false = the animation keeps playing.
    **/
    
    public function AddVCDSequenceToGestureSlot(slot:GESTURE_SLOT, sequenceId:Float, cycle:Float, ?autokill:Bool):Void;
    
    #if client
    /**
        Sets if the player should be muted locally.
		
		Name | Description
		--- | ---
		`mute` | Mute or unmute.
		
		
		___
		### Lua Examples
		#### Example 1
		Mutes all players on the server
		
		```lua 
		for k, v in pairs(player.GetAll()) do
		    v:SetMuted(true)
		end
		```
    **/
    
    public function SetMuted(mute:Bool):Void;
    #end
    
    /**
        Returns true if the player's flashlight is on.
		
		`**Returns:** Whether the player's flashlight is on.
    **/
    
    public function FlashlightIsOn():Bool;
    
    #if client
    /**
        Returns a table containing player information.
		
		`**Returns:** A table containing player information.
		
		___
		### Lua Examples
		#### Example 1
		Example output for a bot and a player.
		
		```lua 
		PrintTable( Entity( 1 ):GetPlayerInfo() ) -- A player
		PrintTable( Entity( 2 ):GetPlayerInfo() ) -- A bot
		```
		**Output:**
		
		Player: friendname	=	
		customfiles:
				1	=	0912fb2c
				2	=	0912fb2c
				3	=	0912fb2c
				4	=	0912fb2c
		fakeplayer	=	false
		guid	=	STEAM_0:0:18313012
		ishltv	=	false
		filesdownloaded	=	0
		friendid	=	36626024
		name	=	Rubat
		userid	=	2 Bot: friendname	=	
		customfiles:
				1	=	00000000
				2	=	00000000
				3	=	00000000
				4	=	00000000
		fakeplayer	=	true
		guid	=	BOT
		ishltv	=	false
		filesdownloaded	=	0
		friendid	=	0
		name	=	Bot01
		userid	=	3
    **/
    
    public function GetPlayerInfo():AnyTable;
    #end
    
    /**
        Sets the widget that is currently in use by the player's mouse. 
		
		Having a pressed widget stops the player from firing his weapon to allow input to be passed onto the widget.
		
		Name | Description
		--- | ---
		`pressedWidget` | The widget the player is currently using.
    **/
    
    public function SetPressedWidget(?pressedWidget:Entity):Void;
    
    #if server
    /**
        Attempts to switch the player weapon to the one specified in the "cl_defaultweapon" convar, if the player does not own the specified weapon nothing will happen. 
		
		If you want to switch to a specific weapon, use: Player:SetActiveWeapon
    **/
    
    public function SwitchToDefaultWeapon():Void;
    #end
    
    /**
        Gets if the player will be pushed out of nocollided players.
		
		`**Returns:** pushed
    **/
    
    public function GetAvoidPlayers():Bool;
    
    
    /**
        Adds an entity to the total count of entities of same class.
		
		Name | Description
		--- | ---
		`str` | Entity type
		`ent` | Entity
    **/
    
    public function AddCount(str:String, ent:Entity):Void;
    
    
    /**
        Returns TOOL table of players current tool, or of the one specified.
		
		Name | Description
		--- | ---
		`mode` | Classname of the tool to retrieve. ( Filename of the tool in gmod_tool/stools/ )
		
		
		`**Returns:** TOOL table, or nil if the table wasn't found or the player doesn't have a tool gun.
    **/
    
    public function GetTool(?mode:String):AnyTable;
    
    
    /**
        Pushes the player away from another player whenever it's inside the other players bounding box.
		
		Name | Description
		--- | ---
		`avoidPlayers` | Avoid or not avoid.
    **/
    
    public function SetAvoidPlayers(avoidPlayers:Bool):Void;
    
    
    /**
        Returns whenever the player is set not to collide with their teammates.
		
		`**Returns:** noCollideWithTeammates
    **/
    
    public function GetNoCollideWithTeammates():Bool;
    
    #if server
    /**
        Sets whether the player's current weapon should drop on death. 
		
		NOTE! This seems to be reset to false when player dies.
		
		Name | Description
		--- | ---
		`drop` | Whether to drop the player's current weapon or not
    **/
    
    public function ShouldDropWeapon(drop:Bool):Void;
    #end
    
    /**
        Sets the player's class id.
		
		Name | Description
		--- | ---
		`classID` | The class id the player is being set with.
    **/
    
    public function SetClassID(classID:Float):Void;
    
    
    /**
        Sets the sequence of the animation playing in the given gesture slot.
		
		Name | Description
		--- | ---
		`slot` | The gesture slot. See GESTURE_SLOT_ Enums
		`sequenceID` | Sequence ID to set.
    **/
    
    public function AnimSetGestureSequence(slot:GESTURE_SLOT, sequenceID:Float):Void;
    
    #if server
    /**
        Performs a trace hull and applies damage to the entities hit, returns the first entity hit.
		
		**Warning:** Hitting the victim entity with this function in ENTITY:OnTakeDamage can cause infinite loops.
		
		Name | Description
		--- | ---
		`startPos` | The start position of the hull trace.
		`endPos` | The end position of the hull trace.
		`mins` | The minimum coordinates of the hull.
		`maxs` | The maximum coordinates of the hull.
		`damage` | The damage to be applied.
		`damageFlags` | Bitflag specifying the damage type, see DMG_ Enums.
		`damageForce` | The force to be applied to the hit object.
		`damageAllNPCs` | Whether to apply damage to all hit NPCs or not.
		
		
		`**Returns:** The hit entity
    **/
    
    public function TraceHullAttack(startPos:Vector, endPos:Vector, mins:Vector, maxs:Vector, damage:Float, damageFlags:DMG, damageForce:Float, damageAllNPCs:Bool):Entity;
    #end
    
    /**
        Returns the player's death count
		
		`**Returns:** The number of deaths the player has had.
		
		___
		### Lua Examples
		#### Example 1
		If the player's deaths are over 10, then they cannot spawn.
		
		```lua 
		function GM:PlayerDeathThink( ply, ent, att )
		
		    if ply:Deaths() >= 10 then
		
		        return false
		
		    end
		
		   return true
		
		end
		```
		**Output:**
		
		The player will not be able to spawn after they've died 10 times.
    **/
    
    public function Deaths():Float;
    
    #if server
    /**
        Removes all ammo from a certain player
		
		___
		### Lua Examples
		#### Example 1
		A console command that removes ammo on the player that used it.
		
		```lua 
		concommand.Add( "removeammo", function( ply )
		    ply:RemoveAllAmmo()
		end )
		```
    **/
    
    public function RemoveAllAmmo():Void;
    #end
    #if server
    /**
        Sets up the players view model hands. Calls GM:PlayerSetHandsModel to set the model of the hands.
		
		Name | Description
		--- | ---
		`ent` | If the player is spectating an entity, this should be the entity the player is spectating, so we can use its hands model instead.
    **/
    
    public function SetupHands(ent:Entity):Void;
    #end
    #if client
    /**
        Returns if the player can be heard by the local player.
		
		`**Returns:** isAudible
    **/
    
    public function IsVoiceAudible():Bool;
    #end
    #if server
    /**
        Removes all weapons and ammo from the player.
    **/
    
    public function RemoveAllItems():Void;
    #end
    
    /**
        Returns the player's user group.
		
		`**Returns:** The user group of the player. This will return "user" if player has no user group.
    **/
    
    public function GetUserGroup():String;
    
    
    /**
        Returns the player's 64bit SteamID aka CommunityID. 
		
		In singleplayer, this will return no value serverside. 
		
		 In a multirun environment, this will return no value serverside for all "copies" of a player. 
		
		 For bots, this will return 90071996842377216 (equivalent to STEAM_0:0:0) for the first bot to join. For each additional bot, the number increases by 1. So the next bot will be 90071996842377217 (STEAM_0:1:0) then 90071996842377218 (STEAM_0:0:1) and so on. 
		
		 On the client it returns no value for bots. 
		
		 Use Player:AccountID for a shorter version of the SteamID.
		
		`**Returns:** Player's 64bit SteamID aka CommunityID.
		
		___
		### Lua Examples
		#### Example 1
		Prints the 64bit SteamID of player
		
		```lua 
		print(ply:SteamID64())
		```
		**Output:**
		
		64bit SteamID (about 20 digits)
    **/
    
    public function SteamID64():String;
    
    
    /**
        Gets the actual view offset which equals the difference between the players actual position and their view when standing. 
		
		Do not confuse with Player:GetViewOffset and Player:GetViewOffsetDucked
		
		`**Returns:** The actual view offset.
    **/
    
    public function GetCurrentViewOffset():Vector;
    
    
    /**
        Returns the entity the player is currently observing. 
		
		Set using Player:SpectateEntity.
		
		`**Returns:** The entity the player is currently spectating, or NULL if the player has no target.
    **/
    
    public function GetObserverTarget():Entity;
    
    #if server
    /**
        Detonates all tripmines belonging to the player.
    **/
    
    public function DetonateTripmines():Void;
    #end
    #if server
    /**
        Enables the sprint on the player.
		
		**Bug:** BUG Not working - use Player:SetRunSpeed or CMoveData:SetMaxSpeed in a GM:Move hook, instead. Issue Tracker: #2390
		
		___
		### Lua Examples
		#### Example 1
		Allows the player with ID 1 to use the sprint (⇧ Shift by default) feature.
		
		```lua 
		player.GetByID( 1 ):SprintEnable()
		```
		**Output:**
		
		None, but Player 1's sprint is enabled.
    **/
    
    public function SprintEnable():Void;
    #end
    
    /**
        Returns the player's active weapon.
		
		`**Returns:** The weapon the player is currently has equipped.
		
		___
		### Lua Examples
		#### Example 1
		Prints the player's active weapon's class name.
		
		```lua 
		print(Entity( 1 ):GetActiveWeapon():GetClass())
		```
		**Output:**
		
		The active weapon's class. For example, if you are holding the tool gun then this will be "gmod_tool".
    **/
    
    public function GetActiveWeapon():Weapon;
    
    
    /**
        Returns the player's name, this is an alias of Player:Nick.
		
		**Note:** This function overrides Entity:GetName (in the Lua metatable, not in c++), keep it in mind when dealing with ents.FindByName or any engine function which requires the mapping name.
		
		**Bug:** BUG This is limited to 31 characters even though Steam names can have 32. Issue Tracker: #3178
		
		`**Returns:** The player's name. BUG This is limited to 31 characters even though Steam names can have 32. Issue Tracker: #3178
		
		___
		### Lua Examples
		#### Example 1
		Prints the player's name
		
		```lua 
		print( Entity(1):GetName() )
		```
		**Output:**
		
		Ninja101
    **/
    
    public function GetName():String;
    
    
    /**
        Sends a third person secondary fire animation event to the player. 
		
		Similar to other animation event functions, calls GM:DoAnimationEvent with PLAYERANIMEVENT_ATTACK_SECONDARY as the event and no extra data.
    **/
    
    public function DoSecondaryAttack():Void;
    
    
    /**
        Returns a table of all ammo the player has.
		
		`**Returns:** number Key: AmmoID to be used with functions like game.GetAmmoName. number Value: Amount of ammo the player has of this kind.
		
		___
		### Lua Examples
		#### Example 1
		Output ammo table of the default Sandbox weapon loadout.
		
		```lua 
		PrintTable(player.GetByID(1):GetAmmo())
		```
		**Output:**
		
		1	=	130
		2	=	6
		3	=	256
		4	=	256
		5	=	32
		6	=	36
		7	=	64
		8	=	3
		10	=	6
    **/
    
    public function GetAmmo():AnyTable;
    
    
    /**
        Restart a gesture on a player, within a gesture slot.
		
		**Warning:** This is not automatically networked. This function has to be called on the client to be seen by said client.
		
		Name | Description
		--- | ---
		`slot` | Gesture slot using GESTURE_SLOT_ Enums
		`activity` | The activity ( see ACT_ Enums ) or sequence that should be played
		`autokill` | Whether the animation should be automatically stopped. true = stops the animation, false = the animation keeps playing/looping
		
		
		___
		### Lua Examples
		#### Example 1
		Defines part of a SWEP with pistol whipping functionality by using a pistol hold type and AnimRestartGesture for the melee attack animation.
		
		```lua 
		function SWEP:Initialize()
		    self:SetHoldType("pistol")
		end
		
		function SWEP:PrimaryAttack()
		
		    -- Weapon attack delay
		    self:SetNextPrimaryFire(CurTime()+0.5)
		
		    -- Get entity in front of us
		    local tr = util.TraceLine(util.GetPlayerTrace(self.Owner))
		    
		    local ent = tr.Entity
		    
		    -- If there's an enemy under 50 units in front of us
		    if(IsValid(ent) && self.Owner:GetShootPos():Distance(tr.HitPos) < 50) then
		    
		        -- Play the melee attack animation
		        self.Owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE, true)
		        
		        -- Create damage info (server-side)
		        if SERVER then
		        
		            local dmg = DamageInfo()        
		            dmg:SetDamage(math.random(5, 10))
		            dmg:SetAttacker(self.Owner)
		            dmg:SetInflictor(self)
		            dmg:SetDamageForce(self.Owner:GetAimVector()*300)
		            dmg:SetDamagePosition(tr.HitPos)
		            dmg:SetDamageType(DMG_CLUB)
		        
		            -- Apply damage to enemy
		            ent:TakeDamageInfo(dmg)
		            
		        end
		        
		        -- Play impact sound
		        ent:EmitSound("physics/flesh/flesh_impact_bullet"..math.random(1, 5)..".wav")
		        
		        -- Make viewmodel pistol whip effect
		        self.Owner:ViewPunch(Angle(0, 45, 0))
		        
		    else
		    
		        -- Typical pistol shot code goes here
		        -- Some can be found in 'weapon_base/shared.lua'
		    
		    end
		    
		end
		```
    **/
    
    public function AnimRestartGesture(slot:GESTURE_SLOT, activity:ACT, ?autokill:Bool):Void;
    
    #if server
    /**
        Kills a player without notifying the rest of the server. 
		
		This will call GM:PlayerSilentDeath instead of GM:PlayerDeath.
		
		___
		### Lua Examples
		#### Example 1
		Silently kills the player.
		
		```lua 
		Player(2):KillSilent()
		```
    **/
    
    public function KillSilent():Void;
    #end
    #if server
    /**
        Plays the correct step sound according to what the player is staying on.
		
		Name | Description
		--- | ---
		`volume` | Volume for the sound, in range from 0 to 1
    **/
    
    public function PlayStepSound(volume:Float):Void;
    #end
    #if server
    /**
        Allows player to use his weapons in a vehicle. You need to call this before entering a vehicle.
		
		**Bug:** BUG Shooting in a vehicle fires two bullets. Issue Tracker: #1277
		
		**Bug:** BUG Weapon viewpunch does not decay while in a vehicle, leading to incorrect aim angles. Issue Tracker: #3261
		
		Name | Description
		--- | ---
		`allow` | Show we allow player to use his weapons in a vehicle or not.
    **/
    
    public function SetAllowWeaponsInVehicle(allow:Bool):Void;
    #end
    
    /**
        Unfreezes the props player is looking at. This is essentially the same as pressing reload with the physics gun, including double press for unfreeze all.
		
		`**Returns:** Number of props unfrozen.
    **/
    
    public function PhysgunUnfreeze():Float;
    
    #if server
    /**
        Returns the number of seconds that the player has been timing out for. You can check if a player is timing out with Player:IsTimingOut.
		
		`**Returns:** Timeout seconds.
    **/
    
    public function GetTimeoutSeconds():Float;
    #end
    #if server
    /**
        Sets whether the player can use the HL2 suit zoom ("+zoom" bind) or not.
		
		Name | Description
		--- | ---
		`canZoom` | Whether to make the player able or unable to zoom.
    **/
    
    public function SetCanZoom(canZoom:Bool):Void;
    #end
    
    /**
        Sets the player's normal walking speed. Not sprinting, not slow walking +walk. 
		
		There currently is no way to modify the slow walking +walk speed. 
		
		 See also Player:GetWalkSpeed, Player:SetCrouchedWalkSpeed, Player:SetMaxSpeed and Player:SetRunSpeed.
		
		**Bug:** BUG Using a speed of 0 can lead to prediction errors. Issue Tracker: #2030
		
		Name | Description
		--- | ---
		`walkSpeed` | The new walk speed when sv_friction is below 10. Higher sv_friction values will result in slower speed. Has to be 7 or above or the player won't be able to move.
    **/
    
    public function SetWalkSpeed(walkSpeed:Float):Void;
    
    
    /**
        Sets the maximum height a player can step onto without jumping.
		
		Name | Description
		--- | ---
		`stepHeight` | The new maximum height the player can step onto without jumping
    **/
    
    public function SetStepSize(stepHeight:Float):Void;
    
    
    /**
        Returns if the player has the specified weapon
		
		Name | Description
		--- | ---
		`className` | Class name of the weapon
		
		
		`**Returns:** True if the player has the weapon
		
		___
		### Lua Examples
		#### Example 1
		prints if the player has the physgun
		
		```lua 
		print(player.GetByID(1):HasWeapon("weapon_physgun"))
		```
		**Output:**
		
		"true" in console, if player 1 has Physics Gun.
    **/
    
    public function HasWeapon(className:String):Bool;
    
    #if client
    /**
        Returns whether or not the player is muted locally.
		
		`**Returns:** whether or not the player is muted locally.
    **/
    
    public function IsMuted():Bool;
    #end
    
    /**
        Returns if the player is an bot or not
		
		`**Returns:** True if the player is a bot.
    **/
    
    public function IsBot():Bool;
    
    #if client
    /**
        Opens the player steam profile page in the steam overlay browser.
    **/
    
    public function ShowProfile():Void;
    #end
    
    /**
        Returns true/false if the player is in specified group or not.
		
		Name | Description
		--- | ---
		`groupname` | Group to check the player for.
		
		
		`**Returns:** isInUserGroup
		
		___
		### Lua Examples
		#### Example 1
		Prints in the players console "yes, I'm awesome!" if he's in the superadmin group.
		
		```lua 
		if ( Player(2):IsUserGroup("superadmin") ) then
		    print("Yes, I'm awesome!")
		end
		```
		**Output:**
		
		"Yes, I'm awesome!" in console.
    **/
    
    public function IsUserGroup(groupname:String):Bool;
    
    
    /**
        Sets the render angles of a player.
		
		Name | Description
		--- | ---
		`ang` | The new render angles to set
    **/
    
    public function SetRenderAngles(ang:Angle):Void;
    
    
    /**
        Returns the maximum height player can step onto.
		
		`**Returns:** The maximum height player can get up onto without jumping, in hammer units.
    **/
    
    public function GetStepSize():Float;
    
    #if client
    /**
        Polls the engine to request if the player should be drawn at the time the function is called.
		
		`**Returns:** shouldDraw
    **/
    
    public function ShouldDrawLocalPlayer():Bool;
    #end
    
    /**
        Returns the entity the player is using to see from (such as the player itself, the camera, or another entity).
		
		`**Returns:** The entity the player is using to see from
		
		___
		### Lua Examples
		#### Example 1
		Will print what entity the first player uses to look through.
		
		```lua 
		print( Entity( 1 ):GetViewEntity() )
		```
		**Output:**
		
		Player [1][ExamplePlayer]
    **/
    
    public function GetViewEntity():Entity;
    
    
    /**
        Sets if the player can toggle his flashlight. Function exists on both the server and client but has no effect when ran on the client.
		
		Name | Description
		--- | ---
		`canFlashlight` | True allows flashlight toggling
    **/
    
    public function AllowFlashlight(canFlashlight:Bool):Void;
    
    
    /**
        Returns whether the players movement is currently frozen, contolled by Player:Freeze.
		
		`**Returns:** Whether the players movement is currently frozen or not.
    **/
    
    public function IsFrozen():Bool;
    
    
    /**
        Sends a third person animation event to the player. 
		
		Calls GM:DoAnimationEvent with PLAYERANIMEVENT_CUSTOM_GESTURE as the event, data as the given data.
		
		Name | Description
		--- | ---
		`data` | The data to send.
    **/
    
    public function DoAnimationEvent(data:Float):Void;
    
    #if server
    /**
        Sets the player armor to the argument.
		
		Name | Description
		--- | ---
		`Amount` | The amount that the player armor is going to be set to.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the player armor to 100 when he types "GiveArmor" at the console.
		
		```lua 
		concommand.Add( "GiveArmor", function( ply )
		 ply:SetArmor( 100 )
		end )
		```
		**Output:**
		
		Sets the player armor to 100
    **/
    
    public function SetArmor(Amount:Float):Void;
    #end
    
    /**
        Set a player's FOV (Field Of View) over a certain amount of time.
		
		Name | Description
		--- | ---
		`fov` | the angle of perception (FOV). Set to 0 to return to default user FOV. ( Which is ranging from 75 to 90, depending on user settings )
		`time` | the time it takes to transition to the FOV expressed in a floating point.
    **/
    
    public function SetFOV(fov:Float, time:Float):Void;
    
    
    /**
        Gets total count of entities of same class.
		
		Name | Description
		--- | ---
		`type` | Entity type to get count of.
		`minus` | If specified, it will reduce the counter by this value. Works only serverside.
    **/
    
    public function GetCount(type:String, ?minus:Float):Void;
    
    
    /**
        Returns the player's sprint speed. 
		
		See also Player:SetRunSpeed, Player:GetWalkSpeed and Player:GetMaxSpeed.
		
		`**Returns:** The sprint speed
		
		___
		### Lua Examples
		#### Example 1
		Prints the players run speed in the code.
		
		```lua 
		print( Entity( 1 ):GetRunSpeed() )
		```
		**Output:**
		
		500
    **/
    
    public function GetRunSpeed():Float;
    
    
    /**
        Returns the weapon for the specified class
		
		Name | Description
		--- | ---
		`className` | Class name of weapon
		
		
		`**Returns:** The weapon for the specified class.
		
		___
		### Lua Examples
		#### Example 1
		Prints the weapon if the player has the toolgun
		
		```lua 
		print( Entity(1):GetWeapon( "gmod_tool" ) )
		```
		**Output:**
		
		Something like "Weapon [77]" in console.
    **/
    
    public function GetWeapon(className:String):Weapon;
    
    
    /**
        Resets the player's view punch ( Player:ViewPunch ) effect back to normal.
		
		Name | Description
		--- | ---
		`tolerance` | Reset all ViewPunch below this threshold.
    **/
    
    public function ViewPunchReset(?tolerance:Float):Void;
    
    
    /**
        ***Deprecated:** You should use Player: GetViewPunchAngles instead.
		
		Returns players screen punch effect angle.
		
		`**Returns:** The punch angle
    **/
    @:deprecated("You should use Player: GetViewPunchAngles instead.")
    public function GetPunchAngle():Angle;
    
    #if server
    /**
        Add a certain amount to the player's death count
		
		Name | Description
		--- | ---
		`count` | number of deaths to add
		
		
		___
		### Lua Examples
		#### Example 1
		Adds 2 deaths to player
		
		```lua 
		Entity( 1 ):AddDeaths( 2 )
		```
		**Output:**
		
		Player1 has 2 extra deaths on the scoreboard relative to his old score.
    **/
    
    public function AddDeaths(count:Float):Void;
    #end
    
    /**
        Starts the player's attack animation. The attack animation is determined by the weapon's HoldType. 
		
		Similar to other animation event functions, calls GM:DoAnimationEvent with PLAYERANIMEVENT_ATTACK_PRIMARY as the event and no extra data.
    **/
    
    public function DoAttackEvent():Void;
    
    
    /**
        Returns whether the player is currently sprinting or not.
		
		`**Returns:** Is the player sprinting or not
    **/
    
    public function IsSprinting():Bool;
    
    
    /**
        Sets how quickly a player ducks.
		
		**Bug:** BUG This will not work for values >= 1. Issue Tracker: #2722
		
		Name | Description
		--- | ---
		`duckSpeed` | How quickly the player will duck.
    **/
    
    public function SetDuckSpeed(duckSpeed:Float):Void;
    
    
    /**
        Returns the packet loss of the client. It is not networked so it only returns 0 when run clientside.
		
		`**Returns:** Packets lost
    **/
    
    public function PacketLoss():Float;
    
    
    /**
        Sets the hands entity of a player. 
		
		The hands entity is an entity introduced in Garry's Mod 13 and it's used to show the player's hands attached to the viewmodel. This is similar to the approach used in L4D and CS:GO, for more information on how to implement this system in your gamemode visit Using Viewmodel Hands.
		
		Name | Description
		--- | ---
		`hands` | The hands entity to set
    **/
    
    public function SetHands(hands:Entity):Void;
    
    #if server
    /**
        Returns if a player is the host of the current session.
		
		`**Returns:** True if the player is the listen server host, false otherwise. This will always be true in single player, and false on a dedicated server.
    **/
    
    public function IsListenServerHost():Bool;
    #end
    
    /**
        Returns the player's ID. You can use Player() to get the player by their ID.
		
		`**Returns:** The player's user ID
    **/
    
    public function UserID():Float;
    
    
    /**
        Returns whether the player is allowed to use his weapons in a vehicle or not.
		
		`**Returns:** Whether the player is allowed to use his weapons in a vehicle or not.
    **/
    
    public function GetAllowWeaponsInVehicle():Bool;
    
    
    /**
        Returns the FOV of the player.
		
		`**Returns:** Field of view as a float
    **/
    
    public function GetFOV():Float;
    
    #if server
    /**
        Prevents a hint from showing up.
		
		**Note:** This function is only available in Sandbox and its derivatives
		
		Name | Description
		--- | ---
		`name` | Hint name/class/index to prevent from showing up
		
		
		___
		### Lua Examples
		#### Example 1
		Removes three default Sandbox hints (taken from the source code of the Sandbox gamemode):
		
		```lua 
		-- Hint type: Show opening menu hint
		-- ... Suppress this hint =>
		ply:SuppressHint( "OpeningMenu" )
		
		-- Hint type: Tell them how to turn the hints off
		-- ... Suppress this hint =>
		ply:SuppressHint( "Annoy1" )
		ply:SuppressHint( "Annoy2" )
		
		-- Other default Hint types : PhysgunFreeze, PhysgunUse, VehicleView ...
		```
    **/
    
    public function SuppressHint(name:String):Void;
    #end
    #if client
    /**
        Returns whenever the player is heard by the local player.
		
		`**Returns:** isSpeaking
    **/
    
    public function IsSpeaking():Bool;
    #end
    
    /**
        Runs the concommand on the player. This does not work on bots. 
		
		If you wish to directly modify the movement input of bots, use GM:StartCommand instead.
		
		**Note:** Some commands/convars are blocked from being ran/changed using this function, usually to prevent harm/annoyance to clients. For a list of blocked commands, see Blocked ConCommands.
		
		Name | Description
		--- | ---
		`command` | command to run
		
		
		___
		### Lua Examples
		#### Example 1
		Kills the player using the concommand
		
		```lua 
		Entity( 1 ):ConCommand("kill")
		```
		**Output:**
		
		The Player1 dies.
    **/
    
    public function ConCommand(command:String):Void;
    
    
    /**
        Returns the view offset of the player which equals the difference between the players actual position and their view when ducked. 
		
		See also Player:GetViewOffset.
		
		`**Returns:** New crouching view offset, must be local vector to players Entity: GetPos
    **/
    
    public function GetViewOffsetDucked():Vector;
    
    #if server
    /**
        Returns the preferred carry angles of an object, if any are set. 
		
		Calls GM:GetPreferredCarryAngles with the target entity and returns the carry angles.
		
		Name | Description
		--- | ---
		`carryEnt` | Entity to retrieve the carry angles of.
		
		
		`**Returns:** Carry angles or nil if the entity has no preferred carry angles.
    **/
    
    public function GetPreferredCarryAngles(carryEnt:Entity):Angle;
    #end
    #if server
    /**
        Sets a player's frags (kills)
		
		Name | Description
		--- | ---
		`fragcount` | Number of frags (positive or negative)
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the frags of player 1 to 9001
		
		```lua 
		player.GetByID( 1 ):SetFrags( 9001 )
		```
    **/
    
    public function SetFrags(fragcount:Float):Void;
    #end
    
    /**
        Returns a 32 bit integer that remains constant for a player across joins/leaves and across different servers. This can be used when a string is inappropriate - e.g. in a database primary key.
		
		**Warning:** This function has collisions, where more than one player has the same UniqueID. It is highly recommended to use Player:AccountID, Player:SteamID or Player:SteamID64 instead, which are guaranteed to be unique to each player.
		
		**Note:** In Singleplayer, this function will always return 1.
		
		`**Returns:** The player's Unique ID
		
		___
		### Lua Examples
		#### Example 1
		Gets the Unique ID of a player.
		
		```lua 
		Entity( 1 ):UniqueID()
		```
		**Output:**
		
		Something like 1592073762
		
		#### Example 2
		Functional equivalent of this function.
		
		```lua 
		local ply = Entity( 1 )
		local uniqueid = util.CRC( "gm_" .. ply:SteamID() .. "_gm" )
		print( uniqueid )
		```
		**Output:**
		
		Something like 1592073762
    **/
    
    public function UniqueID():Float;
    
    
    /**
        Returns the widget the player is hovering with his mouse.
		
		`**Returns:** The hovered widget.
    **/
    
    public function GetHoveredWidget():Entity;
    
    
    /**
        ***Deprecated:** This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.
		
		Doesn't appear to do anything.
		
		___
		### Lua Examples
		#### Example 1
		An example alternative to this function.
		
		```lua 
		local vDelay = 0
		local prevDown = 0
		hook.Add( "StartCommand", "TestFunc", function( ply, cmd )
		    if ( cmd:KeyDown( IN_FORWARD ) and prevDown == false ) then
		        vDelay = CurTime() + 0.4
		    elseif ( cmd:KeyDown( IN_FORWARD ) ) then
		        if ( vDelay < CurTime() )then
		            cmd:SetButtons( bit.bor( cmd:GetButtons(), IN_SPEED ) )
		        end
		    end
		    prevDown = cmd:KeyDown(IN_FORWARD)
		end )
		```
    **/
    @:deprecated("This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.")
    public function StartSprinting():Void;
    
    
    /**
        Returns the player's ping to server.
		
		`**Returns:** The player's ping.
    **/
    
    public function Ping():Float;
    
    #if server
    /**
        Attaches the players view to the position and angles of the specified entity.
		
		Name | Description
		--- | ---
		`viewEntity` | The entity to attach the player view to.
    **/
    
    public function SetViewEntity(viewEntity:Entity):Void;
    #end
    
    /**
        Returns the widget entity the player is using. 
		
		Having a pressed widget stops the player from firing his weapon to allow input to be passed onto the widget.
		
		`**Returns:** The pressed widget.
    **/
    
    public function GetPressedWidget():Entity;
    
    
    /**
        Used to find out if a player is currently 'driving' an entity (by which we mean 'right click > drive' ).
		
		`**Returns:** A value representing whether or not the player is 'driving' an entity.
		
		___
		### Lua Examples
		#### Example 1
		Kills every player currently 'driving' an entity.
		
		```lua 
		local plys = player.GetAll()
		for _, ply in pairs( plys ) do
		    
		    if ( ply:IsDrivingEntity() ) then
		        ply:Kill()
		    end
		    
		end
		```
		**Output:**
		
		Every player 'driving' an entity will die a painful death.
    **/
    
    public function IsDrivingEntity():Bool;
    
    
    /**
        Returns the player's nickname.
		
		**Bug:** BUG This is limited to 31 characters even though Steam names can have 32. Issue Tracker: #3178
		
		`**Returns:** Player's Steam name BUG This is limited to 31 characters even though Steam names can have 32. Issue Tracker: #3178
		
		___
		### Lua Examples
		#### Example 1
		Prints the player's nickname
		
		```lua 
		print( Entity(1):Nick() )
		```
		**Output:**
		
		Ninja101
    **/
    
    public function Nick():String;
    
    
    /**
        Fades the screen
		
		Name | Description
		--- | ---
		`flags` | Fade flags defined with SCREENFADE_ Enums.
		`clr` | The color of the screenfade
		`fadeTime` | Fade(in/out) effect transition time ( From no fade to full fade and vice versa )
		`fadeHold` | Fade effect hold time
		
		
		___
		### Lua Examples
		#### Example 1
		Flashes the screen red to nothing over 0.3 seconds when a player gets hurt.
		
		```lua 
		hook.Add( "PlayerHurt", "hurt_effect_fade", function( ply )
		    ply:ScreenFade( SCREENFADE.IN, Color( 255, 0, 0, 128 ), 0.3, 0 )
		end )
		```
    **/
    
    public function ScreenFade(flags:SCREENFADE, ?clr:Float, fadeTime:Float, fadeHold:Float):Void;
    
    
    /**
        Sets the desired view offset which equals the difference between the players actual position and their view when crouching. 
		
		If you want to set actual view offset, use Player:SetCurrentViewOffset 
		
		 See also Player:SetViewOffset for desired view offset when standing.
		
		Name | Description
		--- | ---
		`viewOffset` | The new desired view offset when crouching.
    **/
    
    public function SetViewOffsetDucked(viewOffset:Vector):Void;
    
    #if server
    /**
        Disables the sprint on the player.
		
		**Bug:** BUG Not working - use Player:SetRunSpeed or CMoveData:SetMaxSpeed in a GM:Move hook, instead. Issue Tracker: #2390
		
		___
		### Lua Examples
		#### Example 1
		Stops and prevents player with ID 1 from sprinting
		
		```lua 
		player.GetByID( 1 ):SprintDisable()
		```
		**Output:**
		
		None, but Player 1's sprint is disabled.
    **/
    
    public function SprintDisable():Void;
    #end
    
    /**
        Returns the player's armor.
		
		`**Returns:** The player's armor.
		
		___
		### Lua Examples
		#### Example 1
		Loops through all the players and checks if they have any armor, if they do not, then sets their armor to 100.
		
		```lua 
		for _, v in pairs( player.GetAll( ) ) do
		    if v:Armor( ) == 0 then
		         v:SetArmor( 100 )
		    end
		end
		```
    **/
    
    public function Armor():Float;
    
    
    /**
        Returns the player's AccountID aka SteamID3. 
		
		For bots and in singleplayer, this will return no value.
		
		`**Returns:** Player's SteamID3 aka AccountID.
    **/
    
    public function AccountID():Float;
    
    
    /**
        Returns whenever the player is equipped with the suit item.
		
		**Bug:** BUG This will only work for the local player when used clientside. Issue Tracker: #3449
		
		`**Returns:** Is the suit equipped or not.
    **/
    
    public function IsSuitEquipped():Bool;
    
    
    /**
        Sets the crouched walk speed multiplier. 
		
		Doesn't work for values above 1. 
		
		 See also Player:SetWalkSpeed and Player:GetCrouchedWalkSpeed.
		
		Name | Description
		--- | ---
		`speed` | The walk speed multiplier that crouch speed should be.
		
		
		___
		### Lua Examples
		#### Example 1
		Set the crouch speed to be as fast as the players walk speed.
		
		```lua 
		Entity(1):SetCrouchedWalkSpeed( 1 )
		```
		**Output:**
		
		The player will crouch-walk as fast as normal walking.
    **/
    
    public function SetCrouchedWalkSpeed(speed:Float):Void;
    
    #if server
    /**
        Removes the specified weapon class from a certain player
		
		Name | Description
		--- | ---
		`weapon` | The weapon class to remove
		
		
		___
		### Lua Examples
		#### Example 1
		Removes the crowbar from the player with the ID 1
		
		```lua 
		player.GetByID( 1 ):StripWeapon("weapon_crowbar")
		```
		**Output:**
		
		Crowbar removed from player 1
    **/
    
    public function StripWeapon(weapon:String):Void;
    #end
    #if server
    /**
        Drops the players' weapon of a specific class.
		
		Name | Description
		--- | ---
		`class` | The class to drop.
		`target` | If set, launches the weapon at given position. There is a limit to how far it is willing to throw the weapon. Overrides velocity argument.
		`velocity` | If set and previous argument is unset, launches the weapon with given velocity. If the velocity is higher than 400, it will be clamped to 400.
    **/
    
    public function DropNamedWeapon(_class:String, ?target:Vector, ?velocity:Vector):Void;
    #end
    
    /**
        Returns whether the player has god mode or not, contolled by Player:GodEnable and Player:GodDisable.
		
		**Bug:** BUG This is not synced between the client and server. This will cause the client to always return false even in godmode. Issue Tracker: #2038
		
		`**Returns:** Whether the player has god mode or not.
    **/
    
    public function HasGodMode():Bool;
    
    
    /**
        Sets the actual view offset which equals the difference between the players actual position and their view when standing. 
		
		Do not confuse with Player:SetViewOffset and Player:SetViewOffsetDucked
		
		Name | Description
		--- | ---
		`viewOffset` | The new view offset.
    **/
    
    public function SetCurrentViewOffset(viewOffset:Vector):Void;
    
    
    /**
        Checks if the player is alive.
		
		`**Returns:** Whether the player is alive
		
		___
		### Lua Examples
		#### Example 1
		Loops through all the players and kills alive ones.
		
		```lua 
		for k, v in pairs( player.GetAll() ) do
		   if ( v:Alive() ) then
		      v:Kill()
		   end
		end
		```
    **/
    
    public function Alive():Bool;
    
    
    /**
        Returns if the player is in a vehicle
		
		`**Returns:** Whether the player is in a vehicle.
    **/
    
    public function InVehicle():Bool;
    
    
    /**
        Returns a Player Data key-value pair from the SQL database. (sv.db when called on server, cl.db when called on client) 
		
		Internally uses the sql library.
		
		**Warning:** This function internally uses Player:UniqueID, which can cause collisions (two or more players sharing the same PData entry). It's recommended that you don't use it. See the related wiki page for more information.
		
		**Note:** PData is not networked from servers to clients!
		
		Name | Description
		--- | ---
		`key` | Name of the PData key
		`default` | Default value if PData key doesn't exist.
		
		
		`**Returns:** The data in the SQL database or the default value given.
		
		___
		### Lua Examples
		#### Example 1
		Reads the key "money" from player 1's PData
		
		```lua 
		player.GetByID( 1 ):GetPData( "money", 0 )
		```
    **/
    
    public function GetPData(key:String, ?_default:Dynamic):String;
    
    
    /**
        Removes a Player Data key-value pair from the SQL database. (sv.db when called on server, cl.db when called on client) 
		
		Internally uses the sql library.
		
		**Warning:** This function internally uses Player:UniqueID, which can cause collisions (two or more players sharing the same PData entry). It's recommended that you don't use it. See the related wiki page for more information.
		
		Name | Description
		--- | ---
		`key` | Key to remove
		
		
		`**Returns:** true is succeeded, false otherwise
		
		___
		### Lua Examples
		#### Example 1
		Deletes the key "money" from player 1
		
		```lua 
		player.GetByID( 1 ):RemovePData( "money" )
		```
    **/
    
    public function RemovePData(key:String):Bool;
    
    
    /**
        Returns the the observer mode of the player
		
		`**Returns:** Observe mode of that player, see OBS_MODE_ Enums.
    **/
    
    public function GetObserverMode():OBS_MODE;
    
    #if server
    /**
        Sets the player's active weapon. You should use CUserCmd:SelectWeapon or Player:SelectWeapon, instead in most cases.
		
		**Note:** This function will not trigger the weapon switch event or associated equip animations. You can achieve this using Player:SelectWeapon with Entity:GetClass.
		
		**Note:** This will not call GM:PlayerSwitchWeapon.
		
		Name | Description
		--- | ---
		`weapon` | The weapon to equip.
    **/
    
    public function SetActiveWeapon(weapon:Weapon):Void;
    #end
    #if server
    /**
        Enables the player's crosshair, if it was previously disabled via Player:CrosshairDisable.
		
		___
		### Lua Examples
		#### Example 1
		Enables crosshair of the first player on the server, if it was disabled.
		
		```lua 
		Entity( 1 ):CrosshairEnable()
		```
    **/
    
    public function CrosshairEnable():Void;
    #end
    
    /**
        Returns the player's team ID. 
		
		Returns 0 clientside when the game is not fully loaded.
		
		`**Returns:** The player's team's index number, as in the TEAM_ Enums or a custom team defined in team. SetUp.
		
		___
		### Lua Examples
		#### Example 1
		Prints the name of the player's team
		
		```lua 
		print(team.GetName( Entity( 1 ):Team() ) )
		```
		**Output:**
		
		Something like "Unassigned" in console.
    **/
    
    public function Team():TEAM;
    
    
    /**
        Set if the player should be allowed to walk using the (default) alt key.
		
		Name | Description
		--- | ---
		`abletowalk` | True allows the player to walk.
    **/
    
    public function SetCanWalk(abletowalk:Bool):Void;
    
    
    /**
        Returns the direction that the player is aiming.
		
		`**Returns:** The direction vector of players aim
		
		___
		### Lua Examples
		#### Example 1
		Launches the player in the direction they're facing.
		
		```lua 
		local ply = Entity( 1 )
		ply:SetVelocity( ply:GetAimVector() * 1000 )
		```
    **/
    
    public function GetAimVector():Vector;
    
    
    /**
        Returns the view offset of the player which equals the difference between the players actual position and their view. 
		
		See also Player:GetViewOffsetDucked.
		
		`**Returns:** New view offset, must be local vector to players Entity: GetPos
    **/
    
    public function GetViewOffset():Vector;
    
    #if server
    /**
        Returns whether the player identity was confirmed by the steam network.
		
		`**Returns:** Whether the player has been fully authenticated or not. This will always be true for singleplayer and the listen server host. This will always be false for bots.
    **/
    
    public function IsFullyAuthenticated():Bool;
    #end
    
    /**
        ***Deprecated:** This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.
		
		When used in a GM:SetupMove hook, this function will force the player to walk, as well as preventing the player from sprinting.
		
		___
		### Lua Examples
		#### Example 1
		Example usage, forces the player to walk. (+walk console command)
		
		```lua 
		hook.Add( "SetupMove", "TestFunc", function( ply, mv, cmd )
		    ply:StartWalking()
		end )
		```
    **/
    @:deprecated("This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.")
    public function StartWalking():Void;
    
    #if server
    /**
        Forces the player to say whatever the first argument is. Works on bots too.
		
		**Note:** This function ignores the default chat message cooldown
		
		Name | Description
		--- | ---
		`text` | The text to force the player to say.
		`teamOnly` | Whether to send this message to our own team only.
    **/
    
    public function Say(text:String, ?teamOnly:Bool):Void;
    #end
    
    /**
        Returns the crouched walk speed multiplier. 
		
		See also Player:GetWalkSpeed and Player:SetCrouchedWalkSpeed.
		
		`**Returns:** The crouched walk speed multiplier.
    **/
    
    public function GetCrouchedWalkSpeed():Float;
    
    #if server
    /**
        Returns the time in seconds since the player connected.
		
		`**Returns:** connectTime
    **/
    
    public function TimeConnected():Float;
    #end
    
    /**
        Returns the entity the player is currently using, like func_tank mounted turrets or +use prop pickups.
		
		`**Returns:** Entity in use, or NULL entity otherwise. For +use prop pickups, this will be NULL clientside.
    **/
    
    public function GetEntityInUse():Entity;
    
    
    /**
        Sets the widget that is currently hovered by the player's mouse.
		
		Name | Description
		--- | ---
		`widget` | The widget entity that the player is hovering.
    **/
    
    public function SetHoveredWidget(?widget:Entity):Void;
    
    
    /**
        Sets the amount of the specified ammo for the player.
		
		Name | Description
		--- | ---
		`ammoCount` | The amount of ammunition to set.
		`ammoType` | The ammunition type. Can be either number ammo ID or string ammo name.
    **/
    
    public function SetAmmo(ammoCount:Float, ammoType:Dynamic):Void;
    
    #if server
    /**
        Bans the player from the server for a certain amount of minutes.
		
		Name | Description
		--- | ---
		`minutes` | Duration of the ban in minutes (0 is permanent)
		`kick` | Whether to kick the player after banning them or not
		
		
		___
		### Lua Examples
		#### Example 1
		Kicks and bans the player for a day.
		
		```lua 
		Entity(1):Ban( 1440, true )
		```
    **/
    
    public function Ban(minutes:Float, ?kick:Bool):Void;
    #end
    
    /**
        Determines whenever the player is allowed to use the zoom functionality.
		
		`**Returns:** canZoom
    **/
    
    public function GetCanZoom():Bool;
    
    
    /**
        Returns true if the player is playing a taunt.
		
		`**Returns:** Whether the player is playing a taunt.
    **/
    
    public function IsPlayingTaunt():Bool;
    
    #if server
    /**
        Add a certain amount to the player's frag count (or kills count)
		
		Name | Description
		--- | ---
		`count` | number of frags to add
		
		
		___
		### Lua Examples
		#### Example 1
		Adds 2 frags to player
		
		```lua 
		Entity( 1 ):AddFrags( 2 )
		```
		**Output:**
		
		Player1 has 2 extra frags on the scoreboard relative to his old score.
    **/
    
    public function AddFrags(count:Float):Void;
    #end
    
    /**
        Sets the player weapon's color. The part of the model that is colored is determined by the model itself, and is different for each model.
		
		Name | Description
		--- | ---
		`Color` | This is the color to be set. The format is Vector(r,g,b), and each color should be between 0 and 1.
		
		
		___
		### Lua Examples
		#### Example 1
		When a player spawns their weapon's color will be red.
		
		```lua 
		function GM:PlayerSpawn( ply )
		 ply:SetWeaponColor( Vector(1,0,0) )
		end
		```
    **/
    
    public function SetWeaponColor(Color:Vector):Void;
    
    
    /**
        Gets the bottom base and the top base size of the player's hull.
		
		Name | Description
		--- | ---
		`a` | Player's hull bottom base size
		`b` | Player's hull top base size
		
		
		___
		### Lua Examples
		#### Example 1
		Prints bases' size of the hull of all players.
		
		```lua 
		for k,v in pairs(player.GetAll()) do
		
		    local bottom, top = v:GetHull()
		
		    print(bottom)
		
		    print(top)
		
		end
		```
		**Output:**
		
		-16.000000 -16.000000 0.000000 16.000000 16.000000 72.000000
    **/
    
    public function GetHull():PlayerGetHullReturn;
    
    
    /**
        Returns the player's normal walking speed. Not sprinting, not slow walking. (+walk) 
		
		See also Player:SetWalkSpeed, Player:GetMaxSpeed and Player:GetRunSpeed.
		
		`**Returns:** The normal walking speed.
		
		___
		### Lua Examples
		#### Example 1
		Gets player 1's walk speed, and prints it to console
		
		```lua 
		print( Entity( 1 ):GetWalkSpeed() )
		```
		**Output:**
		
		200 in console by default
    **/
    
    public function GetWalkSpeed():Float;
    
    #if server
    /**
        Disables the default player's crosshair. Can be reenabled with Player:CrosshairEnable. This will affect WEAPON:DoDrawCrosshair.
		
		___
		### Lua Examples
		#### Example 1
		Disables crosshair of the first player on the server.
		
		```lua 
		Entity( 1 ):CrosshairDisable()
		```
    **/
    
    public function CrosshairDisable():Void;
    #end
    #if server
    /**
        Forces the player to drop the specified weapon
		
		Name | Description
		--- | ---
		`weapon` | Weapon to be dropped. If unset, will default to the currently equipped weapon.
		`target` | If set, launches the weapon at given position. There is a limit to how far it is willing to throw the weapon. Overrides velocity argument.
		`velocity` | If set and previous argument is unset, launches the weapon with given velocity. If the velocity is higher than 400, it will be clamped to 400.
		
		
		___
		### Lua Examples
		#### Example 1
		A console command that drops all the player's weapons
		
		```lua 
		concommand.Add( "drop_weapons", function( ply )
		    if ( !IsValid( ply ) ) then return end
		
		    -- Loop through all player weapons and drop them
		    for k, v in pairs( ply:GetWeapons() ) do
		        ply:DropWeapon( v )
		    end
		end )
		```
		
		#### Example 2
		A console command that drops only the currently equipped weapon
		
		```lua 
		concommand.Add( "drop_weapon", function( ply )
		    if ( !IsValid( ply ) ) then return end
		
		    -- Dtop the currently equipped weapon
		    ply:DropWeapon( ply:GetActiveWeapon() )
		end )
		```
    **/
    
    public function DropWeapon(?weapon:Weapon, ?target:Vector, ?velocity:Vector):Void;
    #end
    
    /**
        Returns true if the player is able to walk using the (default) alt key.
		
		`**Returns:** AbleToWalk
    **/
    
    public function GetCanWalk():Bool;
    
    #if server
    /**
        Lets the player spray his decal without delay
		
		Name | Description
		--- | ---
		`allow` | Allow or disallow
    **/
    
    public function AllowImmediateDecalPainting(allow:Bool):Void;
    #end
    #if server
    /**
        Slows down the player movement simulation by the timescale, this is used internally in the HL2 weapon stripping sequence. 
		
		It achieves such behavior by multiplying the FrameTime by the specified timescale at the start of the movement simulation and then restoring it afterwards.
		
		**Note:** This is reset to 1 on spawn
		
		**Note:** There is no weapon counterpart to this, you'll have to hardcode the multiplier in the weapon or call Weapon:SetNextPrimaryFire / Weapon:SetNextSecondaryFire manually from a Predicted Hook
		
		Name | Description
		--- | ---
		`timescale` | The timescale multiplier.
    **/
    
    public function SetLaggedMovementValue(timescale:Float):Void;
    #end
    
    /**
        Gets the vehicle the player is driving, returns NULL ENTITY if the player is not driving.
		
		`**Returns:** vehicle
    **/
    
    public function GetVehicle():Vehicle;
    
    #if server
    /**
        Starts spectate mode for given player. This will also affect the players movetype in some cases.
		
		Name | Description
		--- | ---
		`mode` | Spectate mode, see OBS_MODE_ Enums.
    **/
    
    public function Spectate(mode:OBS_MODE):Void;
    #end
    
    /**
        Set if the players' model is allowed to rotate around the pitch and roll axis.
		
		Name | Description
		--- | ---
		`Allowed` | Allowed to rotate
    **/
    
    public function SetAllowFullRotation(Allowed:Bool):Void;
    
    #if server
    /**
        Executes a simple Lua string on the player. 
		
		Note: The string is limited to 254 bytes. Consider using the net library for more advanced server-client interaction.
		
		Name | Description
		--- | ---
		`script` | The script to execute.
		
		
		___
		### Lua Examples
		#### Example 1
		Sends "Hello World" to the client's console.
		
		```lua 
		local pl = Entity( 1 )
		pl:SendLua( "print( 'Hello World' )" )
		```
    **/
    
    public function SendLua(script:String):Void;
    #end
    #if server
    /**
        Gives the player a weapon.
		
		**Note:** While this function is meant for weapons/pickupables only, it is not restricted to weapons. Any entity can be spawned using this function, including NPCs and SENTs.
		
		Name | Description
		--- | ---
		`weaponClassName` | Class name of weapon to give the player
		`bNoAmmo` | Set to true to not give any ammo on weapon spawn. (Reserve ammo set by DefaultClip)
		
		
		`**Returns:** The weapon given to the player, if one was given. It will return NULL if the player already has the weapon, or the weapon entity (entity with given classname) doesn't exist.
		
		___
		### Lua Examples
		#### Example 1
		Gives the player a toolgun
		
		```lua 
		Entity( 1 ):Give( "gmod_tool" )
		```
		
		#### Example 2
		Removes all weapons and ammo from a player and gives a weapon_base SWEP with no ammo in it.
		
		```lua 
		Entity( 1 ):StripWeapons()
		Entity( 1 ):StripAmmo()
		
		local w = Entity( 1 ):Give( "weapon_base", true )
		```
    **/
    
    public function Give(weaponClassName:String, ?bNoAmmo:Bool):Weapon;
    #end
    
    /**
        Returns players screen punch effect angle.
		
		`**Returns:** The punch angle
    **/
    
    public function GetViewPunchAngles():Angle;
    
    #if server
    /**
        Removes all ammo from the player.
    **/
    
    public function StripAmmo():Void;
    #end
    
    /**
        Simulates a push on the client's screen.
		
		Name | Description
		--- | ---
		`PunchAngle` | The angle in which to push the player's screen.
		
		
		___
		### Lua Examples
		#### Example 1
		Knocks the player's camera upward
		
		```lua 
		player:ViewPunch(Angle(-10, 0, 0))
		```
    **/
    
    public function ViewPunch(PunchAngle:Angle):Void;
    
    
    /**
        Displays a message either in their chat, console, or center of the screen. See also PrintMessage.
		
		**Note:** When called serverside, this uses the archaic user message system (the umsg library) and hence is limited to ≈250 characters.
		
		**Note:** HUD_PRINTCENTER will not work when this is called clientside.
		
		Name | Description
		--- | ---
		`type` | Which type of message should be sent to the player ( HUD_ Enums)
		`message` | Message to be sent to the player
		
		
		___
		### Lua Examples
		#### Example 1
		Prints into the first players chat: "I'm new here."
		
		```lua 
		Entity(1):PrintMessage(HUD_PRINTTALK, "I'm new here.")
		```
		**Output:**
		
		I'm new here.
    **/
    
    public function PrintMessage(type:HUD, message:String):Void;
    
    
    /**
        Resets both normal and duck hulls to their default values.
    **/
    
    public function ResetHull():Void;
    
    #if server
    /**
        Stops a player from using any inputs, such as moving, turning, or attacking. Key binds are still called. Similar to Player:Freeze but the player takes no damage. 
		
		Adds the FL_FROZEN and FL_GODMODE flags to the player.
		
		**Bug:** BUG Frozen bots will still be able to look around.
    **/
    
    public function Lock():Void;
    #end
    #if server
    /**
        Signals the entity that it was picked up by the gravity gun. This call is only required if you want to simulate the situation of picking up objects.
		
		Name | Description
		--- | ---
		`ent` | The entity picked up
    **/
    
    public function SimulateGravGunPickup(ent:Entity):Void;
    #end
    #if server
    /**
        Sets the usergroup of the player.
		
		Name | Description
		--- | ---
		`groupName` | The user group of the player.
		
		
		___
		### Lua Examples
		#### Example 1
		Make the player superadmin and print their group.
		
		```lua 
		Entity(1):SetUserGroup("superadmin")
		print(Entity(1):GetUserGroup())
		```
    **/
    
    public function SetUserGroup(groupName:String):Void;
    #end
    
    /**
        Unfreezes all objects the player has frozen with their Physics Gun. Same as double pressing R while holding Physics Gun.
    **/
    
    public function UnfreezePhysicsObjects():Void;
    
    
    /**
        Returns whether the player is a superadmin.
		
		`**Returns:** True if the player is a superadmin.
    **/
    
    public function IsSuperAdmin():Bool;
    
    
    /**
        Returns the render angles for the player.
		
		`**Returns:** The render angles of the player. Only yaw part of the angle seems to be present.
    **/
    
    public function GetRenderAngles():Angle;
    
    #if server
    /**
        Makes a player spray their decal.
		
		Name | Description
		--- | ---
		`sprayOrigin` | The location to spray from
		`sprayEndPos` | The location to spray to
		
		
		___
		### Lua Examples
		#### Example 1
		Makes the player spray their decal 5000 units away.
		
		```lua 
		ply:SprayDecal(ply:EyePos(),ply:EyePos() + ply:GetAimVector()*5000)
		```
    **/
    
    public function SprayDecal(sprayOrigin:Vector, sprayEndPos:Vector):Void;
    #end
    #if server
    /**
        Enables god mode on the player.
		
		___
		### Lua Examples
		#### Example 1
		Enable god mode on all players
		
		```lua 
		for k, v in pairs(player.GetAll()) do
		    v:GodEnable()
		end
		```
    **/
    
    public function GodEnable():Void;
    #end
    
    /**
        Returns players death ragdoll. The ragdoll is created by Player:CreateRagdoll.
		
		`**Returns:** The ragdoll. Unlike normal clientside ragdolls (C_ClientRagdoll), this will be a C_HL2MPRagdoll on the client, and hl2mp_ragdoll on the server.
    **/
    
    public function GetRagdollEntity():Entity;
    
    
    /**
        Removes the amount of the specified ammo from the player.
		
		Name | Description
		--- | ---
		`ammoCount` | The amount of ammunition to remove.
		`ammoName` | The name of the ammunition to remove from. This can also be a number ammoID.
    **/
    
    public function RemoveAmmo(ammoCount:Float, ammoName:String):Void;
    
    
    /**
        Sets the maximum speed which the player can move at.
		
		**Note:** This is called automatically by the engine. If you wish to limit player speed without setting their run/sprint speeds, see CMoveData:SetMaxClientSpeed.
		
		Name | Description
		--- | ---
		`walkSpeed` | The maximum speed.
    **/
    
    public function SetMaxSpeed(walkSpeed:Float):Void;
    
    #if server
    /**
        Show/Hide the player's weapon's worldmodel.
		
		Name | Description
		--- | ---
		`draw` | Should draw
    **/
    
    public function DrawWorldModel(draw:Bool):Void;
    #end
    
    /**
        Checks if the limit is hit or not. If it is, it will throw a notification saying so.
		
		Name | Description
		--- | ---
		`limitType` | Limit type. In unmodified Sandbox possible values are: "props" "ragdolls" "vehicles" "effects" "balloons" "cameras" "npcs" "sents" "dynamite" "lamps" "lights" "wheels" "thrusters" "hoverballs" "buttons" "emitters"
		
		
		`**Returns:** Returns true if limit is not hit, false if it is hit
    **/
    
    public function CheckLimit(limitType:String):Bool;
    
    
    /**
        Returns the amount of kills a player has.
		
		`**Returns:** kills
		
		___
		### Lua Examples
		#### Example 1
		Prints the players frags in console.
		
		```lua 
		print(Entity( 1 ):Frags())
		```
    **/
    
    public function Frags():Float;
    
    #if server
    /**
        Unlocks the player movement if locked previously. Will disable godmode for the player if locked previously.
    **/
    
    public function UnLock():Void;
    #end
    
    /**
        Returns a player model's color. The part of the model that is colored is determined by the model itself, and is different for each model. The format is Vector(r,g,b), and each color should be between 0 and 1.
		
		`**Returns:** color
		
		___
		### Lua Examples
		#### Example 1
		Gets player 1's model color, and prints it to console
		
		```lua 
		print( player.GetByID( 1 ):GetPlayerColor() )
		```
		**Output:**
		
		Vector( 1, 1, 1 )
    **/
    
    public function GetPlayerColor():Vector;
    
    
    /**
        Sets the desired view offset which equals the difference between the players actual position and their view when standing. 
		
		If you want to set actual view offset, use Player:SetCurrentViewOffset 
		
		 See also Player:SetViewOffsetDucked for desired view offset when crouching.
		
		Name | Description
		--- | ---
		`viewOffset` | The new desired view offset when standing.
    **/
    
    public function SetViewOffset(viewOffset:Vector):Void;
    
    
    /**
        Sends a specified third person animation event to the player. 
		
		Calls GM:DoAnimationEvent with specified arguments.
		
		Name | Description
		--- | ---
		`event` | The event to send. See PLAYERANIMEVENT_ Enums.
		`data` | The data to send alongside the event.
    **/
    
    public function DoCustomAnimEvent(event:PLAYERANIMEVENT, data:Float):Void;
    
    #if client
    /**
        Returns the players voice volume, how loud the player's voice communication currently is, as a normal number. Doesn't work on local player unless the voice_loopback convar is set to 1.
		
		`**Returns:** The voice volume.
    **/
    
    public function VoiceVolume():Float;
    #end
    
    /**
        Sets the jump power, eg. the velocity the player will applied to when he jumps.
		
		Name | Description
		--- | ---
		`jumpPower` | The new jump velocity.
    **/
    
    public function SetJumpPower(jumpPower:Float):Void;
    
    
    /**
        Sets whenever to suppress the pickup notification for the player.
		
		Name | Description
		--- | ---
		`doSuppress` | Whenever to suppress the notice or not.
    **/
    
    public function SetSuppressPickupNotices(doSuppress:Bool):Void;
    
    #if server
    /**
        Enters the player into specified vehicle
		
		Name | Description
		--- | ---
		`vehicle` | Vehicle the player will enter
		
		
		___
		### Lua Examples
		#### Example 1
		Enters the player into the vehicle they're looking at
		
		```lua 
		local jeep = Entity( 1 ):GetEyeTrace().Entity
		Entity( 1 ):EnterVehicle(jeep)
		```
    **/
    
    public function EnterVehicle(vehicle:Vehicle):Void;
    #end
    #if server
    /**
        Prints the players' name and position to the console.
    **/
    
    public function DebugInfo():Void;
    #end
    #if server
    /**
        Enables/Disables the player's flashlight
		
		Name | Description
		--- | ---
		`isOn` | Turns the flashlight on/off
		
		
		___
		### Lua Examples
		#### Example 1
		Turns off and disables the player's flashlight
		
		```lua 
		Entity( 1 ):Flashlight(false)
		Entity( 1 ):AllowFlashlight(false)
		```
    **/
    
    public function Flashlight(isOn:Bool):Void;
    #end
    #if server
    /**
        Returns true if the player is timing out (i.e. is losing connection), false otherwise.
		
		`**Returns:** isTimingOut
    **/
    
    public function IsTimingOut():Bool;
    #end
    #if server
    /**
        This makes the player hold ( same as pressing E on a small prop ) the provided entity.
		
		**Note:** Don't get this confused with picking up items like ammo or health kits
		
		**Note:** This picks up the passed entity regardless of its mass or distance from the player
		
		Name | Description
		--- | ---
		`entity` | Entity to pick up.
		
		
		___
		### Lua Examples
		#### Example 1
		An extra function to make sure the object isn't held before being picked up.
		
		```lua 
		function PlayerPickupObject(ply, obj)
		    if ( obj:IsPlayerHolding() ) then return end
		    ply:PickupObject( obj )
		end
		```
    **/
    
    public function PickupObject(entity:Entity):Void;
    #end
    
    /**
        Returns driving mode of the player. See Entity Driving.
		
		`**Returns:** The drive mode ID or 0 if player doesn't use the drive system.
    **/
    
    public function GetDrivingMode():Float;
    
    
    /**
        Returns the jump power of the player
		
		`**Returns:** Jump power
		
		___
		### Lua Examples
		#### Example 1
		Prints local player's jump power
		
		```lua 
		print( LocalPlayer():GetJumpPower() )
		```
		**Output:**
		
		200
    **/
    
    public function GetJumpPower():Float;
    
    
    /**
        Returns whether the player is an admin or not
		
		`**Returns:** True if the player is an admin
		
		___
		### Lua Examples
		#### Example 1
		Every time a player spawns, print in the console whether they are an admin.
		
		```lua 
		hook.Add("PlayerSpawn", "PrintIfAdmin", function( ply )
		    if ( ply:IsAdmin() ) then 
		       print( "It's true, " .. ply:Nick() .. " is an admin")
		    else
		       print( "It's false, " .. ply:Nick() .. " is not an admin")
		    end
		end )
		```
    **/
    
    public function IsAdmin():Bool;
    
    #if server
    /**
        Sets the player to the chosen team.
		
		Name | Description
		--- | ---
		`Team` | The team that the player is being set to.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the players team to the first argument when writing "set_team" into the console and respawns the player afterwards, ex. "set_team 1".
		
		```lua 
		function ChangeMyTeam( ply, cmd, args )
		    ply:SetTeam( args[1] )
		    ply:Spawn()
		end
		concommand.Add( "set_team", ChangeMyTeam )
		```
		**Output:**
		
		Sets the player to team 1 and respawns him/her.
    **/
    
    public function SetTeam(Team:Float):Void;
    #end
    
    /**
        Returns if the player is in the context menu.
		
		**Note:** Although this is shared, it will only work properly on the CLIENT for the local player. Using this serverside or on other players will return false.
		
		`**Returns:** Is the player world clicking or not.
    **/
    
    public function IsWorldClicking():Bool;
    
    #if server
    /**
        Adds a entity to the players list of frozen objects.
		
		Name | Description
		--- | ---
		`ent` | Entity
		`physobj` | Physics object belonging to ent
    **/
    
    public function AddFrozenPhysicsObject(ent:Entity, physobj:PhysObj):Void;
    #end
    #if server
    /**
        Stops the player from spectating another entity.
    **/
    
    public function UnSpectate():Void;
    #end
    
    /**
        Sets the angle of the player's view (may rotate body too if angular difference is large)
		
		Name | Description
		--- | ---
		`angle` | Angle to set the view to
		
		
		___
		### Lua Examples
		#### Example 1
		Points a player at Vector(0,0,0)
		
		```lua 
		local ply = LocalPlayer() // Or any player
		local vec1 = Vector(0,0,0) -- Where we're looking at
		local vec2 = ply:GetShootPos() -- The player's eye pos
		ply:SetEyeAngles((vec1 - vec2):Angle()) -- Sets to the angle between the two vectors
		```
		**Output:**
		
		Local player will look at 0,0,0
    **/
    
    public function SetEyeAngles(angle:Angle):Void;
    
    #if server
    /**
        Signals the entity that it was dropped by the gravity gun.
		
		Name | Description
		--- | ---
		`ent` | Entity that was dropped.
    **/
    
    public function SimulateGravGunDrop(ent:Entity):Void;
    #end
    #if server
    /**
        Retrieves the value of a client-side ConVar. The ConVar must have a FCVAR_USERINFO flag for this to work.
		
		**Warning:** The returned value is truncated to 31 bytes.
		
		Name | Description
		--- | ---
		`cVarName` | The name of the client-side ConVar
		
		
		`**Returns:** The value of the ConVar
		
		___
		### Lua Examples
		#### Example 1
		Creates clientside ConVar 'Apple' and retrieves value of it.
		
		```lua 
		if CLIENT then
		    CreateConVar( "Apple", "ILikeApples", FCVAR_USERINFO )
		else
		    MsgN( Entity( 1 ):GetInfo( "Apple" ) )
		end
		```
    **/
    
    public function GetInfo(cVarName:String):String;
    #end
    
    /**
        Sets the mins and maxs of the AABB of the players collision when ducked.
		
		Name | Description
		--- | ---
		`hullMins` | The min coordinates of the hull.
		`hullMaxs` | The max coordinates of the hull.
    **/
    
    public function SetHullDuck(hullMins:Vector, hullMaxs:Vector):Void;
    
    #if server
    /**
        Returns true from the point when the player is sending client info but not fully in the game until they disconnect.
		
		`**Returns:** isConnected
    **/
    
    public function IsConnected():Bool;
    #end
    
    /**
        Returns the player's maximum movement speed. 
		
		See also Player:SetMaxSpeed, Player:GetWalkSpeed and Player:GetRunSpeed.
		
		`**Returns:** The maximum movement speed the player can go at.
    **/
    
    public function GetMaxSpeed():Float;
    
    
    /**
        Returns the player's view model entity by the index. Each player has 3 view models by default, but only the first one is used. 
		
		To use the other viewmodels in your SWEP, see Entity:SetWeaponModel.
		
		**Note:** In the Client realm, other players' viewmodels are not available unless they are being spectated.
		
		Name | Description
		--- | ---
		`index` | optional index of the view model to return, can range from 0 to 2
		
		
		`**Returns:** The view model entity
    **/
    
    public function GetViewModel(?index:Float):Entity;
    
    
    /**
        This allows the server to mitigate the lag of the player by moving back all the entities that can be lag compensated to the time the player attacked with his weapon. 
		
		This technique is most commonly used on things that hit other entities instantaneously, such as traces.
		
		**Warning:** This function NEEDS to be disabled after you're done with it or it will break the movement of the entities affected!
		
		**Note:** Entity:FireBullets calls this function internally.
		
		**Bug:** BUG Lag compensation does not support pose parameters. Issue Tracker: #3683
		
		Name | Description
		--- | ---
		`lagCompensation` | The state of the lag compensation, true to enable and false to disable.
		
		
		___
		### Lua Examples
		#### Example 1
		Do a crowbar-like melee trace, enabling lag compensation before doing so.
		
		```lua 
		function SWEP:PrimaryAttack()
		
		    local tracedata = {}
		    tracedata.start = self.Owner:GetShootPos()
		    tracedata.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 75
		    tracedata.filter = self.Owner
		    tracedata.mins =  Vector( -8 , -8 , -8 )
		    tracedata.maxs =  Vector( 8 , 8 , 8 )
		    
		    -- It is recommended to use an IsPlayer check in case the weapon is being used by an NPC.
		    if ( self.Owner:IsPlayer() ) then
		        self.Owner:LagCompensation( true )
		    end
		    
		    local tr = util.TraceHull( tracedata )
		    
		    if ( self.Owner:IsPlayer() ) then
		        self.Owner:LagCompensation( false )
		    end
		    
		    if tr.Hit then
		        print( tr.Entity )    --your code here
		    end
		    
		    self:SetNextPrimaryFire( CurTime() + 0.5 )
		end
		```
    **/
    
    public function LagCompensation(lagCompensation:Bool):Void;
    
    #if server
    /**
        Returns the player's IP address and connection port in ip:port form
		
		`**Returns:** The player's IP address and connection port
		
		___
		### Lua Examples
		#### Example 1
		Prints the player's IP and port
		
		```lua 
		print( Entity( 1 ):IPAddress() )
		```
		**Output:**
		
		192.168.1.101:27005
    **/
    
    public function IPAddress():String;
    #end
    #if server
    /**
        Makes the player spectate the entity 
		
		To get the applied spectated entity, use Player:GetObserverTarget().
		
		**Bug:** BUG The player's position will not update while spectating, causing area portals and other map optimisations to not work properly. You can fix this by setting the player's position to the spectated entity's each tick. Issue Tracker: #3267
		
		Name | Description
		--- | ---
		`entity` | Entity to spectate.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a entity, spectates it and after 5 seconds, stops spectating it.
		
		```lua 
		local ent = ents.Create( "prop_physics" )
		ent:SetModel( "models/hunter/misc/sphere025x025.mdl" )
		ent:SetPos( Vector( 0, 0, 0 ) )
		ent:Spawn()
		 
		for _, ply in pairs( player.GetAll() ) do
		    ply:Spectate( OBS_MODE_CHASE )
		    ply:SpectateEntity( ent )
		    ply:StripWeapons()
		
		    timer.Simple( 5, function()
		        ply:UnSpectate()
		        ply:Spawn()
		    end )
		end
		```
    **/
    
    public function SpectateEntity(entity:Entity):Void;
    #end
    
    /**
        ***Deprecated:** This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.
		
		When used in a GM:SetupMove hook, this function behaves unexpectedly by preventing the player from sprinting similar to Player:StopSprinting.
		
		___
		### Lua Examples
		#### Example 1
		Disables Sprinting, not Walking.
		
		```lua 
		hook.Add( "SetupMove", "TestFunc", function( ply, mv, cmd )
		    ply:StopWalking()
		end )
		```
    **/
    @:deprecated("This appears to be a direct binding to internal functionality that is overridden by the engine every frame so calling these functions may not have any or expected effect.")
    public function StopWalking():Void;
    
    
    /**
        Returns the player's class id.
		
		`**Returns:** The player's class id.
    **/
    
    public function GetClassID():Float;
    
    
    /**
        Gets whether a key was just released this tick
		
		Name | Description
		--- | ---
		`key` | The key, see IN_ Enums
		
		
		`**Returns:** Was released or not
		
		___
		### Lua Examples
		#### Example 1
		Prints whenever the first player first stops pressing W
		
		```lua 
		hook.Add( "Tick", "CheckPlayer1Forward", function()
		   if Entity( 1 ):KeyReleased( IN_FORWARD ) then print("Ent1 just stopped moving forward!") end
		end)
		```
    **/
    
    public function KeyReleased(key:IN):Bool;
    
    
    /**
        Sets the mins and maxs of the AABB of the players collision.
		
		**Bug:** BUG Setting both the mins and maxs to Vector(0,0,0) will crash the game. Issue Tracker: #3365
		
		Name | Description
		--- | ---
		`hullMins` | The min coordinates of the hull.
		`hullMaxs` | The max coordinates of the hull.
    **/
    
    public function SetHull(hullMins:Vector, hullMaxs:Vector):Void;
    
    
    /**
        Returns the player's SteamID. In singleplayer, this will be STEAM_ID_PENDING serverside. 
		
		For Bots this will return "BOT" on the server and on the client it returns "NULL". 
		
		 Use Player:AccountID for a shorter version of the SteamID.
		
		`**Returns:** SteamID
		
		___
		### Lua Examples
		#### Example 1
		Prints the EntityID, Name and SteamID of all players
		
		```lua 
		for k, v in pairs( player.GetAll() ) do
		     print( "[" .. v:EntIndex() .. "]", v:Name(), v:SteamID( ) )
		end
		```
		**Output:**
		
		A list consisting of every player's EntityID, Name & SteamID on the server.
    **/
    
    public function SteamID():String;
    
    
    /**
        Sends a third person reload animation event to the player. 
		
		Similar to other animation event functions, calls GM:DoAnimationEvent with PLAYERANIMEVENT_RELOAD as the event and no extra data.
    **/
    
    public function DoReloadEvent():Void;
    
    #if server
    /**
        Removes all weapons from a certain player
		
		___
		### Lua Examples
		#### Example 1
		Removes all the weapons from the player with the ID 1
		
		```lua 
		player.GetByID( 1 ):StripWeapons()
		```
		**Output:**
		
		Player 1 has no weapons anymore
    **/
    
    public function StripWeapons():Void;
    #end
    #if server
    /**
        Kicks the player from the server.
		
		**Warning:** This will be shortened to ~512 chars, though this includes the command itself and the player index so will realistically be more around ~498. It is recommended to avoid going near the limit to avoid truncation.
		
		**Note:** This can not be run before the player has fully joined in. Use game.KickID for that.
		
		Name | Description
		--- | ---
		`reason` | Reason to show for disconnection. WARNING This will be shortened to ~512 chars, though this includes the command itself and the player index so will realistically be more around ~498. It is recommended to avoid going near the limit to avoid truncation.
		
		
		___
		### Lua Examples
		#### Example 1
		Kick a player with reason "Goodbye"
		
		```lua 
		ply:Kick( "Goodbye" )
		```
    **/
    
    public function Kick(?reason:String):Void;
    #end
    #if client
    /**
        Sets up the voting system for the player. This is a really barebone system. By calling this a vote gets started, when the player presses 0-9 the callback function gets called along with the key the player pressed. Use the draw callback to draw the vote panel.
		
		Name | Description
		--- | ---
		`name` | Name of the vote
		`timeout` | Time until the vote expires
		`vote_callback` | The function to be run when the player presses 0-9 while a vote is active.
		`draw_callback` | Used to draw the vote panel.
		
		
		___
		### Lua Examples
		#### Example 1
		Simple example. Prints player's choice in chat.
		
		```lua 
		function AfterChoice(num) -- This is callback after we press number (Argument #3)
		    chat.AddText("Your rate is "..num..". Thanks!") 
		    return true -- Return true to close vote
		end
		
		function VisualVote() -- This is drawing function (Argument #4)
		    draw.RoundedBox(4,ScrW()/2-300,ScrH()/2-25,600,50,Color(0,0,0,200))
		    draw.SimpleText("Rate our server by scale of zero to nine. Use number line to vote.","Trebuchet24",ScrW()/2,ScrH()/2,Color(255,255,255),1,1)
		end
		
		LocalPlayer():AddPlayerOption("SelectWeapon",30,AfterChoice,VisualVote) -- Creates new vote
		```
    **/
    
    public function AddPlayerOption(name:String, timeout:Float, vote_callback:Function, draw_callback:Function):Void;
    #end
    
    /**
        Gets whether a key was down one tick ago.
		
		Name | Description
		--- | ---
		`key` | The key, see IN_ Enums
		
		
		`**Returns:** Is key down
		
		___
		### Lua Examples
		#### Example 1
		Prints whenever the first player stopped pressing W last tick
		
		```lua 
		hook.Add( "Tick", "CheckPlayer1Forward", function()
		   if ( !Entity( 1 ):KeyDown( IN_FORWARD ) ) and Entity( 1 ):KeyDownLast( IN_FORWARD ) then print( "Ent1 is no longer holding W!") end
		end )
		```
    **/
    
    public function KeyDownLast(key:IN):Bool;
    
    #if server
    /**
        Strips the player's suit item.
    **/
    
    public function RemoveSuit():Void;
    #end
    #if server
    /**
        Sends a hint to a player.
		
		**Note:** This function is only available in Sandbox and its derivatives. Since this adds #Hint_ to the beginning of each message, you should only use it with default hint messages, or those cached with language.Add. For hints with custom text, look at notification.AddLegacy
		
		Name | Description
		--- | ---
		`name` | Name/class/index of the hint. The text of the hint will contain this value. ( "#Hint_" .. name ) An example is PhysgunFreeze.
		`delay` | Delay in seconds before showing the hint
    **/
    
    public function SendHint(name:String, delay:Float):Void;
    #end
    
    /**
        Returns the position of a Player's view
		
		**Note:** This is the same as calling Entity:EyePos on the player.
		
		`**Returns:** aim pos
		
		___
		### Lua Examples
		#### Example 1
		Gets player 1's shoot position, and prints it to console
		
		```lua 
		print( player.GetByID( 1 ):GetShootPos() )
		```
		**Output:**
		
		A vector of the player's shooting position in the console.
		
		#### Example 2
		Prints the position of your player's camera, but using 3 different functions.This example demonstrates that it doesn't matter whichever of these functions you use, you will get the SAME result.
		
		```lua 
		// run on client
		print(LocalPlayer():GetEyeTrace().StartPos)
		print(LocalPlayer():GetShootPos())
		print(LocalPlayer():EyePos())
		```
    **/
    
    public function GetShootPos():Vector;
    
    
    /**
        Gets the entity the player is currently driving.
		
		`**Returns:** DriveEntity
    **/
    
    public function GetDrivingEntity():Entity;
    
    #if server
    /**
        Sets a player's death count
		
		Name | Description
		--- | ---
		`deathcount` | Number of deaths (positive or negative)
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the deaths of player 1 to 5
		
		```lua 
		player.GetByID( 1 ):SetDeaths( 5 )
		```
		**Output:**
		
		None
    **/
    
    public function SetDeaths(deathcount:Float):Void;
    #end
    #if server
    /**
        Drops any object the player is currently holding with either gravitygun or +Use (E key)
    **/
    
    public function DropObject():Void;
    #end
    
    /**
        Returns a table with information of what the player is looking at. 
		
		The results of this function are cached every frame. 
		
		 See also Player:GetEyeTraceNoCursor
		
		`**Returns:** Trace information, see TraceResult structure
		
		___
		### Lua Examples
		#### Example 1
		Prints the entity the player is looking at.
		
		```lua 
		print( Entity( 1 ):GetEyeTrace().Entity )
		```
		**Output:**
		
		"Entity [0][worldspawn]" in console, if you aim at world.
    **/
    
    public function GetEyeTrace():TraceResult;
    
    
    /**
        Returns a table of the player's weapons.
		
		`**Returns:** All the weapons the player currently has.
		
		___
		### Lua Examples
		#### Example 1
		Prints how many weapons the player has.
		
		```lua 
		print( #Entity(1):GetWeapons() )
		```
		**Output:**
		
		The number of weapons the player has (e.g. 5).
    **/
    
    public function GetWeapons():AnyTable;
    
    
    /**
        Returns true if the player's flashlight hasn't been disabled by Player:AllowFlashlight.
		
		**Note:** This is not synchronized between clients and server automatically!
		
		`**Returns:** Whether the player can use flashlight.
    **/
    
    public function CanUseFlashlight():Bool;
    
    
    /**
        Resets player gesture in selected slot.
		
		Name | Description
		--- | ---
		`slot` | Slot to reset. See the GESTURE_SLOT_ Enums.
    **/
    
    public function AnimResetGestureSlot(slot:GESTURE_SLOT):Void;
    
    
    /**
        Returns the players name. Identical to Player:Nick and Player:GetName.
		
		**Bug:** BUG This is limited to 31 characters even though Steam names can have 32. Issue Tracker: #3178
		
		`**Returns:** Player's Steam name. BUG This is limited to 31 characters even though Steam names can have 32. Issue Tracker: #3178
		
		___
		### Lua Examples
		#### Example 1
		Prints the players name in console.
		
		```lua 
		print(Player(1):Name())
		```
		**Output:**
		
		YourNameHere
    **/
    
    public function Name():String;
    
    
    /**
        Sets the players observer mode. You must start the spectating first with Player:Spectate.
		
		Name | Description
		--- | ---
		`mode` | Spectator mode using OBS_MODE_ Enums.
    **/
    
    public function SetObserverMode(mode:OBS_MODE):Void;
    
    
    /**
        Gets the hands entity of a player
		
		`**Returns:** The hands entity if players has one
    **/
    
    public function GetHands():Entity;
    
    
    /**
        Writes a Player Data key-value pair to the SQL database. (sv.db when called on server, cl.db when called on client) 
		
		Internally uses the sql library.
		
		**Warning:** This function internally uses Player:UniqueID, which can cause collisions (two or more players sharing the same PData entry). It's recommended that you don't use it. See the related wiki page for more information.
		
		**Note:** PData is not networked from servers to clients!
		
		Name | Description
		--- | ---
		`key` | Name of the PData key
		`value` | Value to write to the key ( must be an SQL valid data type, such as a string or integer)
		
		
		`**Returns:** Whether the operation was successful or not
		
		___
		### Lua Examples
		#### Example 1
		Sets the key "money" from player 1's PData to 100
		
		```lua 
		player.GetByID( 1 ):SetPData( "money", 100 )
		```
    **/
    
    public function SetPData(key:String, value:Dynamic):Bool;
    
    
    /**
        Gets whether a key was just pressed this tick
		
		Name | Description
		--- | ---
		`key` | Corresponds to an IN_ Enums
		
		
		`**Returns:** Was pressed or not
		
		___
		### Lua Examples
		#### Example 1
		Prints whenever the first player first starts pressing W
		
		```lua 
		hook.Add( "Tick", "CheckPlayer1Forward", function()
		   if( Entity( 1 ):KeyPressed( IN_FORWARD )) then
		        print( "Ent1 just started moving forward!" )
		    end
		end )
		```
    **/
    
    public function KeyPressed(key:IN):Bool;
    
    #if server
    /**
        Equips the player with the HEV suit. 
		
		Allows the player to zoom, walk slowly, sprint, pickup armor batteries, use the health and armor stations and also shows the HUD. The player also emits a flatline sound on death, which can be overridden with GM:PlayerDeathSound. 
		
		 The player is automatically equipped with the suit on spawn, if you wish to stop that, use Player:RemoveSuit.
    **/
    
    public function EquipSuit():Void;
    #end
    #if server
    /**
        Sets whenever the player should not collide with their teammates.
		
		**Bug:** BUG This only works with Player:Team IDs 1-4. This also has major collision issues. Issue Tracker: #2757
		
		Name | Description
		--- | ---
		`shouldNotCollide` | True to disable, false to enable collision.
    **/
    
    public function SetNoCollideWithTeammates(shouldNotCollide:Bool):Void;
    #end
    
    /**
        Returns a player's weapon color. The part of the model that is colored is determined by the model itself, and is different for each model. The format is Vector(r,g,b), and each color should be between 0 and 1.
		
		`**Returns:** color
		
		___
		### Lua Examples
		#### Example 1
		Gets player 1's weapon color, and prints it to console
		
		```lua 
		print( player.GetByID( 1 ):GetWeaponColor() )
		```
		**Output:**
		
		Vector( 1, 1, 1 )
    **/
    
    public function GetWeaponColor():Vector;
    
    
    /**
        Applies the specified sound filter to the player.
		
		Name | Description
		--- | ---
		`soundFilter` | The index of the sound filter to apply. Pick from the list of DSP's.
		`fastReset` | If set to true the sound filter will be removed faster.
    **/
    
    public function SetDSP(soundFilter:Float, fastReset:Bool):Void;
    
    #if server
    /**
        Gives ammo to a player
		
		Name | Description
		--- | ---
		`amount` | Amount of ammo
		`type` | Type of ammo. This can also be a number for ammo ID, useful for custom ammo types. You can find a list of default ammo types here.
		`hidePopup` | Hide display popup when giving the ammo
		
		
		`**Returns:** Ammo given.
		
		___
		### Lua Examples
		#### Example 1
		Give the player 200 rounds for the pistol, hiding the popup.
		
		```lua 
		player.GetByID(1):GiveAmmo( 200, "Pistol", true )
		```
    **/
    
    public function GiveAmmo(amount:Float, type:String, ?hidePopup:Bool):Float;
    #end
    
    /**
        Gets the bottom base and the top base size of the player's crouch hull.
		
		Name | Description
		--- | ---
		`a` | Player's crouch hull bottom base size
		`b` | Player's crouch hull top base size
		
		
		___
		### Lua Examples
		#### Example 1
		Prints bases' size of the crouch hull of all players.
		
		```lua 
		for k,v in pairs(player.GetAll()) do
		
		    local bottom, top = v:GetHullDuck()
		
		    print(bottom)
		
		    print(top)
		
		end
		```
		**Output:**
		
		-16.000000 -16.000000 0.000000 16.000000 16.000000 36.000000
    **/
    
    public function GetHullDuck():PlayerGetHullDuckReturn;
    
    
    /**
        Prints a string to the chatbox of the client.
		
		**Warning:** Just like the usermessage library, this function is affected by the 255 byte limit!
		
		Name | Description
		--- | ---
		`message` | String to be printed
		
		
		___
		### Lua Examples
		#### Example 1
		Prints "Hello World" to chat of all players
		
		```lua 
		for k, ply in pairs(player.GetAll()) do
		    ply:ChatPrint("Hello World")
		end
		```
		**Output:**
		
		Hello World (In chatbox)
    **/
    
    public function ChatPrint(message:String):Void;
    
    
    /**
        Returns the trace according to the players view direction, ignoring their mouse ( Holding C and moving the mouse in Sandbox ). 
		
		The results of this function are cached every frame. 
		
		 See also Player:GetEyeTrace
		
		`**Returns:** Trace result. See TraceResult structure
    **/
    
    public function GetEyeTraceNoCursor():TraceResult;
    
    #if server
    /**
        Sets the players visibility towards NPCs. 
		
		Internally this toggles the FL_NOTARGET flag, which you can manually test for using Entity:IsFlagSet
		
		Name | Description
		--- | ---
		`visibility` | The visibility.
    **/
    
    public function SetNoTarget(visibility:Bool):Void;
    #end
    
    /**
        Returns the timescale multiplier of the player movement.
		
		`**Returns:** The timescale multiplier, defaults to 1.
    **/
    
    public function GetLaggedMovementValue():Float;
    
    
    /**
        Returns whether the player is typing in their chat. 
		
		This may not work properly if the server uses a custom chatbox.
		
		`**Returns:** Whether the player is typing in their chat or not.
    **/
    
    public function IsTyping():Bool;
    
    
    /**
        Sets the player's sprint speed. 
		
		See also Player:GetRunSpeed, Player:SetWalkSpeed and Player:SetMaxSpeed.
		
		Name | Description
		--- | ---
		`runSpeed` | The new sprint speed when sv_friction is below 10. Higher sv_friction values will result in slower speed. Has to be 7 or above or the player won't be able to move.
    **/
    
    public function SetRunSpeed(runSpeed:Float):Void;
    
    #if server
    /**
        Retrieves the numeric value of a client-side convar, returns nil if value is not convertible to a number. The ConVar must have a FCVAR_USERINFO flag for this to work.
		
		Name | Description
		--- | ---
		`cVarName` | The name of the ConVar to query the value of
		`default` | Default value if we failed to retrieve the number.
		
		
		`**Returns:** The value of the ConVar or the default value
		
		___
		### Lua Examples
		#### Example 1
		Creates clientside ConVar 'Apple' and retrieves value of it.
		
		```lua 
		if CLIENT then
		    CreateConVar( "Apple", "1", FCVAR_USERINFO )
		else
		    MsgN( Entity( 1 ):GetInfoNum( "Apple" ) )
		end
		```
		
		#### Example 2
		Shows difference between Player:GetInfo and Player:GetInfoNum.
		
		```lua 
		if CLIENT then
		    CreateConVar( "Apple", "1", FCVAR_USERINFO )
		else
		    MsgN( type( Entity( 1 ):GetInfoNum( "Apple", 1 ) ) )
		    MsgN( type( Entity( 1 ):GetInfo( "Apple" ) ) )
		end
		```
    **/
    
    public function GetInfoNum(cVarName:String, _default:Float):Float;
    #end
    
    /**
        Sets client's view punch. See Player:ViewPunch
		
		Name | Description
		--- | ---
		`punchAngle` | The angle to set.
    **/
    
    public function SetViewPunchAngles(punchAngle:Angle):Void;
    
    #if server
    /**
        Sets the active weapon of the player by its class name.
		
		**Warning:** This will switch the weapon out of prediction, causing delay on the client and WEAPON:Deploy to be called out of prediction. Try using CUserCmd:SelectWeapon or input.SelectWeapon, instead.
		
		**Note:** This will trigger the weapon switch event and associated animations. To switch weapons silently, use Player:SetActiveWeapon.
		
		Name | Description
		--- | ---
		`className` | The class name of the weapon to switch to. If the player doesn't have the specified weapon, nothing will happen. You can use Player: Give to give the weapon first.
		
		
		___
		### Lua Examples
		#### Example 1
		Force the player to switch to toolgun
		
		```lua 
		Entity(1):SelectWeapon("gmod_tool")
		```
		
		#### Example 2
		Selects a random weapon from the player's inventory and switches to it.
		
		```lua 
		local weapons = Entity( 1 ):GetWeapons()
		local weapon = weapons[ math.random( #weapons ) ]
		
		Entity( 1 ):SelectWeapon( weapon:GetClass() )
		```
    **/
    
    public function SelectWeapon(className:String):Void;
    #end
    
    /**
        ***INTERNAL** 
		
		Sets the driving entity and driving mode. 
		
		Use drive.PlayerStartDriving instead, see Entity Driving.
		
		Name | Description
		--- | ---
		`drivingEntity` | The entity the player should drive.
		`drivingMode` | The driving mode index.
    **/
    @:deprecated("INTERNAL")
    public function SetDrivingEntity(?drivingEntity:Entity, drivingMode:Float):Void;
    
    
    /**
        Returns whether the player is crouching or not
		
		`**Returns:** Whether the player is crouching
    **/
    
    public function Crouching():Bool;
    
    
    /**
        Shows "limit hit" notification in sandbox.
		
		**Note:** This function is only available in Sandbox and its derivatives
		
		Name | Description
		--- | ---
		`type` | Type of hit limit
		
		
		___
		### Lua Examples
		#### Example 1
		Sends a fake "limit hit" notification
		
		```lua 
		for id, ply in pairs( player.GetAll() ) do
		       ply:LimitHit( "test" )
		end
		```
		**Output:**
		
		A notification pops up saying "SBoxLimit_test"
    **/
    
    public function LimitHit(type:String):Void;
    
    
    /**
        Adds an entity to the players clean up list.
		
		Name | Description
		--- | ---
		`type` | Cleanup type
		`ent` | Entity to add
    **/
    
    public function AddCleanup(type:String, ent:Entity):Void;
    
    
    /**
        Restarts the main animation on the player, has the same effect as calling Entity:SetCycle( 0 ).
    **/
    
    public function AnimRestartMainSequence():Void;
    
    #if client
    /**
        Returns the steam "relationship" towards the player.
		
		`**Returns:** Should return one of four different things depending on their status on your friends list: "friend", "blocked", "none" or "requested".
		
		___
		### Lua Examples
		#### Example 1
		Prints the steam relationship towards another player
		
		```lua 
		print(ply:GetFriendStatus())
		```
		**Output:**
		
		"friend"
    **/
    
    public function GetFriendStatus():String;
    #end
    #if server
    /**
        Disables god mode on the player.
		
		___
		### Lua Examples
		#### Example 1
		Disables god mode on all players.
		
		```lua 
		for _, v in pairs(player.GetAll()) do
		    v:GodDisable()
		end
		```
    **/
    
    public function GodDisable():Void;
    #end
    #if server
    /**
        Makes the player exit the vehicle if they're in one.
		
		___
		### Lua Examples
		#### Example 1
		Make player 1 leave his vehicle if he's driving one.
		
		```lua 
		Entity(1):ExitVehicle()
		```
		**Output:**
		
		Player 1 will exit the the vehicle he's currently in.
    **/
    
    public function ExitVehicle():Void;
    #end
    
    /**
        Sets the player model's color. The part of the model that is colored is determined by the model itself, and is different for each model.
		
		Name | Description
		--- | ---
		`Color` | This is the color to be set. The format is Vector(r,g,b), and each color should be between 0 and 1.
		
		
		___
		### Lua Examples
		#### Example 1
		When a player spawns their color will be red.
		
		```lua 
		function GM:PlayerSpawn( ply )
		    ply:SetPlayerColor( Vector(1,0,0) )
		end
		```
		
		#### Example 2
		A function you could use to set the player's color to a Color rather than a Vector
		
		```lua 
		local function SetColor( ply, color )
		    ply:SetPlayerColor( Vector( color.r / 255, color.g / 255, color.b / 255 ) )
		end
		```
    **/
    
    public function SetPlayerColor(Color:Vector):Void;
    
    #if server
    /**
        Turns off the zoom mode of the player. (+zoom console command) 
		
		Basically equivalent of entering "-zoom" into player's console.
    **/
    
    public function StopZooming():Void;
    #end
    
    /**
        Gets the amount of ammo the player has.
		
		Name | Description
		--- | ---
		`ammotype` | The ammunition type. Can be either number ammo ID or string ammo name.
		
		
		`**Returns:** The amount of ammo player has in reserve.
		
		___
		### Lua Examples
		#### Example 1
		A function that returns the ammo for the weapon the player is currently holding.
		
		```lua 
		function GetAmmoForCurrentWeapon( ply )
		    if ( !IsValid( ply ) ) then return -1 end
		
		    local wep = ply:GetActiveWeapon()
		    if ( !IsValid( wep ) ) then return -1 end
		 
		    return ply:GetAmmoCount( wep:GetPrimaryAmmoType() )
		end
		```
		**Output:**
		
		31
		
		#### Example 2
		Example usage. "pistol" ammo type has ID of 3.
		
		```lua 
		print(Entity(1):GetAmmoCount( 3 ))
		print(Entity(1):GetAmmoCount( "3" ))
		print(Entity(1):GetAmmoCount( "pistol" ) )
		```
		**Output:**
		
		255
		0
		255
    **/
    
    public function GetAmmoCount(ammotype:Dynamic):Float;
    
    
    /**
        Returns a table that will stay allocated for the specific player between connects until the server shuts down. Note, that this table is not synchronized between client and server.
		
		Name | Description
		--- | ---
		`key` | Unique table key.
		
		
		`**Returns:** The table that contains any info you have put in it.
		
		___
		### Lua Examples
		#### Example 1
		Example usage
		
		```lua 
		local table = Entity( 1 ):UniqueIDTable( "mytable" )
		table.MyValue = "test"
		
		// Somewhere else
		local table = Entity( 1 ):UniqueIDTable( "mytable" )
		print( table.MyValue )
		local table = Entity( 1 ):UniqueIDTable( "mytable_other" )
		print( table.MyValue )
		```
		**Output:**
		
		"test" nil
    **/
    
    public function UniqueIDTable(key:Dynamic):AnyTable;
}


@:multiReturn extern class PlayerGetHullDuckReturn {
var a:Vector;
var b:Vector;

}
@:multiReturn extern class PlayerGetHullReturn {
var a:Vector;
var b:Vector;

}

