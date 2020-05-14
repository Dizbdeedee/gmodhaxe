package gmod;

enum abstract Hook<T:Function>(Dynamic) from String to String {
	public inline function new(name:String){
		this = name;
	}
}

enum abstract GMHook<T:Function>(Hook<T>) to String to Hook<T> {
    #if server
    /**
        Executes when a player connects to the server. Called before the player has been assigned a UserID and entity. See the player_connect gameevent for a version of this hook called after the player entity has been created.
		
		**Note:** This is only called clientside for listen server hosts.
		
		**Note:** This is not called clientside for the local player.
		
		**Note:** This argument will only be passed serverside.
		
		Name | Description
		--- | ---
		`name` | The player's name.
		`ip` | The player's IP address. Will be "none" for bots. NOTE This argument will only be passed serverside.
		
		
		___
		### Lua Examples
		#### Example 1
		prints a message to the chatbox when a player joins the game
		
		```lua 
		function GM:PlayerConnect( name, ip )
		    PrintMessage( HUD_PRINTTALK, name .. " has joined the game." )
		end
		```
		**Output:**
		
		Player1 has joined the game.
    **/
    var PlayerConnect:GMHook<(name:String, ip:String) -> Void>; 
	#elseif client
	/**
        Executes when a player connects to the server. Called before the player has been assigned a UserID and entity. See the player_connect gameevent for a version of this hook called after the player entity has been created.
		
		**Note:** This is only called clientside for listen server hosts.
		
		**Note:** This is not called clientside for the local player.
		
		Name | Description
		--- | ---
		`name` | The player's name.
		
		
		
		___
		### Lua Examples
		#### Example 1
		prints a message to the chatbox when a player joins the game
		
		```lua 
		function GM:PlayerConnect( name)
		    PrintMessage( HUD_PRINTTALK, name .. " has joined the game." )
		end
		```
		**Output:**
		
		Player1 has joined the game.
    **/
	var PlayerConnect:GMHook<(name:String) -> Void>; 
	#end
    #if server
    /**
        Check if a player can spawn at a certain spawnpoint.
		
		Name | Description
		--- | ---
		`ply` | The player who is spawned
		`spawnpoint` | The spawnpoint entity (on the map)
		`makeSuitable` | If this is true, it'll kill any players blocking the spawnpoint
		
		
		`**Returns:** Return true to indicate that the spawnpoint is suitable (Allow for the player to spawn here), false to prevent spawning
		
		___
		### Lua Examples
		#### Example 1
		This will check if anyone is blocking the spawnpoint. If someone is, then it'll, depending on the bMakeSuitable value, kill the player, or return false.
		
		```lua 
		function GM:IsSpawnpointSuitable( ply, spawnpointent, bMakeSuitable )
		
		    local Pos = spawnpointent:GetPos()
		
		    -- Note that we're searching the default hull size here for a player in the way of our spawning.
		    -- This seems pretty rough, seeing as our player's hull could be different.. but it should do the job
		    -- (HL2DM kills everything within a 128 unit radius)
		    local Ents = ents.FindInBox( Pos + Vector( -16, -16, 0 ), Pos + Vector( 16, 16, 72 ) )
		
		    if ( ply:Team() == TEAM_SPECTATOR or ply:Team() == TEAM_UNASSIGNED ) then return true end
		
		    local Blockers = 0
		
		    for k, v in pairs( Ents ) do
		        if ( IsValid( v ) && v:GetClass() == "player" && v:Alive() ) then
		
		            Blockers = Blockers + 1
		
		            if ( bMakeSuitable ) then
		                v:Kill()
		            end
		
		        end
		    end
		
		    if ( bMakeSuitable ) then return true end
		    if ( Blockers > 0 ) then return false end
		    return true
		
		end
		```
		**Output:**
		
		true or false
    **/
    var IsSpawnpointSuitable:GMHook<(ply:Player, spawnpoint:Entity, makeSuitable:Bool) -> Bool>; 
    #end
    #if server
    /**
        Called from gm_load when the game should load a map.
		
		Name | Description
		--- | ---
		`data` | 
		`map` | 
		`timestamp` | 
    **/
    
    var LoadGModSave:GMHook<(data:String, map:String, timestamp:Float) -> Void>; 
    #end
    #if client
    /**
        Called after view model is drawn.
		
		**Note:** This is a rendering hook with a 3D rendering context. This means that the only rendering functions will work in it are functions with a 3D rendering context.
		
		**Note:** The 3D rendering context in this event is different from the main view. Every render operation will only be accurate with the view model entity.
		
		Name | Description
		--- | ---
		`viewmodel` | Players view model
		`player` | The owner of the weapon/view model
		`weapon` | The weapon the player is currently holding
    **/
    var PostDrawViewModel:GMHook<(viewmodel:Entity, player:Player, weapon:Weapon) -> Void>; 
    #end
    #if server
    /**
        Called when a player executes gm_showteam console command. ( Default bind is F2 )
		
		Name | Description
		--- | ---
		`ply` | Player who executed the command
    **/
    var ShowTeam:GMHook<(ply:Player) -> Void>; 
    #end
    
    /**
        Called to decide whether a pair of entities should collide with each other. This is only called if Entity:SetCustomCollisionCheck was used on one or both entities. 
		
		Where applicable, consider using constraint.NoCollide instead - it is considerably easier to use.
		
		**Warning:** This hook must return the same value consistently for the same pair of entities. If an entity changed in such a way that its collision rules change, you must call Entity:CollisionRulesChanged on that entity immediately - not in this hook.
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		**Bug:** BUG This hook can cause all physics to break under certain conditions. Issue Tracker: #642
		
		Name | Description
		--- | ---
		`ent1` | The first entity in the collision poll.
		`ent2` | The second entity in the collision poll.
		
		
		`**Returns:** Whether the entities should collide.
		
		___
		### Lua Examples
		#### Example 1
		This should always return true unless you have a good reason for it not to.
		
		```lua 
		function GM:ShouldCollide( ent1, ent2 )
		
		    -- If players are about to collide with each other, then they won't collide.
		    if ( IsValid( ent1 ) and IsValid( ent2 ) and ent1:IsPlayer() and ent2:IsPlayer() ) then return false end 
		
		    -- We must call this because anything else should return true.
		    return true
		
		end
		```
    **/
    var ShouldCollide:GMHook<(ent1:Entity, ent2:Entity) -> Bool>; 
    
    #if server
    /**
        Returns whether or not a player is allowed to pick an item up.
		
		Name | Description
		--- | ---
		`ply` | Player attempting to pick up
		`item` | The item the player is attempting to pick up
		
		
		`**Returns:** Allow pick up
    **/
    var PlayerCanPickupItem:GMHook<(ply:Player, item:Entity) -> Bool>; 
    #end
    #if client
    /**
        Runs when the user tries to open the chat box.
		
		**Bug:** BUG Returning true won't stop the chatbox from taking VGUI focus. Issue Tracker: #855
		
		Name | Description
		--- | ---
		`isTeamChat` | Whether the message was sent through team chat.
		
		
		`**Returns:** Return true to hide the default chat box.
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		hook.Add( "StartChat", "HasStartedTyping", function( isTeamChat )
		    if ( isTeamChat ) then
		        print( "Player started typing a message in teamchat." )
		    else
		        print( "Player started typing a message." )
		    end
		end )
		```
    **/
    var StartChat:GMHook<(isTeamChat:Bool) -> Bool>; 
    #end
    #if client
    /**
        Called after rendering effects. This is where halos are drawn. Called just before GM:PreDrawHUD.
		
		**Note:** This is a rendering hook with a 2D rendering context. This means that the only rendering functions will work in it are functions with a 2D rendering context.
    **/
    var PostDrawEffects:GMHook<() -> Void>; 
    #end
    #if server
    /**
        Called when a serverside ragdoll of an entity has been created. 
		
		See GM:CreateClientsideRagdoll for clientside ragdolls.
		
		Name | Description
		--- | ---
		`owner` | Entity that owns the ragdoll
		`ragdoll` | The ragdoll entity
    **/
    var CreateEntityRagdoll:GMHook<(owner:Entity, ragdoll:Entity) -> Void>; 
    #end
    #if client
    /**
        Returning true in this hook will cause it to render depth buffers defined with render.GetResolvedFullFrameDepth.
		
		`**Returns:** Render depth buffer
    **/
    var NeedsDepthPass:GMHook<() -> Bool>; 
    #end
    
    /**
        Called when the game is saved using the Source Engine save system (not the Sandbox saves or dupes). 
		
		See GM:Restored for a hook that is called when such a save file is loaded. 
		
		 See also the saverestore library for relevant functions.
    **/
    var Saved:GMHook<() -> Void>; 
    
    #if client
    /**
        Called whenever a player sends a chat message. For the serverside equivalent, see GM:PlayerSay.
		
		**Note:** The text input of this hook depends on GM:PlayerSay. If it is suppressed on the server, it will be suppressed on the client.
		
		Name | Description
		--- | ---
		`ply` | The player
		`text` | The message's text
		`teamChat` | Is the player typing in team chat?
		`isDead` | Is the player dead?
		
		
		`**Returns:** Should the message be suppressed?
		
		___
		### Lua Examples
		#### Example 1
		Code from base gamemode. See garrysmod/gamemodes/base/gamemode/cl_init.lua#L139
		
		```lua 
		function GM:OnPlayerChat( player, strText, bTeamOnly, bPlayerIsDead )
		 
		    --
		    -- I've made this all look more complicated than it is. Here's the easy version
		    --
		    -- chat.AddText( player, Color( 255, 255, 255 ), ": ", strText )
		    --
		
		    local tab = 
		
		    if ( bPlayerIsDead ) then
		        table.insert( tab, Color( 255, 30, 40 ) )
		        table.insert( tab, "*DEAD* " )
		    end
		
		    if ( bTeamOnly ) then
		        table.insert( tab, Color( 30, 160, 40 ) )
		        table.insert( tab, "(TEAM) " )
		    end
		
		    if ( IsValid( player ) ) then
		        table.insert( tab, player )
		    else
		        table.insert( tab, "Console" )
		    end
		
		    table.insert( tab, Color( 255, 255, 255 ) )
		    table.insert( tab, ": "..strText )
		
		    chat.AddText( unpack(tab) )
		
		    return true
		 
		end
		```
		
		#### Example 2
		How you could create a clientside only chat command.
		
		```lua 
		hook.Add( "OnPlayerChat", "HelloCommand", function( ply, strText, bTeam, bDead ) 
		    if ( ply != LocalPlayer() ) then return end
		
		    strText = string.lower( strText ) -- make the string lower case
		
		    if (strText == "/hello") then -- if the player typed /hello then
		        print("Hello world!") -- print Hello world to the console
		        return true -- this suppresses the message from being shown
		    end
		
		end )
		```
		**Output:**
		
		Prints "Hello world!" to the console when you type /hello in the chat.
    **/
    var OnPlayerChat:GMHook<(ply:Player, text:String, teamChat:Bool, isDead:Bool) -> Bool>; 
    #end
    #if server
    /**
        Called when a player tries to pick up something using the "use" key, return to override. 
		
		See GM:GravGunPickupAllowed for the Gravity Gun pickup variant.
		
		Name | Description
		--- | ---
		`ply` | The player trying to pick up something.
		`ent` | The Entity the player attempted to pick up.
		
		
		`**Returns:** Allow the player to pick up the entity or not.
		
		___
		### Lua Examples
		#### Example 1
		Allows only admins to pick up things
		
		```lua 
		local function up( ply, ent )
		    return ply:IsAdmin()
		end
		hook.Add( "AllowPlayerPickup", "some_unique_name", up )
		```
    **/
    var AllowPlayerPickup:GMHook<(ply:Player, ent:Entity) -> Bool>; 
    #end
    
    /**
        This hook allows you to change how much damage a player receives when one takes damage to a specific body part.
		
		**Note:** This is not called for all damage a player receives ( For example fall damage or NPC melee damage ), so you should use GM:EntityTakeDamage instead if you need to detect ALL damage.
		
		Name | Description
		--- | ---
		`ply` | The player taking damage.
		`hitgroup` | The hitgroup where the player took damage. See HITGROUP_ Enums
		`dmginfo` | The damage info.
		
		
		`**Returns:** Return true to prevent damage that this hook is called for, stop blood particle effects and blood decals. It is possible to return true only on client ( This will work only in multiplayer ) to stop the effects but still take damage.
		
		___
		### Lua Examples
		#### Example 1
		Makes the player take twice as much damage when shot in the head, and only half damage when shot in the limbs.
		
		```lua 
		function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )
		     if ( hitgroup == HITGROUP_HEAD ) then
		        dmginfo:ScaleDamage( 2 ) // More damage when we're shot in the head
		      else
		        dmginfo:ScaleDamage( 0.50 )  // Less damage when shot anywhere else
		     end
		end
		```
    **/
    var ScalePlayerDamage:GMHook<(ply:Player, hitgroup:HITGROUP, dmginfo:CTakeDamageInfo) -> Bool>; 
    
    #if client
    /**
        Called before all opaque entities are drawn. 
		
		See also GM:PreDrawTranslucentRenderables and GM:PostDrawOpaqueRenderables.
		
		**Note:** This is a rendering hook with a 3D rendering context. This means that the only rendering functions will work in it are functions with a 3D rendering context.
		
		Name | Description
		--- | ---
		`isDrawingDepth` | Whether the current draw is writing depth.
		`isDrawSkybox` | Whether the current draw is drawing the skybox.
		
		
		`**Returns:** Return true to prevent opaque renderables from drawing.
    **/
    var PreDrawOpaqueRenderables:GMHook<(isDrawingDepth:Bool, isDrawSkybox:Bool) -> Bool>; 
    #end
    #if server
    /**
        Called when the player spawns for the first time. 
		
		See GM:PlayerSpawn for a hook called every player spawn.
		
		**Warning:** Due to the above note, sending net library messages to the spawned player in this hook is highly unreliable, and they most likely won't be received. See https://github.com/Facepunch/garrysmod-requests/issues/718. A quick and dirty work-around is to delay any sending using timer.Simple with at least 5 seconds delay.
		
		**Note:** This hook is called before the player has fully loaded, when the player is still in seeing the "Starting Lua" screen. For example, trying to use the Entity:GetModel function will return the default model ("player/default.mdl")
		
		Name | Description
		--- | ---
		`player` | The player who spawned.
		`transition` | If true, the player just spawned from a map transition.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints the name of the player joining.
		
		```lua 
		function GM:PlayerInitialSpawn(ply)
		    print( ply:GetName().." joined the server.\n" )
		end
		
		-- That way you are overriding the default hook
		-- you can use hook.Add to make more functions get called when this event occurs
		local function spawn(ply)
		    print( ply:GetName().." joined the game.\n")
		end
		hook.Add( "PlayerInitialSpawn", "some_unique_name", spawn )
		```
		**Output:**
		
		Player1 joined the game
    **/
    var PlayerInitialSpawn:GMHook<(player:Player, transition:Bool) -> Void>; 
    #end
    #if server
    /**
        Makes the player join a specified team. This is a convenience function that calls Player:SetTeam and runs the GM:OnPlayerChangedTeam hook.
		
		Name | Description
		--- | ---
		`ply` | Player to force
		`team` | The team to put player into
    **/
    var PlayerJoinTeam:GMHook<(ply:Player, team:Float) -> Void>; 
    #end
    #if server
    /**
        Called when a player freezes an entity with the physgun.
		
		**Bug:** BUG This is not called for players or NPCs being held with the physgun. Issue Tracker: #723
		
		Name | Description
		--- | ---
		`weapon` | The weapon that was used to freeze the entity.
		`physobj` | Physics object of the entity.
		`ent` | The target entity.
		`ply` | The player who tried to freeze the entity.
		
		
		`**Returns:** Allows you to override whether the player can freeze the entity
		
		___
		### Lua Examples
		#### Example 1
		Only allows admins to freeze things.
		
		```lua 
		hook.Add( "OnPhysgunFreeze", "PhysFreeze", function( weapon, phys, ent, ply )
		
		      if ( !ply:IsAdmin() ) then
		
		        return false
		
		    end
		
		end )
		```
    **/
    var OnPhysgunFreeze:GMHook<(weapon:Entity, physobj:PhysObj, ent:Entity, ply:Player) -> Bool>; 
    #end
    #if server
    /**
        Called to give players the default set of weapons.
		
		**Note:** This function may not work in your custom gamemode if you have overridden your GM:PlayerSpawn and you do not use self.BaseClass.PlayerSpawn or hook.Call.
		
		Name | Description
		--- | ---
		`ply` | Player to give weapons to.
		
		
		___
		### Lua Examples
		#### Example 1
		Gives the player only a pistol.
		
		```lua 
		function GM:PlayerLoadout( ply )
		    ply:Give( "weapon_pistol" )
		
		    -- Prevent default Loadout.
		    return true
		end
		```
    **/
    var PlayerLoadout:GMHook<(ply:Player) -> Void>; 
    #end
    
    /**
        Called right before the map cleans up (usually because game.CleanUpMap was called) 
		
		See also GM:PostCleanupMap.
    **/
    var PreCleanupMap:GMHook<() -> Void>; 
    
    
    /**
        Teams are created within this hook using team.SetUp.
		
		**Note:** This hook is called before GM:PreGamemodeLoaded.
    **/
    var CreateTeams:GMHook<() -> Void>; 
    
    #if client
    /**
        Hides the team selection panel.
    **/
    var HideTeam:GMHook<() -> Void>; 
    #end
    #if client
    /**
        Called whenever the content of the user's chat input box is changed.
		
		Name | Description
		--- | ---
		`text` | The new contents of the input box
    **/
    var ChatTextChanged:GMHook<(text:String) -> Void>; 
    #end
    #if client
    /**
        Called when user clicks on a VGUI panel.
		
		Name | Description
		--- | ---
		`button` | The button that was pressed, see MOUSE_ Enums
		
		
		`**Returns:** Return true if the mouse click should be ignored or not.
    **/
    var VGUIMousePressAllowed:GMHook<(button:MOUSE) -> Bool>; 
    #end
    
