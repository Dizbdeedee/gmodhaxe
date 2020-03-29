package gmod.panels;
#if client

/**
    The DFrame control is the foundation for any Derma menu. It holds all of your controls.
**/
extern class DFrame extends EditablePanel {
    /**
        Hides or removes the DFrame, and calls DFrame:OnClose. 
		
		To set whether the frame is hidden or removed, use DFrame:SetDeleteOnClose.
    **/
    
     
    function Close():Void;
    /**
        Sets whether the frame should be draggable by the user. The DFrame can only be dragged from its title bar.
		
		Name | Description
		--- | ---
		`draggable` | Whether to be draggable or not.
    **/
    
     
    function SetDraggable(draggable:Bool):Void;
    /**
        Gets whether the background behind the frame is being blurred.
		
		`**Returns:** Whether or not background blur is enabled.
    **/
    
     
    function GetBackgroundBlur():Bool;
    /**
        Centers the frame relative to the whole screen and invalidates its layout. This overrides Panel:Center.
    **/
    
     
    function Center():Void;
    /**
        Sets the title of the frame.
		
		Name | Description
		--- | ---
		`title` | New title of the frame.
    **/
    
     
    function SetTitle(title:String):Void;
    /**
        Sets whether the frame is part of a derma menu or not. 
		
		If this is set to true, CloseDermaMenus will not be called when the frame is clicked, and thus any open menus will remain open.
		
		Name | Description
		--- | ---
		`isMenu` | Whether or not this frame is a menu component.
    **/
    
     
    function SetIsMenu(isMenu:Bool):Void;
    /**
        Adds or removes an icon on the left of the DFrame's title.
		
		Name | Description
		--- | ---
		`path` | Set to nil to remove the icon. Otherwise, set to file path to create the icon.
    **/
    
     
    function SetIcon(path:String):Void;
    /**
        Determines whether or not the DFrame will be removed when it is closed. This is set with DFrame:SetDeleteOnClose.
		
		`**Returns:** Whether or not the frame will be removed on close.
    **/
    
     
    function GetDeleteOnClose():Bool;
    /**
        Determines whether the DFrame's control box (close, minimise and maximise buttons) is displayed.
		
		Name | Description
		--- | ---
		`show` | false hides the control box; this is true by default.
    **/
    
     
    function ShowCloseButton(show:Bool):Void;
    /**
        Determines whether or not the DFrame is removed when it is closed with DFrame:Close.
		
		Name | Description
		--- | ---
		`shouldDelete` | Whether or not to delete the frame on close. This is true by default.
    **/
    
     
    function SetDeleteOnClose(shouldDelete:Bool):Void;
    /**
        Gets the minimum width the DFrame can be resized to by the user. 
		
		You must call DFrame:SetSizable before the user can resize the frame.
		
		`**Returns:** The minimum width the user can resize the frame to.
    **/
    
     
    function GetMinWidth():Float;
    /**
        Gets whether or not the frame is draggable by the user.
		
		`**Returns:** Whether the frame is draggable or not.
    **/
    
     
    function GetDraggable():Bool;
    /**
        Sets whether or not the DFrame can be resized by the user. 
		
		This is achieved by clicking and dragging in the bottom right corner of the frame.
		
		Name | Description
		--- | ---
		`sizeable` | Whether the frame should be resizeable or not.
    **/
    
     
    function SetSizable(sizeable:Bool):Void;
    /**
        Gets whether or not the DFrame can be resized by the user. 
		
		This is achieved by clicking and dragging in the bottom right corner of the frame.
		
		`**Returns:** Whether the frame can be resized or not.
    **/
    
     
    function GetSizable():Bool;
    /**
        Gets whether or not the shadow effect bordering the DFrame is being drawn.
		
		`**Returns:** Whether or not the shadow is being drawn.
    **/
    
     
    function GetPaintShadow():Bool;
    /**
        Sets the minimum width the DFrame can be resized to by the user. 
		
		This only applies to users attempting to resize the frame; Panel:SetWide and similar methods will not be affected. You must call DFrame:SetSizable before the user can resize the frame.
		
		Name | Description
		--- | ---
		`minW` | The minimum width the user can resize the frame to.
    **/
    
     
    function SetMinWidth(minW:Float):Void;
    /**
        Called when the DFrame is closed with DFrame:Close. This applies when the close button in the DFrame's control box is clicked. 
		
		This is not called when the DFrame is removed with Panel:Remove.
    **/
    
    @:hook 
    function OnClose():Void;
    /**
        Determines if the frame or one of its children has the screen focus.
		
		`**Returns:** Whether or not the frame has focus.
    **/
    
     
    function IsActive():Bool;
    /**
        Sets whether the DFrame is restricted to the boundaries of the screen resolution.
		
		Name | Description
		--- | ---
		`lock` | If true, the frame cannot be dragged outside of the screen bounds
    **/
    
     
    function SetScreenLock(lock:Bool):Void;
    /**
        Sets whether or not the shadow effect bordering the DFrame should be drawn.
		
		Name | Description
		--- | ---
		`shouldPaint` | Whether or not to draw the shadow. This is true by default.
    **/
    
     
    function SetPaintShadow(shouldPaint:Bool):Void;
    /**
        Returns the title of the frame.
		
		`**Returns:** Title of the frame.
    **/
    
     
    function GetTitle():String;
    /**
        Blurs background behind the frame.
		
		Name | Description
		--- | ---
		`blur` | Whether or not to create background blur or not.
    **/
    
     
    function SetBackgroundBlur(blur:Bool):Void;
    /**
        Sets the minimum height the DFrame can be resized to by the user. 
		
		This only applies to users attempting to resize the frame; Panel:SetTall and similar methods will not be affected. You must call DFrame:SetSizable before the user can resize the frame.
		
		Name | Description
		--- | ---
		`minH` | The minimum height the user can resize the frame to.
    **/
    
     
    function SetMinHeight(minH:Float):Void;
    /**
        Gets whether or not the DFrame is restricted to the boundaries of the screen resolution.
		
		`**Returns:** Whether or not the frame is restricted.
    **/
    
     
    function GetScreenLock():Bool;
    /**
        Gets the minimum height the DFrame can be resized to by the user. 
		
		You must call DFrame:SetSizable before the user can resize the frame.
		
		`**Returns:** The minimum height the user can resize the frame to.
    **/
    
     
    function GetMinHeight():Float;
    /**
        Gets whether or not the frame is part of a derma menu. This is set with DFrame:SetIsMenu.
		
		`**Returns:** Whether or not this frame is a menu component.
    **/
    
     
    function GetIsMenu():Bool;
    
}



#end