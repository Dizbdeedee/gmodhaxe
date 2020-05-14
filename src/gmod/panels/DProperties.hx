package gmod.panels;
#if client

/**
    A grid for editing the properties of something using names and values. Properties can be categorized and strongly typed.
**/
extern class DProperties extends Panel {
    /**
        ***INTERNAL** 
		
		Returns (or creates) a category of properties. 
		
		See DProperties:CreateRow for adding actual properties.
		
		Name | Description
		--- | ---
		`name` | Name of the category
		`create` | Create a new category if it doesn't exist.
		
		
		`**Returns:** An internal panel.
    **/
    @:deprecated("INTERNAL")
     
    function GetCategory(name:String, create:Bool):Panel;
    /**
        Returns the DScrollPanel all the properties panels are attached to.
		
		`**Returns:** A DScrollPanel canvas
    **/
    
     
    function GetCanvas():Panel;
    /**
        Creates a row in the properties panel.
		
		Name | Description
		--- | ---
		`category` | The category to list this row under
		`name` | The label of this row
		
		
		`**Returns:** An internal Row panel.
    **/
    
     
    function CreateRow(category:String, name:String):Panel;
    
}



#end