    /**
        Called when a Lua error occurs, only works in the Menu realm.
		
		**Warning:** Modify menu state Lua code at your own risk!
		
		Name | Description
		--- | ---
		`error` | The error that occurred.
		`realm` | Where the Lua error took place
		`name` | Title of the addon that is creating the Lua errors
		`id` | Steam Workshop ID of the addon creating Lua errors, if it is an addon.
		
		
		___
		### Lua Examples
		#### Example 1
		Code from garrysmod/lua/menu/errors.lua
		
		```lua 
		local Errors = 
		
		hook.Add( "OnLuaError", "MenuErrorHandler", function( str, realm, addontitle, addonid )
		
		    local text = "Something is creating script errors"
		
		    --
		    -- This error is caused by a specific addon
		    --
		    if ( isstring( addonid ) ) then
		
		        --
		        -- Down Vote
		        --
		        -- steamworks.Vote( addonid, false )
		
		        --
		        -- Disable Naughty Addon
		        --
		        --timer.Simple( 5, function()
		        --    MsgN( "Disabling addon '", addontitle, "' due to lua errors" )
		        --    steamworks.SetShouldMountAddon( addonid, false )
		        --    steamworks.ApplyAddons()
		        --end )
		
		        text = "The addon \"" .. addontitle .. "\" is creating errors, check the console for details"
		
		    end
		
		    if ( addonid == nil ) then addonid = 0 end
		
		    if ( Errors[ addonid ] ) then
		
		        Errors[ addonid ].times    = Errors[ addonid ].times + 1
		        Errors[ addonid ].last    = SysTime()
		
		        return
		    end
		
		    local error = {
		        first    = SysTime(),
		        last    = SysTime(),
		        times    = 1,
		        title    = addontitle,
		        x        = 32,
		        text    = text
		    }
		
		    Errors[ addonid ] = error
		
		end )
		
		local matAlert = Material( "icon16/error.png" )
		
		hook.Add( "DrawOverlay", "MenuDrawLuaErrors", function()
		
		    if ( table.IsEmpty( Errors ) ) then return end
		
		    local idealy = 32
		    local height = 30
		    local EndTime = SysTime() - 10
		    local Recent = SysTime() - 0.5
		
		    for k, v in SortedPairsByMemberValue( Errors, "last" ) do
		
		        surface.SetFont( "DermaDefaultBold" )
		        if ( v.y == nil ) then v.y = idealy end
		        if ( v.w == nil ) then v.w = surface.GetTextSize( v.text ) + 48 end
		
		        draw.RoundedBox( 2, v.x + 2, v.y + 2, v.w, height, Color( 40, 40, 40, 255 ) )
		        draw.RoundedBox( 2, v.x, v.y, v.w, height, Color( 240, 240, 240, 255 ) )
		
		        if ( v.last > Recent ) then
		
		            draw.RoundedBox( 2, v.x, v.y, v.w, height, Color( 255, 200, 0, ( v.last - Recent ) * 510 ) )
		
		        end
		
		        surface.SetTextColor( 90, 90, 90, 255 )
		        surface.SetTextPos( v.x + 34, v.y + 8 )
		        surface.DrawText( v.text )
		
		        surface.SetDrawColor( 255, 255, 255, 150 + math.sin( v.y + SysTime() * 30 ) * 100 )
		        surface.SetMaterial( matAlert )
		        surface.DrawTexturedRect( v.x + 6, v.y + 6, 16, 16 )
		
		        v.y = idealy
		
		        idealy = idealy + 40
		
		        if ( v.last Hook< EndTime ) then
		            Errors[k] = nil
		        end
		
		    end
		
		end )
		```
    **/
    var OnLuaError:GMHook<(error:String, realm:Float, name:String, id:Float) -> Void>; 
    
    #if server
    /**
        Called when an entity is released by a gravity gun.
		
		Name | Description
		--- | ---
		`ply` | Player who is wielding the gravity gun
		`ent` | The entity that has been dropped
    **/
    var GravGunOnDropped:GMHook<(ply:Player, ent:Entity) -> Void>; 
    #end
    #if client
    /**
        Allows you to modify the supplied User Command with mouse input. This could be used to make moving the mouse do funky things to view angles.
		
		Name | Description
		--- | ---
		`cmd` | User command
		`x` | The amount of mouse movement across the X axis this frame
		`y` | The amount of mouse movement across the Y axis this frame
		`ang` | The current view angle
		
		
		`**Returns:** Return true if we modified something
		
		___
		### Lua Examples
		#### Example 1
		Prevents all players from turning with the mouse.
		
		```lua 
		hook.Add("InputMouseApply", "FreezeTurning", function( cmd )
		    cmd:SetMouseX(0)
		    cmd:SetMouseY(0)
		    
		    return true
		end)
		```
    **/
    var InputMouseApply:GMHook<(cmd:CUserCmd, x:Float, y:Float, ang:Angle) -> Bool>; 
    #end
    
    /**
        Called whenever a player pressed a key included within the IN keys. 
		
		For a more general purpose function that handles all kinds of input, see GM:PlayerButtonDown
		
		**Warning:** Due to this being a predicted hook, ParticleEffects created only serverside from this hook will not be networked to the client, so make sure to do that on both realms
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		Name | Description
		--- | ---
		`ply` | The player pressing the key. If running client-side, this will always be LocalPlayer
		`key` | The key that the player pressed using IN_ Enums.
		
		
		___
		### Lua Examples
		#### Example 1
		"hi" will be printed to the console when the player presses the IN_USE (E) key.
		
		```lua 
		hook.Add( "KeyPress", "keypress_use_hi", function( ply, key )
		    if ( key == IN_USE ) then
		        print( "hi" )
		    end
		end )
		```
		
		#### Example 2
		When a player tries to jump, they will be shot straight up in the air.
		
		```lua 
		hook.Add( "KeyPress", "keypress_jump_super", function( ply, key )
		    if ( key == IN_JUMP ) then
		        ply:SetVelocity( ply:GetVelocity() + Vector( 0, 0, 1000 ) )
		    end
		end )
		```
    **/
    var KeyPress:GMHook<(ply:Player, key:IN) -> Void>; 
    
    
    /**
        Allows to override player flying ( in mid-air, not noclipping ) animations.
		
		Name | Description
		--- | ---
		`ply` | The player
		`velocity` | Players velocity
		
		
		`**Returns:** Return true if we've changed/set the animation, false otherwise
    **/
    var HandlePlayerVaulting:GMHook<(ply:Player, velocity:Float) -> Bool>; 
    
    #if server
    /**
        Returns whether or not the player can see the other player's chat.
		
		Name | Description
		--- | ---
		`text` | The chat text
		`teamOnly` | If the message is team-only
		`listener` | The player receiving the message
		`speaker` | The player sending the message
		
		
		`**Returns:** Can see other player's chat
    **/
    var PlayerCanSeePlayersChat:GMHook<(text:String, teamOnly:Bool, listener:Player, speaker:Player) -> Bool>; 
    #end
    #if server
    /**
        Called every think while the player is dead. The return value will determine if the player respawns. 
		
		Overwriting this function will prevent players from respawning by pressing space or clicking.
		
		**Bug:** BUG This hook is not called for players with the FL_FROZEN flag applied. Issue Tracker: #1577
		
		Name | Description
		--- | ---
		`ply` | The player affected in the hook.
		
		
		`**Returns:** Allow spawn
    **/
    var PlayerDeathThink:GMHook<(ply:Player) -> Bool>; 
    #end
    
    /**
        Called when a key-value pair is set on an entity, either by the engine (for example when map spawns) or Entity:SetKeyValue. 
		
		See ENTITY:KeyValue for a hook that works for scripted entities. See WEAPON:KeyValue for a hook that works for scripted weapons.
		
		Name | Description
		--- | ---
		`ent` | Entity that the keyvalue is being set on
		`key` | Key of the key/value pair
		`value` | Value of the key/value pair
		
		
		`**Returns:** If set, the value of the key-value pair will be overridden by this string.
    **/
    var EntityKeyValue:GMHook<(ent:Entity, key:String, value:String) -> String>; 
    
    #if client
    /**
        Called before the view model has been drawn. This hook by default also calls this on weapons, so you can use WEAPON:PreDrawViewModel.
		
		**Note:** This is a rendering hook with a 3D rendering context. This means that the only rendering functions will work in it are functions with a 3D rendering context.
		
		**Bug:** BUG This is also called once a frame with no arguments. Issue Tracker: #3024
		
		Name | Description
		--- | ---
		`vm` | This is the view model entity before it is drawn. On server-side, this entity is the predicted view model.
		`ply` | The the owner of the view model.
		`weapon` | This is the weapon that is from the view model.
		
		
		`**Returns:** Return true to prevent the default view model rendering. This also affects GM: PostDrawViewModel.
    **/
    var PreDrawViewModel:GMHook<(vm:Entity, ply:Player, weapon:Weapon) -> Bool>; 
    #end
    
    /**
        Allows to override player landing animations.
		
		Name | Description
		--- | ---
		`ply` | The player
		`velocity` | Players velocity
		`onGround` | Was the player on ground?
		
		
		`**Returns:** Return true if we've changed/set the animation, false otherwise
    **/
    var HandlePlayerLanding:GMHook<(ply:Player, velocity:Float, onGround:Bool) -> Bool>; 
    
    #if server
    /**
        Returns whether or not a player is allowed to pick up a weapon.
		
		Name | Description
		--- | ---
		`ply` | The player attempting to pick up the weapon
		`wep` | The weapon entity in question
		
		
		`**Returns:** Allowed pick up or not
		
		___
		### Lua Examples
		#### Example 1
		Disallows picking up a weapon if player already has this weapon. ( Prevents ammo pickups from lying guns )
		
		```lua 
		hook.Add( "PlayerCanPickupWeapon", "noDoublePickup", function( ply, wep )
		    if ( ply:HasWeapon( wep:GetClass() ) ) then return false end
		end )
		```
		
		#### Example 2
		Players can only pick up the HL2 Pistol.
		
		```lua 
		function GM:PlayerCanPickupWeapon(ply, wep)
		    return (wep:GetClass() == "weapon_pistol")
		end
		```
		
		#### Example 3
		How you could give a player an alternate weapon to the one they picked up (such as an RPG Launcher rather than a pistol)
		
		```lua 
		hook.Add( "PlayerCanPickupWeapon", "NoPistolGiveFists", function( ply, wep )
		    if wep:GetClass() == "weapon_pistol" then -- if the weapon they are trying to pick up is a pistol
		        ply:Give( "weapon_rpg" ) -- give them an RPG
		        wep:Remove() -- remove the one they were trying to pick up
		        return false -- don't give them a pistol
		    end
		end )
		```
    **/
    var PlayerCanPickupWeapon:GMHook<(ply:Player, wep:Weapon) -> Bool>; 
    #end
    
    /**
        Called when downloading content from Steam workshop ends. Used by default to hide fancy workshop downloading panel.
    **/
    var WorkshopEnd:GMHook<() -> Void>; 
    
    #if server
    /**
        Called right after GM:DoPlayerDeath, GM:PlayerDeath and GM:PlayerSilentDeath. 
		
		This hook will be called for all deaths, including Player:KillSilent
		
		**Note:** The player is considered dead when this is hook is called, Player:Alive will return false.
		
		Name | Description
		--- | ---
		`ply` | The player
    **/
    var PostPlayerDeath:GMHook<(ply:Player) -> Void>; 
    #end
    #if client
    /**
        Called when the mouse has been double clicked on any panel derived from CGModBase, such as the panel used by gui.EnableScreenClicker and the panel used by Panel:ParentToHUD. 
		
		By default this hook calls GM:GUIMousePressed.
		
		Name | Description
		--- | ---
		`mouseCode` | The code of the mouse button pressed, see MOUSE_ Enums
		`aimVector` | A normalized vector pointing in the direction the client has clicked
    **/
    var GUIMouseDoublePressed:GMHook<(mouseCode:MOUSE, aimVector:Vector) -> Void>; 
    #end
    
    /**
        Sets player run and sprint speeds.
		
		**Warning:** This is not a hook. Treat this as a utility function to set the player's speed.
		
		Name | Description
		--- | ---
		`ply` | The player to set the speed of.
		`walkSpeed` | The walk speed.
		`runSpeed` | The run speed.
    **/
    var SetPlayerSpeed:GMHook<(ply:Player, walkSpeed:Float, runSpeed:Float) -> Void>; 
    
    #if client
    /**
        Called after drawing the skybox.
		
		**Note:** This is a rendering hook with a 3D rendering context. This means that the only rendering functions will work in it are functions with a 3D rendering context.
    **/
    var PostDrawSkyBox:GMHook<() -> Void>; 
    #end
    
    /**
        Called after GM:Move, applies all the changes from the CMoveData to the player. 
		
		See Game Movement for an explanation on the move system.
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		Name | Description
		--- | ---
		`ply` | Player
		`mv` | Movement data
		
		
		`**Returns:** Return true to suppress default engine behavior, i.e. declare that you have already moved the player according to the move data in a custom way.
    **/
    var FinishMove:GMHook<(ply:Player, mv:CMoveData) -> Bool>; 
    
    #if server
    /**
        Determines if the player can kill themselves using the concommands "kill" or "explode".
		
		Name | Description
		--- | ---
		`player` | The player
		
		
		`**Returns:** True if they can suicide.
		
		___
		### Lua Examples
		#### Example 1
		Makes suiciding only accessible for super admins.
		
		```lua 
		function GM:CanPlayerSuicide( ply )
		    return ply:IsSuperAdmin()
		end
		```
    **/
    var CanPlayerSuicide:GMHook<(player:Player) -> Bool>; 
    #end
    #if client
    /**
        Called whenever an entity becomes a clientside ragdoll. 
		
		See GM:CreateEntityRagdoll for serverside ragdolls.
		
		Name | Description
		--- | ---
		`entity` | The Entity that created the ragdoll
		`ragdoll` | The ragdoll being created.
		
		
		___
		### Lua Examples
		#### Example 1
		A way of fade out a ragdoll easily. Idea from here.
		
		```lua 
		hook.Add( "CreateClientsideRagdoll", "fade_out_corpses", function( entity, ragdoll )
		
		    ragdoll:SetSaveValue( "m_bFadingOut", true ) -- Set the magic internal variable that will cause the ragdoll to immediately start fading out
		
		end )
		```
    **/
    var CreateClientsideRagdoll:GMHook<(entity:Entity, ragdoll:Entity) -> Void>; 
    #end
    
    /**
        Called right before an entity starts driving. Overriding this hook will cause it to not call drive.Start and the player will not begin driving the entity.
		
		Name | Description
		--- | ---
		`ent` | The entity that is going to be driven
		`ply` | The player that is going to drive the entity
    **/
    var StartEntityDriving:GMHook<(ent:Entity, ply:Player) -> Void>; 
    
    #if client
    /**
        Allows you to use render.Fog* functions to manipulate world fog.
		
		`**Returns:** Return true to tell the engine that fog is set up
    **/
    var SetupWorldFog:GMHook<() -> Bool>; 
    #end
    #if server
    /**
        Called when a player is killed by Player:Kill or any other normal means. 
		
		This hook is not called if the player is killed by Player:KillSilent. See GM:PlayerSilentDeath for that.
		
		**Note:** Player:Alive will return true in this hook.
		
		Name | Description
		--- | ---
		`victim` | The player who died
		`inflictor` | Item used to kill the victim
		`attacker` | Player or entity that killed the victim
		
		
		___
		### Lua Examples
		#### Example 1
		If the player suicides (he is the killer and the victim (ply)), then it will print a message to console. If someone else kills him, it will print a different message to console.
		
		```lua 
		function GM:PlayerDeath( victim, inflictor, attacker )
		    if ( victim == attacker ) then
		        PrintMessage( HUD_PRINTTALK, victim:Name() .. " committed suicide." )
		    else
		        PrintMessage( HUD_PRINTTALK, victim:Name() .. " was killed by " .. attacker:Name() .. ".")
		    end
		end
		```
		**Output:**
		
		If suicide: Player1 has committed suicide. Else: Player1 was killed by Player2.
    **/
    var PlayerDeath:GMHook<(victim:Player, inflictor:Entity, attacker:Entity) -> Void>; 
    #end
    #if server
    /**
        Decides whether a player can hear another player using voice chat.
		
		**Note:** This hook is called several times a tick, so ensure your code is efficient.
		
		Name | Description
		--- | ---
		`listener` | The listening player.
		`talker` | The talking player.
		
		
		Name | Description
		--- | ---
		`a` | Return true if the listener should hear the talker, false if they shouldn't.
		`b` | 3D sound. If set to true, will fade out the sound the further away listener is from the talker, the voice will also be in stereo, and not mono.
		
		
		___
		### Lua Examples
		#### Example 1
		Players can only hear each other if they are within 500 units.
		
		```lua 
		hook.Add("PlayerCanHearPlayersVoice", "Maximum Range", function(listener, talker)
		    if listener:GetPos() -> Distance>;(talker:GetPos()) > 500 then return false end
		end)
		```
    **/
    var PlayerCanHearPlayersVoice:GMHook<(listener:Player, talker:Player) -> Dynamic>;  //return
    #end
    #if server
    /**
        Called when a player has changed team using GM:PlayerJoinTeam.
		
		**Warning:** This hook will not work with hook.Add and it is only called manually from GM:PlayerJoinTeam by the base gamemode
		
		Name | Description
		--- | ---
		`ply` | Player who has changed team
		`oldTeam` | Index of the team the player was originally in
		`newTeam` | Index of the team the player has changed to
    **/
    var OnPlayerChangedTeam:GMHook<(ply:Player, oldTeam:Float, newTeam:Float) -> Void>; 
    #end
    
    /**
        Allows to override player driving animations.
		
		Name | Description
		--- | ---
		`ply` | Player to process
		
		
		`**Returns:** Return true if we've changed/set the animation, false otherwise
    **/
    var HandlePlayerDriving:GMHook<(ply:Player) -> Bool>; 
    
