package gmod.panels;
#if client

/**
    A standard Derma color mixer
**/
extern class DColorMixer extends DPanel {
    /**
        Returns the ConVar name for the green channel of the color. 
		
		See also:
		
		`**Returns:** The ConVar name for the green channel of the color
    **/
    
     
    function GetConVarG():String;
    /**
        Sets the ConVar name for the green channel of the color. 
		
		See also:
		
		Name | Description
		--- | ---
		`convar` | The ConVar name for the green channel of the color
    **/
    
     
    function SetConVarG(convar:String):Void;
    /**
        Show/Hide the alpha bar in DColorMixer
		
		Name | Description
		--- | ---
		`show` | Show / Hide the alpha bar
    **/
    
     
    function SetAlphaBar(show:Bool):Void;
    /**
        Sets the base color of the DColorCube part of the DColorMixer. 
		
		See also DColorCube:SetBaseRGB
		
		Name | Description
		--- | ---
		`clr` | Color structure
    **/
    
     
    function SetBaseColor(clr:Color):Void;
    /**
        Sets the label's text to show.
		
		Name | Description
		--- | ---
		`text` | Set to non empty string to show the label and its text. Give it an empty string or nothing and the label will be hidden.
    **/
    
     
    function SetLabel(?text:String):Void;
    /**
        Sets the color of DColorMixer from a Vector. Alpha is not included.
		
		Name | Description
		--- | ---
		`vec` | The color to set. It is expected that the vector will have values be from 0 to 1. (i.e. be normalized)
    **/
    
     
    function SetVector(vec:Vector):Void;
    /**
        ***INTERNAL** 
		
		Use DColorMixer:SetColor instead!
		
		Name | Description
		--- | ---
		`clr` | 
    **/
    @:deprecated("INTERNAL")
     
    function UpdateColor(clr:AnyTable):Void;
    /**
        ***INTERNAL** 
    **/
    @:deprecated("INTERNAL")
     
    function ConVarThink():Void;
    /**
        Returns the ConVar name for the alpha channel of the color. 
		
		See also:
		
		`**Returns:** The ConVar name for the alpha channel of the color
    **/
    
     
    function GetConVarA():String;
    /**
        Return true if alpha bar is shown, false if not.
		
		`**Returns:** Return true if shown, false if not.
    **/
    
     
    function GetAlphaBar():Bool;
    /**
        Called when the player changes the color of the DColorMixer.
		
		Name | Description
		--- | ---
		`col` | The new color. See Color structure
    **/
    
     
    function ValueChanged(col:Color):Void;
    /**
        Show / Hide the colors indicators in DColorMixer
		
		Name | Description
		--- | ---
		`show` | Show / Hide the colors indicators
    **/
    
     
    function SetWangs(show:Bool):Void;
    /**
        ***INTERNAL** 
		
		
		
		Name | Description
		--- | ---
		`cvar` | 
    **/
    @:deprecated("INTERNAL")
     
    function DoConVarThink(cvar:String):Void;
    /**
        ***INTERNAL** 
		
		***Deprecated:** 
		
		Does nothing.
    **/
    @:deprecated("INTERNAL")
     
    function TranslateValues():Void;
    /**
        Returns the color as a normalized Vector.
		
		`**Returns:** A vector representing the color of the DColorMixer, each value being in range of 0 to 1. Alpha is not included.
    **/
    
     
    function GetVector():Vector;
    /**
        Show or hide the palette panel
		
		Name | Description
		--- | ---
		`enabled` | Show or hide the palette panel?
    **/
    
     
    function SetPalette(enabled:Bool):Void;
    /**
        Sets the ConVar name for the blue channel of the color. 
		
		See also:
		
		Name | Description
		--- | ---
		`convar` | The ConVar name for the blue channel of the color
    **/
    
     
    function SetConVarB(convar:String):Void;
    /**
        Return true if palette is shown, false if not.
		
		`**Returns:** Return true if shown, false if not.
    **/
    
     
    function GetPalette():Bool;
    /**
        Return true if the wangs are shown, false if not.
		
		`**Returns:** Return true if shown, false if not.
    **/
    
     
    function GetWangs():Bool;
    /**
        ***INTERNAL** 
		
		
		
		Name | Description
		--- | ---
		`cvar` | The ConVar name
		`part` | The color part to set the cvar to. "r", "g", "b" or "a".
		`clr` | The Color structure
    **/
    @:deprecated("INTERNAL")
     
    function UpdateConVar(cvar:String, part:String, clr:Color):Void;
    /**
        ***INTERNAL** 
		
		
		
		Name | Description
		--- | ---
		`clr` | The Color structure
    **/
    @:deprecated("INTERNAL")
     
    function UpdateConVars(clr:Color):Void;
    /**
        Returns the ConVar name for the blue channel of the color. 
		
		See also:
		
		`**Returns:** The ConVar name for the blue channel of the color
    **/
    
     
    function GetConVarB():String;
    /**
        Sets the ConVar name for the alpha channel of the color. 
		
		See also:
		
		Name | Description
		--- | ---
		`convar` | The ConVar name for the alpha channel of the color
    **/
    
     
    function SetConVarA(convar:String):Void;
    /**
        Returns the current selected color.
		
		`**Returns:** The current selected color as a Color structure.
    **/
    
     
    function GetColor():Color;
    /**
        Returns the ConVar name for the red channel of the color. 
		
		See also:
		
		`**Returns:** The ConVar name for the red channel of the color
    **/
    
     
    function GetConVarR():String;
    /**
        Sets the ConVar name for the red channel of the color. 
		
		See also:
		
		Name | Description
		--- | ---
		`convar` | The ConVar name for the red channel of the color
    **/
    
     
    function SetConVarR(convar:String):Void;
    /**
        Sets the color of the DColorMixer
		
		Name | Description
		--- | ---
		`color` | The color to set. See Color
    **/
    
     
    function SetColor(color:AnyTable):Void;
    
}



#end