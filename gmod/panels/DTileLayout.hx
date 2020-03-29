package gmod.panels;
#if client

/**
    Similarly to DIconLayout, this lays out panels in two dimensions as tiles. The difference between this and DIconLayout is that DIconLayout items all have the same height while DTileLayout items do not have this enforcement. DTileLayout will find the best way to "pack" its chidren. For example, in a two column layout, a item of height 2 units will be placed in one column while two items of height 1 unit will be placed in the other column. It is worth noting however that because this panel iterates through its children in an undefined order and lays out while it is iterating, there is no guarentee that this packing will lead to the lowest possible height. 
	
	This is used by the spawnmenu to arrange spawnicons. 
	
	 The base size defines the smallest a tile can be, and it will resize vertically to accommodate all child panels. The number of elements in each row is determinded by the base size and width. 
	
	 It also optionally permits the rearrangement of these tiles. To enable this functionality, call DDragBase:MakeDroppable on the DTileLayout with a unique identifier. All panels added following this will be moveable.
**/
extern class DTileLayout extends DDragBase {
    /**
        ***INTERNAL** 
		
		Determines if a group of tiles is vacant.
		
		Name | Description
		--- | ---
		`x` | The x coordinate of the first tile.
		`y` | The y coordinate of the first tile.
		`w` | The width needed.
		`h` | The height needed.
		
		
		`**Returns:** Whether or not this group is available for occupation.
    **/
    @:deprecated("INTERNAL")
     
    function FitsInTile(x:Float, y:Float, w:Float, h:Float):Bool;
    /**
        Sets the spacing between 2 elements in the DTileLayout on the X axis.
		
		Name | Description
		--- | ---
		`spacingX` | 
    **/
    
     
    function SetSpaceX(spacingX:Float):Void;
    /**
        Returns the border spacing set by DTileLayout:SetBorder.
		
		`**Returns:** 
    **/
    
     
    function GetBorder():Float;
    /**
        ***INTERNAL** 
		
		Called by [PANEL](https://wiki.garrysmod.com/page/Category:PANEL_Hooks): [PerformLayout](https://wiki.garrysmod.com/page/PANEL/PerformLayout) to arrange and lay out the child panels, if it has changed in size.
    **/
    @:deprecated("INTERNAL")
     
    function LayoutTiles():Void;
    /**
        Called when anything is dropped on or rearranged within the DTileLayout.
    **/
    
    @:hook 
    function OnModified():Void;
    /**
        ***INTERNAL** 
		
		Gets the occupied state of a tile.
		
		Name | Description
		--- | ---
		`x` | The x coordinate of the tile.
		`y` | The y coordinate of the tile.
		
		
		`**Returns:** The occupied state of the tile, normally 1 or nil.
    **/
    @:deprecated("INTERNAL")
     
    function GetTile(x:Float, y:Float):Dynamic;
    /**
        Sets the spacing between the border/edge of the DTileLayout and all the elements inside.
		
		Name | Description
		--- | ---
		`border` | 
    **/
    
     
    function SetBorder(border:Float):Void;
    /**
        Returns the X axis spacing between 2 elements set by DTileLayout:SetSpaceX.
		
		`**Returns:** 
    **/
    
     
    function GetSpaceX():Float;
    /**
        ***INTERNAL** 
		
		Finds the coordinates of the first group of free tiles that fit the given size.
		
		Name | Description
		--- | ---
		`x` | The x coordinate to start looking from.
		`y` | The y coordinate to start looking from.
		`w` | The needed width.
		`h` | The needed height.
		
		
		Name | Description
		--- | ---
		`a` | The x coordinate of the found available space.
		`b` | The y coordinate of the found available space.
    **/
    @:deprecated("INTERNAL")
     
    function FindFreeTile(x:Float, y:Float, w:Float, h:Float):DTileLayoutFindFreeTileReturn;
    /**
        Returns the size of each single tile, set with DTileLayout:SetBaseSize.
		
		`**Returns:** Base tile size.
    **/
    
     
    function GetBaseSize():Float;
    /**
        ***INTERNAL** 
		
		Called to designate a range of tiles as occupied by a panel.
		
		Name | Description
		--- | ---
		`x` | The x coordinate of the top-left corner of the panel.
		`y` | The y coordinate of the top-left corner of the panel.
		`w` | The panel's width.
		`h` | The panel's height.
    **/
    @:deprecated("INTERNAL")
     
    function ConsumeTiles(x:Float, y:Float, w:Float, h:Float):Void;
    /**
        ***INTERNAL** 
		
		Clears the panel's tile table. Used by [DTileLayout](https://wiki.garrysmod.com/page/Category:DTileLayout): [LayoutTiles](https://wiki.garrysmod.com/page/DTileLayout/LayoutTiles).
    **/
    @:deprecated("INTERNAL")
     
    function ClearTiles():Void;
    /**
        Creates copies of all the children from the given panel object and parents them to this one.
		
		Name | Description
		--- | ---
		`source` | The source panel from which to copy all children.
    **/
    
     
    function CopyContents(source:Panel):Void;
    /**
        ***INTERNAL** 
		
		Called to set the occupied state of a tile.
		
		Name | Description
		--- | ---
		`x` | The x coordinate of the tile.
		`y` | The y coordinate of the tile.
		`state` | The new state of the tile, normally 1 or nil.
    **/
    @:deprecated("INTERNAL")
     
    function SetTile(x:Float, y:Float, state:Dynamic):Void;
    /**
        Sets the spacing between 2 elements in the DTileLayout on the Y axis.
		
		Name | Description
		--- | ---
		`spaceY` | 
    **/
    
     
    function SetSpaceY(spaceY:Float):Void;
    /**
        Creates and returns an exact copy of the DTileLayout.
		
		`**Returns:** The created copy.
    **/
    
     
    function Copy():Panel;
    /**
        Determines the minimum height the DTileLayout will resize to. This is useful if child panels will be added/removed often.
		
		Name | Description
		--- | ---
		`minH` | The minimum height the panel can shrink to.
    **/
    
     
    function SetMinHeight(minH:Float):Void;
    /**
        Returns the Y axis spacing between 2 elements set by DTileLayout:SetSpaceY.
		
		`**Returns:** 
    **/
    
     
    function GetSpaceY():Float;
    /**
        Returns the minimum height the DTileLayout can resize to.
		
		`**Returns:** The minimum height the panel can shrink to.
    **/
    
     
    function GetMinHeight():Float;
    /**
        Resets the last width/height info, and invalidates the panel's layout, causing it to recalculate all child positions. It is called whenever a child is added or removed, and can be called to refresh the panel.
    **/
    
     
    function Layout():Void;
    /**
        Sets the size of a single tile. If a child panel is larger than this size, it will occupy several tiles. 
		
		If you are setting the size of the children properly then you probably don't need to change this.
		
		Name | Description
		--- | ---
		`size` | The size of each tile. It is recommended you use 2 n ( 16, 32, 64...) numbers, and those above 4, as numbers lower than this will result in many tiles being processed and therefore slow operation.
    **/
    
     
    function SetBaseSize(size:Float):Void;
    
}


@:multiReturn extern class DTileLayoutFindFreeTileReturn {
var a:Float;
var b:Float;

}

#end