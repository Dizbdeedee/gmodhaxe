package gmod.libs;
#if client

/**
    The search library.
**/
@:native("_G.search")extern class SearchLib {
    
    /**
        Adds a search result provider. For examples, see gamemodes/sandbox/gamemode/cl_search_models.lua
		
		Name | Description
		--- | ---
		`provider` | Provider function. It has one argument: string searchQuery You must return a list of tables structured like this: string text - Text to "Copy to clipboard" function func - Function to use/spawn the item Panel icon - A panel to add to spawnmenu table words - A table of words?
		`id` | If provided, ensures that only one provider exists with the given ID at a time.
    **/
    
    public static function AddProvider(provider:Function, ?id:String):Void;
    
    
    /**
        Retrieves search results.
		
		Name | Description
		--- | ---
		`query` | Search query
		
		
		`**Returns:** A table of results ( Maximum 1024 items )
    **/
    
    public static function GetResults(query:String):AnyTable;
    
    

}



#end