package gmod.gclass;
#if server

/**
    List of all possible functions to manipulate Recipient Filters. Can be created with RecipientFilter.
**/
extern class CRecipientFilter {
    
    /**
        Adds all players that are on the given team to the filter.
		
		Name | Description
		--- | ---
		`teamid` | Team index to add players from.
    **/
    
    public function AddRecipientsByTeam(teamid:Float):Void;
    
    
    /**
        Returns the number of valid players in the recipient filter.
		
		`**Returns:** Number of valid players in the recipient filter.
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the function
		
		```lua 
		local rf = RecipientFilter()
		rf:AddAllPlayers()
		print( rf:GetCount() )
		PrintTable( rf:GetPlayers() )
		```
		**Output:**
		
		2 1 = Player [1][Player #1] 2 = Player [2][Player #2]
    **/
    
    public function GetCount():Float;
    
    
    /**
        Adds all players to the recipient filter.
		
		___
		### Lua Examples
		#### Example 1
		Adds all players to a recipient filter, then uses the recipient filter in a usermessage.
		
		```lua 
		function SendMessage()
		    local filter = RecipientFilter()
		    filter:AddAllPlayers()
		    umsg.Start("message",filter)
		    umsg.End()
		end
		```
		**Output:**
		
		Sends a usermessage to every player.
    **/
    
    public function AddAllPlayers():Void;
    
    
    /**
        Removes all players from the recipient filter.
		
		___
		### Lua Examples
		#### Example 1
		Adds all players that can see the origin of the map, removes all players, then adds the first player object to the recipient filter, and sends them a message.
		
		```lua 
		function SendMessage()
		 local filter = RecipientFilter()
		 filter:AddPVS(Vector(0,0,0))
		 filter:RemoveAllPlayers()
		 filter:AddPlayer(Entity(1))
		 umsg.Start("message",filter)
		 umsg.End()
		end
		```
		**Output:**
		
		Sends a usermessage to the first player object, if it exists.
    **/
    
    public function RemoveAllPlayers():Void;
    
    
    /**
        Removes all players that can see this PVS from the recipient filter.
		
		Name | Description
		--- | ---
		`pos` | Position that players may be able to see.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds the first player object to the recipient filter, then sends him a message.
		
		```lua 
		function SendMessage()
		    local filter = RecipientFilter()
		    filter:AddPVS( Vector( 0,0,0 ) )
		    filter:RemovePVS( Vector( 0,10,0 ) )
		    umsg.Start( "message", filter )
		    umsg.End()
		end
		```
		**Output:**
		
		Adds all players that can see the map's origin to the recipient filter, then removes all players who can see 10 units to the left of the origin, and sends the rest a message.
    **/
    
    public function RemovePVS(pos:Vector):Void;
    
    
    /**
        Removes all players that are not on the given team from the filter.
		
		Name | Description
		--- | ---
		`teamid` | Team index.
    **/
    
    public function RemoveRecipientsNotOnTeam(teamid:Float):Void;
    
    
    /**
        Returns a table of all valid players currently in the recipient filter.
		
		`**Returns:** A table of all valid players currently in the recipient filter.
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the function
		
		```lua 
		local rf = RecipientFilter()
		rf:AddAllPlayers()
		print( rf:GetCount() )
		PrintTable( rf:GetPlayers() )
		```
		**Output:**
		
		2 1 = Player [1][Player #1] 2 = Player [2][Player #2]
    **/
    
    public function GetPlayers():AnyTable;
    
    
    /**
        Removes all players that are on the given team from the filter.
		
		Name | Description
		--- | ---
		`teamid` | Team index to remove players from.
    **/
    
    public function RemoveRecipientsByTeam(teamid:Float):Void;
    
    
    /**
        Removes the player from the recipient filter.
		
		Name | Description
		--- | ---
		`Player` | The player that should be in the recipient filter if you call this function.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds all players to the recipient filter, then removes the first player and sends a message to the rest.
		
		```lua 
		util.AddNetworkString("message")
		function SendMessage()
		    local filter = RecipientFilter()
		    filter:AddAllPlayers()
		    filter:RemovePlayer(Entity(1))
		    net.Start("message")
		    net.Send(filter)
		end
		```
		**Output:**
		
		Sends a net message to every player except the first.
    **/
    
    public function RemovePlayer(Player:Player):Void;
    
    
    /**
        Adds a player to the recipient filter
		
		Name | Description
		--- | ---
		`Player` | Player to add to the recipient filter.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds the first player object to the recipient filter, then sends him a message.
		
		```lua 
		function SendMessage()
		 local filter = RecipientFilter()
		 filter:AddPlayer(Entity(1))
		 umsg.Start("message",filter)
		 umsg.End()
		end
		```
		**Output:**
		
		Sends a usermessage to the first player object, if it exists.
    **/
    
    public function AddPlayer(Player:Player):Void;
    
    
    /**
        Adds all players that are in the same PAS as this position.
		
		Name | Description
		--- | ---
		`pos` | PAS position that players may be able to see.
    **/
    
    public function AddPAS(pos:Vector):Void;
    
    
    /**
        Removes all players from the filter that are in Potentially Audible Set for given position.
		
		Name | Description
		--- | ---
		`position` | The position to test
    **/
    
    public function RemovePAS(position:Vector):Void;
    
    
    /**
        Adds all players that are in the same PVS as this position.
		
		Name | Description
		--- | ---
		`Position` | PVS position.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds players that are visible from the origin of the map to a recipient filter, then sends them a message.
		
		```lua 
		function SendMessage()
		    local filter = RecipientFilter()
		    filter:AddPVS( Vector( 0, 0, 0 ) )
		    umsg.Start( "message", filter )
		    umsg.End()
		end
		```
		**Output:**
		
		Sends a usermessage to every player visible from 0,0,0
    **/
    
    public function AddPVS(Position:Vector):Void;
    
    
}



#end