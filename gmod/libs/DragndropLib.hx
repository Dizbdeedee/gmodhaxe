package gmod.libs;
#if client

/**
    The drag'n'drop library, used internally by certain base panels to allow for drag'n'drop functionality, like spawnmenu's customizations.
**/
@:native("_G.dragndrop")extern class DragndropLib {
    
    /**
        ***INTERNAL** 
		
		Starts the drag'n'drop.
    **/
    @:deprecated("INTERNAL")
    public static function StartDragging():Void;
    
    
    /**
        Stops the drag'n'drop and calls dragndrop.Clear.
    **/
    
    public static function StopDragging():Void;
    
    
    /**
        ***INTERNAL** 
		
		Handles the drop action of drag'n'drop library.
    **/
    @:deprecated("INTERNAL")
    public static function Drop():Void;
    
    
    /**
        ***INTERNAL** 
		
		Updates the receiver to drop the panels onto. Called from dragndrop.Think.
    **/
    @:deprecated("INTERNAL")
    public static function UpdateReceiver():Void;
    
    
    /**
        If returns true, calls dragndrop.StopDragging in dragndrop.Drop. Seems to be broken and does nothing. Is it for override?
    **/
    
    public static function HandleDroppedInGame():Void;
    
    
    /**
        ***INTERNAL** 
		
		Calls the receiver function of hovered panel.
		
		Name | Description
		--- | ---
		`bDoDrop` | true if the mouse was released, false if we right clicked.
		`command` | The command value. This should be the ID of the clicked dropdown menu ( if right clicked, or nil )
		`mx` | The local to the panel mouse cursor X position when the click happened.
		`my` | The local to the panel mouse cursor Y position when the click happened.
    **/
    @:deprecated("INTERNAL")
    public static function CallReceiverFunction(bDoDrop:Bool, command:Float, mx:Float, my:Float):Void;
    
    
    /**
        ***INTERNAL** 
		
		Handles all the drag'n'drop processes. Calls dragndrop.UpdateReceiver and dragndrop.HoverThink.
    **/
    @:deprecated("INTERNAL")
    public static function Think():Void;
    
    
    /**
        Clears all the internal drag'n'drop variables.
    **/
    
    public static function Clear():Void;
    
    
    /**
        Returns whether the user is dragging something with the drag'n'drop system.
		
		`**Returns:** True if the user is dragging something with the drag'n'drop system.
    **/
    
    public static function IsDragging():Bool;
    
    
    /**
        ***INTERNAL** 
		
		Handles the hover think. Called from dragndrop.Think.
    **/
    @:deprecated("INTERNAL")
    public static function HoverThink():Void;
    
    
    /**
        Returns a table of currently dragged panels.
		
		Name | Description
		--- | ---
		`name` | If set, the function will return only the panels with this Panel: Droppable name.
		
		
		`**Returns:** A table of all panels that are being currently dragged, if any.
    **/
    
    public static function GetDroppable(?name:String):AnyTable;
    
    

}



#end