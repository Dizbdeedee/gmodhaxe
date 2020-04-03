package gmod.panels;
#if client

/**
    ***Deprecated:**   This is derived from the deprecated DPanelList.
	
	A vertical list of models.  Inherits the following functions from DPanelSelect and its parents up to 3 levels deep:
**/
extern class DModelSelect extends DPanelSelect {
    /**
        Called to set the list of models within the panel element.
		
		Name | Description
		--- | ---
		`models` | Each key is a model path, the value is a kay-value table where they key is a convar name and value is the value to set to that convar.
		`convar` | 
		`dontSort` | 
		`DontCallListConVars` | 
    **/
    
     
    function SetModelList(models:AnyTable, convar:String, dontSort:Bool, DontCallListConVars:Bool):Void;
    /**
        Sets the height of the panel in the amount of 64px spawnicons. 
		
		Overrides Panel:SetHeight.
		
		Name | Description
		--- | ---
		`num` | Basically how many rows of 64x64 px spawnicons should fit in this DModelSelect
    **/
    
     
    function SetHeight(?num:Float):Void;
    
}



#end