    #if server
    /**
        Called when a player enters a vehicle. 
		
		Called just after GM:CanPlayerEnterVehicle. 
		
		 See also GM:PlayerLeaveVehicle.
		
		Name | Description
		--- | ---
		`ply` | Player who entered vehicle
		`veh` | Vehicle the player entered
		`role` | 
    **/
    var PlayerEnteredVehicle:GMHook<(ply:Player, veh:Vehicle, role:Float) -> Void>; 
    #end
    #if client
    /**
        Called when an item has been picked up. Override to disable the default HUD notification.
		
		Name | Description
		--- | ---
		`itemName` | Name of the picked up item
    **/
    var HUDItemPickedUp:GMHook<(itemName:String) -> Void>; 
    #end
    #if client
    /**
        Called whenever a players presses a mouse key on the context menu in Sandbox or on any panel derived from CGModBase, such as the panel used by gui.EnableScreenClicker and the panel used by Panel:ParentToHUD. 
		
		See GM:VGUIMousePressed for a hook that is called on all VGUI elements.
		
		Name | Description
		--- | ---
		`mouseCode` | The key that the player pressed using MOUSE_ Enums.
		`aimVector` | A normalized direction vector local to the camera. Internally, this is gui. ScreenToVector( gui. MousePos() ).
    **/
    var GUIMousePressed:GMHook<(mouseCode:MOUSE, aimVector:Vector) -> Void>; 
    #end
    #if client
    /**
        Called before GM:HUDPaint when the HUD background is being drawn. Things rendered in this hook will always appear behind things rendered in GM:HUDPaint.
		
		**Note:** This is a rendering hook with a 2D rendering context. This means that the only rendering functions will work in it are functions with a 2D rendering context.
    **/
    var HUDPaintBackground:GMHook<() -> Void>; 
    #end
    #if server
    /**
        Called when the player is killed by Player:KillSilent. The player is already considered dead when this hook is called.
		
		**Note:** Player:Alive will return true in this hook.
		
		Name | Description
		--- | ---
		`ply` | The player who was killed
    **/
    var PlayerSilentDeath:GMHook<(ply:Player) -> Void>; 
    #end
    #if server
    /**
        Called when a player has been hurt by an explosion. Override to disable default sound effect.
		
		Name | Description
		--- | ---
		`ply` | Player who has been hurt
		`dmginfo` | Damage info from explsion
		
		
		___
		### Lua Examples
		#### Example 1
		Disables the high pitched ringing sound effect.Note that this hook does not have a return value, and instead by default it calls Player:SetDSP( 35, false ) in the base gamemode.
		
		```lua 
		hook.Add( "OnDamagedByExplosion", "DisableSound", function()
		    return true
		end )
		```
    **/
    var OnDamagedByExplosion:GMHook<(ply:Player, dmginfo:CTakeDamageInfo) -> Void>; 
    #end
    #if server
    /**
        Called when a player dispatched a chat message. For the clientside equivalent, see GM:OnPlayerChat.
		
		Name | Description
		--- | ---
		`sender` | The player which sent the message.
		`text` | The message's content
		`teamChat` | Is team chat?
		
		
		`**Returns:** What to show instead of original text. Set to "" to stop the message from displaying.
		
		___
		### Lua Examples
		#### Example 1
		Will put "[Global]" in front of the players message if they type "/all " before the message.
		
		```lua 
		hook.Add("PlayerSay", "PlayerSayExample", function( ply, text, team )
		    -- Make the chat message entirely lowercase
		    if ( string.sub(string.lower( text ),1,4) == "/all" ) then
		        return "[Global] " .. string.sub( text, 5 ) -- add [Global] in front of the players text then display
		    end
		end)
		```
    **/
    var PlayerSay:GMHook<(sender:Player, text:String, teamChat:Bool) -> String>; 
    #end
    
    /**
        Called right after the map has cleaned up (usually because game.CleanUpMap was called) 
		
		See also GM:PreCleanupMap.
    **/
    var PostCleanupMap:GMHook<() -> Void>; 
    
    
    /**
        Override this gamemode function to disable mouth movement when talking on voice chat.
		
		Name | Description
		--- | ---
		`ply` | Player in question
    **/
    var MouthMoveAnimation:GMHook<(ply:Player) -> Void>; 
    
    
    /**
        Called after the player's think.
		
		Name | Description
		--- | ---
		`ply` | The player
    **/
    var PlayerPostThink:GMHook<(ply:Player) -> Void>; 
    
    
    /**
        Called when a player tries to switch noclip mode.
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		Name | Description
		--- | ---
		`ply` | The person who entered/exited noclip
		`desiredState` | Represents the noclip state (on/off) the user will enter if this hook allows them to.
		
		
		`**Returns:** Return false to disallow the switch.
		
		___
		### Lua Examples
		#### Example 1
		Disable Noclip for all but admins.
		
		```lua 
		local function DisableNoclip( ply )
		    return ply:IsAdmin()
		end
		hook.Add( "PlayerNoClip", "DisableNoclip", DisableNoclip )
		```
		
		#### Example 2
		Get the player when they enter/exit no clip and display their status
		
		```lua 
		hook.Add( "PlayerNoClip", "isInNoClip", function( ply, desiredNoClipState )
		    if ( desiredNoClipState ) then
		        print( ply:Name() .. " wants to enter noclip." )
		    else
		        print( ply:Name() .. " wants to leave noclip." )
		    end
		end )
		```
		
		#### Example 3
		While keeping the default behaviour of admin-only noclip, the following example will also allow anyone to turn it off (if it's set on by a third-party administration addon, for example).
		
		```lua 
		hook.Add( "PlayerNoClip", "FeelFreeToTurnItOff", function( ply, desiredState )
		    if ( desiredState == false ) then -- the player wants to turn noclip off
		        return true -- always allow
		    elseif ( ply:IsAdmin() ) then
		        return true -- allow administrators to enter noclip
		    end
		end )
		```
    **/
    var PlayerNoClip:GMHook<(ply:Player, desiredState:Bool) -> Bool>; 
    
    
    /**
        Called to update the player's animation during a drive.
		
		Name | Description
		--- | ---
		`ply` | The driving player
    **/
    var PlayerDriveAnimate:GMHook<(ply:Player) -> Void>; 
    
    #if server
    /**
        Called when a player leaves a vehicle.
		
		**Note:** For vehicles with exit animations, this will be called at the end of the animation, not at the start!
		
		**Bug:** BUG This is not called when a different vehicle is immediately entered with Player:EnterVehicle. Issue Tracker: #2619
		
		Name | Description
		--- | ---
		`ply` | Player who left a vehicle.
		`veh` | Vehicle the player left.
		
		
		___
		### Lua Examples
		#### Example 1
		Make the vehicle continue running (or more precisely start its engine again) when a player exists it, unless the player holds their Reload key.
		
		```lua 
		hook.Add( "PlayerLeaveVehicle", "PlayerLeaveVehicleTurnOn", function( ply, veh )
		    if ( ply:KeyDown( IN_RELOAD ) ) then return end
		
		    -- We need to wait a few frames for the vehicle to stop working
		    timer.Create( "magic timer" .. veh:EntIndex(), 0, 2, function()
		        -- Only run on the last time the timer is fired
		        if ( timer.RepsLeft( "magic timer" .. veh:EntIndex() ) > 0 ) then return end
		
		        veh:StartEngine( true ) -- Start the engine back up
		        veh:ReleaseHandbrake() -- Release the handbrake
		    end )
		end )
		```
    **/
    var PlayerLeaveVehicle:GMHook<(ply:Player, veh:Vehicle) -> Void>; 
    #end
    
    /**
        Called when the game is reloaded from a Source Engine save system ( not the Sandbox saves or dupes ). 
		
		See GM:Saved for a hook that is called when such a save file is created.
    **/
    var Restored:GMHook<() -> Void>; 
    
    #if client
    /**
        Called to determine if the LocalPlayer should be drawn. 
		
		Due to an optimization, this hook is only called once per frame (github issue). This is problematic if you need to have the player drawn only in certain contexts, such as within render.RenderView or based on the render target. As a workaround, you can call cam.Start3D() cam.End3D() within this hook to force the engine to call it every time.
		
		**Note:** If you're using this hook to draw a player for a GM:CalcView hook, then you may want to consider using the drawviewer variable you can use in your CamData structure table instead.
		
		Name | Description
		--- | ---
		`ply` | The player
		
		
		`**Returns:** True to draw the player, false to hide.
    **/
    var ShouldDrawLocalPlayer:GMHook<(ply:Player) -> Bool>; 
    #end
    
    /**
        Called right before an entity stops driving. Overriding this hook will cause it to not call drive.End and the player will not stop driving.
		
		Name | Description
		--- | ---
		`ent` | The entity being driven
		`ply` | The player driving the entity
    **/
    var EndEntityDriving:GMHook<(ent:Entity, ply:Player) -> Void>; 
    
    #if server
    /**
        Called when a player executes gm_showspare2 console command. ( Default bind is F4 )
		
		Name | Description
		--- | ---
		`ply` | Player who executed the command
    **/
    var ShowSpare2:GMHook<(ply:Player) -> Void>; 
    #end
    #if server
    /**
        Find a team spawn point entity for this player.
		
		Name | Description
		--- | ---
		`team` | Players team
		`ply` | The player
		
		
		`**Returns:** The entity to use as a spawn point.
    **/
    var PlayerSelectTeamSpawn:GMHook<(team:Float, ply:Player) -> Entity>; 
    #end
    #if server
    /**
        Called when a player has been validated by Steam.
		
		Name | Description
		--- | ---
		`name` | Player name
		`steamID` | Player SteamID
    **/
    var NetworkIDValidated:GMHook<(name:String, steamID:String) -> Void>; 
    #end
    
    /**
        SetupMove is called before the engine process movements. This allows us to override the players movement. 
		
		See Game Movement for an explanation on the move system.
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		Name | Description
		--- | ---
		`ply` | The player whose movement we are about to process
		`mv` | The move data to override/use
		`cmd` | The command data
		
		
		___
		### Lua Examples
		#### Example 1
		Make drowning even more entertaining:
		
		```lua 
		hook.Add( "SetupMove", "Drowning:HandleWaterInLungs", function( ply, mv, cmd )
		    if ( ply:WaterLevel() > 2 ) then
		        mv:SetUpSpeed( -100 )
		        cmd:SetUpMove( -100 )
		    end
		end )
		```
		
		#### Example 2
		Disable the player's ability to jump by removing a key from CMoveData:
		
		```lua 
		local CMoveData = FindMetaTable("CMoveData")
		
		function CMoveData:RemoveKeys(keys)
		    -- Using bitwise operations to clear the key bits.
		    local newbuttons = bit.band(self:GetButtons(), bit.bnot(keys))
		    self:SetButtons(newbuttons)
		end
		
		hook.Add("SetupMove", "Disable Jumping", function(ply, mvd, cmd)
		    if mvd:KeyDown(IN_JUMP) then
		        mvd:RemoveKeys(IN_JUMP)
		    end
		end)
		```
    **/
    var SetupMove:GMHook<(ply:Player, mv:CMoveData, cmd:CUserCmd) -> Void>; 
    
    
    /**
        Called when a player presses a button.
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		Name | Description
		--- | ---
		`ply` | Player who pressed the button
		`button` | The button, see BUTTON_CODE_ Enums
    **/
    var PlayerButtonDown:GMHook<(ply:Player, button:BUTTON_CODE) -> Void>; 
    
    #if client
    /**
        Called when the Gamemode is about to draw a given element on the client's HUD (heads-up display).
		
		**Note:** This hook is called HUNDREDS of times per second (more than 5 times per frame on average). You shouldn't be performing any computationally intensive operations.
		
		Name | Description
		--- | ---
		`name` | The name of the HUD element. You can find a full list of HUD elements for this hook here.
		
		
		`**Returns:** Return false to prevent the given element from being drawn on the client's screen.
		
		___
		### Lua Examples
		#### Example 1
		Hides the default health and battery (armor) HUD elements, while still allowing the display of other elements to be controlled by other addons.
		
		```lua 
		local hide = {
		    ["CHudHealth"] = true,
		    ["CHudBattery"] = true
		}
		
		hook.Add( "HUDShouldDraw", "HideHUD", function( name )
		    if ( hide[ name ] ) then return false end
		
		    -- Don't return anything here, it may break other addons that rely on this hook.
		end )
		```
    **/
    var HUDShouldDraw:GMHook<(name:String) -> Bool>; 
    #end
    #if client
    /**
        Called when player released the scoreboard button. ( TAB by default )
    **/
    var ScoreboardHide:GMHook<() -> Void>; 
    #end
    
    /**
        Called upon an animation event, this is the ideal place to call player animation functions such as Player:AddVCDSequenceToGestureSlot, Player:AnimRestartGesture and so on.
		
		Name | Description
		--- | ---
		`ply` | Player who is being animated
		`event` | Animation event. See PLAYERANIMEVENT_ Enums
		`data` | The data for the event. This is interpreted as an ACT_ Enums by PLAYERANIMEVENT_CUSTOM and PLAYERANIMEVENT_CUSTOM_GESTURE, or a sequence by PLAYERANIMEVENT_CUSTOM_SEQUENCE.
		
		
		`**Returns:** The translated activity to send to the weapon. See ACT_ Enums. Return ACT_INVALID if you don't want to send an activity.
		
		___
		### Lua Examples
		#### Example 1
		Fires a custom animation event with PLAYERANIMEVENT_ATTACK_GRENADE as the event, and 123 as the extra data on primary attack, and 321 as the secondary attack. The player will play the item throw gesture on the primary attack, and the drop one on secondary.
		
		```lua 
		function SWEP:PrimaryAttack()
		    self.Owner:DoCustomAnimEvent( PLAYERANIMEVENT_ATTACK_GRENADE , 123 )
		    self:SetNextPrimaryFire(CurTime() + 0.5 )
		    self:SetNextSecondaryFire(CurTime() + 0.5 )
		end
		
		function SWEP:SecondaryAttack()
		    self.Owner:DoCustomAnimEvent( PLAYERANIMEVENT_ATTACK_GRENADE , 321 )
		    self:SetNextPrimaryFire(CurTime() + 0.5 )
		    self:SetNextSecondaryFire(CurTime() + 0.5 )
		end
		
		hook.Add("DoAnimationEvent" , "AnimEventTest" , function( ply , event , data )
		    if event == PLAYERANIMEVENT_ATTACK_GRENADE then
		        if data == 123 then
		            ply:AnimRestartGesture( GESTURE_SLOT_GRENADE, ACT_GMOD_GESTURE_ITEM_THROW, true )
		            return ACT_INVALID
		        end
		        
		        if data == 321 then
		            ply:AnimRestartGesture( GESTURE_SLOT_GRENADE, ACT_GMOD_GESTURE_ITEM_DROP, true )
		            return ACT_INVALID
		        end
		    end
		end)
		```
    **/
    var DoAnimationEvent:GMHook<(ply:Player, event:PLAYERANIMEVENT, ?data:ACT) -> ACT>; 
    
    
    /**
        Called when menu.lua has finished loading.
    **/
    var MenuStart:GMHook<() -> Void>; 
    
    
    /**
        Called when you start a new game via the menu.
    **/
    var StartGame:GMHook<() -> Void>; 
    
    #if client
    /**
        Render the scene. Used by the "Stereoscopy" Post-processing effect.
		
		**Note:** Materials rendered in this hook require $ignorez parameter to draw properly.
		
		Name | Description
		--- | ---
		`origin` | View origin
		`angles` | View angles
		`fov` | View FOV
		
		
		`**Returns:** Return true to override drawing the scene
    **/
    var RenderScene:GMHook<(origin:Vector, angles:Angle, fov:Float) -> Bool>; 
    #end
    
    /**
        Called when a player releases a button.
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		Name | Description
		--- | ---
		`ply` | Player who released the button
		`button` | The button, see BUTTON_CODE_ Enums
    **/
    var PlayerButtonUp:GMHook<(ply:Player, button:BUTTON_CODE) -> Void>; 
    
    
    /**
        Called when an addon from the Steam workshop begins downloading. Used by default to place details on the workshop downloading panel.
		
		Name | Description
		--- | ---
		`id` | Workshop ID of addon.
		`imageID` | ID of addon's preview image. For example, for Extended Spawnmenu addon, the image URL is http://cloud-4.steamusercontent.com/ugc/702859018846106764/9E7E1946296240314751192DA0AD15B6567FF92D/ So, the value of this argument would be 702859018846106764.
		`title` | Name of addon.
		`size` | File size of addon in bytes.
    **/
    var WorkshopDownloadFile:GMHook<(id:Float, imageID:Float, title:String, size:Float) -> Void>; 
    
