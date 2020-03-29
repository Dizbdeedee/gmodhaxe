package gmod.panels;
#if client

/**
    [DComboBox](https://wiki.garrysmod.com/page/Category:DComboBox) control for a [DProperties](https://wiki.garrysmod.com/page/Category:DProperties) panel.  Inherits the following functions from DProperty_Generic and its parents up to 3 levels deep:
**/
extern class DProperty_Combo extends DProperty_Generic {
    /**
        Sets up a combo control.
		
		Name | Description
		--- | ---
		`prop` | The name of DProperty sub control to add.
		`data` | Data to use to set up the combo box control. Structure: string text - The default label for this combo box table values - The values to add to the combo box
		
		
		___
		### Lua Examples
		#### Example 1
		Setup a Combo control with a custom default text and two options.
		
		```lua 
		local Combo = DP:CreateRow( "Catergory", "Hello World" )
		Combo:Setup( "Combo", {
		    text = "Select me!",
		    values = {
		        [ "Label 1" ] = "data 1",
		        [ "Label 2" ] = 2,
		    }
		} )
		```
    **/
    
     
    function Setup(?prop:String, ?data:AnyTable):Void;
    /**
        Called after the user selects a new value.
		
		Name | Description
		--- | ---
		`data` | The new data that was selected.
		
		
		___
		### Lua Examples
		#### Example 1
		Click on the "Table" choice.
		
		```lua 
		local choice = DP:CreateRow( "Choices", "Combo #2: Custom default text" )
		choice:Setup( "Combo", "Select type..." )
		choice:AddChoice( "Table", {} )
		choice:AddChoice( "Function", function() end )
		choice:AddChoice( "String", "Hello world" )
		choice.DataChanged = function( self, data )
		
		   print( "You selected: ", data )
		
		end
		```
		**Output:**
		
		You selected: table: 0x8e05f3b8
    **/
    
     
    function DataChanged(data:Dynamic):Void;
    /**
        Set the selected option.
		
		Name | Description
		--- | ---
		`Id` | Id of the choice to be selected.
		
		
		___
		### Lua Examples
		#### Example 1
		Set the second option selected.
		
		```lua 
		local choice = DP:CreateRow( "Choices", "Hello world" )
		choice:Setup( "Combo" )
		choice:AddChoice( "Choice #1", {} )
		choice:AddChoice( "Choice #2", 8 )
		choice:AddChoice( "Choice #3", "Hello world", true )
		choice:SetSelected( 2 ) -- Even if "Choice #3" is selected by default, "Choice #2" will be selected.
		```
    **/
    
     
    function SetSelected(Id:Float):Void;
    /**
        Add a choice to your combo control.
		
		Name | Description
		--- | ---
		`Text` | Shown text.
		`data` | Stored Data.
		`select` | Select this element?
		
		
		___
		### Lua Examples
		#### Example 1
		Set the "I am selected" option selected.
		
		```lua 
		local choice = DP:CreateRow( "Choices", "Hello world" )
		choice:Setup( "Combo" )
		choice:AddChoice( "I am a choice", {} )
		choice:AddChoice( "I am selected", 8, true )
		choice:AddChoice( "I am not selected", "Hello world" )
		```
    **/
    
     
    function AddChoice(Text:String, data:Dynamic, ?select:Bool):Void;
    
}



#end