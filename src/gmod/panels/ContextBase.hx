package gmod.panels;
#if client
import gmod.gclass.Panel;
/**
    A base for all context menu panels ( The ones used for tool options in sandbox )
**/
extern class ContextBase extends Panel {
    /**
        Called by spawnmenu functions (when creating a context menu) to fill this control with data.
		
		Name | Description
		--- | ---
		`contextData` | A two-membered table: string convar - The console variable to use. Calls ContextBase:SetConVar. string label - The text to display inside the control's label.
    **/
    
     
    function ControlValues(contextData:AnyTable):Void;
    /**
        Returns the ConVar for the panel to change/handle, set by ContextBase:SetConVar
		
		`**Returns:** The ConVar for the panel to change.
    **/
    
     
    function ConVar():String;
    /**
        Sets the ConVar for the panel to change/handle.
		
		Name | Description
		--- | ---
		`cvar` | The ConVar for the panel to change.
    **/
    
     
    function SetConVar(cvar:String):Void;
    /**
        You should override this function and use it to check whether your convar value changed.
    **/
    
     
    function TestForChanges():Void;
    
}



#end