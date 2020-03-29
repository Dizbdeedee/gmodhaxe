package gmod.gclass;


/**
    An object returned by GetConVar. It represents a console variable. See this page for more information.
**/
extern class ConVar {
    
    /**
        Sets a ConVar's value to 1 or 0 based on the input boolean. This can only be ran on ConVars created from within Lua.
		
		Name | Description
		--- | ---
		`value` | Value to set the ConVar to.
    **/
    
    public function SetBool(value:Bool):Void;
    
    
    /**
        Returns the help text assigned to that convar.
		
		`**Returns:** The help text
    **/
    
    public function GetHelpText():String;
    
    
    /**
        Returns the name of the ConVar.
		
		`**Returns:** The name of the console variable.
    **/
    
    public function GetName():String;
    
    
    /**
        Attempts to convert the ConVar value to a float
		
		`**Returns:** The float value of the console variable. If the value cannot be converted to a float, it will return 0.
    **/
    
    public function GetFloat():Float;
    
    
    /**
        Attempts to convert the ConVar value to a integer.
		
		`**Returns:** The integer value of the console variable. If it fails to convert to an integer, it will return 0. All float/decimal values will be rounded down. ( With math. floor )
    **/
    
    public function GetInt():Float;
    
    
    /**
        Sets a ConVar's value to to the input number. This can only be ran on ConVars created from within Lua.
		
		Name | Description
		--- | ---
		`value` | Value to set the ConVar to.
    **/
    
    public function SetFloat(value:Float):Void;
    
    
    /**
        Returns the current ConVar value as a string.
		
		`**Returns:** The current console variable value as a string.
		
		___
		### Lua Examples
		#### Example 1
		Will check if the gamemode is sandbox
		
		```lua 
		if GetConVar("gamemode"):GetString() == "sandbox" then
		    print("Gamemode is sandbox")
		end
		```
		**Output:**
		
		Gamemode is sandbox
    **/
    
    public function GetString():String;
    
    
    /**
        Sets a ConVar's value to the input number after converting it to an integer. This can only be ran on ConVars created from within Lua.
		
		Name | Description
		--- | ---
		`value` | Value to set the ConVar to.
    **/
    
    public function SetInt(value:Float):Void;
    
    
    /**
        Sets a ConVar's value to the input string. This can only be ran on ConVars created from within Lua.
		
		Name | Description
		--- | ---
		`value` | Value to set the ConVar to.
    **/
    
    public function SetString(value:String):Void;
    
    
    /**
        Tries to convert the current string value of a ConVar to a boolean.
		
		`**Returns:** The boolean value of the console variable. If the variable is numeric and not 0, the result will be true. Otherwise the result will be false.
    **/
    
    public function GetBool():Bool;
    
    
    /**
        Returns the default value of the ConVar
		
		`**Returns:** The default value of the console variable.
    **/
    
    public function GetDefault():String;
    
    
}