    #if client
    /**
        Called after the player was drawn.
		
		**Note:** This is a rendering hook with a 3D rendering context. This means that the only rendering functions will work in it are functions with a 3D rendering context.
		
		Name | Description
		--- | ---
		`ply` | The player that was drawn.
		
		
		___
		### Lua Examples
		#### Example 1
		Show each player's name above their model.
		
		```lua 
		local function DrawName( ply )
		    if ( !IsValid( ply ) ) then return end 
		    if ( ply == LocalPlayer() ) then return end -- Don't draw a name when the player is you
		    if ( !ply:Alive() ) then return end -- Check if the player is alive 
		 
		    local Distance = LocalPlayer() -> GetPos>;() -> Distance>;( ply:GetPos() ) --Get the distance between you and the player
		    
		    if ( Distance Hook< 1000 ) then --If the distance is less than 1000 units, it will draw the name
		 
		        local offset = Vector( 0, 0, 85 )
		        local ang = LocalPlayer() -> EyeAngles>;()
		        local pos = ply:GetPos() + offset + ang:Up()
		     
		        ang:RotateAroundAxis( ang:Forward(), 90 )
		        ang:RotateAroundAxis( ang:Right(), 90 )
		     
		        
		        cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.25 )
		            draw.DrawText( ply:GetName(), "HudSelectionText", 2, 2, team.GetColor(ply:Team()), TEXT_ALIGN_CENTER )
		        cam.End3D2D()
		    end
		end
		hook.Add( "PostPlayerDraw", "DrawName", DrawName )
		```
		
		#### Example 2
		Draw a headcrab hat on all players.
		
		```lua 
		local model = ClientsideModel( "models/headcrabclassic.mdl" )
		model:SetNoDraw( true )
		
		hook.Add( "PostPlayerDraw" , "manual_model_draw_example" , function( ply )
		    if not IsValid(ply) or not ply:Alive() then return end
		
		    local attach_id = ply:LookupAttachment('eyes')
		    if not attach_id then return end
		            
		    local attach = ply:GetAttachment(attach_id)
		            
		    if not attach then return end
		            
		    local pos = attach.Pos
		    local ang = attach.Ang
		        
		    model:SetModelScale(1.1, 0)
		    pos = pos + (ang:Forward() * 2.5)
		    ang:RotateAroundAxis(ang:Right(), 20)
		        
		    model:SetPos(pos)
		    model:SetAngles(ang)
		
		    model:SetRenderOrigin(pos)
		    model:SetRenderAngles(ang)
		    model:SetupBones()
		    model:DrawModel()
		    model:SetRenderOrigin()
		    model:SetRenderAngles()
		
		end )
		```
    **/
    var PostPlayerDraw:GMHook<(ply:Player) -> Void>; 
    #end
    #if client
    /**
        Called after the VGUI has been drawn.
		
		**Note:** This is a rendering hook with a 2D rendering context. This means that the only rendering functions will work in it are functions with a 2D rendering context.
    **/
    var PostRenderVGUI:GMHook<() -> Void>; 
    #end
    #if server
    /**
        Called when a variable is edited on an Entity (called by Edit Properties... menu)
		
		Name | Description
		--- | ---
		`ent` | The entity being edited
		`ply` | The player doing the editing
		`key` | The name of the variable
		`val` | The new value, as a string which will later be converted to its appropriate type
		`editor` | The edit table defined in Entity: NetworkVar
		
		
		___
		### Lua Examples
		#### Example 1
		From base/gamemode/variable_edit.lua
		
		```lua 
		function GM:VariableEdited( ent, ply, key, val, editor )
		    if ( !IsValid( ent ) ) then return end
		    if ( !IsValid( ply ) ) then return end
		    local CanEdit = hook.Run( "CanEditVariable", ent, ply, key, val, editor )
		    if ( !CanEdit ) then return end
		    ent:EditValue( key, val )
		end
		```
    **/
    var VariableEdited:GMHook<(ent:Entity, ply:Player, key:String, val:String, editor:AnyTable) -> Void>; 
    #end
    #if server
    /**
        Called whenever a player attempts to either turn on or off their flashlight, returning false will deny the change.
		
		**Note:** Also gets called when using Player:Flashlight.
		
		Name | Description
		--- | ---
		`ply` | The player who attempts to change their flashlight state.
		`enabled` | The new state the player requested, true for on, false for off.
		
		
		`**Returns:** Can toggle the flashlight or not
    **/
    var PlayerSwitchFlashlight:GMHook<(ply:Player, enabled:Bool) -> Bool>; 
    #end
    #if server
    /**
        Called whenever an NPC is killed.
		
		Name | Description
		--- | ---
		`npc` | The killed NPC
		`attacker` | The NPCs attacker, the entity that gets the kill credit, for example a player or an NPC.
		`inflictor` | Death inflictor. The entity that did the killing. Not necessarily a weapon.
    **/
    var OnNPCKilled:GMHook<(npc:NPC, attacker:Entity, inflictor:Entity) -> Void>; 
    #end
    #if client
    /**
        Returns the team color for the given team index.
		
		Name | Description
		--- | ---
		`team` | Team index
		
		
		`**Returns:** Team Color
    **/
    var GetTeamNumColor:GMHook<(team:Float) -> AnyTable>; 
    #end
    #if client
    /**
        Called when a DTextEntry gets focus. 
		
		This hook is run from DTextEntry:OnGetFocus and PANEL:OnMousePressed of DTextEntry.
		
		Name | Description
		--- | ---
		`panel` | The panel that got focus
    **/
    var OnTextEntryGetFocus:GMHook<(panel:Panel) -> Void>; 
    #end
    #if server
    /**
        Determines if the player can spray using the "impulse 201" console command.
		
		Name | Description
		--- | ---
		`sprayer` | The player
		
		
		`**Returns:** Return false to allow spraying, return true to prevent spraying.
		
		___
		### Lua Examples
		#### Example 1
		Makes so that only Admins can spray.
		
		```lua 
		hook.Add( "PlayerSpray", "DisablePlayerSpray", function( ply )
		    return !ply:IsAdmin()
		end )
		```
    **/
    var PlayerSpray:GMHook<(sprayer:Player) -> Bool>; 
    #end
    
    /**
        Called whenever a player steps. Return true to mute the normal sound.
		
		Name | Description
		--- | ---
		`ply` | The stepping player
		`pos` | The position of the step
		`foot` | Foot that is stepped. 0 for left, 1 for right
		`sound` | Sound that is going to play
		`volume` | Volume of the footstep
		`filter` | The Recipient filter of players who can hear the footstep
		
		
		`**Returns:** Prevent default step sound
		
		___
		### Lua Examples
		#### Example 1
		Disables default player footsteps and plays custom ones.
		
		```lua 
		function GM:PlayerFootstep( ply, pos, foot, sound, volume, rf ) 
		    ply:EmitSound("NPC_Hunter.Footstep") -- Play the footsteps hunter is using
		    return true -- Don't allow default footsteps
		end
		```
    **/
    
	
	#if server
    var PlayerFootstep:GMHook<(ply:Player, pos:Vector, foot:Float, sound:String, volume:Float, filter:CRecipientFilter) -> Bool>; 
	#else
	var PlayerFootstep:GMHook<(ply:Player, pos:Vector, foot:Float, sound:String, volume:Float) -> Bool>; 
	#end
    /**
        Called when the player changes their weapon to another one - and their viewmodel model changes.
		
		**Bug:** BUG This is not always called clientside. Issue Tracker: #2473
		
		Name | Description
		--- | ---
		`viewmodel` | The viewmodel that is changing
		`oldModel` | The old model
		`newModel` | The new model
    **/
    var OnViewModelChanged:GMHook<(viewmodel:Entity, oldModel:String, newModel:String) -> Void>; 
    
    
    /**
        Called when a prop has been destroyed.
		
		Name | Description
		--- | ---
		`attacker` | The person who broke the prop.
		`prop` | The entity that has been broken by the attacker.
		
		
		___
		### Lua Examples
		#### Example 1
		This kills a player when a person breaks a prop (i.e. a wooden crate).
		
		```lua 
		hook.Add("PropBreak", "PropVengeance", function(client, prop)
		    client:Kill()
		end)
		```
    **/
    var PropBreak:GMHook<(attacker:Player, prop:Entity) -> Void>; 
    
    #if server
    /**
        Called to determine preferred carry angles for the entity. It works for both, +use pickup and gravity gun pickup.
		
		**Warning:** Due to nature of the gravity gun coding in multiplayer, this hook MAY seem to not work ( but rest assured it does ), due to clientside prediction not knowing the carry angles. The +use pickup doesn't present this issue as it doesn't predict the player carrying the object clientside ( as you may notice by the prop lagging behind in multiplayer )
		
		**Note:** This hook can not override preferred carry angles of props such as the sawblade and the harpoon.
		
		Name | Description
		--- | ---
		`ent` | The entity to generate carry angles for
		
		
		`**Returns:** The preferred carry angles for the entity.
		
		___
		### Lua Examples
		#### Example 1
		Makes all pickupable entities default to Angle( 0, 0, 0 ) relatively to players aim direction.
		
		```lua 
		hook.Add( "GetPreferredCarryAngles", "MyPreferredCarryAngles", function( ent )
		    return Angle( 0, 0, 0 )
		end )
		```
    **/
    var GetPreferredCarryAngles:GMHook<(ent:Entity) -> Angle>; 
    #end
    #if server
    /**
        Determines if the player can unfreeze the entity.
		
		Name | Description
		--- | ---
		`player` | The player
		`entity` | The entity
		`phys` | The physics object of the entity
		
		
		`**Returns:** True if they can unfreeze.
    **/
    var CanPlayerUnfreeze:GMHook<(player:Player, entity:Entity, phys:PhysObj) -> Bool>; 
    #end
    #if client
    /**
        Adds a death notice entry.
		
		**Bug:** BUG You cannot use hook.Add on this hook yet. Issue Tracker: #2611 Pull Request: #1380
		
		Name | Description
		--- | ---
		`attacker` | The name of the attacker
		`attackerTeam` | The team of the attacker
		`inflictor` | Class name of the entity inflicting the damage
		`victim` | Name of the victim
		`victimTeam` | Team of the victim
		
		
		___
		### Lua Examples
		#### Example 1
		Shows a suicide death notice in Sandbox.
		
		```lua 
		local ply = Entity(1)
		GAMEMODE:AddDeathNotice( ply:GetName(), ply:Team(), nil, ply:GetName(), ply:Team() )
		```
    **/
    var AddDeathNotice:GMHook<(attacker:String, attackerTeam:Float, inflictor:String, victim:String, victimTeam:Float) -> Void>; 
    #end
    #if client
    /**
        Called before rendering the halos. This is the place to call halo.Add. This hook is actually running inside of GM:PostDrawEffects.
		
		**Note:** This is a rendering hook with a 3D rendering context. This means that the only rendering functions will work in it are functions with a 3D rendering context.
    **/
    var PreDrawHalos:GMHook<() -> Void>; 
    #end
    
    /**
        Called after the gamemode has loaded.
    **/
    var PostGamemodeLoaded:GMHook<() -> Void>; 
    
    #if client
    /**
        Called when the context menu keybind (+menu_context) is released, which by default is C. 
		
		This hook will not run if input.IsKeyTrapping returns true. 
		
		 See also GM:OnContextMenuOpen.
    **/
    var OnContextMenuClose:GMHook<() -> Void>; 
    #end
    #if client
    /**
        Allows you to change the players movements before they're sent to the server. 
		
		See Game Movement for an explanation on the move system.
		
		**Note:** Due to this hook being clientside only, it could be overridden by the user allowing them to completely skip your logic, it is recommended to use GM:StartCommand in a shared file instead.
		
		Name | Description
		--- | ---
		`cmd` | The User Command data
		
		
		`**Returns:** Return true to: Disable Sandbox C menu "screen clicking" Disable Teammate nocollide (verification required) Prevent calling of C_BaseHLPlayer::CreateMove & subsequently C_BasePlayer::CreateMove
    **/
    var CreateMove:GMHook<(cmd:CUserCmd) -> Bool>; 
    #end
    
    /**
        Called when a player drops an entity with the Physgun.
		
		Name | Description
		--- | ---
		`ply` | The player who dropped an entitiy
		`ent` | The dropped entity
    **/
    var PhysgunDrop:GMHook<(ply:Player, ent:Entity) -> Void>; 
    
    #if server
    /**
        Returns whether or not the default death sound should be muted.
		
		`**Returns:** Mute death sound
    **/
    var PlayerDeathSound:GMHook<() -> Bool>; 
    #end
    #if client
    /**
        Called when a player has achieved an achievement. You can get the name and other information from an achievement ID with the achievements library.
		
		Name | Description
		--- | ---
		`ply` | The player that earned the achievement
		`achievement` | The index of the achievement
    **/
    var OnAchievementAchieved:GMHook<(ply:Player, achievement:Float) -> Void>; 
    #end
    
    /**
        Allows to override player swimming animations.
		
		Name | Description
		--- | ---
		`ply` | The player
		`velocity` | Players velocity
		
		
		`**Returns:** Return true if we've changed/set the animation, false otherwise
    **/
    var HandlePlayerSwimming:GMHook<(ply:Player, velocity:Float) -> Bool>; 
    
    
    /**
        This hook is used to calculate animations for a player.
		
		**Warning:** This hook must return the same values at the same time on both, client and server. On client for players to see the animations, on server for hit detection to work properly.
		
		**Bug:** BUG This can return the incorrect velocity when on a moving object. Issue Tracker: #3322
		
		Name | Description
		--- | ---
		`ply` | The player to apply the animation.
		`vel` | The velocity of the player.
		
		
		Name | Description
		--- | ---
		`a` | ACT_ Enums for the activity the player should use. A nil return will be treated as ACT_INVALID.
		`b` | Sequence for the player to use. This takes precedence over the activity (the activity is still used for layering). Return -1 or nil to let the activity determine the sequence.
    **/
    var CalcMainActivity:GMHook<(ply:Player, vel:Vector) -> Dynamic>; 
    
    #if client
    /**
        Called when a weapon has been picked up. Override to disable the default HUD notification.
		
		Name | Description
		--- | ---
		`weapon` | The picked up weapon
    **/
    var HUDWeaponPickedUp:GMHook<(weapon:Weapon) -> Void>; 
    #end
    #if client
    /**
        Called right after the 2D skybox has been drawn - allowing you to draw over it.
		
		**Note:** This is a rendering hook with a 3D rendering context. This means that the only rendering functions will work in it are functions with a 3D rendering context.
		
		___
		### Lua Examples
		#### Example 1
		Draw a textured quad on the horizon, behind the 3D skybox.
		
		```lua 
		local Mat = Material( "dev/graygrid" )
		
		hook.Add("PostDraw2DSkyBox", "ExampleHook", function()
		    
		    render.OverrideDepthEnable( true, false ) -- ignore Z to prevent drawing over 3D skybox
		
		    -- Start 3D cam centered at the origin
		    cam.Start3D( Vector( 0, 0, 0 ), EyeAngles() )
		        render.SetMaterial( Mat )
		        render.DrawQuadEasy( Vector(1,0,0) * 200, Vector(-1,0,0), 64, 64, Color(255,255,255), 0 )
		    cam.End3D()
		
		    render.OverrideDepthEnable( false, false )
		
		end)
		```
    **/
    var PostDraw2DSkyBox:GMHook<() -> Void>; 
    #end
    #if client
    /**
        Called after all other 2D draw hooks are called. Draws over all VGUI Panels and HUDs. 
		
		Unlike GM:HUDPaint, this hook is called with the game paused and while the Camera SWEP is equipped.
		
		**Note:** Only be called when r_drawvgui is enabled
		
		**Note:** This is a rendering hook with a 2D rendering context. This means that the only rendering functions will work in it are functions with a 2D rendering context.
    **/
    var DrawOverlay:GMHook<() -> Void>; 
    #end
    #if server
    /**
        Called whenever view model hands needs setting a model. By default this calls PLAYER:GetHandsModel and if that fails, sets the hands model according to his player model.
		
		Name | Description
		--- | ---
		`ply` | The player whose hands needs a model set
		`ent` | The hands to set model of
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the players hands to the model's hands.
		
		```lua 
		function GM:PlayerSetHandsModel( ply, ent )
		   local simplemodel = player_manager.TranslateToPlayerModelName(ply:GetModel())
		   local info = player_manager.TranslatePlayerHands(simplemodel)
		   if info then
		      ent:SetModel(info.model)
		      ent:SetSkin(info.skin)
		      ent:SetBodyGroups(info.body)
		   end
		end
		```
    **/
    var PlayerSetHandsModel:GMHook<(ply:Player, ent:Entity) -> Void>; 
    #end
    
    /**
        Called when the gamemode is loaded. 
		
		LocalPlayer() returns NULL at the time this is run.
    **/
    var OnGamemodeLoaded:GMHook<() -> Void>; 
    
    #if client
    /**
        Called just after GM:PreDrawViewModel and can technically be considered "PostDrawAllViewModels".
		
		**Note:** This is a rendering hook with a 3D rendering context. This means that the only rendering functions will work in it are functions with a 3D rendering context.
    **/
    var PreDrawEffects:GMHook<() -> Void>; 
    #end
    #if server
    /**
        Called whenever a player spawns, including respawns. 
		
		See GM:PlayerInitialSpawn for a hook called only the first time a player spawns. 
		
		 See the player_spawn gameevent for a shared version of this hook.
		
		**Warning:** By default, in "base" derived gamemodes, this hook will also call GM:PlayerLoadout and GM:PlayerSetModel, which may override your Entity:SetModel and Player:Give calls. Consider using the other hooks or a 0-second timer.
		
		Name | Description
		--- | ---
		`player` | The player who spawned.
		`transition` | If true, the player just spawned from a map transition. You probably want to not touch player's weapons if this is set to true from this hook.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints a message when a player spawns.
		
		```lua 
		function GM:PlayerSpawn( ply )
		    MsgN( ply:Nick() .. " has spawned!" )
		end
		```
		
		#### Example 2
		Prints a message when a player spawns using a hook.
		
		```lua 
		local function spawn( ply )
		    print( ply:Nick().. " has spawned!.")
		end
		hook.Add( "PlayerSpawn", "some_unique_name", spawn )
		```
    **/
    var PlayerSpawn:GMHook<(player:Player, transition:Bool) -> Void>; 
    #end
    #if client
    /**
        Allows you to use render.Fog* functions to manipulate skybox fog.
		
		Name | Description
		--- | ---
		`scale` | The scale of 3D skybox
		
		
		`**Returns:** Return true to tell the engine that fog is set up
    **/
    var SetupSkyboxFog:GMHook<(scale:Float) -> Bool>; 
    #end
    
    /**
        Called when an entity is about to be punted with the gravity gun (primary fire). 
		
		By default this function makes ENTITY:GravGunPunt work in Sandbox derived gamemodes.
		
		Name | Description
		--- | ---
		`ply` | The player wielding the gravity gun
		`ent` | The entity the player is attempting to punt
		
		
		`**Returns:** Return true to allow and false to disallow.
    **/
    var GravGunPunt:GMHook<(ply:Player, ent:Entity) -> Bool>; 
    
