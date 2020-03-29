package gmod.libs;


/**
    The undo library allows you to add custom entities to the undo list, allowing users to "undo" their creation with their undo (default: Z) key.
**/
@:native("_G.undo")extern class UndoLib {
    #if server
    /**
        Processes an undo block (in table form). This is used internally by the undo manager when a player presses Z.
		
		Name | Description
		--- | ---
		`tab` | The undo block to process as an Undo structure
		
		
		`**Returns:** Number of removed entities
		
		___
		### Lua Examples
		#### Example 1
		This example removes two entities, and informs player 1 that they just "Undone Prop!"
		
		```lua 
		local tab = {}
		tab.Owner = Entity(1)
		tab.Name = "prop"
		tab.Entities = {Entity(56),Entity(57)}
		undo.Do_Undo(tab)
		```
    **/
    
    public static function Do_Undo(tab:Undo):Float;
    #end
    #if server
    /**
        Adds a function to call when the current undo block is undone
		
		Name | Description
		--- | ---
		`func` | The function to call
		`arguments` | Arguments to pass to the function (after the undo info table)
		
		
		___
		### Lua Examples
		#### Example 1
		This example creates a prop_physics, and adds it to the players undo list. A message will be printed to console about it.
		
		```lua 
		prop = ents.Create("prop_physics")
		prop:SetModel("models/props_junk/wood_crate001a.mdl")
		prop:Spawn()
		undo.Create("prop")
		 undo.AddEntity(prop)
		 undo.AddFunction(function(tab, arg2)
		 print(tab.Owner:GetName().." removed prop "..tab.Entities[1]:GetModel()..", code: "..arg2)
		 end, 556)
		 undo.SetPlayer(ply)
		undo.Finish()
		```
		**Output:**
		
		"PlayerName removed prop models/props_junk/wood_crate001a.mdl, code: 556" will be printed
    **/
    
    public static function AddFunction(func:Function, arguments:Rest<Dynamic>):Void;
    #end
    #if client
    /**
        ***INTERNAL** 
		
		Adds a hook (CPanelPaint) to the control panel paint function so we can determine when it is being drawn.
    **/
    @:deprecated("INTERNAL")
    public static function SetupUI():Void;
    #end
    #if server
    /**
        Begins a new undo entry
		
		Name | Description
		--- | ---
		`name` | Name of the undo message to show to players
		
		
		___
		### Lua Examples
		#### Example 1
		This example creates a prop_physics, and adds it to Player's undo list.
		
		```lua 
		prop = ents.Create("prop_physics")
		prop:SetModel("models/props_junk/wood_crate001a.mdl")
		prop:Spawn()
		undo.Create("prop")
		 undo.AddEntity(prop)
		 undo.SetPlayer(Player)
		undo.Finish()
		```
    **/
    
    public static function Create(name:String):Void;
    #end
    #if server
    /**
        Sets the player which the current undo block belongs to
		
		Name | Description
		--- | ---
		`ply` | The player responsible for undoing the block
		
		
		___
		### Lua Examples
		#### Example 1
		This example creates a prop_physics, and adds it to the players undo list.
		
		```lua 
		prop = ents.Create("prop_physics")
		prop:SetModel("models/props_junk/wood_crate001a.mdl")
		prop:Spawn()
		undo.Create("prop")
		 undo.AddEntity(prop)
		 undo.SetPlayer(ply)
		undo.Finish()
		```
    **/
    
    public static function SetPlayer(ply:Player):Void;
    #end
    
    /**
        Serverside, returns a table containing all undo blocks of all players. Clientside, returns a table of the local player's undo blocks.
		
		`**Returns:** The undo table.
    **/
    
    public static function GetTable():AnyTable;
    
    #if server
    /**
        Replaces any instance of the "from" reference with the "to" reference, in any existing undo block. Returns true if something was replaced
		
		Name | Description
		--- | ---
		`from` | The old entity
		`to` | The new entity to replace the old one
		
		
		`**Returns:** somethingReplaced
		
		___
		### Lua Examples
		#### Example 1
		When an entity is ragdolled, this will replace any instances of the entity with it's ragdoll.
		
		```lua 
		function GM:CreateEntityRagdoll( entity, ragdoll )
		 // Replace the entity with the ragdoll in cleanups etc
		 undo.ReplaceEntity( entity, ragdoll )
		 cleanup.ReplaceEntity( entity, ragdoll )
		end
		```
    **/
    
    public static function ReplaceEntity(from:Entity, to:Entity):Bool;
    #end
    
    /**
        Completes an undo entry, and registers it with the player's client
		
		___
		### Lua Examples
		#### Example 1
		This example creates a prop_physics, and adds it to the players undo list.
		
		```lua 
		prop = ents.Create("prop_physics")
		prop:SetModel("models/props_junk/wood_crate001a.mdl")
		prop:Spawn()
		undo.Create("prop")
		 undo.AddEntity(prop)
		 undo.SetPlayer(Player)
		undo.Finish()
		```
    **/
    
    public static function Finish():Void;
    
    #if server
    /**
        Sets a custom undo text for the current undo block
		
		Name | Description
		--- | ---
		`customText` | The text to display when the undo block is undone
		
		
		___
		### Lua Examples
		#### Example 1
		This example creates a prop_physics, adds it to the players undo list, and sets a custom undo text
		
		```lua 
		local prop = ents.Create( "prop_physics" )
		prop:SetModel( "models/props_junk/wood_crate001a.mdl" )
		prop:Spawn()
		undo.Create( "prop" )
		 undo.AddEntity( prop )
		 undo.SetPlayer( Player )
		 undo.SetCustomUndoText("Undone a crate prop")
		undo.Finish()
		```
    **/
    
    public static function SetCustomUndoText(customText:String):Void;
    #end
    #if client
    /**
        ***INTERNAL** 
		
		Makes the UI dirty - it will re-create the controls the next time it is viewed. We also take this opportun
    **/
    @:deprecated("INTERNAL")
    public static function MakeUIDirty():Void;
    #end
    #if server
    /**
        Adds an entity to the current undo block
		
		Name | Description
		--- | ---
		`ent` | The entity to add
		
		
		___
		### Lua Examples
		#### Example 1
		This example creates a prop_physics, and adds it to the players undo list.
		
		```lua 
		prop = ents.Create("prop_physics")
		prop:SetModel("models/props_junk/wood_crate001a.mdl")
		prop:Spawn()
		
		undo.Create("prop")
		    undo.AddEntity(prop)
		    undo.SetPlayer(Player)
		undo.Finish()
		```
    **/
    
    public static function AddEntity(ent:Entity):Void;
    #end
    

}



