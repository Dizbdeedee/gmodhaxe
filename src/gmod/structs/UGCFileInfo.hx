package gmod.structs;
/**
    Table structure used by [steamworks](https://wiki.garrysmod.com/page/Category:steamworks). [FileInfo](https://wiki.garrysmod.com/page/steamworks/FileInfo).
**/
typedef UGCFileInfo = {
    /**
        The description of the Workshop item
    **/
    var description : String;
    /**
        If the addon is subscribed, this value represents whether it is installed on the client and its files are accessible, false otherwise.
    **/
    var installed : Bool;
    /**
        The title of the Workshop item
    **/
    var title : String;
    /**
        File size of the workshop item contents
    **/
    var size : Float;
    /**
        The internal File ID of the workshop item preview, if any
    **/
    var previewid : Float;
    /**
        The Workshop item ID
    **/
    var id : Float;
    /**
        Unix timestamp of when the item was created
    **/
    var created : Float;
    /**
        If the addon is subscribed, this value represents whether it is disabled on the client, false otherwise.
    **/
    var disabled : Bool;
    /**
        A list of child Workshop Items for this item. 
		
		For collections this will be sub-collections, for workshop items this will be the items they depend on.
    **/
    var children : AnyTable;
    /**
        The "nice" name of the Uploader, or "Unnammed Player" if we failed to get the data for some reason. 
		
		Do not use this field as it will most likely not be updated in time. Use steamworks.RequestPlayerInfo instead.
    **/
    var ownername : String;
    /**
        The SteamID64 of the original uploader of the addon
    **/
    var owner : Float;
    /**
        Unix timestamp of when the file was last updated
    **/
    var updated : Float;
    /**
        The internal File ID of the workshop item, if any
    **/
    var fileid : Float;
    /**
        Comma (,) separated list of tags, may be truncated to some length
    **/
    var tags : String;
    /**
        If this key is set, no other data will be present in the response. 
		
		Values above 0 represent Steam Error codes, values below 0 mean the following:
    **/
    var error : Float;
    /**
        Filesize of the preview file
    **/
    var previewsize : Float;
    /**
        Whether the file is banned or not
    **/
    var banned : Bool;
    
}
