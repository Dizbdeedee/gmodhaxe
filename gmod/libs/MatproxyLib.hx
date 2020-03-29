package gmod.libs;
#if client

/**
    Add proxies to materials.
**/
@:native("_G.matproxy")extern class MatproxyLib {
    
    /**
        Adds a material proxy.
		
		Name | Description
		--- | ---
		`MatProxyData` | The information about the proxy. See MatProxyData structure
		
		
		___
		### Lua Examples
		#### Example 1
		Adds PlayerColor proxy. Example taken from lua/matproxy/player_color.lua.
		
		```lua 
		matproxy.Add({
		    name = "PlayerColor", 
		    init = function( self, mat, values )
		        -- Store the name of the variable we want to set
		        self.ResultTo = values.resultvar
		    end,
		    bind = function( self, mat, ent )
		        -- If the target ent has a function called GetPlayerColor then use that
		        -- The function SHOULD return a Vector with the chosen player's colour.
		
		        -- In sandbox this function is created as a network function, 
		        -- in player_sandbox.lua in SetupDataTables
		       if ( ent.GetPlayerColor ) then
		           mat:SetVector( self.ResultTo, ent:GetPlayerColor() )
		       end
		   end 
		})
		```
		**Output:**
		
		Adds PlayerColor proxy.
		
		#### Example 2
		Material proxy values are stored like this:In the .vmt:
		
		```lua 
		Proxies {
		    PlayerColor {
		       resultVar $color2
		       myVariable $color
		    }
		}
		```
    **/
    
    public static function Add(MatProxyData:MatProxyData):Void;
    
    
    /**
        Called by the engine from OnBind
		
		Name | Description
		--- | ---
		`uname` | 
		`mat` | 
		`ent` | 
    **/
    
    public static function Call(uname:String, mat:IMaterial, ent:Entity):Void;
    
    
    /**
        Called by engine, returns true if we're overriding a proxy
		
		Name | Description
		--- | ---
		`name` | The name of proxy in question
		
		
		`**Returns:** Are we overriding it?
    **/
    
    public static function ShouldOverrideProxy(name:String):Bool;
    
    
    /**
        Called by the engine from OnBind
		
		Name | Description
		--- | ---
		`name` | 
		`uname` | 
		`mat` | 
		`values` | 
    **/
    
    public static function Init(name:String, uname:String, mat:IMaterial, values:AnyTable):Void;
    
    

}



#end