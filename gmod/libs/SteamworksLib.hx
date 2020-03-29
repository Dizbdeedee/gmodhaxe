package gmod.libs;
#if client

/**
    Steamworks related functions.
**/
@:native("_G.steamworks")extern class SteamworksLib {
    
    /**
        Sets if an addon should be enabled or disabled. Call steamworks.ApplyAddons afterwards to update.
		
		Name | Description
		--- | ---
		`workshopItemID` | The ID of the Steam Workshop item we should enable/disable
		`shouldMount` | true to enable the item, false to disable.
		
		
		___
		### Lua Examples
		#### Example 1
		Enables the Gm_construct_Beta Steam Workshop addon and reloads addons afterwards
		
		```lua 
		steamworks.SetShouldMountAddon( 21197, true )
		steamworks.ApplyAddons()
		```
		**Output:**
		
		Enabled the gm_construct_beta addon, if installed.
    **/
    
    public static function SetShouldMountAddon(workshopItemID:String, shouldMount:Bool):Void;
    
    
    /**
        
		
		Name | Description
		--- | ---
		`workshopid` | The Steam Workshop item id
		
		
		`**Returns:** Whatever you have put in as first argument
    **/
    
    public static function SetFileCompleted(workshopid:String):String;
    
    
    /**
        Opens the workshop website in the steam overlay browser.
		
		___
		### Lua Examples
		#### Example 1
		An alternative to this function.
		
		```lua 
		gui.OpenURL( "http://steamcommunity.com/app/4000/workshop/" )
		```
    **/
    
    public static function OpenWorkshop():Void;
    
    
    /**
        ***INTERNAL** 
		
		Publishes dupes, saves or demos to workshop.
		
		Name | Description
		--- | ---
		`tags` | The workshop tags to apply
		`filename` | Path to the file to upload
		`image` | Path to the image to use as icon
		`name` | Name of the Workshop submission
		`desc` | Description of the Workshop submission
    **/
    @:deprecated("INTERNAL")
    public static function Publish(tags:AnyTable, filename:String, image:String, name:String, desc:String):Void;
    
    
    /**
        ***Deprecated:** You should use the callback of steamworks. RequestPlayerInfo instead.
		
		Retrieves players name by his 64bit SteamID. 
		
		You must call steamworks.RequestPlayerInfo a decent amount of time before calling this function.
		
		Name | Description
		--- | ---
		`steamID64` | The 64bit Steam ID ( aka Community ID ) of the player
		
		
		`**Returns:** The name of that player
		
		___
		### Lua Examples
		#### Example 1
		Retrieves name of local player.
		
		```lua 
		steamworks.RequestPlayerInfo( LocalPlayer():SteamID64() )
		timer.Simple( 1, function() -- this is not instant!
		    print( steamworks.GetPlayerName( LocalPlayer():SteamID64() ) )
		end )
		```
		**Output:**
		
		A name of local player is printed into console.
    **/
    @:deprecated("You should use the callback of steamworks. RequestPlayerInfo instead.")
    public static function GetPlayerName(steamID64:String):String;
    
    
    /**
        Refreshes clients addons.
		
		___
		### Lua Examples
		#### Example 1
		Subscribes to gm_construct_beta and reloads addons.
		
		```lua 
		steamworks.Subscribe( 21197 )
		steamworks.ApplyAddons()
		```
    **/
    
    public static function ApplyAddons():Void;
    
    
    /**
        Downloads a file from the supplied addon and saves it as a .cache file in garrysmod/cache folder. 
		
		This is mostly used to download the preview image of the addon, but the game seems to also use it to download replays and saves. 
		
		 In case the retrieved file is an image and you need the IMaterial, use AddonMaterial with the path supplied from the callback.
		
		Name | Description
		--- | ---
		`workshopPreviewID` | The Preview ID of workshop item.
		`uncompress` | Whether to uncompress the file or not, assuming it was compressed with LZMA. You will usually want to set this to true.
		`resultCallback` | The function to process retrieved data. The first and only argument is a string, containing path to the saved file.
		
		
		___
		### Lua Examples
		#### Example 1
		Downloads and saves icon of Gm_construct_Beta Steam Workshop addon.
		
		```lua 
		steamworks.FileInfo( 21197, function( result )
		    steamworks.Download( result.previewid, true, function( name )
		        print( name )
		    end) 
		end)
		```
		**Output:**
		
		Something like this will be printed into console: cache/559813303754221947.cache
    **/
    
    public static function Download(workshopPreviewID:String, uncompress:Bool, resultCallback:Function):Void;
    
    
    /**
        Retrieves info about supplied Steam Workshop addon.
		
		Name | Description
		--- | ---
		`workshopItemID` | The ID of Steam Workshop item.
		`resultCallback` | The function to process retrieved data, with the following arguments: table data - The data about the item, if the request succeeded, nil otherwise. See UGCFileInfo structure.
		
		
		___
		### Lua Examples
		#### Example 1
		Retries all info of gm_construct_Beta Steam Workshop addon.
		
		```lua 
		steamworks.FileInfo( 21197, function( result ) PrintTable( result ) end)
		```
    **/
    
    public static function FileInfo(workshopItemID:String, resultCallback:UGCFileInfo):Void;
    
    
    /**
        Retrieves vote info of supplied addon.
		
		Name | Description
		--- | ---
		`workshopItemID` | The ID of workshop item.
		`resultCallback` | The function to process retrieved data. The first and only argument is a table, containing all the info.
		
		
		___
		### Lua Examples
		#### Example 1
		Retrieves vote info of Gm_construct_Beta Steam Workshop addon.
		
		```lua 
		steamworks.VoteInfo( 21197, function( result ) PrintTable( result ) end)
		```
		**Output:**
		
		A table printed into console: score = 0.97182178497314
		total = 2952
		down = 36
		 up = 2916
    **/
    
    public static function VoteInfo(workshopItemID:String, resultCallback:Function):Void;
    
    
    /**
        ***INTERNAL** 
		
		Subscribes to the specified workshop addon. Call steamworks.ApplyAddons afterwards to update.
		
		Name | Description
		--- | ---
		`workshopItemID` | The ID of the Steam Workshop item we should subscribe to
		
		
		___
		### Lua Examples
		#### Example 1
		Subscribes to the Gm_construct_Beta Steam Workshop addon and reloads addons afterwards
		
		```lua 
		steamworks.Subscribe( "21197" )
		steamworks.ApplyAddons()
		```
		**Output:**
		
		Subscribes to gm_construct_beta addon, if not already.
    **/
    @:deprecated("INTERNAL")
    public static function Subscribe(workshopItemID:String):Void;
    
    
    /**
        Opens the workshop website for specified Steam Workshop item in the Steam overlay browser.
		
		Name | Description
		--- | ---
		`workshopItemID` | The ID of workshop item.
		
		
		___
		### Lua Examples
		#### Example 1
		Opens web page of Gm_construct_Beta Steam Workshop addon in Steam overlay browser.
		
		```lua 
		steamworks.ViewFile( 21197 )
		```
    **/
    
    public static function ViewFile(workshopItemID:String):Void;
    
    
    /**
        ***INTERNAL** 
		
		Makes the user vote for the specified addon       Give the Gm_construct_Beta Steam Workshop item a thumbs up.
		
		Name | Description
		--- | ---
		`workshopItemID` | The ID of workshop item.
		`upOrDown` | Sets if the user should vote up/down. True makes them upvote, false down
		
		
		___
		### Lua Examples
		#### Example 1
		Give the Gm_construct_Beta Steam Workshop item a thumbs up.
		
		```lua 
		steamworks.Vote( 21197, true )
		```
    **/
    @:deprecated("INTERNAL")
    public static function Vote(workshopItemID:String, upOrDown:Bool):Void;
    
    
    /**
        Sets whether you have played this addon or not. This will be shown to the user in the Steam Workshop itself:
		
		Name | Description
		--- | ---
		`workshopid` | The Steam Workshop item ID
		
		
		`**Returns:** Whatever you have put in as first argument
    **/
    
    public static function SetFilePlayed(workshopid:String):String;
    
    
    /**
        Retrieves a customized list of Steam Workshop addons.
		
		Name | Description
		--- | ---
		`type` | The type of items to retrieve.
		`tags` | A table of tags to match.
		`offset` | How much of results to skip from first one. Mainly used for pages.
		`numRetrieve` | How much addons to retrieve.
		`days` | When getting Most Popular content from Steam, this determines a time period. ( 7 = most popular addons in last 7 days, 1 = most popular addons today, etc )
		`userID` | "0" to retrieve all addons, "1" to retrieve addons only published by you.
		`resultCallback` | The function to process retrieved data. The first and only argument is a table, containing all the info.
		
		
		___
		### Lua Examples
		#### Example 1
		Retrieves top 10 of Steam Workshop addons.
		
		```lua 
		steamworks.GetList( "", nil, nil, 10, nil, 0, function( data ) PrintTable(data) end )
		```
		**Output:**
		
		A printed into console table: totalresults = 1748
		numresults = 10
		results:
		1 = 21197
		2 = 72122655
		3 = 68207248
		4 = 71921341
		5 = 79927494
		6 = 12692
		7 = 21174
		8 = 72145362
		9 = 16221
		 10 = 22104
    **/
    
    public static function GetList(type:String, tags:AnyTable, offset:Float, numRetrieve:Float, days:Float, userID:String, resultCallback:Function):Void;
    
    
    /**
        Requests information of the player with SteamID64 for later use with steamworks.GetPlayerName.
		
		Name | Description
		--- | ---
		`steamID64` | The 64bit Steam ID of player.
		`callback` | A callback function with only 1 argument - string name.
		
		
		___
		### Lua Examples
		#### Example 1
		Gets and prints the steam name of the local player
		
		```lua 
		steamworks.RequestPlayerInfo( LocalPlayer():SteamID64(), function(steamName)
		        print( steamName )
		end )
		```
		**Output:**
		
		The local player's name
    **/
    
    public static function RequestPlayerInfo(steamID64:String, callback:Function):Void;
    
    
    /**
        ***INTERNAL** 
		
		Unsubscribes to the specified workshop addon. Call [steamworks](https://wiki.garrysmod.com/page/Category:steamworks). [ApplyAddons](https://wiki.garrysmod.com/page/steamworks/ApplyAddons) afterwards to update. This function should never be called without a user's consent and should not be called if the addon is currently in use (aka: the user is not in the main menu) as it may result in unexpected behaviour.
		
		Name | Description
		--- | ---
		`workshopItemID` | The ID of the Steam Workshop item we should unsubscribe from.
		
		
		___
		### Lua Examples
		#### Example 1
		Unsubscribes from the Gm_construct_Beta Steam Workshop addon, if subscribed, and reloads addons afterwards
		
		```lua 
		steamworks.Unsubscribe( 21197 )
		steamworks.ApplyAddons()
		```
		**Output:**
		
		Unsubscribes from the gm_construct_beta addon, if subscribed.
    **/
    @:deprecated("INTERNAL")
    public static function Unsubscribe(workshopItemID:String):Void;
    
    
    /**
        Returns whenever the client is subscribed to the specified Steam Workshop item.
		
		Name | Description
		--- | ---
		`workshopItemID` | The ID of the Steam Workshop item.
		
		
		`**Returns:** Is the client subscribed to the addon or not.
		
		___
		### Lua Examples
		#### Example 1
		Checks if client is subscribed to Gm_construct_Beta Steam Workshop addon.
		
		```lua 
		print( steamworks.IsSubscribed( 21197 ) )
		```
		**Output:**
		
		If client is subscribed true is printed into console, false otherwise.
    **/
    
    public static function IsSubscribed(workshopItemID:String):Bool;
    
    
    /**
        Returns whenever the specified Steam Workshop addon will be mounted or not.
		
		Name | Description
		--- | ---
		`workshopItemID` | The ID of the Steam Workshop
		
		
		`**Returns:** Will the workshop item be mounted or not
		
		___
		### Lua Examples
		#### Example 1
		Checks if the client has enabled Gm_construct_Beta Steam Workshop addon.
		
		```lua 
		print( steamworks.ShouldMountAddon( 21197 ) )
		```
		**Output:**
		
		If client has enabled the addon true is printed into console, false otherwise.
    **/
    
    public static function ShouldMountAddon(workshopItemID:String):Bool;
    
    

}



#end