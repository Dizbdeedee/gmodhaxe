package gmod.panels;
#if client

/**
    A tree view element for Derma. 
	
	See also DTree_Node.
**/
extern class DTree extends DScrollPanel {
    /**
        Sets whether or not the Silkicons next to each node of the DTree will be displayed. 
		
		Individual icons can be set with DTree_Node:SetIcon or passed as the second argument in DTree:AddNode.
		
		Name | Description
		--- | ---
		`show` | Whether or not to show icons.
    **/
    
     
    function SetShowIcons(show:Bool):Void;
    /**
        Add a node to the DTree
		
		Name | Description
		--- | ---
		`name` | Name of the option.
		`icon` | The icon that will show nexto the node in the DTree.
		
		
		`**Returns:** Returns the created DTree_Node panel.
    **/
    
     
    function AddNode(name:String, ?icon:String):Panel;
    /**
        Sets the indentation size of the DTree, the distance between each "level" of the tree is offset on the left from the previous level. 
		
		Currently this feature has no effect on the DTree element.
		
		Name | Description
		--- | ---
		`size` | The new indentation size.
    **/
    
     
    function SetIndentSize(size:Float):Void;
    /**
        Returns the height of each DTree_Node in the tree.
		
		`**Returns:** The height of each DTree_Node in the tree.
    **/
    
     
    function GetLineHeight():Float;
    /**
        Returns the currently selected node.
		
		`**Returns:** Curently selected node.
    **/
    
     
    function GetSelectedItem():Panel;
    /**
        Returns the root DTree_Node, the node that is the parent to all other nodes of the DTree.
		
		`**Returns:** Root node.
    **/
    
     
    function Root():Panel;
    /**
        Returns whether or not the Silkicons next to each node of the DTree will be displayed. 
		
		Alias of DTree:GetShowIcons.
		
		`**Returns:** Whether or not the silkicons next to each node will be displayed.
    **/
    
     
    function ShowIcons():Bool;
    /**
        Called when the any node is clicked. Called by DTree_Node:DoClick.
    **/
    
    @:hook 
    function DoClick():Void;
    /**
        Returns whether or not the Silkicons next to each node of the DTree will be displayed. 
		
		Individual icons can be set with DTree_Node:SetIcon or passed as the second argument in DTree:AddNode.
		
		`**Returns:** Whether or not the silkicons next to each node will be displayed.
    **/
    
     
    function GetShowIcons():Bool;
    /**
        Returns the status of DTree:SetClickOnDragHover. See that for more info.
		
		`**Returns:** 
    **/
    
     
    function GetClickOnDragHover():Bool;
    /**
        Returns the indentation size of the DTree, the distance between each "level" of the tree is offset on the left from the previous level. 
		
		Currently this feature has no effect on the DTree element.
		
		`**Returns:** The indentation size.
    **/
    
     
    function GetIndentSize():Float;
    /**
        Enables the "click when drag-hovering" functionality. 
		
		If enabled, when hovering over any DTree_Node of this DTree while dragging a panel, the node will be automatically clicked on (and subsequently DTree:OnNodeSelected will be called) to open any attached panels, such as spawnlists in spawnmenu. 
		
		 See also: PANEL:DragHoverClick.
		
		Name | Description
		--- | ---
		`enable` | 
    **/
    
     
    function SetClickOnDragHover(enable:Bool):Void;
    /**
        ***INTERNAL** 
		
		Does nothing. Used as a placeholder empty function alongside DTree:MoveChildTo, DTree:SetExpanded and DTree:ChildExpanded. 
		
		The DTree acts a root node and methods with the same name in DTree_Node call to the parent.
		
		Name | Description
		--- | ---
		`bExpand` | 
    **/
    @:deprecated("INTERNAL")
     
    function ExpandTo(bExpand:Bool):Void;
    /**
        ***Deprecated:** 
		
		Does nothing.
    **/
    @:deprecated("")
     
    function LayoutTree():Void;
    /**
        ***INTERNAL** 
		
		Does nothing. Is not called by the DTree itself. 
		
		Used as a placeholder empty function alongside DTree:ExpandTo, DTree:MoveChildTo and DTree:ChildExpanded to prevent errors when DTree_Node:SetExpanded is incorrectly used on a DTree.
		
		Name | Description
		--- | ---
		`bExpand` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetExpanded(bExpand:Bool):Void;
    /**
        ***Deprecated:** 
		
		Moves given node to the top of DTrees children. (Makes it the topmost mode) 
		
		Used as a placeholder function alongside DTree:ExpandTo, DTree:SetExpanded and DTree:ChildExpanded. 
		
		 The DTree acts a root node and methods with the same name in DTree_Node call to the parent.
		
		Name | Description
		--- | ---
		`child` | The node to move
		`pos` | This feature is deprecated. You should avoid using it as it may be removed in a future version. Unused, does nothing. This feature is deprecated. You should avoid using it as it may be removed in a future version.
    **/
    @:deprecated("")
     
    function MoveChildTo(child:Panel, pos:Float):Void;
    /**
        Called when the any node is right clicked. Called by DTree_Node:DoRightClick.
    **/
    
    @:hook 
    function DoRightClick():Void;
    /**
        Set the currently selected top-level node.
		
		Name | Description
		--- | ---
		`node` | DTree_Node to select.
    **/
    
     
    function SetSelectedItem(node:Panel):Void;
    /**
        ***INTERNAL** 
		
		Calls directly to Panel:InvalidateLayout. Called by DTree_Nodes when a sub element has been expanded or collapsed. 
		
		Used as a placeholder function alongside DTree:ExpandTo, DTree:SetExpanded and DTree:MoveChildTo. 
		
		 The DTree acts a root node and methods with the same name in DTree_Node call to the parent.
		
		Name | Description
		--- | ---
		`bExpand` | 
    **/
    @:deprecated("INTERNAL")
     
    function ChildExpanded(bExpand:Bool):Void;
    /**
        Sets the height of each DTree_Node in the tree. 
		
		The default value is 17.
		
		Name | Description
		--- | ---
		`h` | The height to set.
    **/
    
     
    function SetLineHeight(h:Float):Void;
    /**
        This function is called when a node within a tree is selected.
		
		Name | Description
		--- | ---
		`node` | The node that was selected.
    **/
    
    @:hook 
    function OnNodeSelected(node:Panel):Void;
    
}



#end