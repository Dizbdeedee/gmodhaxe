package gmod.libs;
#if server

/**
    The resource library is used to control what files are sent to clients who join a server, this includes models, materials, sounds, text files but not Lua files.
**/
@:native("_G.resource")extern class ResourceLib {
    
    /**
        Adds the specified file to the files the client should download.
		
		**Note:** There's a 8192 downloadable file limit. If you need more, consider using Workshop addons - resource.AddWorkshop. You should also consider the fact that you have way too many downloads. This limit is shared among all resource.Add functions.
		
		Name | Description
		--- | ---
		`path` | Path of the file to be added, relative to garrysmod/
    **/
    
    public static function AddSingleFile(path:String):Void;
    
    
    /**
        Adds a workshop addon for the client to download before entering the server. 
		
		Having the raw files from a workshop item does not count as having already downloaded it. So players who previously downloaded a map through Fast Download will have to re-download it if you use the workshop. 
		
		 You should try to only add addons that have custom content ( models, sounds, etc ). 
		
		 Gamemodes that are workshop enabled are automatically added to this list - so there's no need to add them. The server's current map is also automatically added, if it is loaded from a workshop addon.
		
		**Warning:** This will not "install" the addon on your server, see Workshop for Dedicated Servers for installing Steam Workshop addons onto your servers
		
		Name | Description
		--- | ---
		`workshopid` | The workshop id of the file. This cannot be a collection.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds the Achievement Viewer addon (workshop id 104606562). Any clients that join will download this addon if they haven't previously downloaded it from the workshop or from the server (via the workshop).You get the ID from the URL of the workshop addon. For example, here's the URL of the Achievement Viewer addon's page: http://steamcommunity.com/sharedfiles/filedetails/?id=104606562 The ID is 104606562.
		
		```lua 
		resource.AddWorkshop( "104606562" )
		```
		**Output:**
		
		Players joining the server will now be forced to download the Achievement Viewer addon.
    **/
    
    public static function AddWorkshop(workshopid:String):Void;
    
    
    /**
        Adds the specified and all related files to the files the client should download. 
		
		For convenience, this function will automatically add any other files that are related to the selected one, and throw an error if it can't find them. For example, a .vmt file will automatically add the .vtf with the same name, and a .mdl file will automatically add all .vvd, .ani, .dx80.vtx, .dx90.vtx, .sw.vtx, .phy and .jpg files with the same name, with a separate error for each missing file. If you do not want it to do this, use resource.AddSingleFile.
		
		**Note:** There's a 8192 downloadable file limit. If you need more, consider using Workshop addons - resource.AddWorkshop. You should also consider the fact that you have way too many downloads. This limit is shared among all resource.Add functions.
		
		**Note:** Running this function using a path relative to the main garrysmod/ folder will not work for files in addons and gamemodes. Instead, the files must be added relative to their respective content folders. For example, a sound file from an addon would use the path "sound/[FILENAME_AND_EXTENSION]," despite the file being located in "addons/[ADDON_NAME]/sound/[FILENAME_AND_EXTENSION]"
		
		Name | Description
		--- | ---
		`path` | Virtual path of the file to be added, relative to garrysmod/. Do not add .bz2 to the filepath. Do not put gamemodes/<gamemodename>/content/ or addons/<addonname>/ into the path.
		
		
		___
		### Lua Examples
		#### Example 1
		Example of usage.
		
		```lua 
		resource.AddFile( "materials/my/material.vmt" ) -- Automatically adds materials/my/material.vtf
		resource.AddFile( "models/my/model.mdl" ) -- Automatically adds models/my/model.vtx and the rest
		resource.AddFile( "sound/my/sound.wav" ) -- Be careful, there's no S in the sound.
		```
    **/
    
    public static function AddFile(path:String):Void;
    
    

}



#end