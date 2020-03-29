package gmod.libs;
#if client

/**
    The vgui library allows you to script and create your own panels using Valve's GUI system. For an alphabetically ordered list of VGUI panels, see VGUI Element List.
**/
@:native("_G.vgui")extern class VguiLib {
    
    /**
        Returns whenever the cursor is hovering the world panel.
		
		`**Returns:** isHoveringWorld
    **/
    
    public static function IsHoveringWorld():Bool;
    
    
    /**
        Returns whether the currently focused panel is a child of the given one.
		
		Name | Description
		--- | ---
		`parent` | The parent panel to check the currently focused one against. This doesn't need to be a direct parent (focused panel can be a child of a child and so on).
		
		
		`**Returns:** Whether or not the focused panel is a child of the passed one.
    **/
    
    public static function FocusedHasParent(parent:Panel):Bool;
    
    
    /**
        Returns the panel the cursor is hovering above.
		
		**Warning:** This returns a cached value that is only updated after rendering and before the next VGUI Think/Layout pass. ie. it lags one frame behind panel layout and is completely unhelpful for PANEL:Paint if your panels are moving around under the mouse a lot every frame.
		
		`**Returns:** The panel that the user is currently hovering over with their cursor.
    **/
    
    public static function GetHoveredPanel():Panel;
    
    
    /**
        Returns whenever the cursor is currently active and visible.
		
		`**Returns:** isCursorVisible
    **/
    
    public static function CursorVisible():Bool;
    
    
    /**
        Registers a new VGUI panel from a file.
		
		Name | Description
		--- | ---
		`file` | The file to register
		
		
		`**Returns:** A table containing info about the panel. Can be supplied to vgui. CreateFromTable
    **/
    
    public static function RegisterFile(file:String):AnyTable;
    
    
    /**
        Creates a panel by the specified classname.
		
		Name | Description
		--- | ---
		`classname` | Classname of the panel to create. Valid classnames are listed at: VGUI Element List.
		`parent` | Parent of the created panel.
		`name` | Name of the created panel.
		
		
		`**Returns:** panel
    **/
    public static function Create<T:Panel>(classname:PanelClass<T>, ?parent:Panel, ?name:String):T;
    
    
    /**
        Registers a table to use as a panel. All this function does is assigns Base key to your table and returns the table.
		
		Name | Description
		--- | ---
		`panel` | The PANEL table
		`base` | A base for the panel
		
		
		`**Returns:** The PANEL table
    **/
    
    public static function RegisterTable(panel:AnyTable, ?base:String):AnyTable;
    
    
    /**
        Returns the panel which is currently receiving keyboard input.
		
		`**Returns:** The panel with keyboard focus
    **/
    
    public static function GetKeyboardFocus():Panel;
    
    
    /**
        Creates a panel from table.
		
		Name | Description
		--- | ---
		`metatable` | Your PANEL table
		`parent` | Which panel to parent the newly created panel to
		`name` | Name of your panel
		
		
		`**Returns:** Created panel
    **/
    
    public static function CreateFromTable(metatable:AnyTable, ?parent:Panel, ?name:String):Panel;
    
    
    /**
        Registers a panel for later creation.
		
		Name | Description
		--- | ---
		`classname` | Classname of the panel to create.
		`panelTable` | The table containg the panel information.
		`baseName` | Name of the base of the panel.
		
		
		`**Returns:** panel
    **/
    
    public static function Register(classname:String, panelTable:AnyTable, baseName:String):Panel;
    
    
    /**
        Returns the global world panel which is the parent to all others. 
		
		See also GetHUDPanel.
		
		`**Returns:** The world panel
    **/
    
    public static function GetWorldPanel():Panel;
    
    
    /**
        Gets the method table of this panel. Does not return parent methods!
		
		Name | Description
		--- | ---
		`Panelname` | The name of the panel
		
		
		`**Returns:** methods
    **/
    
    public static function GetControlTable(Panelname:String):AnyTable;
    
    
    /**
        ***INTERNAL** 
		
		Creates a engine panel.
		
		Name | Description
		--- | ---
		`class` | Class of the panel to create
		`parent` | If specified, parents created panel to given one
		`name` | Name of the created panel
		
		
		`**Returns:** Created panel
    **/
    @:deprecated("INTERNAL")
    public static function CreateX(_class:String, ?parent:Panel, ?name:String):Panel;
    
    

}



#end