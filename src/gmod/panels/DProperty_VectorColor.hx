package gmod.panels;
#if client

/**
    Color picker control for a DProperties panel. Opens a DColorCombo if the color preview is clicked. 
	
	See Editable Entities for how this is used ingame.
**/
extern class DProperty_VectorColor extends DProperty_Generic {
    /**
        ***INTERNAL** 
		
		Called by a property row to setup a color selection control.
		
		Name | Description
		--- | ---
		`prop` | 
		`settings` | A table of settings. None of the values are used for this property. See Editable Entities.
    **/
    @:deprecated("INTERNAL")
     
    function Setup(?prop:String, settings:AnyTable):Void;
    /**
        Sets the color value of the property.
		
		Name | Description
		--- | ---
		`color` | Sets the color to use in a DProperty_VectorColor.
		
		
		___
		### Lua Examples
		#### Example 1
		Setup a color selection control with a custom default color.
		
		```lua 
		local color = DP:CreateRow( "Category", "Select Color" )
		color:Setup( "VectorColor", {} )
		color:SetValue( Vector( 0.39, 1, 1 ) )
		```
    **/
    
     
    function SetValue(color:Vector):Void;
    
}



#end