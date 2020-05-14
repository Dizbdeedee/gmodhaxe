package gmod.panels;
#if client

/**
    A panel capable of loading .tga images.
**/
extern class TGAImage extends Panel {
    /**
        Sets a new image to be loaded by a TGAImage.
		
		Name | Description
		--- | ---
		`imageName` | The file path.
		`strPath` | The PATH to search in. See File Search Paths. This isn't used internally.
    **/
    
     
    function LoadTGAImage(imageName:String, strPath:String):Void;
    
}



#end