    #if server
    /**
        Called when a player takes damage from falling, allows to override the damage.
		
		Name | Description
		--- | ---
		`ply` | The player
		`speed` | The fall speed
		
		
		`**Returns:** New fall damage
		
		___
		### Lua Examples
		#### Example 1
		The player takes a realistic amount of damage when they fall. Fall damage becomes the fall speed divided by 8.
		
		```lua 
		function GM:GetFallDamage( ply, speed )
		    return ( speed / 8 )
		end
		```
		
		#### Example 2
		Closely approximates the Counter-Strike: Source fall damage.
		
		```lua 
		function GM:GetFallDamage( ply, speed )
		    return math.max( 0, math.ceil( 0.2418*speed - 141.75 ) )
		end
		```
    **/
    var GetFallDamage:GMHook<(ply:Player, speed:Float) -> Float>; 
    #end
    #if server
    /**
        Determines if the player can exit the vehicle.
		
		Name | Description
		--- | ---
		`veh` | The vehicle entity
		`ply` | The player
		
		
		`**Returns:** True if the player can exit the vehicle.
		
		___
		### Lua Examples
		#### Example 1
		Only lets player exit vehicle if it is not in motion.
		
		```lua 
		function GM:CanExitVehicle(veh, ply)
		    return (veh:GetVelocity() == Vector(0,0,0))
		end
		```
    **/
    var CanExitVehicle:GMHook<(veh:Vehicle, ply:Player) -> Bool>; 
    #end
    #if client
    /**
        Runs when a bind has been pressed. Allows to block commands.
		
		**Note:** By using the "alias" console command, this hook can be effectively circumvented
		
		**Note:** To stop the user from using +attack, +left and any other movement commands of the sort, please look into using GM:StartCommand instead
		
		**Bug:** BUG The third argument will always be true. Issue Tracker: #1176
		
		**Bug:** BUG This does not run for function keys binds (F1-F12). Issue Tracker: #2888
		
		Name | Description
		--- | ---
		`ply` | The player who used the command; this will always be equal to LocalPlayer
		`bind` | The bind command
		`pressed` | If the bind was activated or deactivated
		
		
		`**Returns:** Return true to prevent the bind
		
		___
		### Lua Examples
		#### Example 1
		Prevents players from using flashlight.
		
		```lua 
		hook.Add( "PlayerBindPress", "PlayerBindPressExample", function( ply, bind, pressed )
		    --To block more commands, you could add another line similar to
		    --the one below, just replace the command
		    if ( string.find( bind, "impulse 100" ) ) then return true end
		end )
		```
    **/
    var PlayerBindPress:GMHook<(ply:Player, bind:String, pressed:Bool) -> Bool>; 
    #end
    #if client
    /**
        Called after drawing opaque entities. 
		
		See also GM:PostDrawTranslucentRenderables and GM:PreDrawOpaqueRenderables.
		
		**Note:** This is a rendering hook with a 3D rendering context. This means that the only rendering functions will work in it are functions with a 3D rendering context.
		
		Name | Description
		--- | ---
		`bDrawingDepth` | Whether the current draw is writing depth.
		`bDrawingSkybox` | Whether the current draw is drawing the skybox.
    **/
    var PostDrawOpaqueRenderables:GMHook<(bDrawingDepth:Bool, bDrawingSkybox:Bool) -> Void>; 
    #end
    #if client
    /**
        Called from GM:CalcView when player is in driving a vehicle. 
		
		This hook may not be called in gamemodes that override GM:CalcView.
		
		Name | Description
		--- | ---
		`veh` | The vehicle the player is driving
		`ply` | The vehicle driver
		`view` | The view data containing players FOV, view position and angles, see CamData structure
		
		
		`**Returns:** The modified view table containing new values, see CamData structure
    **/
    var CalcVehicleView:GMHook<(veh:Vehicle, ply:Player, view:CamData) -> CamData>; 
    #end
    #if client
    /**
        Called when a message is printed to the chat box. Note, that this isn't working with player messages even though there are arguments for it. 
		
		For player messages see GM:PlayerSay and GM:OnPlayerChat
		
		Name | Description
		--- | ---
		`index` | The index of the player.
		`name` | The name of the player.
		`text` | The text that is being sent.
		`type` | Chat filter type. Possible values are: joinleave - Player join and leave messages namechange - Player name change messages servermsg - Server messages such as convar changes teamchange - Team changes? chat - (Obsolete?) Player chat? none - A fallback value
		
		
		`**Returns:** Return true to suppress the chat message
		
		___
		### Lua Examples
		#### Example 1
		Hides default join and leave messages in chat.
		
		```lua 
		hook.Add( "ChatText", "hide_joinleave", function( index, name, text, typ )
		    if ( typ == "joinleave" ) then return true end
		end )
		```
    **/
    var ChatText:GMHook<(index:Float, name:String, text:String, type:String) -> Bool>; 
    #end
    #if server
    /**
        Called when a map I/O event occurs. 
		
		See also Entity:Fire and Entity:Input for functions to fire Inputs on entities.
		
		Name | Description
		--- | ---
		`ent` | Entity that receives the input
		`input` | The input name. Is not guaranteed to be a valid input on the entity.
		`activator` | Activator of the input
		`caller` | Caller of the input
		`value` | Data provided with the input. Will be either a string, a number, a boolean or a nil.
		
		
		`**Returns:** Return true to prevent this input from being processed.
		
		___
		### Lua Examples
		#### Example 1
		This would block any input that the lua_run entity would receive.
		
		```lua 
		hook.Add( "AcceptInput", "BlockLuaRun", function( ent, name, activator, caller, data )
		    if ( ent:GetClass() == "lua_run" ) then
		        return true
		    end
		end )
		```
    **/
    var AcceptInput:GMHook<(ent:Entity, input:String, activator:Entity, caller:Entity, value:Dynamic) -> Bool>; 
    #end
    #if server
    /**
        Called to when a player has successfully picked up an entity with their Physics Gun. 
		
		Not to be confused with GM:PhysgunPickup which is called multiple times to ask if the player should be able to pick up an entity.
		
		Name | Description
		--- | ---
		`ply` | The player that has picked up something using the physics gun.
		`ent` | The entity that was picked up.
    **/
    var OnPhysgunPickup:GMHook<(ply:Player, ent:Entity) -> Void>; 
    #end
    #if client
    /**
        Allows you to adjust the mouse sensitivity.
		
		Name | Description
		--- | ---
		`defaultSensitivity` | The old sensitivity In general it will be 0, which is equivalent to a sensitivity of 1.
		
		
		`**Returns:** A fraction of the normal sensitivity (0.5 would be half as sensitive), return -1 to not override.
    **/
    var AdjustMouseSensitivity:GMHook<(defaultSensitivity:Float) -> Float>; 
    #end
    #if client
    /**
        Called when spawn icon is generated.
		
		Name | Description
		--- | ---
		`lastmodel` | File path of previously generated model.
		`imagename` | File path of the generated icon.
		`modelsleft` | Amount of models left to generate.
		
		
		___
		### Lua Examples
		#### Example 1
		That's how it is used in garrysmod/lua/includes/gui/icon_progress.lua for show progress of generating icons
		
		```lua 
		local g_Progress = nil
		
		hook.Add( "SpawniconGenerated", "SpawniconGenerated", function( lastmodel, imagename, modelsleft )
		
		    if ( !IsValid( g_Progress ) ) then
		    
		        g_Progress = vgui.Create( "DPanel" )
		        g_Progress:SetSize( 64+10, 64+10+20 )
		        g_Progress:SetBackgroundColor( Color( 0, 0, 0, 100 ) )
		        g_Progress:SetDrawOnTop( true )
		        g_Progress:DockPadding( 5, 0, 5, 5 )
		        g_Progress.Think = function()
		        
		            if ( SysTime() - g_Progress.LastTouch Hook< 3 ) then return end
		            
		            g_Progress:Remove()
		            g_Progress.LastTouch = SysTime()
		        
		        end
		        
		
		        
		        local label = g_Progress:Add( "DLabel" )
		        label:Dock( BOTTOM )
		        label:SetText( "remaining" )
		        label:SetTextColor( Color( 255, 255, 255, 255 ) )
		        label:SetExpensiveShadow( 1, Color( 0, 0, 0, 200 ) )
		        label:SetContentAlignment( 5 )
		        label:SetHeight( 14 )
		        label:SetFont( "DefaultSmall" )
		        
		        g_Progress.Label = g_Progress:Add( "DLabel" )
		        g_Progress.Label:Dock( BOTTOM )
		        g_Progress.Label:SetTextColor( Color( 255, 255, 255, 255 ) )
		        g_Progress.Label:SetExpensiveShadow( 1, Color( 0, 0, 0, 200 ) )
		        g_Progress.Label:SetContentAlignment( 5 )
		        g_Progress.Label:SetFont( "DermaDefaultBold" )
		        g_Progress.Label:SetHeight( 14 )
		        
		        g_Progress.icon = vgui.Create( "DImage", g_Progress )
		        g_Progress.icon:SetSize( 64, 64 )
		        g_Progress.icon:Dock( TOP )
		    
		    end
		    
		    g_Progress.LastTouch = SysTime()
		    
		    imagename = imagename:Replace( "materials\\", "" )
		    imagename = imagename:Replace( "materials/", "" )
		        
		    g_Progress.icon:SetImage( imagename )
		        
		    g_Progress:AlignRight( 10 )
		    g_Progress:AlignBottom( 10 )
		    
		    g_Progress.Label:SetText( modelsleft )
		
		end )
		```
    **/
    var SpawniconGenerated:GMHook<(lastmodel:String, imagename:String, modelsleft:Float) -> Void>; 
    #end
    #if client
    /**
        Called before the player hands are drawn.
		
		Name | Description
		--- | ---
		`hands` | This is the gmod_hands entity before it is drawn.
		`vm` | This is the view model entity before it is drawn.
		`ply` | The the owner of the view model.
		`weapon` | This is the weapon that is from the view model.
		
		
		`**Returns:** Return true to prevent the viewmodel hands from rendering
    **/
    var PreDrawPlayerHands:GMHook<(hands:Entity, vm:Entity, ply:Player, weapon:Weapon) -> Bool>; 
    #end
    
    /**
        Called to determine if a player should be able to pick up an entity with the Physics Gun. 
		
		See GM:OnPhysgunPickup for a hook which is called when a player has successfully picked up an entity.
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		Name | Description
		--- | ---
		`player` | The player that is picking up using the Physics Gun.
		`entity` | The entity that is being picked up.
		
		
		`**Returns:** Returns whether the player can pick up the entity or not.
		
		___
		### Lua Examples
		#### Example 1
		Allows Admins to pick up players.
		
		```lua 
		hook.Add( "PhysgunPickup", "AllowPlayerPickup", function( ply, ent )
		    if ( ply:IsAdmin() and ent:IsPlayer() ) then
		        return true
		    end
		end )
		```
    **/
    var PhysgunPickup:GMHook<(player:Player, entity:Entity) -> Bool>; 
    
    #if server
    /**
        Called when a player executes gm_showhelp console command. ( Default bind is F1 )
		
		Name | Description
		--- | ---
		`ply` | Player who executed the command
    **/
    var ShowHelp:GMHook<(ply:Player) -> Void>; 
    #end
    #if client
    /**
        Called when derma menus are closed with CloseDermaMenus.
    **/
    var CloseDermaMenus:GMHook<() -> Void>; 
    #end
    
    /**
        Called when a player makes contact with the ground.
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		Name | Description
		--- | ---
		`player` | Player
		`inWater` | Did the player land in water?
		`onFloater` | Did the player land on an object floating in the water?
		`speed` | The speed at which the player hit the ground
		
		
		`**Returns:** Return true to suppress default action
		
		___
		### Lua Examples
		#### Example 1
		Explode players when they hit the ground too hard.
		
		```lua 
		function GM:OnPlayerHitGround( ply, inWater, onFloater, speed )
		    if speed > 1000 && !inWater then
		        local exp = ents.Create("env_explosion")
		        exp:SetPos(ply:GetPos())
		        exp:Spawn()
		        exp:SetKeyValue("iMagnitude", "0")
		        exp:Fire("Explode", 0, 0)
		 
		        ply:Kill()
		    end
		end
		```
    **/
    var OnPlayerHitGround:GMHook<(player:Entity, inWater:Bool, onFloater:Bool, speed:Float) -> Bool>; 
    
    #if server
    /**
        Called when an entity is picked up by a gravity gun.
		
		Name | Description
		--- | ---
		`ply` | The player wielding the gravity gun
		`ent` | The entity that has been picked up by the gravity gun
    **/
    var GravGunOnPickedUp:GMHook<(ply:Player, ent:Entity) -> Void>; 
    #end
    
    /**
        The Move hook is called for you to manipulate the player's MoveData. 
		
		You shouldn't adjust the player's position in any way in the move hook. This is because due to prediction errors, the netcode might run the move hook multiple times as packets arrive late. Therefore you should only adjust the movedata construct in this hook. 
		
		 Generally you shouldn't have to use this hook - if you want to make a custom move type you should look at the drive system. 
		
		 This hook is called after GM:PlayerTick. 
		
		 See Game Movement for an explanation on the move system.
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		Name | Description
		--- | ---
		`ply` | Player
		`mv` | Movement information
		
		
		`**Returns:** Return true to suppress default engine action
		
		___
		### Lua Examples
		#### Example 1
		A noclip move type
		
		```lua 
		function GM:Move( ply, mv )
		
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
		    -- by our forward speed (which will be > 0 if we're holding W, Hook< 0 if we're
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
		    if ( math.abs(mv:GetForwardSpeed()) + math.abs(mv:GetSideSpeed()) + math.abs(mv:GetUpSpeed()) Hook< 0.1 ) then
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
		    -- we instead store them in the movedata. They should get applied
		    -- in the FinishMove hook.
		    --
		    mv:SetVelocity( vel )
		    mv:SetOrigin( pos )
		
		    --
		    -- Return true to not use the default behavior
		    --
		    return true
		
		end
		```
    **/
    var Move:GMHook<(ply:Player, mv:CMoveData) -> Bool>; 
    
    #if client
    /**
        Called whenever a players releases a mouse key on the context menu in Sandbox or on any panel derived from CGModBase, such as the panel used by gui.EnableScreenClicker and the panel used by Panel:ParentToHUD.
		
		Name | Description
		--- | ---
		`mouseCode` | The key the player released, see MOUSE_ Enums
		`aimVector` | A normalized direction vector local to the camera. Internally this is gui. ScreenToVector( gui. MousePos() ).
    **/
    var GUIMouseReleased:GMHook<(mouseCode:MOUSE, aimVector:Vector) -> Void>; 
    #end
    #if client
    /**
        Called when a player starts using voice chat.
		
		Name | Description
		--- | ---
		`ply` | Player who started using voice chat
    **/
    var PlayerStartVoice:GMHook<(ply:Player) -> Void>; 
    #end
    
    /**
        The Move hook is called for you to manipulate the player's CMoveData. This hook is called moments before GM:Move and GM:PlayerNoClip.
		
		**Warning:** This hook will not run when inside a vehicle. GM:VehicleMove will be called instead.
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		Name | Description
		--- | ---
		`player` | The player
		`mv` | The current movedata for the player.
    **/
    var PlayerTick:GMHook<(player:Player, mv:CMoveData) -> Void>; 
    
    
    /**
        Called after the gamemode loads and starts.
		
		___
		### Lua Examples
		#### Example 1
		"hi" will be printed to the console when the gamemode initializes.
		
		```lua 
		function GM:Initialize()
		    print("hi" )
		end
		
		-- That way you are overriding the default hook
		-- you can use hook.Add to make more functions get called on initialization
		local function init()
		    print("Initialization hook called")
		end
		hook.Add( "Initialize", "some_unique_name", init )
		```
    **/
    var Initialize:GMHook<() -> Void>; 
    
    
    /**
        Allows you to change the players inputs before they are processed by the server. This is basically a shared version of GM:CreateMove.
		
		**Note:** This function is also called for bots, making it the best solution to control them so far
		
		**Note:** This hook is predicted, but not by usual means, this hook is called when a CUserCmd is generated on the client, and on the server when it is received, so it is necessary for this hook to be called clientside even on singleplayer
		
		Name | Description
		--- | ---
		`ply` | The player
		`ucmd` | The usercommand
		
		
		___
		### Lua Examples
		#### Example 1
		Example of how you'd control a bot using this hook.The example causes all bots to go kill any players they can get to with crowbars.
		
		```lua 
		hook.Add( "StartCommand", "StartCommandExample", function( ply, cmd )
		
		    -- If the player is not a bot or the bot is dead, do not do anything
		    -- TODO: Maybe spawn the bot manually here if the bot is dead
		    if ( !ply:IsBot() or !ply:Alive() ) then return end
		
		    -- Clear any default movement or actions
		    cmd:ClearMovement() 
		    cmd:ClearButtons()
		
		    -- Bot has no enemy, try to find one
		    if ( !IsValid( ply.CustomEnemy ) ) then
		        -- Scan through all players and select one not dead
		        for id, pl in pairs( player.GetAll() ) do
		            if ( !pl:Alive() or pl == ply ) then continue end -- Don't select dead players or self as enemies 
		            ply.CustomEnemy = pl
		        end
		        -- TODO: Maybe add a Line Of Sight check so bots won't walk into walls to try to get to their target
		        -- Or add path finding so bots can find their way to enemies
		    end
		
		    -- We failed to find an enemy, don't do anything
		    if ( !IsValid( ply.CustomEnemy ) ) then return end
		
		    -- Move forwards at the bots normal walking speed
		    cmd:SetForwardMove( ply:GetWalkSpeed() )
		
		    -- Aim at our enemy
		    if ( ply.CustomEnemy:IsPlayer() ) then
		        cmd:SetViewAngles( ( ply.CustomEnemy:GetShootPos() - ply:GetShootPos() ) -> GetNormalized>;() -> Angle>;() )
		    else
		        cmd:SetViewAngles( ( ply.CustomEnemy:GetPos() - ply:GetShootPos() ) -> GetNormalized>;() -> Angle>;() )
		    end
		
		    -- Give the bot a crowbar if the bot doesn't have one yet
		    if ( SERVER and !ply:HasWeapon( "weapon_crowbar" ) ) then ply:Give( "weapon_crowbar" ) end
		
		    -- Select the crowbar
		    cmd:SelectWeapon( ply:GetWeapon( "weapon_crowbar" ) )
		
		    -- Hold Mouse 1 to cause the bot to attack
		    cmd:SetButtons( IN_ATTACK )
		
		    -- Enemy is dead, clear our enemy so that we may acquire a new one
		    if ( !ply.CustomEnemy:Alive() ) then
		        ply.CustomEnemy = nil
		    end
		
		end )
		```
    **/
    var StartCommand:GMHook<(ply:Player, ucmd:CUserCmd) -> Void>; 
    
