package gmod.libs;
#if server

/**
    The hammer library.
**/
@:native("_G.hammer")extern class HammerLib {
    
    /**
        Sends command to Hammer, if Hammer is running with the current map loaded.
		
		Name | Description
		--- | ---
		`cmd` | Command to send including arguments All commands are in the format "command var1 var2 etc" All commands that pick an entity with x y z , must use the exact position including decimals. i.e. -354.4523 123.4 -1224.325452 List of commands "session_begin mapName mapVersion" - Starts a hammer edit, locking the editor. mapName is the current map without path or suffix, mapVersion is the current version in the .vmf file "session_end" - Ends a hammer edit, unlocking the editor. "map_check_version mapName mapVersion" - This only works after session_begin, so you'd know the right version already and this only returns ok, this function is apparently useless "entity_create entityClass x y z" - Creates an entity of entityClass at position x y z "entity_delete entityClass x y z" - Deletes an entity of entityClass at position x y z "entity_set_keyvalue entityClass x y z "key" "value"" - Set's the KeyValue pair of an entity of entityClass at x y z. The Key name and Value String must be in quotes. "entity_rotate_incremental entityClass x y z incX incY incZ" - Rotates an entity of entityClass at x y z by incX incY incZ "node_create nodeClass nodeID x y z" - Creates an AI node of nodeClass with nodeID at x y z you should keep nodeID unique or you will have issues "node_delete nodeID" - Deletes node(s) with nodeID, this will delete multiple nodes if they have the same nodeID "nodelink_create startNodeID endNodeID" - Creates a link between AI nodes startNodeID and endNodeID "nodelink_delete startNodeID endNodeID" - Removes a link between AI nodes startNodeID and endNodeID
		
		
		`**Returns:** Returns "ok" if command succeeded otherwise returns "badcommand". All changes only happen in hammer, there is *NO* in game representation/feedback
		
		___
		### Lua Examples
		#### Example 1
		A hammer function library I wrote while testing all these functions.Please feel free to use this library as-is or with modification.
		
		```lua 
		if ( !SERVER) then return end
		-- Hammer Editor Lua Library
		-- By Malcolm Greene Jr (Fantym420)
		 
		-- Allows easy access to the hammer editor commands from lua code
		-- All commands return ok if they worked and badcommand if they don't
		-- All changes only show up in hammer, so if you want to see stuff in game you must
		-- write your own ghost entites and such.
		
		hammerLib = {}
		hammerLib.mapName = game.GetMap() -- Get the map name
		hammerLib.vBSPMapVer = game.GetMapVersion() -- This is the vbsp map version, we need the vmf map version
		hammerLib.mapVer = hammerLib.vBSPMapVer -- place holder value findGoodVer will find the current vmf version via trial and error
		
		-- returns a vector string with spaces the way hammer likes it
		function hammerLib.vectorToString(vec)
		
		    return tostring(vec.x) .. " " .. tostring(vec.y) .. " " .. tostring(vec.z)
		
		end
		
		-- tries to start a session using the current version, if it fails it tries the next
		-- if it can't find it in 20 tries you should probably compile your map before edititng more
		function hammerLib.findGoodVer()
		    
		    local verInc = 0
		    local result = ""
		    
		    for verInc = 0, 20 do 
		    
		        hammerLib.mapVer = hammerLib.vBSPMapVer + verInc
		        
		        result = hammerLib.startSession()
		        
		        if result == "ok" then
		            break
		        end
		        
		        if verInc == 20 then
		            print("Good Version Not Found, Please Re-Compile your map!!!")
		        end
		    end
		    
		    hammerLib.endSession()
		    
		end
		
		-- simple wrapper for hammer.SendCommand so that I could print the debug info
		-- un-comment the prints to see the command strings and results in console
		function hammerLib.runCommand(cmd)
		    
		    local result = ""
		    --print("running " .. cmd)
		    result = hammer.SendCommand(cmd)
		    --print(cmd .. " result: " .. result)
		    return result
		    
		
		end
		
		-- Always ran when starting an edit
		-- This locks hammer until you issue the session_end command
		function hammerLib.startSession()
		    
		    local cmd = "session_begin " .. hammerLib.mapName .. " " .. hammerLib.mapVer
		    
		    return hammerLib.runCommand(cmd)
		    
		end
		
		-- Ends the session unlocking hammer
		function hammerLib.endSession()
		    
		    local cmd = "session_end"
		
		    return hammer.SendCommand(cmd)
		    
		end
		
		-- useless function, it will return ok if you give it a good name and version
		-- however to run it you must already have a good version because you ran session_start
		-- implemented here for thoroughness, if you give it no variables it will just use the stored info.
		function hammerLib.mapCheckVersion(mcName, mcVer)
		    
		    mcName = mcName or hammerLib.mapName
		    mcVer = mcVer or hammerLib.mapVer
		    local cmd = "map_check_version " .. mcName .. " " .. mcVer
		    local result = ""
		    hammerLib.startSession()
		    result = hammerLib.runCommand(cmd)
		    hammerLib.endSession()
		    
		    return result
		    
		end
		
		-- this creates an entity of type entityClass at the given position
		--  I believe this only works with point entites seeing as there is no tie to brush command
		function hammerLib.entityCreate(entityClass, entityPos)
		    
		    if (entityClass == nil) or (entityPos == nil) then return end
		    local cmd = "entity_create " .. entityClass .. " " .. hammerLib.vectorToString(entityPos)
		    local result = ""
		    hammerLib.startSession()
		    result = hammerLib.runCommand(cmd)
		    hammerLib.endSession()
		    
		    return result
		    
		end
		
		-- this deletes an entity of type entityClass at entityPos
		-- NOTE: must be entities **EXACT** position, decimals and all or it fails
		function hammerLib.entityDelete(entityClass, entityPos)
		    
		    if (entityClass == nil) or (entityPos == nil) then return end
		    local cmd = "entity_delete " .. entityClass .. " " .. hammerLib.vectorToString(entityPos)
		    local result = ""
		    hammerLib.startSession()
		    result = hammerLib.runCommand(cmd)
		    hammerLib.endSession()
		    
		    return result
		    
		end
		
		-- Set's a Key/Value pair on entity of type entityClass at entityPos
		-- NOTE: must be entities **EXACT** position, decimals and all or it fails
		function hammerLib.entitySetKeyValue(entityClass, entityPos, key, value)
		    
		    
		    if (entityClass == nil) or 
		       (entityPos == nil) or
		       (key == nil) or
		       (value == nil) then return end
		       
		    local cmd = "entity_set_keyvalue " .. entityClass .. " " .. hammerLib.vectorToString(entityPos) .. " \"" .. key .. "\" \"" .. value .. "\""
		    local result = ""
		    hammerLib.startSession()
		    result = hammerLib.runCommand(cmd)
		    hammerLib.endSession()
		    
		    return result
		    
		end
		-- this will rotate an entity of type entityClass(string) at entityPos(vector) by rotationInc(vector)
		-- NOTE: must be entities **EXACT** position, decimals and all or it fails
		function hammerLib.entityRotateIncremental(entityClass, entityPos, rotationInc)
		    
		    if (entityClass == nil) or (entityPos == nil) then return end
		    local cmd = "entity_rotate_incremental " .. entityClass .. " " .. hammerLib.vectorToString(entityPos) .. " " .. hammerLib.vectorToString(rotationInc)
		    local result = ""
		    hammerLib.startSession()
		    result = hammerLib.runCommand(cmd)
		    hammerLib.endSession()
		    
		    return result
		    
		end
		
		-- This creates a node of type nodeClass with an ID of nodeID at nodePos
		-- keep nodeID unique, if you don't and you use node_delete, it deletes all nodes with the given id
		function hammerLib.nodeCreate(nodeClass, nodeID, nodePos)
		    
		    if (nodeClass == nil) or (nodeID == nil) or (nodePos == nil) then return end
		    local cmd = "node_create " .. nodeClass .. " " .. nodeID .. " " .. hammerLib.vectorToString(nodePos)
		    local result = ""
		    hammerLib.startSession()
		    result = hammerLib.runCommand(cmd)
		    hammerLib.endSession()
		    
		    return result
		    
		end
		-- deletes node(s) with the given nodeID, however if there are more than one node with the nodeID all 
		-- are deleted
		function hammerLib.nodeDelete(nodeID)
		    
		    if (nodeID == nil) then return end
		    local cmd = "node_delete " .. nodeID
		    local result = ""
		    hammerLib.startSession()
		    result = hammerLib.runCommand(cmd)
		    hammerLib.endSession()
		    
		    return result
		end
		
		-- This creates a link between two nodes, not sure if there's a limit no number of links
		-- so far it does at least 2 per node
		function hammerLib.nodeLinkCreate(node1ID, node2ID)
		    
		    if (node1ID == nil) or (node2ID == nil) then return end
		    local cmd = "nodelink_create " .. node1ID .. " " .. node2ID
		    local result = ""
		    hammerLib.startSession()
		    result = hammerLib.runCommand(cmd)
		    hammerLib.endSession()
		    
		    return result
		    
		end
		
		-- This deletes a connection between two nodes
		function hammerLib.nodeLinkDelete(node1ID, node2ID)
		    
		    if (node1ID == nil) or (node2ID == nil) then return end
		    local cmd = "nodelink_delete " .. node1ID .. " " .. node2ID
		    local result = ""
		    hammerLib.startSession()
		    result = hammerLib.runCommand(cmd)
		    hammerLib.endSession()
		    
		    return result
		    
		end
		
		-- All loaded, run findGoodVer to store the current vmf version
		hammerLib.findGoodVer()
		```
    **/
    
    public static function SendCommand(cmd:String):String;
    
    

}



#end