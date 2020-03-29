package gmod.panels;
#if client

/**
    A panel similar to Label used by DLabelURL.
**/
extern class URLLabel {
    /**
        Sets the URL of a link-based panel such as [DLabelURL](https://wiki.garrysmod.com/page/Category:DLabelURL).
		
		Name | Description
		--- | ---
		`url` | The URL to set. This must begin with http://.
    **/
    
     
    function SetURL(url:String):Void;
    
}



#end