    #if server
    /**
        Returns whether or not a player is allowed to join a team
		
		Name | Description
		--- | ---
		`ply` | Player attempting to switch teams
		`team` | Index of the team
		
		
		`**Returns:** Allowed to switch
    **/
    var PlayerCanJoinTeam:GMHook<(ply:Player, team:Float) -> Bool>; 
    #end
    #if client
    /**
        Called when an entity has been created over the network.
		
		Name | Description
		--- | ---
		`ent` | Created entity
    **/
    var NetworkEntityCreated:GMHook<(ent:Entity) -> Void>; 
    #end
    
    /**
        Called each frame to record demos to video using IVideoWriter.
		
		**Note:** This hook is called every frame regardless of whether or not a demo is being recorded
    **/
    var CaptureVideo:GMHook<() -> Void>; 
    
    
    /**
        Runs when a IN key was released by a player. 
		
		For a more general purpose function that handles all kinds of input, see GM:PlayerButtonUp
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		Name | Description
		--- | ---
		`ply` | The player releasing the key. If running client-side, this will always be LocalPlayer
		`key` | The key that the player released using IN_ Enums.
		
		
		___
		### Lua Examples
		#### Example 1
		"hi" will be printed to the console when the player releases the IN_USE (E) key.
		
		```lua 
		function GM:KeyRelease( player, key )
		    if ( key == IN_USE ) then
		        print( "hi" )
		    end
		end
		```
    **/
    var KeyRelease:GMHook<(ply:Player, key:IN) -> Void>; 
    
    #if server
    /**
        Called when a player freezes an object.
		
		Name | Description
		--- | ---
		`ply` | Player who has frozen an object
		`ent` | The frozen object
		`physobj` | The frozen physics object of the frozen entity ( For ragdolls )
    **/
    var PlayerFrozeObject:GMHook<(ply:Player, ent:Entity, physobj:PhysObj) -> Void>; 
    #end
    #if client
    /**
        Called when it's time to populate the context menu menu bar at the top.
		
		Name | Description
		--- | ---
		`menubar` | The DMenuBar itself.
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the hook
		
		```lua 
		hook.Add( "PopulateMenuBar", "My_MenuBar", function( menubar )
		
		    local m = menubar:AddOrGetMenu( "Test" )
		
		    m:AddCVar( "Item 1", "console_var1", "1", "0" )
		
		    m:AddSpacer()
		
		    m:AddCVar( "Item 2", "console_var2", "0", "100" )
		
		    m:AddCVar( "Check console", "console_var3", "1", "0", function() print("I was clicked!") end )
		
		
		    local submenu = m:AddSubMenu( "Submenu" )
		
		    submenu:SetDeleteSelf( false )
		    submenu:AddCVar( "No password", "password", "" )
		    submenu:AddSpacer()
		
		    submenu:AddCVar( "Password: test1", "password", "test1" )
		    submenu:AddCVar( "Password: lolno", "password", "lolno" )
		
		end )
		```
    **/
    var PopulateMenuBar:GMHook<(menubar:Panel) -> Void>; 
    #end
    #if client
    /**
        Called when a player presses the "+menu" bind on their keyboard, which is bound to Q by default.
    **/
    var OnSpawnMenuOpen:GMHook<() -> Void>; 
    #end
    #if client
    /**
        Called before all the translucent entities are drawn. 
		
		See also GM:PreDrawOpaqueRenderables and GM:PostDrawTranslucentRenderables.
		
		**Note:** This is a rendering hook with a 3D rendering context. This means that the only rendering functions will work in it are functions with a 3D rendering context.
		
		**Bug:** BUG This is still called when r_drawentities or r_drawopaquerenderables is disabled. Issue Tracker: #3295
		
		**Bug:** BUG This is not called when r_drawtranslucentworld is disabled. Issue Tracker: #3296
		
		Name | Description
		--- | ---
		`isDrawingDepth` | Whether the current draw is writing depth.
		`isDrawSkybox` | Whether the current draw is drawing the skybox.
		
		
		`**Returns:** Return true to prevent translucent renderables from drawing.
    **/
    var PreDrawTranslucentRenderables:GMHook<(isDrawingDepth:Bool, isDrawSkybox:Bool) -> Bool>; 
    #end
    #if server
    /**
        Called when a non local player connects to allow the Lua system to check the password. 
		
		The default behaviour in the base gamemodes emulates what would normally happen. If sv_password is set and its value matches the password passed in by the client - then they are allowed to join. If it isn't set it lets them in too.
		
		Name | Description
		--- | ---
		`steamID64` | The 64bit Steam ID of the joining player, use util. SteamIDFrom64 to convert it to a "STEAM_0:" one.
		`ipAddress` | The IP of the connecting client
		`svPassword` | The current value of sv_password (the password set by the server)
		`clPassword` | The password provided by the client
		`name` | The name of the joining player
		
		
		Name | Description
		--- | ---
		`a` | If the hook returns false then the player is disconnected
		`b` | If returning false in the first argument, then this should be the disconnect message. This will default to "#GameUI_ServerRejectBadPassword", which is "Bad Password." translated to the client's language.
		
		
		___
		### Lua Examples
		#### Example 1
		A user access whitelist to the serverAvailable pre-defined messages can be found in ../sourceengine/resource/gameui_english.txt files.Suggested messages are #GameUI_ConnectionFailed and #GameUI_ServerRejectLANRestrict
		
		```lua 
		local allowed = {
		    ["76561198012345678"] = true, -- Me
		    ["76561198123456789"] = true, -- Friend #1
		    ["76561198234567890"] = true, -- Friend #2
		}
		
		hook.Add( "CheckPassword", "access_whitelist", function( steamID64 )
		    if not allowed[steamID64] then
		        return false, "#GameUI_ServerRejectLANRestrict"
		    end
		end )
		```
    **/
    var CheckPassword:GMHook<(steamID64:String, ipAddress:String, svPassword:String, clPassword:String, name:String) -> Dynamic>; 
    #end
    #if client
    /**
        Called when player presses the scoreboard button. ( TAB by default )
    **/
    var ScoreboardShow:GMHook<() -> Void>; 
    #end
    #if client
    /**
        Called before any of 2D drawing functions. Drawing anything in it seems to work incorrectly.
		
		___
		### Lua Examples
		#### Example 1
		Allows you to draw something before any other HUD elements.
		
		```lua 
		local clr = Color(20, 20, 20, 200)
		hook.Add("PreDrawHUD", "PreDrawExample", function()
		    cam.Start2D() -- If you don't call this the drawing will not work properly.
		    
		    surface.SetDrawColor(clr)
		    surface.DrawRect(0, 0, ScrW(), ScrH())
		    
		    cam.End2D()
		end)
		```
    **/
    var PreDrawHUD:GMHook<() -> Void>; 
    #end
    #if client
    /**
        Called when DTextEntry loses focus.
		
		Name | Description
		--- | ---
		`panel` | The panel that lost focus
    **/
    var OnTextEntryLoseFocus:GMHook<(panel:Panel) -> Void>; 
    #end
    #if server
    /**
        Called when a player executes gm_showspare1 console command. ( Default bind is F3 )
		
		Name | Description
		--- | ---
		`ply` | Player who executed the command
    **/
    var ShowSpare1:GMHook<(ply:Player) -> Void>; 
    #end
    #if client
    /**
        Allows overriding the position and angle of the viewmodel.
		
		Name | Description
		--- | ---
		`wep` | The weapon entity
		`vm` | The viewmodel entity
		`oldPos` | Original position (before viewmodel bobbing and swaying)
		`oldAng` | Original angle (before viewmodel bobbing and swaying)
		`pos` | Current position
		`ang` | Current angle
		
		
		Name | Description
		--- | ---
		`a` | New position
		`b` | New angle
    **/
    var CalcViewModelView:GMHook<(wep:Weapon, vm:Entity, oldPos:Vector, oldAng:Angle, pos:Vector, ang:Angle) -> Dynamic>; 
    #end
    
    /**
        Called while an addon from the Steam workshop is downloading. Used by default to update details on the fancy workshop download panel.
		
		Name | Description
		--- | ---
		`id` | Workshop ID of addon.
		`imageID` | ID of addon's preview image. For example, for Extended Spawnmenu addon, the image URL is http://cloud-4.steamusercontent.com/ugc/702859018846106764/9E7E1946296240314751192DA0AD15B6567FF92D/ So, the value of this argument would be 702859018846106764.
		`title` | Name of addon.
		`downloaded` | Current bytes of addon downloaded.
		`expected` | Expected file size of addon in bytes.
    **/
    var WorkshopDownloadProgress:GMHook<(id:Float, imageID:Float, title:String, downloaded:Float, expected:Float) -> Void>; 
    
    #if client
    /**
        Allows override of the default view.
		
		Name | Description
		--- | ---
		`ply` | The local player.
		`origin` | The player's view position.
		`angles` | The player's view angles.
		`fov` | Field of view.
		`znear` | Distance to near clipping plane.
		`zfar` | Distance to far clipping plane.
		
		
		`**Returns:** View data table. See CamData structure
		
		___
		### Lua Examples
		#### Example 1
		Draws the LocalPlayer and sets the view behind.
		
		```lua 
		local function MyCalcView(ply, pos, angles, fov)
		    local view = 
		    view.origin = pos-(angles:Forward()*100)
		    view.angles = angles
		    view.fov = fov
		    view.drawviewer = true
		 
		    return view
		end
		 
		hook.Add( "CalcView", "MyCalcView", MyCalcView )
		```
    **/
    var CalcView:GMHook<(ply:Player, origin:Vector, angles:Angle, fov:Float, znear:Float, zfar:Float) -> CamData>; 
    #end
    #if server
    /**
        Called when a player unfreezes an object.
		
		Name | Description
		--- | ---
		`ply` | Player who has unfrozen an object
		`ent` | The unfrozen object
		`physobj` | The frozen physics object of the unfrozen entity ( For ragdolls )
    **/
    var PlayerUnfrozeObject:GMHook<(ply:Player, ent:Entity, physobj:PhysObj) -> Void>; 
    #end
    
    /**
        Allows you to translate player activities.
		
		Name | Description
		--- | ---
		`ply` | The player
		`act` | The activity. See ACT_ Enums
		
		
		`**Returns:** The new, translated activity
    **/
    var TranslateActivity:GMHook<(ply:Player, act:ACT) -> Float>; 
    
    #if server
    /**
        Allows to suppress player taunts.
		
		Name | Description
		--- | ---
		`ply` | Player who tried to taunt
		`act` | Act ID of the taunt player tries to do, see ACT_ Enums
		
		
		`**Returns:** Return false to disallow player taunting
    **/
    var PlayerShouldTaunt:GMHook<(ply:Player, act:ACT) -> Bool>; 
    #end
    #if client
    /**
        Called before the player is drawn.
		
		Name | Description
		--- | ---
		`player` | The player that is about to be drawn.
		
		
		`**Returns:** Prevent default player rendering. Return true to hide the player.
    **/
    var PrePlayerDraw:GMHook<(player:Player) -> Bool>; 
    #end
    #if client
    /**
        Called after the player hands are drawn.
		
		Name | Description
		--- | ---
		`hands` | This is the gmod_hands entity.
		`vm` | This is the view model entity.
		`ply` | The the owner of the view model.
		`weapon` | This is the weapon that is from the view model.
    **/
    var PostDrawPlayerHands:GMHook<(hands:Entity, vm:Entity, ply:Player, weapon:Weapon) -> Void>; 
    #end
    #if client
    /**
        Allows you to suppress post processing effect drawing.
		
		Name | Description
		--- | ---
		`ppeffect` | The classname of Post Processing effect
		
		
		`**Returns:** Return true/false depending on whether this post process should be allowed
    **/
    var PostProcessPermitted:GMHook<(ppeffect:String) -> Bool>; 
    #end
    
    /**
        Called when you are driving a vehicle. This hook works just like GM:Move. 
		
		This hook is called before GM:Move and will be called when GM:PlayerTick is not.
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		Name | Description
		--- | ---
		`ply` | Player who is driving the vehicle
		`veh` | The vehicle being driven
		`mv` | Move data
    **/
    var VehicleMove:GMHook<(ply:Player, veh:Vehicle, mv:CMoveData) -> Void>; 
    
    #if server
    /**
        Called every tick to poll whether a player is allowed to pick up an entity with the gravity gun or not. 
		
		See GM:AllowPlayerPickup for the +USE pickup variant. 
		
		 Calls ENTITY:GravGunPickupAllowed on the entity being hovered every frame in Sandbox-derived gamemodes.
		
		Name | Description
		--- | ---
		`ply` | The player wielding the gravity gun
		`ent` | The entity the player is attempting to pick up
		
		
		`**Returns:** Return true to allow entity pick up
    **/
    var GravGunPickupAllowed:GMHook<(ply:Player, ent:Entity) -> Bool>; 
    #end
    
    /**
        Called whenever the Lua environment is about to be shut down, for example on map change, or when the server is going to shut down.
    **/
    var ShutDown:GMHook<() -> Void>; 
    
    #if server
    /**
        Called when a variable is edited on an Entity (called by Edit Properties... menu), to determine if the edit should be permitted. 
		
		See Editable entities for more details about the system.
		
		Name | Description
		--- | ---
		`ent` | The entity being edited
		`ply` | The player doing the editing
		`key` | The name of the variable
		`val` | The new value, as a string which will later be converted to its appropriate type
		`editor` | The edit table defined in Entity: NetworkVar
		
		
		`**Returns:** Return true to allow editing
		
		___
		### Lua Examples
		#### Example 1
		From base/gamemode/variable_edit.lua Makes "Edit Properties..." right click property admin only
		
		```lua 
		function GM:CanEditVariable( ent, ply, key, val, editor )
		    return ply:IsAdmin()
		end
		```
    **/
    var CanEditVariable:GMHook<(ent:Entity, ply:Player, key:String, val:String, editor:AnyTable) -> Bool>; 
    #end
    
    /**
        Called when an NWVar is changed.
		
		**Note:** Currently this hook only works for the NW2Var system (accessed by adding a 2 in between NW and Var for most NWVar functions), which will replace the original one at some point in the future
		
		**Note:** This hook is fired before the client value is actually changed. Calling the GetNW function for the specified variable name within this hook will return the old value, not the current/updated one.
		
		Name | Description
		--- | ---
		`ent` | The owner entity of changed NWVar
		`name` | The name if changed NWVar
		`oldval` | The old value of the NWVar
		`newval` | The new value of the NWVar
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the hook. Prints out all NWVar changes.
		
		```lua 
		hook.Add("EntityNetworkedVarChanged","printchange", print )
		
		-- Trigger a change!
		Entity(1) -> SetNW>;2String( "UserGroup", "owner" )
		```
    **/
    var EntityNetworkedVarChanged:GMHook<(ent:Entity, name:String, oldval:Dynamic, newval:Dynamic) -> Void>; 
    
    
    /**
        Called every time a bullet is fired from an entity.
		
		**Warning:** This hook is called directly from Entity:FireBullets. Due to this, you cannot call Entity:FireBullets inside this hook or an infinite loop will occur crashing the game.
		
		Name | Description
		--- | ---
		`ent` | The entity that fired the bullet
		`data` | The bullet data. See Bullet structure
		
		
		`**Returns:** Return true to apply all changes done to the bullet table. Return false to suppress the bullet.
    **/
    var EntityFireBullets:GMHook<(ent:Entity, data:Bullet) -> Bool>; 
    
    
    /**
        Allows to override player jumping animations.
		
		Name | Description
		--- | ---
		`ply` | The player
		`velocity` | Players velocity
		
		
		`**Returns:** Return true if we've changed/set the animation, false otherwise
    **/
    var HandlePlayerJumping:GMHook<(ply:Player, velocity:Float) -> Bool>; 
    
    #if client
    /**
        Called when player stops using voice chat.
		
		Name | Description
		--- | ---
		`ply` | Player who stopped talking
    **/
    var PlayerEndVoice:GMHook<(ply:Player) -> Void>; 
    #end
    
    /**
        Called every frame on client and every tick on server. 
		
		See GM:Tick for a hook that runs every tick on both the client and server.
		
		**Note:** This hook WILL NOT run if the server is empty, unless you set the ConVar sv_hibernate_think to 1
    **/
    var Think:GMHook<() -> Void>; 
    
