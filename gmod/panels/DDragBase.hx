package gmod.panels;
#if client

/**
    A VGUI base panel providing drag/drop functionality. Used by DIconLayout, DListLayout and DTileLayout.
**/
extern class DDragBase extends DPanel {
    /**
        
		
		Name | Description
		--- | ---
		`newState` | 
    **/
    
     
    function SetUseLiveDrag(newState:Bool):Void;
    /**
        
		
		`**Returns:** 
    **/
    
     
    function GetUseLiveDrag():Bool;
    /**
        
		
		Name | Description
		--- | ---
		`name` | Name of the DnD family.
    **/
    
     
    function SetDnD(name:String):Void;
    /**
        ***INTERNAL** 
		
		Internal function used in DDragBase:DropAction_Normal
		
		Name | Description
		--- | ---
		`drops` | 
		`bDoDrop` | 
		`command` | 
		`y` | 
		`x` | 
    **/
    @:deprecated("INTERNAL")
     
    function DropAction_Simple(drops:AnyTable, bDoDrop:Bool, command:String, y:Float, x:Float):Void;
    /**
        
		
		`**Returns:** Name of the DnD family.
    **/
    
     
    function GetDnD():String;
    /**
        ***INTERNAL** 
		
		Internal function used in DDragBase:MakeDroppable
		
		Name | Description
		--- | ---
		`drops` | 
		`bDoDrop` | 
		`command` | 
		`y` | 
		`x` | 
    **/
    @:deprecated("INTERNAL")
     
    function DropAction_Copy(drops:AnyTable, bDoDrop:Bool, command:String, y:Float, x:Float):Void;
    /**
        Called when anything is dropped on or rearranged within the DDragBase.
    **/
    
    @:hook 
    function OnModified():Void;
    /**
        ***INTERNAL** 
		
		Internal function used in DDragBase:DropAction_Normal
		
		Name | Description
		--- | ---
		`drop` | 
		`pnl` | 
    **/
    @:deprecated("INTERNAL")
     
    function UpdateDropTarget(drop:Float, pnl:Panel):Void;
    /**
        Determines where you can drop stuff. "4" for left "5" for center "6" for right "8" for top "2" for bottom
		
		Name | Description
		--- | ---
		`pos` | Where you're allowed to drop things.
    **/
    
     
    function SetDropPos(?pos:String):Void;
    /**
        Makes the panel a receiver for any droppable panel with the same DnD name. Internally calls Panel:Receiver.
		
		Name | Description
		--- | ---
		`name` | The unique name for the receiver slot. Only droppable panels with the same DnD name as this can be dropped on the panel.
		`allowCopy` | Whether or not to allow droppable panels to be copied when the Ctrl key is held down.
    **/
    
     
    function MakeDroppable(name:String, allowCopy:Bool):Void;
    /**
        ***INTERNAL** 
		
		Internal function used in DDragBase:DropAction_Copy
		
		Name | Description
		--- | ---
		`drops` | 
		`bDoDrop` | 
		`command` | 
		`y` | 
		`x` | 
    **/
    @:deprecated("INTERNAL")
     
    function DropAction_Normal(drops:AnyTable, bDoDrop:Bool, command:String, y:Float, x:Float):Void;
    
}



#end