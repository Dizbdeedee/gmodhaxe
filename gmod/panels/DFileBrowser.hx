package gmod.panels;
#if client

/**
    A tree and list-based file browser. 
	
	It allows filtering by folder (directory) name and file extension, and can display models as SpawnIcons.
	
	**Note:** Uses the same DFrame as above
**/
extern class DFileBrowser extends DPanel {
    /**
        Sets the search filter for the file tree. 
		
		This accepts the same wildcards as file.Find.
		
		Name | Description
		--- | ---
		`filter` | The filter to use on the file tree.
    **/
    
     
    function SetSearch(?filter:String):Void;
    /**
        Returns the current directory/folder being displayed.
		
		`**Returns:** The directory the file list is currently displaying.
    **/
    
     
    function GetCurrentFolder():String;
    /**
        Sets the directory/folder from which to display the file list.
		
		Name | Description
		--- | ---
		`currentDir` | The directory to display files from.
    **/
    
     
    function SetCurrentFolder(currentDir:String):Void;
    /**
        ***INTERNAL** 
		
		Called to set up the [DTree](https://wiki.garrysmod.com/page/Category:DTree) and file viewer when a base path has been set. Calls DFileBrowser:SetupTree and DFileBrowser:SetupFiles.
		
		`**Returns:** Whether or not the variables needed to set up have been defined.
    **/
    @:deprecated("INTERNAL")
     
    function Setup():Bool;
    /**
        Sets the name to use for the file tree.
		
		Name | Description
		--- | ---
		`treeName` | The name for the root of the file tree. Passing no value causes this to be the base folder name. See DFileBrowser: SetBaseFolder.
    **/
    
     
    function SetName(?treeName:String):Void;
    /**
        Called when a file is right-clicked.
		
		**Note:** When not in model viewer mode, DFileBrowser:OnSelect will also be called if the file is not already selected.
		
		Name | Description
		--- | ---
		`filePath` | The path to the file that was right-clicked.
		`selectedPanel` | The panel that was right-clicked to select this file. This will either be a DListView_Line or SpawnIcon depending on whether the model viewer mode is enabled. See DFileBrowser: SetModels.
    **/
    
    @:hook 
    function OnRightClick(filePath:String, selectedPanel:Panel):Void;
    /**
        Enables or disables the model viewer mode. In this mode, files are displayed as SpawnIcons instead of a list.
		
		**Note:** This should only be used for .mdl files; the spawn icons will display error models for others. See DFileBrowser:SetFileTypes
		
		Name | Description
		--- | ---
		`showModels` | Whether or not to display files using SpawnIcons.
    **/
    
     
    function SetModels(?showModels:Bool):Void;
    /**
        Returns the name being used for the file tree.
		
		`**Returns:** The name used for the root of the file tree.
    **/
    
     
    function GetName():String;
    /**
        Returns the DTree Node that the file tree stems from. 
		
		This is a child of the root node of the DTree.
		
		`**Returns:** The DTree_Node used for the tree.
    **/
    
     
    function GetFolderNode():Panel;
    /**
        Sorts the file list.
		
		**Note:** This is only functional when not using the model viewer. See DFileBrowser:SetModels
		
		Name | Description
		--- | ---
		`descending` | The sort order. true for descending (z-a), false for ascending (a-z).
    **/
    
     
    function SortFiles(?descending:Bool):Void;
    /**
        Called when a file is selected.
		
		Name | Description
		--- | ---
		`filePath` | The path to the file that was selected.
		`selectedPanel` | The panel that was clicked to select this file. This will either be a DListView_Line or SpawnIcon depending on whether the model viewer mode is enabled. See DFileBrowser: SetModels.
    **/
    
    @:hook 
    function OnSelect(filePath:String, selectedPanel:Panel):Void;
    /**
        ***INTERNAL** 
		
		Builds the file or icon list for the current directory. You should use DFileBrowser:SetCurrentFolder to change the directory.
		
		Name | Description
		--- | ---
		`currentDir` | The directory to populate the list from.
    **/
    @:deprecated("INTERNAL")
     
    function ShowFolder(currentDir:String):Void;
    /**
        Returns the current file type filter on the file list.
		
		`**Returns:** The current filter applied to the file list.
    **/
    
     
    function GetFileTypes():String;
    /**
        ***INTERNAL** 
		
		Called to set up the [DListView](https://wiki.garrysmod.com/page/Category:DListView) or [DIconBrowser](https://wiki.garrysmod.com/page/Category:DIconBrowser) by [DFileBrowser](https://wiki.garrysmod.com/page/Category:DFileBrowser): [Setup](https://wiki.garrysmod.com/page/DFileBrowser/Setup). The icon browser is used when in models mode. See DFileBrowser:SetModels.
		
		`**Returns:** Whether or not the files pane was set up successfully.
    **/
    @:deprecated("INTERNAL")
     
    function SetupFiles():Bool;
    /**
        Returns the current search filter on the file tree.
		
		`**Returns:** The filter in use on the file tree.
    **/
    
     
    function GetSearch():String;
    /**
        ***INTERNAL** 
		
		Called to set up the [DTree](https://wiki.garrysmod.com/page/Category:DTree) by [DFileBrowser](https://wiki.garrysmod.com/page/Category:DFileBrowser): [Setup](https://wiki.garrysmod.com/page/DFileBrowser/Setup).
		
		`**Returns:** Whether or not the tree was set up successfully.
    **/
    @:deprecated("INTERNAL")
     
    function SetupTree():Bool;
    /**
        Sets the access path for the file tree. This is set to GAME by default. 
		
		See file.Read for how paths work.
		
		Name | Description
		--- | ---
		`path` | The access path i.e. "GAME", "LUA", "DATA" etc.
    **/
    
     
    function SetPath(path:String):Void;
    /**
        Sets the root directory/folder of the file tree. 
		
		This needs to be set for the file tree to be displayed.
		
		Name | Description
		--- | ---
		`baseDir` | The path to the folder to use as the root.
    **/
    
     
    function SetBaseFolder(baseDir:String):Void;
    /**
        Clears the file tree and list, and resets all values.
    **/
    
     
    function Clear():Void;
    /**
        Opens or closes the file tree.
		
		Name | Description
		--- | ---
		`open` | true to open the tree, false to close it.
		`useAnim` | If true, the DTree's open/close animation is used.
    **/
    
     
    function SetOpen(?open:Bool, ?useAnim:Bool):Void;
    /**
        Returns the root directory/folder of the file tree.
		
		`**Returns:** The path to the root folder.
    **/
    
     
    function GetBaseFolder():String;
    /**
        Returns the access path of the file tree. This is GAME unless changed with DFileBrowser:SetPath. 
		
		See file.Read for how paths work.
		
		`**Returns:** The current access path i.e. "GAME", "LUA", "DATA" etc.
    **/
    
     
    function GetPath():String;
    /**
        Sets the file type filter for the file list. 
		
		This accepts the same file extension wildcards as file.Find.
		
		Name | Description
		--- | ---
		`fileTypes` | A list of file types to display, separated by spaces e.g. "*.lua *.txt *.mdl"
    **/
    
     
    function SetFileTypes(?fileTypes:String):Void;
    /**
        Returns whether or not the model viewer mode is enabled. In this mode, files are displayed as SpawnIcons instead of a list.
		
		`**Returns:** Whether or not files will be displayed using SpawnIcons.
    **/
    
     
    function GetModels():Bool;
    /**
        Returns whether or not the file tree is open.
		
		`**Returns:** Whether or not the file tree is open.
    **/
    
     
    function GetOpen():Bool;
    /**
        Called when a file is double-clicked.
		
		**Note:** Double-clicking a file or icon will trigger both this and DFileBrowser:OnSelect.
		
		Name | Description
		--- | ---
		`filePath` | The path to the file that was double-clicked.
		`selectedPanel` | The panel that was double-clicked to select this file. This will either be a DListView_Line or SpawnIcon depending on whether the model viewer mode is enabled. See DFileBrowser: SetModels.
    **/
    
    @:hook 
    function OnDoubleClick(filePath:String, selectedPanel:Panel):Void;
    
}



#end