    #if server
    /**
        Handles the player's death. 
		
		This hook is not called if the player is killed by Player:KillSilent. See GM:PlayerSilentDeath for that.
		
		**Note:** Player:Alive returns true when this is called
		
		Name | Description
		--- | ---
		`ply` | The player
		`attacker` | The entity that killed the player
		`dmg` | Damage info
    **/
    var DoPlayerDeath:GMHook<(ply:Player, attacker:Entity, dmg:CTakeDamageInfo) -> Void>; 
    #end
    #if server
    /**
        Called when an entity takes damage. You can modify all parts of the damage info in this hook.
		
		Name | Description
		--- | ---
		`target` | The entity taking damage
		`dmg` | Damage info
		
		
		`**Returns:** Return true to completely block the damage event
		
		___
		### Lua Examples
		#### Example 1
		Explosion damage is reduced to players only.
		
		```lua 
		hook.Add( "EntityTakeDamage", "EntityDamageExample", function( target, dmginfo )
		
		    if ( target:IsPlayer() and dmginfo:IsExplosionDamage() ) then
		
		        dmginfo:ScaleDamage( 0.5 ) // Damage is now half of what you would normally take.
		
		    end
		
		end )
		```
		
		#### Example 2
		Players in vehicles takes halved damage.
		
		```lua 
		hook.Add( "EntityTakeDamage", "EntityDamageExample2", function( target, dmginfo )
		
		    if ( target:IsVehicle() ) then
		 
		        local ply = target:GetDriver()
		        if ( IsValid(ply) && dmginfo:GetDamage() > 1 ) then
		            dmginfo:SetDamage(dmginfo:GetDamage() / 2)
		            ply:TakeDamageInfo(dmginfo)
		            dmginfo:SetDamage(0)
		        
		        end
		
		    end
		
		end )
		```
    **/
    var EntityTakeDamage:GMHook<(target:Entity, dmg:CTakeDamageInfo) -> Bool>; 
    #end
    #if client
    /**
        Called when a player releases the "+menu" bind on their keyboard, which is bound to Q by default.
    **/
    var OnSpawnMenuClose:GMHook<() -> Void>; 
    #end
    #if client
    /**
        Called when the client has picked up ammo. Override to disable default HUD notification.
		
		Name | Description
		--- | ---
		`itemName` | Name of the item (ammo) picked up
		`amount` | Amount of the item (ammo) picked up
    **/
    var HUDAmmoPickedUp:GMHook<(itemName:String, amount:Float) -> Void>; 
    #end
    #if server
    /**
        Called when an NPC takes damage.
		
		**Note:** This hook is called only when a specific hit group of the NPC is hit. In cases where the hitgroup doesn't matter, you should use GM:EntityTakeDamage instead!
		
		Name | Description
		--- | ---
		`npc` | The NPC that takes damage
		`hitgroup` | The hitgroup (hitbox) enum where the NPC took damage. See HITGROUP_ Enums
		`dmginfo` | Damage info
		
		
		___
		### Lua Examples
		#### Example 1
		Double the damage whenever an NPC is hurt.
		
		```lua 
		hook.Add( "ScaleNPCDamage", "ScaleNPCDamageExample", function( npc, hitgroup, dmginfo )
		    dmginfo:ScaleDamage( 2 )
		end )
		```
    **/
    var ScaleNPCDamage:GMHook<(npc:NPC, hitgroup:HITGROUP, dmginfo:CTakeDamageInfo) -> Void>; 
    #end
    #if server
    /**
        Called as a weapon entity is picked up by a player. 
		
		See also GM:PlayerDroppedWeapon.
		
		**Note:** At the time when this hook is called Entity:GetOwner will return NULL. The owner is set on the next frame
		
		**Note:** This will not be called when picking up a weapon you already have as the weapon will be removed and WEAPON:EquipAmmo will be called instead
		
		Name | Description
		--- | ---
		`weapon` | The equipped weapon.
		`owner` | The player that is picking up the weapon.
		
		
		___
		### Lua Examples
		#### Example 1
		Drops the player's weapons as soon as they pick one up.
		
		```lua 
		hook.Add( "WeaponEquip", "WeaponEquipExample", function( wep, ply )
		    timer.Simple( 0, function() ply:DropWeapon( wep ) end )
		end )
		```
    **/
    var WeaponEquip:GMHook<(weapon:Weapon, owner:Player) -> Void>; 
    #end
    
    /**
        Called before the gamemode is loaded.
    **/
    var PreGamemodeLoaded:GMHook<() -> Void>; 
    
    #if client
    /**
        Used to render post processing effects.
		
		**Note:** This is a rendering hook with a 2D rendering context. This means that the only rendering functions will work in it are functions with a 2D rendering context.
		
		___
		### Lua Examples
		#### Example 1
		Renders color modify and sobel effects to create a cartoon effect.
		
		```lua 
		local tab = {
		    ["$pp_colour_addr"] = 0,
		    ["$pp_colour_addg"] = 0,
		    ["$pp_colour_addb"] = 0,
		    ["$pp_colour_brightness"] = -0.04,
		    ["$pp_colour_contrast"] = 1.35,
		    ["$pp_colour_colour"] = 5,
		    ["$pp_colour_mulr"] = 0,
		    ["$pp_colour_mulg"] = 0,
		    ["$pp_colour_mulb"] = 0
		}
		function GM:RenderScreenspaceEffects()
		    DrawColorModify( tab ) --Draws Color Modify effect
		    DrawSobel( 0.5 ) --Draws Sobel effect
		end
		```
    **/
    var RenderScreenspaceEffects:GMHook<() -> Void>; 
    #end
    
    /**
        Called when downloading content from Steam workshop begins. Used by default to show fancy workshop downloading panel. 
		
		The order of Workshop hooks is this:
    **/
    var WorkshopStart:GMHook<() -> Void>; 
    
    #if server
    /**
        Called when a player gets hurt.
		
		Name | Description
		--- | ---
		`victim` | Victim
		`attacker` | Attacker Entity
		`healthRemaining` | Remaining Health
		`damageTaken` | Damage Taken
		
		
		___
		### Lua Examples
		#### Example 1
		Show players attacker in Chat.
		
		```lua 
		function GM:PlayerHurt(victim, attacker)
		    if ( attacker:IsPlayer() ) then
		        victim:ChatPrint("You were attacked by : " .. attacker:Nick())
		    end
		end
		```
    **/
    var PlayerHurt:GMHook<(victim:Player, attacker:Entity, healthRemaining:Float, damageTaken:Float) -> Void>; 
    #end
    
    /**
        Called after GM:WorkshopStart.
		
		Name | Description
		--- | ---
		`remain` | Remaining addons to download
		`total` | Total addons needing to be downloaded
    **/
    var WorkshopDownloadTotals:GMHook<(remain:Float, total:Float) -> Void>; 
    
    #if server
    /**
        Returns true if the player should take damage from the given attacker.
		
		Name | Description
		--- | ---
		`ply` | The player
		`attacker` | The attacker
		
		
		`**Returns:** Allow damage
    **/
    var PlayerShouldTakeDamage:GMHook<(ply:Player, attacker:Entity) -> Bool>; 
    #end
    #if client
    /**
        This hook is called every frame to draw all of the current death notices.
		
		Name | Description
		--- | ---
		`x` | X position to draw death notices as a ratio
		`y` | Y position to draw death notices as a ratio
    **/
    var DrawDeathNotice:GMHook<(x:Float, y:Float) -> Void>; 
    #end
    
    /**
        Called every server tick. Serverside, this is similar to GM:Think.
    **/
    var Tick:GMHook<() -> Void>; 
    
    
    /**
        Animation updates (pose params etc) should be done here.
		
		Name | Description
		--- | ---
		`ply` | The player to update the animation info for.
		`velocity` | The player's velocity.
		`maxSeqGroundSpeed` | Speed of the animation - used for playback rate scaling.
    **/
    var UpdateAnimation:GMHook<(ply:Player, velocity:Vector, maxSeqGroundSpeed:Float) -> Void>; 
    
    #if client
    /**
        Called when a mouse button is pressed on a VGUI element or menu.
		
		Name | Description
		--- | ---
		`pnl` | Panel that currently has focus.
		`mouseCode` | The key that the player pressed using MOUSE_ Enums.
    **/
    var VGUIMousePressed:GMHook<(pnl:Panel, mouseCode:MOUSE) -> Void>; 
    #end
    
    /**
        Called whenever a sound has been played. This will not be called clientside if the server played the sound without the client also calling Entity:EmitSound.
		
		**Bug:** BUG This is not called for scripted sequences. Issue Tracker: #1021
		
		Name | Description
		--- | ---
		`data` | Information about the played sound. Changes done to this table can be applied by returning true from this hook. See EmitSoundInfo structure.
		
		
		`**Returns:** Return true to apply all changes done to the data table. Return false to prevent the sound from playing. Return nil or nothing to play the sound without altering it.
		
		___
		### Lua Examples
		#### Example 1
		Slows down all sounds to reflect game.SetTimeScale.
		
		```lua 
		hook.Add( "EntityEmitSound", "TimeWarpSounds", function( t )
		    
		    local p = t.Pitch
		    
		    if ( game.GetTimeScale() != 1 ) then
		        p = p * game.GetTimeScale()
		    end
		    
		    if ( GetConVarNumber( "host_timescale" ) != 1 && GetConVarNumber( "sv_cheats" ) >= 1 ) then
		        p = p * GetConVarNumber( "host_timescale" )
		    end
		    
		    if ( p != t.Pitch ) then
		        t.Pitch = math.Clamp( p, 0, 255 )
		        return true
		    end
		    
		    if ( CLIENT && engine.GetDemoPlaybackTimeScale() != 1 ) then
		        t.Pitch = math.Clamp( t.Pitch * engine.GetDemoPlaybackTimeScale(), 0, 255 )
		        return true
		    end
		    
		end )
		```
    **/
    var EntityEmitSound:GMHook<(data:EmitSoundInfo) -> Bool>; 
    
    
    /**
        Called to refresh menu content once it has initialized or something has been mounted.
    **/
    var GameContentChanged:GMHook<() -> Void>; 
    
    #if server
    /**
        Determines whether or not the player can enter the vehicle. 
		
		Called just before GM:PlayerEnteredVehicle.
		
		Name | Description
		--- | ---
		`player` | The player
		`vehicle` | The vehicle
		`role` | 
		
		
		`**Returns:** False if the player is not allowed to enter the vehicle.
    **/
    var CanPlayerEnterVehicle:GMHook<(player:Player, vehicle:Vehicle, role:Float) -> Bool>; 
    #end
    #if server
    /**
        Called to spawn the player as a spectator.
		
		Name | Description
		--- | ---
		`ply` | The player to spawn as a spectator
		
		
		___
		### Lua Examples
		#### Example 1
		Makes all players spawn as spectators.
		
		```lua 
		function GM:PlayerSpawn( ply )
		 
		    GAMEMODE:PlayerSpawnAsSpectator( ply )
		 
		end
		```
    **/
    var PlayerSpawnAsSpectator:GMHook<(ply:Player) -> Void>; 
    #end
    #if client
    /**
        Allows you to override physgun beam drawing.
		
		**Bug:** BUG This is still called when physgun_drawbeams is disabled. Issue Tracker: #3294
		
		Name | Description
		--- | ---
		`ply` | Physgun owner
		`physgun` | The physgun
		`enabled` | Is the beam enabled
		`target` | Entity we are grabbing. This will be NULL if nothing is being held
		`physBone` | ID of the physics bone ( PhysObj) we are grabbing at. Use Entity: TranslatePhysBoneToBone to translate to an actual bone.
		`hitPos` | Beam hit position relative to the physics bone ( PhysObj) we are grabbing.
		
		
		`**Returns:** Return false to hide default beam
		
		___
		### Lua Examples
		#### Example 1
		Example code that will draw a direct line from the physgun to the target.
		
		```lua 
		hook.Add( "DrawPhysgunBeam", "test", function( ply, wep, enabled, target, bone, deltaPos )
		
		    -- Draw any physgun effects here that are not the beam.
		
		    -- Not "firing" the physgun? Don't draw anything.
		    if ( !enabled ) then return false end
		
		    local clr = Color( 255, 0, 0 )
		
		    -- White when not "firing" physgun, this will not work with the "if" above
		    if ( !enabled ) then clr = Color( 255, 255, 255, 255 ) end
		
		    local hitpos = ply:GetEyeTrace().HitPos
		    if ( IsValid( target ) ) then
		        local mt = target:GetBoneMatrix( bone )
		        if ( target:TranslatePhysBoneToBone( bone ) >= 0 ) then
		            mt = target:GetBoneMatrix( target:TranslatePhysBoneToBone( bone ) )
		        end
		
		        hitpos = LocalToWorld( deltaPos, Angle( 0, 0, 0 ), mt:GetTranslation(), mt:GetAngles() )
		    end
		
		    local srcPos = wep:GetAttachment( 1 ).Pos
		    if ( !ply:ShouldDrawLocalPlayer() ) then
		        srcPos = ply:GetViewModel() -> GetAttachment>;( 1 ).Pos
		    end
		
		    render.DrawLine( srcPos, hitpos, clr )
		
		    return false -- Hide original physics gun beam
		
		end )
		```
    **/
    var DrawPhysgunBeam:GMHook<(ply:Player, physgun:Weapon, enabled:Bool, target:Entity, physBone:Float, hitPos:Vector) -> Bool>; 
    #end
    #if client
    /**
        Called when the context menu keybind (+menu_context) is pressed, which by default is C. 
		
		See also GM:OnContextMenuClose.
    **/
    var OnContextMenuOpen:GMHook<() -> Void>; 
    #end
    #if server
    /**
        Allows you to add extra positions to the player's PVS. This is the place to call AddOriginToPVS.
		
		Name | Description
		--- | ---
		`ply` | The player
		`viewEntity` | Players Player: GetViewEntity
    **/
    var SetupPlayerVisibility:GMHook<(ply:Player, viewEntity:Entity) -> Void>; 
    #end
    #if server
    /**
        Called when player starts taunting.
		
		Name | Description
		--- | ---
		`ply` | The player who is taunting
		`act` | The sequence ID of the taunt
		`length` | Length of the taunt
    **/
    var PlayerStartTaunt:GMHook<(ply:Player, act:Float, length:Float) -> Void>; 
    #end
    #if client
    /**
        Called whenever this entity changes its transmission state for this LocalPlayer, such as exiting or re entering the PVS.
		
		**Note:** This is the best place to handle the reset of Entity:SetPredictable, as this would be usually called when the player lags and requests a full packet update
		
		**Note:** When the entity stops transmitting, Entity:IsDormant will only return true after this hook
		
		Name | Description
		--- | ---
		`ent` | The entity that changed its transmission state.
		`shouldtransmit` | True if we started transmitting to this client and false if we stopped.
    **/
    var NotifyShouldTransmit:GMHook<(ent:Entity, shouldtransmit:Bool) -> Void>; 
    #end
    
    /**
        Called when a player has been hit by a trace and damaged (such as from a bullet). Returning true overrides the damage handling and prevents GM:ScalePlayerDamage from being called.
		
		Name | Description
		--- | ---
		`ply` | The player that has been hit
		`dmginfo` | The damage info of the bullet
		`dir` | Normalized vector direction of the bullet's path
		`trace` | The trace of the bullet's path, see TraceResult structure
		
		
		`**Returns:** Override engine handling
    **/
    var PlayerTraceAttack:GMHook<(ply:Player, dmginfo:CTakeDamageInfo, dir:Vector, trace:TraceResult) -> Bool>; 
    
    #if client
    /**
        Called to allow override of the default Derma skin for all panels.
		
		**Note:** This hook is only called on Lua start up, changing its value (or adding new hooks) after it has been already called will not have any effect.
		
		`**Returns:** A case sensitive Derma skin name to be used as default, registered previously via derma.DefineSkin. Returning nothing, nil or invalid name will make it fallback to the "Default" skin.
		
		___
		### Lua Examples
		#### Example 1
		Example on how to use this hook. This will make that all panels
		
		```lua 
		hook.Add( "ForceDermaSkin", "my_new_skin", function()
		    return "some_skin"
		end )
		```
    **/
    var ForceDermaSkin:GMHook<() -> String>; 
    #end
    
    /**
        Called when the game(server) needs to update the text shown in the server browser as the gamemode.
		
		`**Returns:** The text to be shown in the server browser as the gamemode
    **/
    var GetGameDescription:GMHook<() -> String>; 
    
    #if client
    /**
        Called before the renderer is about to start rendering the next frame.
		
		`**Returns:** Return true to prevent all rendering. This can make the whole game stop rendering anything.
		
		___
		### Lua Examples
		#### Example 1
		Fills the draw buffer with black pixels, removing tearing when looking at a world leak. Achieves the same effect as using gl_clear. This is no longer needed as GMod does this by default.
		
		```lua 
		hook.Add("PreRender", "ResetBuffer", function()
		    cam.Start2D()
		        surface.SetDrawColor(0, 0, 0, 255)
		        surface.DrawRect(0, 0, ScrW(), ScrH())
		    cam.End2D()
		end)
		```
    **/
    var PreRender:GMHook<() -> Bool>; 
    #end
    #if server
    /**
        Called to determine a spawn point for a player to spawn at.
		
		Name | Description
		--- | ---
		`ply` | The player who needs a spawn point
		`transition` | If true, the player just spawned from a map transition. You probably want to not return an entity for that case to not override player's position.
		
		
		`**Returns:** The spawnpoint entity to spawn the player at
		
		___
		### Lua Examples
		#### Example 1
		Find a random spawn point
		
		```lua 
		function GM:PlayerSelectSpawn( pl )
		    
		    local spawns = ents.FindByClass( "info_player_start" )
		    local random_entry = math.random( #spawns )
		    
		    return spawns[ random_entry ]
		    
		end
		```
    **/
    var PlayerSelectSpawn:GMHook<(ply:Player, transition:Bool) -> Entity>; 
    #end
    #if client
    /**
        Called when the player undoes something.
		
		Name | Description
		--- | ---
		`name` | The name of the undo action
		`customText` | The custom text for the undo, set by undo. SetCustomUndoText
		
		
		___
		### Lua Examples
		#### Example 1
		Print a message when the player undoes something.
		
		```lua 
		function GM:OnUndo( name, customText )
		     if customText != nil then
		          MsgN( "Undone " .. customText )
		     else
		          MsgN( "Undone " .. name )
		     end
		end
		```
		**Output:**
		
		Undone Hook<action>;
    **/
    var OnUndo:GMHook<(name:String, customText:String) -> Void>; 
    #end
    #if client
    /**
        Called when the local player presses TAB while having their chatbox opened.
		
		Name | Description
		--- | ---
		`text` | The currently typed into chatbox text
		
		
		`**Returns:** What should be placed into the chatbox instead of what currently is when player presses tab
    **/
    var OnChatTab:GMHook<(text:String) -> String>; 
    #end
    #if client
    /**
        Allows you to modify the Source Engine's motion blur shaders.
		
		Name | Description
		--- | ---
		`horizontal` | The amount of horizontal blur.
		`vertical` | The amount of vertical blur.
		`forward` | The amount of forward/radial blur.
		`rotational` | The amount of rotational blur.
		
		
		Name | Description
		--- | ---
		`a` | New amount of horizontal blur.
		`b` | New amount of vertical blur.
		`c` | New amount of forward/radial blur.
		`d` | New amount of rotational blur.
		
		
		___
		### Lua Examples
		#### Example 1
		Makes your forward/radial blur pulse.
		
		```lua 
		local function GetNewMotionBlurValues( h, v, f, r )
		    f = f * math.sin( CurTime() * 5 )
		    return h, v, f, r
		end
		hook.Add( "GetMotionBlurValues", "GetNewMotionBlurValues", GetNewMotionBlurValues )
		```
		**Output:**
		
		Your radial blur pulses.
    **/
    var GetMotionBlurValues:GMHook<(horizontal:Float, vertical:Float, forward:Float, rotational:Float) -> Dynamic>; 
    #end
    
