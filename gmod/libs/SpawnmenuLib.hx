package gmod.libs;
#if client

/**
    The spawnmenu library is a set of functions that allow you to control the spawn (Q) menu.
**/
@:native("_G.spawnmenu")extern class SpawnmenuLib {
    
    /**
        Adds a new tool tab to the right side of the spawnmenu via the SANDBOX:AddToolMenuTabs hook. 
		
		This function is a inferior duplicate of spawnmenu.GetToolMenu, just without its return value.
		
		Name | Description
		--- | ---
		`name` | The internal name of the tab. This is used for sorting.
		`label` | The 'nice' name of the tab (Tip: language. Add)
		`icon` | The filepath to the icon of the tab. Should be a .png
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a new tab named, "Tab name!" with a unique name and a wrench icon.
		
		```lua 
		hook.Add( "AddToolMenuTabs", "myHookClass", function()
		    spawnmenu.AddToolTab( "Tab name!", "#Unique_Name", "icon16/wrench.png" )
		end )
		```
    **/
    
    public static function AddToolTab(name:String, ?label:String, ?icon:String):Void;
    
    
    /**
        Inserts a new tab into the CreationMenus table, which will be used by the creation menu to generate its tabs (Spawnlists, Weapons, Entities, etc.)
		
		Name | Description
		--- | ---
		`name` | What text will appear on the tab (I.E Spawnlists).
		`function` | The function called to generate the content of the tab.
		`material` | Path to the material that will be used as an icon on the tab.
		`order` | The order in which this tab should be shown relative to the other tabs on the creation menu.
		`tooltip` | The tooltip to be shown for this tab.
		
		
		___
		### Lua Examples
		#### Example 1
		An excerpt from the Dupe creation menu tab.
		
		```lua 
		spawnmenu.AddCreationTab( "#spawnmenu.category.dupes", function()
		
		    HTML = vgui.Create( "DHTML" );
		        JS_Language( HTML )
		        HTML:SetAllowLua( true );
		        HTML:OpenURL( "asset://garrysmod/html/dupes.html" );
		        HTML:Call( "SetDupeSaveState( " .. tostring( DupeInClipboard ).. " );" );        
		
		    return HTML
		
		end, "icon16/control_repeat_blue.png", 200 )
		```
		**Output:**
		
		A new tab named "Dupes" will be placed in the creation menu.
    **/
    
    public static function AddCreationTab(name:String, _function:Function, ?material:String, ?order:Float, ?tooltip:String):Void;
    
    
    /**
        Used to create a new category in the list inside of a spawnmenu ToolTab. 
		
		You must call this function from SANDBOX:AddToolMenuCategories for it to work properly.
		
		Name | Description
		--- | ---
		`tab` | The ToolTab name, as created with spawnmenu.AddToolTab. You can also use the default ToolTab names "Main" and "Utilities".
		`RealName` | The identifier name
		`PrintName` | The displayed name
		
		
		___
		### Lua Examples
		#### Example 1
		Adds the Constraints category to the Main ToolTab. See lua\includes\modules\spawnmenu.lua.
		
		```lua 
		spawnmenu.AddToolCategory( "Main", "Constraints", "#spawnmenu.tools.constraints" )
		```
		
		#### Example 2
		Adds the User category to the Utilities ToolTab. See lua\autorun\utilities_menu.lua.
		
		```lua 
		spawnmenu.AddToolCategory( "Utilities", "User", "#spawnmenu.utilities.user" )
		```
    **/
    
    public static function AddToolCategory(tab:String, RealName:String, PrintName:String):Void;
    
    
    /**
        Used to add addon spawnlists to the spawnmenu tree. This function should be called within SANDBOX:PopulatePropMenu. 
		
		Addon spawnlists will not save to disk if edited.
		
		**Warning:** You should never try to modify player customized spawnlists!
		
		Name | Description
		--- | ---
		`classname` | A unique classname of the list.
		`name` | The name of the category displayed to the player, e.g. Comic Props.
		`contents` | A table of entries for the spawn menu. It must be numerically indexed. Each member of the table is a sub-table containing a type member, and other members depending on the type. string type - "header" - a simple header for organization string text - The text that the header will display string type - "model" - spawns a model where the player is looking string model - The path to the model file number skin - The skin for the model to use (optional) string body - The bodygroups for the model (optional) number wide - The width of the spawnicon (optional) number tall - The height of the spawnicon (optional) string type - "entity" - spawns an entity where the player is looking (appears in the Entities tab by default) string spawnname - The filename of the entity, for example "sent_ball" string nicename - The name of the entity to display string material - The icon to display, this should be set to "entities/<sent_name>.png" boolean admin - Whether the entity is only spawnable by admins (optional) string type - "vehicle" - spawns a vehicle where the player is looking (appears in the Vehicles tab by default) string spawnname - The filename of the vehicle string nicename - The name of the vehicle to display string material - The icon to display boolean admin - Whether the vehicle is only spawnable by admins (optional) string type - "npc" - spawns an NPC where the player is looking (appears in the NPCs tab by default) string spawnname - The spawn name of the NPC string nicename - The name to display string material - The icon to display table weapon - A table of potential weapons (each a string) to give to the NPC. When spawned, one of these will be chosen randomly each time. boolean admin - Whether the NPC is only spawnable by admins (optional) string type - "weapon" - When clicked, gives the player a weapon; when middle-clicked, spawns a weapon where the player is looking (appears in the Weapons tab by default) string spawnname - The spawn name of the weapon string nicename - The name to display string material - The icon to display boolean admin - Whether the weapon is only spawnable by admins (optional)
		`icon` | The icon to use in the tree.
		`id` | The unique ID number for the spawnlist category. Used to make sub categories. See "parentID" parameter below. If not set, it will be automatically set to ever increasing number, starting with 1000.
		`parentID` | The unique ID of the parent category. This will make the created category a subcategory of category with given unique ID. 0 makes this a base category (such as Builder).
		`needsApp` | The needed game for this prop category, if one is needed. If the specified game is not mounted, the category isn't shown. This uses the shortcut name, e.g. cstrike, and not the Steam AppID.
		
		
		___
		### Lua Examples
		#### Example 1
		Create a spawn menu with two icons for each type
		
		```lua 
		hook.Add("PopulatePropMenu", "Add Two Of Each", function()
		    
		    local contents = {}
		    
		    -- Props
		    table.insert( contents, {
		        type = "header",
		        text = "Props"
		    } )
		    table.insert( contents, {
		        type = "model",
		        model = "models/props_c17/oildrum001.mdl"
		    } )
		    table.insert( contents, {
		        type = "model",
		        model = "models/props_wasteland/cargo_container01.mdl",
		        skin = 1,
		        wide = 128,
		        tall = 64
		    } )
		
		    -- Entities
		    table.insert( contents, {
		        type = "header",
		        text = "Entities"
		    } )
		    table.insert( contents, {
		        type = "entity",
		        spawnname = "sent_ball",
		        nicename = "Bouncy Ball",
		        material = "entities/sent_ball.png"
		    } )
		    table.insert( contents, {
		        type = "entity",
		        spawnname = "combine_mine",
		        nicename = "Hopper Mine",
		        material = "entities/combine_mine.png"
		    } )
		
		    -- Vehicles
		    table.insert( contents, {
		        type = "header",
		        text = "Vehicles"
		    } )
		    table.insert( contents, {
		        type = "vehicle",
		        spawnname = "Airboat",
		        nicename = "Half-Life 2 Airboat",
		        material = "entities/Airboat.png"
		    } )
		    table.insert( contents, {
		        type = "vehicle",
		        spawnname = "Chair_Office2",
		        nicename = "Executive's Chair",
		        material = "entities/Chair_Office2.png"
		    } )
		
		    -- NPCs
		    table.insert( contents, {
		        type = "header",
		        text = "NPCs"
		    } )
		    table.insert( contents, {
		        type = "npc",
		        spawnname = "npc_citizen",
		        nicename = "A random citizen",
		        material = "entities/npc_citizen.png",
		        weapon = { "weapon_smg1", "weapon_crowbar" }
		    } )
		    table.insert( contents, {
		        type = "npc",
		        spawnname = "npc_headcrab",
		        nicename = "Headhumper",
		        material = "entities/npc_headcrab.png"
		    } )
		
		    -- Weapons
		    table.insert( contents, {
		        type = "header",
		        text = "Weapons"
		    } )
		    table.insert( contents, {
		        type = "weapon",
		        spawnname = "weapon_crowbar",
		        nicename = "Crowbar",
		        material = "entities/weapon_crowbar.png",
		    } )
		    table.insert( contents, {
		        type = "weapon",
		        spawnname = "weapon_smg1",
		        nicename = "SMG",
		        material = "entities/weapon_smg1.png",
		    } )
		
		    spawnmenu.AddPropCategory( "TwoOfEach", "Two of each type", contents, "icon16/box.png" )
		end )
		```
    **/
    
    public static function AddPropCategory(classname:String, name:String, contents:AnyTable, icon:String, ?id:Float, ?parentID:Float, ?needsApp:String):Void;
    
    
    /**
        Creates a new content icon.
		
		Name | Description
		--- | ---
		`type` | The type of the content icon.
		`parent` | The parent to add the content icon to.
		`data` | The data to send to the content icon in spawnmenu. AddContentType
		
		
		`**Returns:** The created content icon, if it was returned by spawnmenu. AddContentType
    **/
    
    public static function CreateContentIcon(type:String, parent:Panel, data:AnyTable):Panel;
    
    
    /**
        ***Deprecated:** 
		
		Adds an option to the right side of the spawnmenu
		
		Name | Description
		--- | ---
		`tab` | The spawnmenu tab to add into (for example "Utilities")
		`category` | The category to add into (for example "Admin")
		`class` | Unique identifier of option to add
		`name` | The nice name of item
		`cmd` | Command to execute when the item is selected
		`config` | Config name, used in older versions to load tool settings UI from a file. No longer works. This feature is deprecated. You should avoid using it as it may be removed in a future version. This feature is deprecated. You should avoid using it as it may be removed in a future version.
		`cpanel` | A function to build the context panel. The function has one argument: Panel pnl - A DForm that will be shown in the context menu
		`table` | Allows to override the table that will be added to the tool list. Some of the fields will be overwritten by this function.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds a new option to the menu with a slider to change the gravity
		
		```lua 
		hook.Add( "PopulateToolMenu", "CustomMenuSettings", function()
		    spawnmenu.AddToolMenuOption( "Utilities", "Stuff", "Custom_Menu", "My Custom Menu", "", "", function( panel )
		        panel:ClearControls()
		        panel:NumSlider( "Gravity", "sv_gravity", 0, 600 )
		        -- Add stuff here
		    end )
		end )
		```
    **/
    @:deprecated("")
    public static function AddToolMenuOption(tab:String, category:String, _class:String, name:String, cmd:String, config:String, cpanel:Function, ?table:AnyTable):Void;
    
    
    /**
        Gets a table of tools on the client.
		
		`**Returns:** A table with groups of tools, along with information on each tool.
		
		___
		### Lua Examples
		#### Example 1
		Prints the output
		
		```lua 
		PrintTable( spawnmenu.GetTools() )
		```
    **/
    
    public static function GetTools():AnyTable;
    
    
    /**
        ***Deprecated:** 
		
		Supposed to open specified tool tab in spawnmenu, in reality does nothing.
		
		Name | Description
		--- | ---
		`id` | The tab ID to open
    **/
    @:deprecated("")
    public static function SwitchToolTab(id:Float):Void;
    
    
    /**
        Returns the function to create an vgui element for a specified content type
		
		Name | Description
		--- | ---
		`contentType` | 
		
		
		`**Returns:** The panel creation function
    **/
    
    public static function GetContentType(contentType:String):Function;
    
    
    /**
        Activates a tool, opens context menu and brings up the tool gun.
		
		Name | Description
		--- | ---
		`tool` | Tool class/file name
    **/
    
    public static function ActivateTool(tool:String):Void;
    
    
    /**
        Clears all the tools from the different tool categories and the categories itself, if ran at the correct place. 
		
		Seems to only work when ran at initialization.
		
		___
		### Lua Examples
		#### Example 1
		Clear the tool menu completely, after populating it:
		
		```lua 
		hook.Run( "PopulateToolMenu" )
		
		spawnmenu.ClearToolMenus()
		```
    **/
    
    public static function ClearToolMenus():Void;
    
    
    /**
        Adds a new tool tab (or returns an existing one by name) to the right side of the spawnmenu via the SANDBOX:AddToolMenuTabs hook.
		
		Name | Description
		--- | ---
		`name` | The internal name of the tab. This is used for sorting.
		`label` | The 'nice' name of the tab
		`icon` | The filepath to the icon of the tab. Should be a .png
		
		
		`**Returns:** A table of tables representing categories and items in the left part of the tab. See example below to example structure.
		
		___
		### Lua Examples
		#### Example 1
		Prints out the contents of the default Tool Tab.
		
		```lua 
		PrintTable( spawnmenu.GetToolMenu( "Main" ) )
		```
    **/
    
    public static function GetToolMenu(name:String, ?label:String, ?icon:String):AnyTable;
    
    
    /**
        Activates tools context menu in specified tool tab.
		
		Name | Description
		--- | ---
		`tab` | The tabID of the tab to open the context menu in
		`cp` | The control panel to open
    **/
    
    public static function ActivateToolPanel(tab:Float, cp:Panel):Void;
    
    
    /**
        Registers a new content type that is saveable into spawnlists. Created/called by spawnmenu.CreateContentIcon.
		
		Name | Description
		--- | ---
		`name` | An unique name of the content type.
		`constructor` | A function that is called whenever we need create a new panel for this content type. It has two arguments: Panel container - The container/parent of the new panel table data - Data for the content type passed from spawnmenu.CreateContentIcon
		
		
		___
		### Lua Examples
		#### Example 1
		A simple header content type.
		
		```lua 
		spawnmenu.AddContentType( "header", function( container, obj )
		
		    if ( !obj.text or type(obj.text) != "string" ) then return end
		
		    local label = vgui.Create( "ContentHeader", container )
		    label:SetText( obj.text )
		    
		    container:Add( label )
		    
		end )
		```
    **/
    
    public static function AddContentType(name:String, constructor:Function):Void;
    
    
    /**
        Sets currently active control panel to be returned by spawnmenu.ActiveControlPanel.
		
		Name | Description
		--- | ---
		`pnl` | The panel to set.
    **/
    
    public static function SetActiveControlPanel(pnl:Panel):Void;
    
    
    /**
        ***INTERNAL** 
		
		Calls spawnmenu.SaveToTextFiles.
		
		Name | Description
		--- | ---
		`spawnlists` | A table containing spawnlists.
    **/
    @:deprecated("INTERNAL")
    public static function DoSaveToTextFiles(spawnlists:AnyTable):Void;
    
    
    /**
        Returns currently opened control panel of a tool, post process effect or some other menu in spawnmenu.
		
		`**Returns:** The currently opened control panel, if any.
    **/
    
    public static function ActiveControlPanel():Panel;
    
    
    /**
        Similar to spawnmenu.GetPropTable, but only returns spawnlists created by addons via spawnmenu.AddPropCategory. 
		
		These spawnlists are shown in a separate menu in-game.
		
		`**Returns:** See spawnmenu. GetPropTable for table format.
    **/
    
    public static function GetCustomPropTable():AnyTable;
    
    
    /**
        ***INTERNAL** 
		
		Calls spawnmenu.PopulateFromTextFiles.
    **/
    @:deprecated("INTERNAL")
    public static function PopulateFromEngineTextFiles():Void;
    
    
    /**
        Gets the CreationMenus table, which was filled with creation menu tabs from spawnmenu.AddCreationTab.
		
		`**Returns:** The CreationMenus table. See the CreationMenus structure.
    **/
    
    public static function GetCreationTabs():CreationMenus;
    
    
    /**
        ***INTERNAL** 
		
		Saves a table of spawnlists to files.
		
		Name | Description
		--- | ---
		`spawnlists` | A table containing spawnlists.
    **/
    @:deprecated("INTERNAL")
    public static function SaveToTextFiles(spawnlists:AnyTable):Void;
    
    
    /**
        Returns a table of all prop categories and their props in the spawnmenu. 
		
		Note that if the spawnmenu has not been populated, this will return an empty table. 
		
		 This will not return spawnlists created by addons, see spawnmenu.GetCustomPropTable for that.
		
		`**Returns:** Table of all the prop categories and props in the following format: {
			["settings/spawnlist/001-construction props.txt"] = {
				name = "Construction Props",
				icon = "icon16/page.png",
				id = 1,
				parentid = 0,
				needsapp = "",
				contents = {
					{
						model = "models/Cranes/crane_frame.mdl",
						type = "model"
					}
					-- etc.
				},
			}
			-- etc.
		}
    **/
    
    public static function GetPropTable():AnyTable;
    
    
    /**
        Loads spawnlists from text files.
		
		Name | Description
		--- | ---
		`callback` | The function to call. Arguments are ( strFilename, strName, tabContents, icon, id, parentid, needsapp )
    **/
    
    public static function PopulateFromTextFiles(callback:Function):Void;
    
    

}



#end