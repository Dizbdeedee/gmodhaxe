package gmod.panels;
#if client

/**
    This panel is created whenever you add a node to a DTree. 
	
	The root node of a DTree is also a DTree_Node and controls much of its action; it can be accessed with DTree:Root.
**/
extern class DTree_Node extends DPanel {
    /**
        ***INTERNAL** 
		
		Returns whether or not the node is set to be populated from the filesystem.
		
		`**Returns:** 
    **/
    @:deprecated("INTERNAL")
     
    function GetNeedsPopulating():Bool;
    /**
        Returns the folder path to search in, set by DTree_Node:MakeFolder.
		
		`**Returns:** The folder path.
    **/
    
     
    function GetFolder():String;
    /**
        ***INTERNAL** 
		
		Called automatically from DTree_Node:PopulateChildrenAndSelf.
    **/
    @:deprecated("INTERNAL")
     
    function PopulateChildren():Void;
    /**
        Returns whether the expand button (little + button) should be shown or hidden.
		
		`**Returns:** 
    **/
    
     
    function GetHideExpander():Bool;
    /**
        Returns the root node, the DTree this node is under. 
		
		See also DTree_Node:GetParentNode.
		
		`**Returns:** The root node
    **/
    
     
    function GetRoot():Panel;
    /**
        Inserts a sub-node into this node before or after the given node.
		
		Name | Description
		--- | ---
		`node` | The DTree_Node to insert.
		`nodeNextTo` | The node to insert the node above before or after.
		`before` | true to insert before, false to insert after.
    **/
    
     
    function Insert(node:Panel, nodeNextTo:Panel, before:Bool):Void;
    /**
        ***INTERNAL** 
		
		See DTree_Node:DoClick
    **/
    @:deprecated("INTERNAL")
     
    function InternalDoClick():Void;
    /**
        ***INTERNAL** 
		
		See DTree_Node:DoRightClick.
    **/
    @:deprecated("INTERNAL")
     
    function InternalDoRightClick():Void;
    /**
        Add a child node to the DTree_Node
		
		Name | Description
		--- | ---
		`name` | Name of the node.
		`icon` | The icon that will show nexto the node in the DTree.
		
		
		`**Returns:** Returns the created DTree_Node panel.
    **/
    
     
    function AddNode(name:String, ?icon:String):Panel;
    /**
        ***INTERNAL** 
		
		
		
		`**Returns:** 
    **/
    @:deprecated("INTERNAL")
     
    function GetNeedsChildSearch():Bool;
    /**
        ***INTERNAL** 
		
		Called automatically to update the status of DTree_Node:GetLastChild on children of this node.
    **/
    @:deprecated("INTERNAL")
     
    function DoChildrenOrder():Void;
    /**
        Makes this node a folder in the filesystem. This will make it automatically populated. 
		
		See also DTree_Node:AddFolder.
		
		Name | Description
		--- | ---
		`folder` | The folder in the filesystem to use, relative to the garrysmod/ folder.
		`path` | The path to search in. See File Search Paths
		`showFiles` | Should files be added as nodes (true) or folders only (false)
		`wildcard` | The wildcard to use when searching for files.
		`dontForceExpandable` | If set to true, don't show the expand buttons on empty nodes.
    **/
    
     
    function MakeFolder(folder:String, path:String, ?showFiles:Bool, ?wildcard:String, ?dontForceExpandable:Bool):Void;
    /**
        Returns the wildcard set by DTree_Node:MakeFolder.
		
		`**Returns:** The search wildcard
    **/
    
     
    function GetWildCard():String;
    /**
        The height of a single DTree_Node of the DTree this node belongs to. 
		
		Alias of DTree:GetLineHeight.
		
		`**Returns:** The height of a single DTree_Node.
    **/
    
     
    function GetLineHeight():Float;
    /**
        Sets the material for the icon of the DTree_Node.
		
		Name | Description
		--- | ---
		`path` | The path to the material to be used. Do not include "materials/". .pngs are supported.
    **/
    
     
    function SetIcon(path:String):Void;
    /**
        ***INTERNAL** 
		
		Used to store name for sub elements for a Panel:Droppable call.
		
		Name | Description
		--- | ---
		`name` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetDraggableName(name:String):Void;
    /**
        ***INTERNAL** 
		
		Called automatically to perform layout on this node if this node DTree_Node:IsRootNode.
    **/
    @:deprecated("INTERNAL")
     
    function PerformRootNodeLayout():Void;
    /**
        Removes given node as a sub-node of this node. 
		
		It doesn't actually remove or unparent the panel, just removes it from the internal DListView.
		
		Name | Description
		--- | ---
		`pnl` | The node to remove
    **/
    
     
    function LeaveTree(pnl:Panel):Void;
    /**
        Returns the parent DTree_Node. Note that Panel:GetParent will not be the same!
		
		`**Returns:** The parent node.
    **/
    
     
    function GetParentNode():Panel;
    /**
        Returns the path ID (File Search Paths) used in populating the DTree from the filesystem. 
		
		See DTree_Node:SetPathID and DTree_Node:MakeFolder.
		
		`**Returns:** The Path ID
    **/
    
     
    function GetPathID():String;
    /**
        Returns whether or not the DTree this node is in has icons enabled. 
		
		See DTree:ShowIcons for more info.
		
		`**Returns:** Whether the icons are shown or not
    **/
    
     
    function ShowIcons():Float;
    /**
        ***INTERNAL** 
		
		Inserts an existing node as a "child" or a sub-node of this node. Used internally by the drag'n'drop functionality.
		
		Name | Description
		--- | ---
		`node` | Has to be DTree_Node
    **/
    @:deprecated("INTERNAL")
     
    function InsertNode(node:Panel):Void;
    /**
        ***INTERNAL** 
		
		Called automatically from DTree_Node:PopulateChildrenAndSelf and DTree_Node:PopulateChildren to populate this node with child nodes of files and folders.
		
		Name | Description
		--- | ---
		`bAndChildren` | Does nothing. Set to true if called from DTree_Node: PopulateChildren.
		`bExpand` | Expand self once population process is finished.
    **/
    @:deprecated("INTERNAL")
     
    function FilePopulate(bAndChildren:Bool, bExpand:Bool):Void;
    /**
        Called when the node is clicked. 
		
		See also DTree_Node:DoRightClick.
		
		`**Returns:** Return true to prevent DoClick from being called on parent nodes or the DTree itself.
    **/
    
    @:hook 
    function DoClick():Bool;
    /**
        Called when sub-nodes of this DTree_Node were changed, such as being rearranged if that functionality is enabled.
    **/
    
    @:hook 
    function OnModified():Void;
    /**
        ***INTERNAL** 
		
		Creates the container DListLayout for the DTree_Nodes. 
		
		This is called automatically so you don't have to.
    **/
    @:deprecated("INTERNAL")
     
    function CreateChildNodes():Void;
    /**
        Returns the indentation level of the DTree this node belongs to. 
		
		Alias of DTree:GetIndentSize, see it for more info.
		
		`**Returns:** The indentation level.
    **/
    
     
    function GetIndentSize():Float;
    /**
        ***INTERNAL** 
		
		Sets whether or not this node should draw visual lines.
		
		Name | Description
		--- | ---
		`draw` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetDrawLines(draw:Bool):Void;
    /**
        ***INTERNAL** 
		
		
		
		Name | Description
		--- | ---
		`newState` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetNeedsChildSearch(newState:Bool):Void;
    /**
        Collapses or expands all nodes from the topmost-level node to this one. 
		
		Works opposite of DTree_Node:ExpandRecurse.
		
		Name | Description
		--- | ---
		`expand` | Whether to expand (true) or collapse (false)
    **/
    
     
    function ExpandTo(expand:Bool):Void;
    /**
        ***INTERNAL** 
		
		Sets the search wildcard. 
		
		Use DTree_Node:MakeFolder instead
		
		Name | Description
		--- | ---
		`wildcard` | The wildcard to set
    **/
    @:deprecated("INTERNAL")
     
    function SetWildCard(wildcard:String):Void;
    /**
        Returns whether or not nodes for files should/will be added when populating the node from filesystem.
		
		`**Returns:** 
    **/
    
     
    function GetShowFiles():Bool;
    /**
        ***INTERNAL** 
		
		Sets the parent node of this node. Not the same as Panel:SetParent. 
		
		This is set automatically, you shouldn't use this.
		
		Name | Description
		--- | ---
		`parent` | The panel to set as a parent node for this node
    **/
    @:deprecated("INTERNAL")
     
    function SetParentNode(parent:Panel):Void;
    /**
        ***INTERNAL** 
		
		Sets the folder to search files and folders in. 
		
		Use DTree_Node:MakeFolder instead.
		
		Name | Description
		--- | ---
		`folder` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetFolder(folder:String):Void;
    /**
        ***INTERNAL** 
		
		Called automatically from DTree_Node:SetExpanded (or when user manually expands the node) to populate the node with sub-nodes from the filesystem if this was enabled via DTree_Node:MakeFolder.
		
		Name | Description
		--- | ---
		`expand` | Expand self once population process is finished.
    **/
    @:deprecated("INTERNAL")
     
    function PopulateChildrenAndSelf(expand:Bool):Void;
    /**
        Sets whether double clicking the node should expand/collapse it or not.
		
		Name | Description
		--- | ---
		`enable` | true to enable, false to disable this functionality.
    **/
    
     
    function SetDoubleClickToOpen(enable:Bool):Void;
    /**
        ***INTERNAL** 
		
		Sets the path ID (File Search Paths) for populating the tree from the filesystem. 
		
		Use DTree_Node:MakeFolder instead.
		
		Name | Description
		--- | ---
		`path` | The path ID to set.
    **/
    @:deprecated("INTERNAL")
     
    function SetPathID(path:String):Void;
    /**
        ***INTERNAL** 
		
		Called automatically from DTree_Node:FilePopulate to actually fill the node with sub-nodes based on set preferences like should files be added, etc.
		
		Name | Description
		--- | ---
		`files` | A list of files in this folder
		`folders` | A list of folder in this folder.
		`foldername` | The folder name/path this node represents
		`path` | The Path ID search was performed with. See File Search Paths
		`bAndChildren` | Inherited from the FilePopulate call. Does nothing
		`wildcard` | The wildcard that was given
    **/
    @:deprecated("INTERNAL")
     
    function FilePopulateCallback(files:AnyTable, folders:AnyTable, foldername:String, path:String, bAndChildren:Bool, wildcard:String):Void;
    /**
        ***INTERNAL** 
		
		Called automatically internally. 
		
		Makes the target node compatible with this node's drag'n'drop.
		
		Name | Description
		--- | ---
		`node` | The DTree_Node.
    **/
    @:deprecated("INTERNAL")
     
    function InstallDraggable(node:Panel):Void;
    /**
        ***Deprecated:** 
		
		Currently does nothing, not implemented.
    **/
    @:deprecated("")
     
    function SetupCopy():Void;
    /**
        ***INTERNAL** 
		
		Sets whether the expand button (little + button) should be shown or hidden.
		
		Name | Description
		--- | ---
		`hide` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetHideExpander(hide:Bool):Void;
    /**
        ***INTERNAL** 
		
		Returns what is set by DTree_Node:SetDraggableName.
		
		`**Returns:** 
    **/
    @:deprecated("INTERNAL")
     
    function GetDraggableName():String;
    /**
        ***INTERNAL** 
		
		Called automatically to set whether this node is the last child on this level or not.
		
		Name | Description
		--- | ---
		`last` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetLastChild(last:Bool):Void;
    /**
        Expands or collapses this node.
		
		Name | Description
		--- | ---
		`expand` | Whether to expand (true) or collapse (false)
		`surpressAnimation` | Whether to play animation (false) or not (true)
    **/
    
     
    function SetExpanded(expand:Bool, ?surpressAnimation:Bool):Void;
    /**
        ***INTERNAL** 
		
		Sets whether or not nodes for files should be added when populating the node from filesystem.
		
		Name | Description
		--- | ---
		`showFiles` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetShowFiles(showFiles:Bool):Void;
    /**
        Moves given panel to the top of the children of this node. 
		
		Despite name of this function, it cannot move the children to any position but the topmost.
		
		Name | Description
		--- | ---
		`node` | The node to move.
    **/
    
     
    function MoveChildTo(node:Panel):Void;
    /**
        ***INTERNAL** 
		
		Adds the given panel to the child nodes list, a DListLayout.
		
		Name | Description
		--- | ---
		`pnl` | The panel to add.
    **/
    @:deprecated("INTERNAL")
     
    function AddPanel(pnl:Panel):Void;
    /**
        Returns whether the double clock to collapse/expand functionality is enabled on this node.
		
		`**Returns:** 
    **/
    
     
    function GetDoubleClickToOpen():Bool;
    /**
        Returns whether the expand/collapse button is shown on this node regardless of whether or not it has sub-nodes. 
		
		See also DTree_Node:SetForceShowExpander.
		
		`**Returns:** 
    **/
    
     
    function GetForceShowExpander():Bool;
    /**
        Called when the node is right clicked. 
		
		See also DTree_Node:DoClick.
		
		`**Returns:** Return true to prevent DoRightClick from being called on parent nodes or the DTree itself.
    **/
    
    @:hook 
    function DoRightClick():Bool;
    /**
        Sets the text value of a panel object containing text, such as a Label, TextEntry or RichText and their derivatives, such as DLabel, DTextEntry or DButton.
		
		**Warning:** When used on a Label or its derivatives ( DLabel and DButton ), it will automatically call Panel:InvalidateLayout, meaning that you should avoid running this function every frame on these panels to avoid unnecessary performance loss.
		
		Name | Description
		--- | ---
		`text` | The text value to set.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a RichText element and sets the text to a localized string; the default VAC rejection message.
		
		```lua 
		-- Window frame for the RichText
		TextFrame = vgui.Create("DFrame")
		TextFrame:SetSize(250, 150)
		TextFrame:Center()
		TextFrame:SetTitle("#VAC_ConnectionRefusedTitle") -- Results in "Connection Refused - VAC"
		
		-- RichText panel
		local richtext = vgui.Create("RichText", TextFrame)
		richtext:Dock(FILL)
		
		-- Set the text to the message you get when VAC banned
		richtext:SetText("#VAC_ConnectionRefusedDetail")
		```
    **/
    
     
    function SetText(text:String):Void;
    /**
        ***INTERNAL** 
		
		Called when a child node is expanded or collapsed to propagate this event to parent nodes to update layout.
		
		Name | Description
		--- | ---
		`expanded` | 
    **/
    @:deprecated("INTERNAL")
     
    function ChildExpanded(expanded:Bool):Void;
    /**
        Create and returns a copy of this node, including all the sub-nodes.
		
		`**Returns:** The copied DTree_Node.
    **/
    
     
    function Copy():Panel;
    /**
        Sets whether or not the expand/collapse button (+/- button) should be shown on this node regardless of whether it has sub-elements or not.
		
		Name | Description
		--- | ---
		`forceShow` | 
    **/
    
     
    function SetForceShowExpander(forceShow:Bool):Void;
    /**
        Returns whether this node is the last child on this level or not.
		
		`**Returns:** 
    **/
    
     
    function GetLastChild():Bool;
    /**
        Cleans up the internal table of items (sub-nodes) of this node from invalid panels or sub-nodes that were moved from this node to another. 
		
		Appears the be completely unused by the game on its own.
    **/
    
     
    function CleanList():Void;
    /**
        Returns n-th child node. 
		
		Basically an alias of Panel:GetChild.
		
		Name | Description
		--- | ---
		`num` | The number of the child to get, starting with 0
		
		
		`**Returns:** The child panel, if valid ID is given
    **/
    
     
    function GetChildNode(num:Float):Panel;
    /**
        ***INTERNAL** 
		
		Sets the root node (the DTree) of this node. 
		
		This is set automatically, you shouldn't use this.
		
		Name | Description
		--- | ---
		`root` | The panel to set as root node.
    **/
    @:deprecated("INTERNAL")
     
    function SetRoot(root:Panel):Void;
    /**
        Returns the filepath of the file attached to this node.
		
		`**Returns:** 
    **/
    
     
    function GetFileName():String;
    /**
        ***INTERNAL** 
		
		Returns whether or not this node is drawing lines
		
		`**Returns:** 
    **/
    @:deprecated("INTERNAL")
     
    function GetDrawLines():Bool;
    /**
        ***INTERNAL** 
		
		Called automatically to update the "selected" status of this node.
		
		Name | Description
		--- | ---
		`selected` | Whether this node is currently selected or not.
    **/
    @:deprecated("INTERNAL")
     
    function SetSelected(selected:Bool):Void;
    /**
        ***Deprecated:** 
		
		Returns value set by DTree_Node:SetDirty.
		
		`**Returns:** 
    **/
    @:deprecated("")
     
    function GetDirty():Bool;
    /**
        ***INTERNAL** 
		
		Sets whether or not the node needs populating from the filesystem.
		
		Name | Description
		--- | ---
		`needs` | Whether or not the node needs populating
    **/
    @:deprecated("INTERNAL")
     
    function SetNeedsPopulating(needs:Bool):Void;
    /**
        A helper function that adds a new node and calls to DTree_Node:MakeFolder on it.
		
		Name | Description
		--- | ---
		`name` | The name of the new node
		`folder` | The folder in the filesystem to use, relative to the garrysmod/ folder.
		`path` | The path to search in. See File Search Paths
		`showFiles` | Should files be added as nodes (true) or folders only (false)
		`wildcard` | The wildcard to use when searching for files.
		`bDontForceExpandable` | 
    **/
    
     
    function AddFolder(name:String, folder:String, path:String, ?showFiles:Bool, ?wildcard:String, ?bDontForceExpandable:Bool):Void;
    /**
        ***INTERNAL** 
		
		Internal function that handles the expand/collapse animations.
		
		Name | Description
		--- | ---
		`anim` | 
		`delta` | 
		`data` | 
    **/
    @:deprecated("INTERNAL")
     
    function AnimSlide(anim:AnyTable, delta:Float, data:AnyTable):Void;
    /**
        Expands or collapses this node, as well as ALL child nodes of this node. 
		
		Works opposite of DTree_Node:ExpandTo.
		
		Name | Description
		--- | ---
		`expand` | Whether to expand (true) or collapse (false)
    **/
    
     
    function ExpandRecurse(expand:Bool):Void;
    /**
        ***INTERNAL** 
		
		Called when this or a sub node is selected. Do not use this, it is not for override. 
		
		Use DTree:OnNodeSelected or DTree_Node:DoClick instead.
		
		Name | Description
		--- | ---
		`node` | 
    **/
    @:deprecated("INTERNAL")
     
    function OnNodeSelected(node:Panel):Void;
    /**
        ***INTERNAL** 
		
		Sets the file full filepath to the file attached to this node
		
		Name | Description
		--- | ---
		`filename` | 
    **/
    @:deprecated("INTERNAL")
     
    function SetFileName(filename:String):Void;
    /**
        Returns true if DTree_Node:GetRoot is the same as DTree_Node:GetParentNode of this node.
		
		`**Returns:** If this is a root node.
    **/
    
     
    function IsRootNode():Bool;
    /**
        Returns the image path to the icon of this node.
		
		`**Returns:** The path to the image
    **/
    
     
    function GetIcon():String;
    /**
        Moves this node to the top of the level.
    **/
    
     
    function MoveToTop():Void;
    /**
        ***Deprecated:** 
		
		Appears to have no effect on the DTree_Node.
		
		Name | Description
		--- | ---
		`dirty` | 
    **/
    @:deprecated("")
     
    function SetDirty(dirty:Bool):Void;
    
}



#end