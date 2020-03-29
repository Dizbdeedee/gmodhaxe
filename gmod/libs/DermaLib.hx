package gmod.libs;
#if client

/**
    The derma library allows you to add custom derma controls and create & modify derma skins.
**/
@:native("_G.derma")extern class DermaLib {
    
    /**
        Clears all cached panels so that they reassess which skin they should be using.
    **/
    
    public static function RefreshSkins():Void;
    
    
    /**
        Returns the default skin table, which can be changed with the hook GM/ForceDermaSkin
		
		`**Returns:** Skin table
    **/
    
    public static function GetDefaultSkin():AnyTable;
    
    
    /**
        Gets the color from a Derma skin of a panel and returns default color if not found
		
		Name | Description
		--- | ---
		`name` | 
		`pnl` | 
		`default` | The default color in case of failure.
    **/
    
    public static function Color(name:String, pnl:Panel, _default:AnyTable):Void;
    
    
    /**
        Calls the specified hook for the given panel
		
		Name | Description
		--- | ---
		`type` | The type of hook to run
		`name` | The name of the hook to run
		`panel` | The panel to call the hook for
		`w` | The width of the panel
		`h` | The height of the panel
		
		
		`**Returns:** The returned variable from the skin hook
    **/
    
    public static function SkinHook(type:String, name:String, panel:Panel, w:Float, h:Float):Dynamic;
    
    
    /**
        Returns how many times derma.RefreshSkins has been called.
		
		`**Returns:** Amount of times derma. RefreshSkins has been called.
    **/
    
    public static function SkinChangeIndex():Float;
    
    
    /**
        Returns the derma.Controls table, a list of all derma controls registered with derma.DefineControl.
		
		`**Returns:** A listing of all available derma-based controls. See derma. Controls for structure and contents.
    **/
    
    public static function GetControlList():AnyTable;
    
    
    /**
        Defines a new skin so that it is usable by Derma. The default skin can be found in "garrysmod/lua/skins/default.lua"
		
		Name | Description
		--- | ---
		`name` | Name of the skin
		`descriptions` | Description of the skin
		`skin` | Table containing skin data
    **/
    
    public static function DefineSkin(name:String, descriptions:String, skin:AnyTable):Void;
    
    
    /**
        Returns the skin table of the skin with the supplied name
		
		Name | Description
		--- | ---
		`name` | Name of skin
		
		
		`**Returns:** Skin table
    **/
    
    public static function GetNamedSkin(name:String):AnyTable;
    
    
    /**
        Defines a new Derma control with an optional base. 
		
		This calls vgui.Register internally, but also does the following:
		
		Name | Description
		--- | ---
		`name` | Name of the newly created control
		`description` | Description of the control
		`tab` | Table containing control methods and properties
		`base` | Derma control to base the new control off of
		
		
		`**Returns:** A table containing the new control's methods and properties
		
		___
		### Lua Examples
		#### Example 1
		Defines a new control based off of DTextEntry that prints to the console whenever it is changed
		
		```lua 
		local PANEL = {}
		
		function PANEL:OnChange()
		    print(self:GetValue())
		end
		
		derma.DefineControl("MyTextEntry", "Printing text entry control", PANEL, "DTextEntry")
		```
    **/
    
    public static function DefineControl(name:String, description:String, tab:AnyTable, base:String):AnyTable;
    
    
    /**
        Returns a function to draw a specified texture of panels skin.
		
		Name | Description
		--- | ---
		`name` | The identifier of the texture
		`pnl` | Panel to get the skin of.
		`fallback` | What to return if we failed to retrieve the texture
		
		
		`**Returns:** A function that is created with the GWEN library to draw a texture.
    **/
    
    public static function SkinTexture(name:String, pnl:Panel, ?fallback:Dynamic):Function;
    
    
    /**
        Returns a copy of the table containing every Derma skin
		
		`**Returns:** Table of every Derma skin
    **/
    
    public static function GetSkinTable():AnyTable;
    
    

}



#end