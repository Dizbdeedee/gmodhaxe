package gmod.libs;
#if client

/**
    The halo library is used to draw glowing outlines around entities, an example of this can be seen by picking up props with the physgun in Garry's Mod 13.
**/
@:native("_G.halo")extern class HaloLib {
    
    /**
        Returns the entity the halo library is currently rendering the halo for. 
		
		The main purpose of this function is to be used in ENTITY:Draw in order not to draw certain parts of the entity when the halo is being rendered, so there's no halo around unwanted entity parts, such as lasers, 3D2D displays, etc.
		
		`**Returns:** If set, the currently rendered entity by the halo library.
    **/
    
    public static function RenderedEntity():Entity;
    
    
    /**
        Applies a "halo" glow effect to one or multiple entities.
		
		**Warning:** Using this function outside of the PreDrawHalos hook can cause instability or crashes.
		
		Name | Description
		--- | ---
		`entities` | A table of entities to add the halo effect to
		`color` | The desired color of the halo. See Color structure
		`blurX` | The strength of the halo's blur on the x axis.
		`blurY` | The strength of the halo's blur on the y axis.
		`passes` | The number of times the halo should be drawn per frame. Increasing this may hinder player FPS.
		`additive` | Sets the render mode of the halo to additive.
		`ignoreZ` | Renders the halo through anything when set to true.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds a halo around all props in the map using an O(n) operation and iterating through unseen objects which can be extremely expensive to process.
		
		```lua 
		hook.Add( "PreDrawHalos", "AddPropHalos", function()
		    halo.Add( ents.FindByClass( "prop_physics*" ), Color( 255, 0, 0 ), 5, 5, 2 )
		end )
		```
		**Output:**
		
		All the props on the map will be rendered with a red halo, a blur amount of 5, and two passes.
		
		#### Example 2
		Adds a green halo around all admins.
		
		```lua 
		hook.Add( "PreDrawHalos", "AddStaffHalos", function()
		    local staff = {}
		    local staffcount = 0
		
		    for _, ply in ipairs( player.GetAll() ) do
		        if ( ply:IsAdmin() ) then
		            staffcount = staffcount + 1
		            staff[ staffcount ] = ply
		        end
		    end
		
		    if ( staffcount > 0 ) then
		        halo.Add( staff, Color( 0, 255, 0 ), 0, 0, 2, true, true )
		    end
		end )
		```
    **/
    
    public static function Add(entities:AnyTable, color:Color, ?blurX:Float, ?blurY:Float, ?passes:Float, ?additive:Bool, ?ignoreZ:Bool):Void;
    
    
    /**
        ***INTERNAL** 
		
		Renders a halo according to the specified table, only used internally, called from a PostDrawEffects hook added by the halo library
		
		Name | Description
		--- | ---
		`entry` | Table with info about the halo to draw.
    **/
    @:deprecated("INTERNAL")
    public static function Render(entry:AnyTable):Void;
    
    

}



#end