package gmod.libs;


/**
    The properties library gives you access to the menu that shows up when right clicking entities while holding C.
**/
@:native("_G.properties")extern class PropertiesLib {
    
    /**
        Add properties to the properties module
		
		Name | Description
		--- | ---
		`name` | A unique name used to identify the property
		`propertyData` | A table that defines the property. Uses the PropertyAdd structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Defines a property that can be used to ignite entities (from Sandbox)
		
		```lua 
		properties.Add( "ignite", {
		    MenuLabel = "#ignite", -- Name to display on the context menu
		    Order = 999, -- The order to display this property relative to other properties
		    MenuIcon = "icon16/fire.png", -- The icon to display next to the property
		
		    Filter = function( self, ent, ply ) -- A function that determines whether an entity is valid for this property
		        if ( !IsValid( ent ) ) then return false end
		        if ( ent:IsPlayer() ) then return false end
		        if ( !CanEntityBeSetOnFire( ent ) ) then return false end
		        if ( !gamemode.Call( "CanProperty", ply, "ignite", ent ) ) then return false end
		
		        return !ent:IsOnFire() 
		    end,
		    Action = function( self, ent ) -- The action to perform upon using the property ( Clientside )
		
		        self:MsgStart()
		            net.WriteEntity( ent )
		        self:MsgEnd()
		
		    end,
		    Receive = function( self, length, player ) -- The action to perform upon using the property ( Serverside )
		        local ent = net.ReadEntity()
		        if ( !self:Filter( ent, player ) ) then return end
		        
		        ent:Ignite( 360 )
		    end 
		} )
		```
    **/
    
    public static function Add(name:String, propertyData:PropertyAdd):Void;
    
    #if client
    /**
        Returns an entity player is hovering over with his cursor.
		
		Name | Description
		--- | ---
		`pos` | Eye position of local player, Entity: EyePos
		`aimVec` | Aim vector of local player, Player: GetAimVector
		
		
		`**Returns:** The hovered entity
    **/
    
    public static function GetHovered(pos:Vector, aimVec:Vector):Entity;
    #end
    
    /**
        Checks if player hovers over any entities and open a properties menu for it.
		
		Name | Description
		--- | ---
		`eyepos` | The eye pos of a player
		`eyevec` | The aim vector of a player
    **/
    
    public static function OnScreenClick(eyepos:Vector, eyevec:Vector):Void;
    
    
    /**
        Opens properties menu for given entity.
		
		Name | Description
		--- | ---
		`ent` | The entity to open menu for
		`tr` | The trace that is passed as second argument to Action callback of a property
    **/
    
    public static function OpenEntityMenu(ent:Entity, tr:AnyTable):Void;
    
    
    /**
        Returns true if given entity can be targeted by the player via the properties system. 
		
		This should be used serverside in your properties to prevent abuse by clientside scripting.
		
		Name | Description
		--- | ---
		`ent` | The entity to test
		`ply` | If given, will also perform a distance check based on the entity's Orientated Bounding Box.
		
		
		`**Returns:** True if entity can be targeted, false otherwise
    **/
    
    public static function CanBeTargeted(ent:Entity, ply:Player):Bool;
    
    

}