    /**
        Called after all the entities are initialized.
		
		**Note:** At this point the client only knows about the entities that are within the spawnpoints' PVS. For instance, if the server sends an entity that is not within this PVS, the client will receive it as NULL entity.
		
		___
		### Lua Examples
		#### Example 1
		Some message will be printed in the console when the entities initialize.
		
		```lua 
		function GM:InitPostEntity()
		    print("All Entities have initialized" )
		end
		
		-- That way you are overriding the default hook
		-- you can use hook.Add to make more functions get called when this event occurs
		
		hook.Add( "InitPostEntity", "some_unique_name", function()
		    print("Initialization hook called")
		end )
		```
    **/
    var InitPostEntity:GMHook<() -> Void>; 
    
    
    /**
        Override this hook to disable/change ear-grabbing in your gamemode.
		
		Name | Description
		--- | ---
		`ply` | Player
    **/
    var GrabEarAnimation:GMHook<(ply:Player) -> Void>; 
    
    #if client
    /**
        ***INTERNAL** 
		
		Called whenever a player's class is changed on the server-side with player_manager.SetPlayerClass.
		
		Name | Description
		--- | ---
		`ply` | The player whose class has been changed.
		`newID` | The network ID of the player class's name string, or 0 if we are clearing a player class from the player. Pass this into util. NetworkIDToString to retrieve the proper name of the player class.
    **/
    @:deprecated("INTERNAL")
    
    var PlayerClassChanged:GMHook<(ply:Player, newID:Float) -> Void>; 
    #end
    #if server
    /**
        Called whenever a player spawns and must choose a model. A good place to assign a model to a player.
		
		**Note:** This function may not work in your custom gamemode if you have overridden your GM:PlayerSpawn and you do not use self.BaseClass.PlayerSpawn or hook.Call.
		
		Name | Description
		--- | ---
		`ply` | The player being chosen
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the player's model to Odessa
		
		```lua 
		function GM:PlayerSetModel( ply )
		   ply:SetModel( "models/player/odessa.mdl" )
		end
		```
    **/
    var PlayerSetModel:GMHook<(ply:Player) -> Void>; 
    #end
    #if client
    /**
        Called from GM:HUDPaint to draw player info when you hover over a player with your crosshair or mouse.
		
		___
		### Lua Examples
		#### Example 1
		This code will turn off the player and health appearing when you look at them.
		
		```lua 
		function GM:HUDDrawTargetID()
		end
		```
    **/
    var HUDDrawTargetID:GMHook<() -> Void>; 
    #end
    #if server
    /**
        Called when a weapon is dropped by a player via Player:DropWeapon. 
		
		See also GM:WeaponEquip for a hook when a player picks up a weapon. 
		
		 The weapon's Entity:GetOwner will be NULL at the time this hook is called. WEAPON:OnDrop will be called before this hook is.
		
		Name | Description
		--- | ---
		`owner` | The player who owned this weapon before it was dropped
		`wep` | The weapon that was dropped
    **/
    var PlayerDroppedWeapon:GMHook<(owner:Player, wep:Weapon) -> Void>; 
    #end
    
    /**
        Called when an addon from the Steam workshop finishes downloading. Used by default to update details on the workshop downloading panel.
		
		Name | Description
		--- | ---
		`id` | Workshop ID of addon.
		`title` | Name of addon.
    **/
    var WorkshopDownloadedFile:GMHook<(id:Float, title:String) -> Void>; 
    
    #if server
    /**
        Request a player to join the team. This function will check if the team is available to join or not. 
		
		This hook is called when the player runs "changeteam" in the console. 
		
		 To prevent the player from changing teams, see GM:PlayerCanJoinTeam
		
		Name | Description
		--- | ---
		`ply` | The player to try to put into a team
		`team` | Team to put the player into if the checks succeeded
    **/
    var PlayerRequestTeam:GMHook<(ply:Player, team:Float) -> Void>; 
    #end
    #if server
    /**
        Triggered when the player presses use on an object. Continuously runs until USE is released but will not activate other Entities until the USE key is released; dependent on activation type of the Entity.
		
		Name | Description
		--- | ---
		`ply` | The player pressing the "use" key.
		`ent` | The entity which the player is looking at / activating USE on.
		
		
		`**Returns:** Return false if the player is not allowed to USE the entity. Do not return true if using a hook, otherwise other mods may not get a chance to block a player's use.
		
		___
		### Lua Examples
		#### Example 1
		The arguments will continue to be output as long as the user holds their USE key. If the user activates one object, say a door, and looks at a different object, say a different door, then the print statement will reflect the new Entity, however even when true is returned the new Entity will not be activated until the user lets go of USE and depresses it once again; this is dependent on the USE TYPE of the Entity.
		
		```lua 
		hook.Add( "PlayerUse", "some_unique_name2", function( ply, ent )
		    print( ply, ent )
		end )
		```
		**Output:**
		
		After holding it for a VERY brief moment looking at one door in a way that I would look at the other door once the first opens. Player [1][Example_User_Name] 	Entity [369][func_door_rotating]
		Player [1][Example_User_Name] 	Entity [369][func_door_rotating]
		Player [1][Example_User_Name] 	Entity [368][func_door_rotating]
		Player [1][Example_User_Name] 	Entity [368][func_door_rotating]
		
		#### Example 2
		Prevent users from using the ammo cache on the back of a Jeep.
		
		```lua 
		hook.Add( "PlayerUse", "some_unique_name", function( ply, ent )
		    if ( !IsValid( ent ) or !ent:IsVehicle() ) then return end
		    
		    if ( ply:GetEyeTrace().HitGroup == 5 ) then
		        return false
		    end
		end )
		```
    **/
    var PlayerUse:GMHook<(ply:Player, ent:Entity) -> Bool>; 
    #end
    #if client
    /**
        Runs when user cancels/finishes typing.
		
		___
		### Lua Examples
		#### Example 1
		Prints "User has closed the chatbox." when player closes their chat or sends the message.
		
		```lua 
		hook.Add( "FinishChat", "ClientFinishTyping", function()
		    print( "User has closed the chatbox." )
		end)
		```
    **/
    var FinishChat:GMHook<() -> Void>; 
    #end
    #if client
    /**
        Called whenever the HUD should be drawn. Called right before GM:HUDDrawScoreBoard and after GM:HUDPaintBackground. 
		
		Not called when the Camera SWEP is equipped. See also GM:DrawOverlay.
		
		**Note:** Only be called when r_drawvgui is enabled and the game is not paused
		
		**Note:** This is a rendering hook with a 2D rendering context. This means that the only rendering functions will work in it are functions with a 2D rendering context.
		
		___
		### Lua Examples
		#### Example 1
		Draws a transparent black box in the top left corner of the screen.
		
		```lua 
		hook.Add("HUDPaint", "HUDPaint_DrawABox", function()
		    surface.SetDrawColor( 0, 0, 0, 128 )
		    surface.DrawRect( 50, 50, 128, 128 )
		end )
		```
    **/
    var HUDPaint:GMHook<() -> Void>; 
    #end
    
    /**
        Allows to override player noclip animations.
		
		Name | Description
		--- | ---
		`ply` | The player
		`velocity` | Players velocity
		
		
		`**Returns:** Return true if we've changed/set the animation, false otherwise
    **/
    var HandlePlayerNoClipping:GMHook<(ply:Player, velocity:Float) -> Bool>; 
    
    #if client
    /**
        Called after GM:PreDrawHUD, GM:HUDPaintBackground and GM:HUDPaint but before GM:DrawOverlay.
		
		**Note:** This is a rendering hook with a 2D rendering context. This means that the only rendering functions will work in it are functions with a 2D rendering context.
    **/
    var PostDrawHUD:GMHook<() -> Void>; 
    #end
    #if client
    /**
        Called before the sky box is drawn.
		
		**Note:** This is a rendering hook with a 3D rendering context. This means that the only rendering functions will work in it are functions with a 3D rendering context.
		
		`**Returns:** Return true to disable skybox drawing (both 2D and 3D skybox)
    **/
    var PreDrawSkyBox:GMHook<() -> Bool>; 
    #end
    
    /**
        Allows to override player crouch animations.
		
		Name | Description
		--- | ---
		`ply` | The player
		`velocity` | Players velocity
		
		
		`**Returns:** Return true if we've changed/set the animation, false otherwise
    **/
    var HandlePlayerDucking:GMHook<(ply:Player, velocity:Float) -> Bool>; 
    
    #if client
    /**
        Called every frame to render the scoreboard. It is recommended to use Derma and VGUI for this job instead of this hook. Called right after GM:HUDPaint.
		
		**Note:** This is a rendering hook with a 2D rendering context. This means that the only rendering functions will work in it are functions with a 2D rendering context.
    **/
    var HUDDrawScoreBoard:GMHook<() -> Void>; 
    #end
    
    /**
        Called right before the removal of an entity.
		
		Name | Description
		--- | ---
		`ent` | Entity being removed
    **/
    var EntityRemoved:GMHook<(ent:Entity) -> Void>; 
    
    #if client
    /**
        Returns the color for the given entity's team. This is used in chat and deathnotice text.
		
		Name | Description
		--- | ---
		`ent` | Entity
		
		
		`**Returns:** Team Color
    **/
    var GetTeamColor:GMHook<(ent:Entity) -> AnyTable>; 
    #end
    
    /**
        Called when gamemode has been reloaded by auto refresh.
		
		**Note:** It seems that this event can be triggered more than once for a single refresh event.
    **/
    var OnReloaded:GMHook<() -> Void>; 
    
    #if client
    /**
        Called after the frame has been rendered.
    **/
    var PostRender:GMHook<() -> Void>; 
    #end
    #if client
    /**
        Called after all translucent entities are drawn. 
		
		See also GM:PostDrawOpaqueRenderables and GM:PreDrawTranslucentRenderables.
		
		**Note:** This is a rendering hook with a 3D rendering context. This means that the only rendering functions will work in it are functions with a 3D rendering context.
		
		**Bug:** BUG This is still called when r_drawentities or r_drawopaquerenderables is disabled. Issue Tracker: #3295
		
		**Bug:** BUG This is not called when r_drawtranslucentworld is disabled. Issue Tracker: #3296
		
		Name | Description
		--- | ---
		`bDrawingDepth` | Whether the current call is writing depth.
		`bDrawingSkybox` | Whether the current call is drawing skybox.
		
		
		___
		### Lua Examples
		#### Example 1
		Draws a solid black sphere at where the player is looking at, but not when the skybox is being drawn.You can see why this is needed if you disable the skybox check and look into the sky on gm_flatgrass (or any other map where the 3d skybox is below the map) and you will notice 2 spheres and not 1.
		
		```lua 
		hook.Add( "PostDrawTranslucentRenderables", "test", function( bDepth, bSkybox )
		
		    -- If we are drawing in the skybox, bail
		    if ( bSkybox ) then return end
		
		    -- Set the draw material to solid white
		    render.SetColorMaterial()
		
		    -- The position to render the sphere at, in this case, the looking position of the local player
		    local pos = LocalPlayer() -> GetEyeTrace>;().HitPos
		
		    -- Draw the sphere!
		    render.DrawSphere( pos, 500, 30, 30, Color( 0, 0, 0 ) )
		
		end )
		```
    **/
    var PostDrawTranslucentRenderables:GMHook<(bDrawingDepth:Bool, bDrawingSkybox:Bool) -> Void>; 
    #end
    
    /**
        ***INTERNAL** 
		
		Called by the engine when the game initially fetches subscriptions to be displayed on the bottom of the main menu screen.
		
		Name | Description
		--- | ---
		`num` | Amount of subscribed addons that have info retrieved.
		`max` | Total amount of subscribed addons that need their info retrieved.
    **/
    @:deprecated("INTERNAL")
    
    var WorkshopSubscriptionsProgress:GMHook<(num:Float, max:Float) -> Void>; 
    
    
    /**
        Called when the entity is created.
		
		**Warning:** Removing the created entity during this event can lead to unexpected problems. Use timer.Simple( 0, .... ) to safely remove the entity.
		
		**Note:** Some entities on initial map spawn are passed through this hook, and then removed in the same frame. This is used by the engine to precache things like models and sounds, so always check their validity with IsValid.
		
		Name | Description
		--- | ---
		`entity` | The entity
		
		
		___
		### Lua Examples
		#### Example 1
		When a prop spawns it yells.
		
		```lua 
		function GM:OnEntityCreated( ent )
		    if ( ent:GetClass() == "prop_physics" ) then
		        ent:EmitSound( "vo/npc/male01/no02.wav" )
		    end
		end
		```
		
		#### Example 2
		Adds all props and ragdolls into a list. More efficient alternative to looping over ents.GetAll().
		
		```lua 
		local TrackedEnts =
		{
		    [ "prop_physics" ] = true,
		    [ "prop_ragdoll" ] = true
		}
		
		local EntList = 
		
		hook.Add( "OnEntityCreated", "SoftEntList", function( ent )
		    if ( not ent:IsValid() or not TrackedEnts[ ent:GetClass() ] ) then return end
		    
		    EntList[ ent:EntIndex() ] = ent
		end )
		```
    **/
    var OnEntityCreated:GMHook<(entity:Entity) -> Void>; 
    
    
    /**
        Allows you to override the time between footsteps.
		
		Name | Description
		--- | ---
		`ply` | Player who is walking
		`type` | The type of footsteps, see STEPSOUNDTIME_ Enums
		`walking` | Is the player walking or not ( +walk? )
		
		
		`**Returns:** Time between footsteps, in ms
    **/
    var PlayerStepSoundTime:GMHook<(ply:Player, type:STEPSOUNDTIME, walking:Bool) -> Float>; 
    
    #if client
    /**
        This will prevent IN_ATTACK from sending to server when player tries to shoot from C menu.
		
		`**Returns:** Return true to prevent screen clicks
		
		___
		### Lua Examples
		#### Example 1
		Prevents usage of the World Clicker feature, where a player can hold C to shoot at their cursor instead of their crosshair.
		
		```lua 
		hook.Add( "PreventScreenClicks", "DisableWorldClicker", function()
		    local pnl = vgui.GetHoveredPanel()
		    if ( pnl:IsWorldClicker() ) then return true end
		end )
		```
    **/
    var PreventScreenClicks:GMHook<() -> Bool>; 
    #end
    
    /**
        Called when a player switches their weapon.
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		**Bug:** BUG This can be NULL on the client if the weapon hasn't been created over the network yet. Issue Tracker: #2922
		
		Name | Description
		--- | ---
		`player` | The player switching weapons.
		`oldWeapon` | The previous weapon. Will be NULL if the previous weapon was removed or the player is switching from nothing.
		`newWeapon` | The weapon the player switched to. Will be NULL if the player is switching to nothing. BUG This can be NULL on the client if the weapon hasn't been created over the network yet. Issue Tracker: #2922
		
		
		`**Returns:** Return true to prevent weapon switch
		
		___
		### Lua Examples
		#### Example 1
		The players weapon information will be printed when the player switched weapons.
		
		```lua 
		function GM:PlayerSwitchWeapon(ply, oldWeapon, newWeapon)
		    //GetClass() will return the weapons class as a string.
		    MsgN("You switched weapons! Your old weapon is " .. oldWeapon:GetClass() ..".")
		    MsgN("Your new weapon is " .. newWeapon:GetClass() .. ".");
		end
		```
    **/
    var PlayerSwitchWeapon:GMHook<(player:Player, oldWeapon:Weapon, newWeapon:Weapon) -> Bool>; 
    
    #if client
    /**
        Called every frame before drawing the in-game monitors ( Breencast, in-game TVs, etc ), but doesn't seem to be doing anything, trying to render 2D or 3D elements fail.
    **/
    var DrawMonitors:GMHook<() -> Void>; 
    #end
    #if client
    /**
        Renders the HUD pick-up history. Override to hide default or draw your own HUD.
    **/
    var HUDDrawPickupHistory:GMHook<() -> Void>; 
    #end
    #if server
    /**
        Called when a player leaves the server. See the player_disconnect gameevent for a shared version of this hook.
		
		**Bug:** BUG This is not called in single-player or listen servers for the host. Issue Tracker: #3523
		
		Name | Description
		--- | ---
		`ply` | the player
		
		
		___
		### Lua Examples
		#### Example 1
		Print a message to the chatbox upon player disconnect
		
		```lua 
		function GM:PlayerDisconnected( ply )
		     PrintMessage( HUD_PRINTTALK, ply:Name().. " has left the server." )
		end
		```
		**Output:**
		
		Garry :D has left the server.
    **/
    var PlayerDisconnected:GMHook<(ply:Player) -> Void>; 
    #end
    #if server
    /**
        Called when a player reloads with the physgun. Override this to disable default unfreezing behavior.
		
		Name | Description
		--- | ---
		`physgun` | The physgun in question
		`ply` | The player wielding the physgun
		
		
		`**Returns:** Whether the player can reload with the physgun or not
    **/
    var OnPhysgunReload:GMHook<(physgun:Weapon, ply:Player) -> Bool>; 
    #end
    #if server
    /**
        Called once when the player is authenticated.
		
		**Bug:** BUG CurTime returns 0 in this hook. Issue Tracker: #3026
		
		Name | Description
		--- | ---
		`ply` | The player
		`steamid` | The player's SteamID
		`uniqueid` | The player's UniqueID
		
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		function GM:PlayerAuthed( ply, steamid, uniqueid )
		    print( ply:Name() .. " has been authenticated as " .. steamid .. "." )
		end
		```
    **/
    var PlayerAuthed:GMHook<(ply:Player, steamid:String, uniqueid:String) -> Void>; 
    #end
    
    /**
        This hook polls the entity the player use action should be applied to.
		
		**Note:** The default behavior of this hook is in CBasePlayer::FindUseEntity. Despite CBasePlayer::FindUseEntity being defined shared, it is only called serverside in practice, so this hook will be only called serverside, as well. It is possible for modules to call it clientside, so the Lua code should still be treated as shared.
		
		Name | Description
		--- | ---
		`ply` | The player who initiated the use action.
		`defaultEnt` | The entity that was chosen by the engine.
		
		
		`**Returns:** The entity to use instead of default entity
    **/
    var FindUseEntity:GMHook<(ply:Player, defaultEnt:Entity) -> Entity>; 

}

