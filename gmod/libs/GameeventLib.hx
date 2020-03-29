package gmod.libs;


/**
    Used to interface with the built in game events system.
**/
@:native("_G.gameevent")extern class GameeventLib {
    
    /**
        Add a game event listener.
		
		Name | Description
		--- | ---
		`eventName` | The event to listen to, travels through hooks with eventName as event. List of valid events can be found here.
		
		
		___
		### Lua Examples
		#### Example 1
		Announce to everyone that a player has connected.
		
		```lua 
		gameevent.Listen( "player_connect" )
		hook.Add("player_connect", "AnnounceConnection", function( data )
		    for k,v in pairs( player.GetAll() ) do
		        v:ChatPrint( data.name .. " has connected to the server." )
		    end
		end)
		```
		**Output:**
		
		"Shinycow has connected to the server."
		
		#### Example 2
		This is a basic template for creating game_event listeners/hooks with the purpose of including all arguments / table variables for each game-event to make it easily known which values can be accessed and when: player_connect. player_connect is triggered at the exact moment they join the server.
		
		```lua 
		gameevent.Listen( "player_connect" )
		hook.Add( "player_connect", "player_connect_example", function( data )
		    local name = data.name            // Same as Player:Nick()
		    local steamid = data.networkid    // Same as Player:SteamID()
		    local ip = data.address            // Same as Player:IPAddress()
		    local id = data.userid            // Same as Player:UserID()
		    local bot = data.bot            // Same as Player:IsBot()
		    local index = data.index        // Same as Player:EntIndex()
		
		    // Player has connected; this happens instantly after they join -- do something..
		
		end )
		```
		
		#### Example 3
		This is a basic template for creating game_event listeners/hooks with the purpose of including all arguments / table variables for each game-event to make it easily known which values can be accessed and when: player_disconnect. player_disconnect is triggered at the exact moment they disconnect from the server and will ALWAYS trigger regardless of whether they time-out, are kick/banned, client crashes, they click the X, they type quit in console, etc...
		
		```lua 
		gameevent.Listen( "player_disconnect" )
		hook.Add( "player_disconnect", "player_disconnect_example", function( data )
		    local name = data.name            // Same as Player:Nick()
		    local steamid = data.networkid        // Same as Player:SteamID()
		    local id = data.userid            // Same as Player:UserID()
		    local bot = data.bot            // Same as Player:IsBot()
		    local reason = data.reason        // Text reason for disconnected such as "Kicked by console!", "Timed out!", etc...
		
		    // Player has disconnected - this is more reliable than PlayerDisconnect
		    
		end )
		```
		
		#### Example 4
		This is a basic template for creating game_event listeners/hooks with the purpose of including all arguments / table variables for each game-event to make it easily known which values can be accessed and when: player_spawn. player_spawn is triggered when the player initially spawns, or respawns.
		
		```lua 
		gameevent.Listen( "player_spawn" )
		hook.Add( "player_spawn", "player_spawn_example", function( data ) 
		    local id = data.userid    // Same as Player:UserID()
		
		    // Called when the player spawns initially or respawns.
		
		end )
		```
		
		#### Example 5
		This is a basic template for creating game_event listeners/hooks with the purpose of including all arguments / table variables for each game-event to make it easily known which values can be accessed and when: player_hurt. player_hurt is triggered when the player is injured or dies.The SERVER receives 1 extra value - Priority.
		
		```lua 
		gameevent.Listen( "player_hurt" )
		hook.Add( "player_hurt", "player_hurt_example", function( data ) 
		    local health = data.health                // Remaining health after injury
		    local priority = SERVER and data.Priority or 5         // Priority ??
		    local id = data.userid                    // Same as Player:UserID()
		    local attackerid = data.attacker            // Same as Player:UserID() but it's the attacker id.
		
		    // Called when the player is injured or dies.
		
		end )
		```
		
		#### Example 6
		This is a basic template for creating game_event listeners/hooks with the purpose of including all arguments / table variables for each game-event to make it easily known which values can be accessed and when: player_hurt. player_hurt is triggered when the player is injured or dies.The SERVER receives 1 extra value - Priority.
		
		```lua 
		gameevent.Listen( "player_say" )
		hook.Add( "player_say", "player_say_example", function( data ) 
		    local priority = SERVER and data.Priority or 1     // Priority ??
		    local id = data.userid                // Same as Player:UserID() for the speaker
		    local text = data.text                // The written text.
		
		    // Called when a player writes text ( Called by the SERVER on the client AFTER the PlayerSay hook )
		
		end )
		```
		
		#### Example 7
		This is a basic template for creating game_event listeners/hooks with the purpose of including all arguments / table variables for each game-event to make it easily known which values can be accessed and when: entity_killed. entity_killed is triggered when the player or entity dies.
		
		```lua 
		gameevent.Listen( "entity_killed" )
		hook.Add( "entity_killed", "entity_killed_example", function( data ) 
		    local inflictor_index = data.entindex_inflictor        // Same as Weapon:EntIndex() / weapon used to kill victim
		    local attacker_index = data.entindex_attacker        // Same as Player/Entity:EntIndex() / person or entity who did the damage
		    local damagebits = data.damagebits            // DAMAGE_TYPE - use BIT operations to decipher damage types...
		    local victim_index = data.entindex_killed        // Same as Victim:EntIndex() / the entity / player victim
		
		    // Called when a Player or Entity is killed
		
		end )
		```
    **/
    
    public static function Listen(eventName:String):Void;
    
    

}



