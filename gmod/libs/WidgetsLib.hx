package gmod.libs;


/**
    The widgets library. 
	
	Widgets allow the player to have mouse interaction with entities, such as being able to manipulate the bones of an NPC.
**/
@:native("_G.widgets")extern class WidgetsLib {
    
    /**
        ***INTERNAL** 
		
		Automatically called to update all widgets.       That's how it is used in lua/includes/modules/widget.lua
		
		Name | Description
		--- | ---
		`ply` | The player
		`mv` | Player move data
		
		
		___
		### Lua Examples
		#### Example 1
		That's how it is used in lua/includes/modules/widget.lua
		
		```lua 
		hook.Add( "PlayerTick", "TickWidgets", function( pl, mv ) widgets.PlayerTick( pl, mv ) end )
		```
    **/
    @:deprecated("INTERNAL")
    public static function PlayerTick(ply:Player, mv:CMoveData):Void;
    
    #if client
    /**
        Renders a widget. Normally you won't need to call this.
		
		Name | Description
		--- | ---
		`ent` | Widget entity to render
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage in lua/entities/widget_base.lua
		
		```lua 
		function ENT:Draw()
		
		    widgets.RenderMe( self )
		    
		end
		```
    **/
    
    public static function RenderMe(ent:Entity):Void;
    #end
    

}



