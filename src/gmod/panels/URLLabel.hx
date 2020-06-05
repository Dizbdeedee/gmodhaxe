package gmod.panels;
#if client

/**
    A panel similar to Label used by DLabelURL.
**/
extern class URLLabel extends Panel { //FIXME don't know what it actually extends
    /**
        Sets the URL of a link-based panel such as [DLabelURL](https://wiki.garrysmod.com/page/Category:DLabelURL).
		
		Name | Description
		--- | ---
		`url` | The URL to set. This must begin with http://.
    **/
    
     
    function SetURL(url:String):Void;
    
}



#end
