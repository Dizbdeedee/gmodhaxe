package gmod.panels;
#if client

/**
    A field with multiple selectable values.
**/
extern class DComboBox extends DButton {
    /**
        Selects an option within a combo box based on its table index.
		
		Name | Description
		--- | ---
		`index` | Selects the option with given index.
		
		
		___
		### Lua Examples
		#### Example 1
		A simple combo box menu which gives choices for a favorite lunch meal, including a non-preference choice which randomly chooses an option.
		
		```lua 
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetPos(20, 20)
		BGPanel:SetSize(200, 100)
		
		-- Text output
		local lbl = vgui.Create("DLabel", BGPanel)
		lbl:SetPos(10, 80)
		lbl:SetSize(180, 20)
		lbl:SetDark(true)
		lbl:SetText("You choose...")
		
		-- Combo box
		local cbox = vgui.Create("DComboBox", BGPanel)
		cbox:SetPos(5, 5)
		cbox:SetSize(190, 20)
		
		cbox:SetValue("What's your favorite lunch meal?")
		
		-- Choices
		cbox:AddChoice("BBQ Chicken")
		cbox:AddChoice("Fish and Chips")
		cbox:AddChoice("Pizza")
		cbox:AddChoice("Potato Salad")
		cbox:AddChoice("Roast Beef Sandwich")
		cbox:AddChoice("Spaghetti")
		
		-- No preference: data is set to -1
		cbox:AddChoice("I don't have a favorite.", -1)
		
		function cbox:OnSelect(index, value, data)
		
		    -- No preference? Choose a random choice
		    if(data == -1) then                
		        self:ChooseOptionID(math.random(1, 6))
		        
		    -- Otherwise update the text label with our choice
		    else
		        lbl:SetText("You choose "..value..".")
		    end
		    
		end
		```
    **/
    
     
    function ChooseOptionID(index:Float):Void;
    /**
        Selects a combo box option by its index and changes the text displayed at the top of the combo box.
		
		Name | Description
		--- | ---
		`value` | The text to display at the top of the combo box.
		`index` | The option index.
    **/
    
     
    function ChooseOption(value:String, index:Float):Void;
    /**
        Returns the currently selected option's text and data
		
		Name | Description
		--- | ---
		`a` | The option's text value.
		`b` | The option's stored data.
    **/
    
     
    function GetSelected():DComboBoxGetSelectedReturn;
    /**
        Returns an option's data based on the given index.
		
		Name | Description
		--- | ---
		`index` | The option index.
		
		
		`**Returns:** The option's data value.
    **/
    
     
    function GetOptionData(index:Float):Dynamic;
    /**
        Returns whether or not the combo box's menu is opened.
		
		`**Returns:** True if the menu is open, false otherwise.
    **/
    
     
    function IsMenuOpen():Bool;
    /**
        Called when an option in the combo box is selected.
		
		Name | Description
		--- | ---
		`index` | The index of the option for use with other DComboBox functions.
		`value` | The name of the option.
		`data` | The data assigned to the option.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a combo box that controls the color of the background panel.
		
		```lua 
		local frame = vgui.Create("DFrame")
		frame:SetSize( 500, 500 )
		frame:Center()
		frame:MakePopup()
		
		-- Background panel
		local BGPanel = vgui.Create( "DPanel", frame )
		BGPanel:Dock( FILL )
		
		local cbox = vgui.Create( "DComboBox", BGPanel )
		cbox:SetPos( 5, 5 )
		cbox:SetSize( 190, 20 )
		cbox:SetValue( "Pick a color" ) -- Default text
		
		-- Color choices
		cbox:AddChoice( "Red", Color( 255, 0, 0 ) )
		cbox:AddChoice( "Orange", Color( 255, 128, 0 ) )
		cbox:AddChoice( "Yellow", Color( 255, 255, 0 ) )
		cbox:AddChoice( "Green", Color( 0, 255, 0 ) )
		cbox:AddChoice( "Blue", Color( 0, 0, 255 ) )
		cbox:AddChoice( "Indigo", Color( 64, 0, 255 ) )
		cbox:AddChoice( "Violet", Color( 128, 0, 255 ) )
		cbox:AddChoice( "Pink", Color( 255, 0, 255 ) )
		
		function cbox:OnSelect( index, text, data )
		
		    -- Set background panel color
		    BGPanel:SetBackgroundColor( data )
		
		end
		```
    **/
    
    @:hook 
    function OnSelect(index:Float, value:String, data:Dynamic):Void;
    /**
        Closes the combo box menu. Called when the combo box is clicked while open.
    **/
    
     
    function CloseMenu():Void;
    /**
        Sets the text shown in the combo box when the menu is not collapsed.
		
		Name | Description
		--- | ---
		`value` | The text in the DComboBox.
		
		
		___
		### Lua Examples
		#### Example 1
		A simple feedback combo box which has the value set to a thank you message once a choice is clicked.
		
		```lua 
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetPos(20, 20)
		BGPanel:SetSize(200, 30)
		
		local cbox = vgui.Create("DComboBox", BGPanel)
		cbox:SetPos(5, 5)
		cbox:SetSize(190, 20)
		
		cbox:SetValue("What do you think of this server?")
		
		-- Responses
		cbox:AddChoice("It's the best server of all time!")
		cbox:AddChoice("It's pretty good.")
		cbox:AddChoice("It's okay.")
		cbox:AddChoice("It's not that good.")
		cbox:AddChoice("Don't bother me with this.")
		
		function cbox:OnSelect(index, value, data)
		
		    -- Clear combo box and set a thank you message
		    self:Clear()
		    self:SetText("Thank you for your feedback!")
		    
		    -- Here you would send the feedback to the server using a net message
		    -- The choice is stored in the 'data' variable
		
		end
		```
    **/
    
     
    function SetValue(value:String):Void;
    /**
        Sets whether or not the items should be sorted alphabetically in the dropdown menu of the DComboBox. If set to false, items will appear in the order they were added by DComboBox:AddChoice calls. 
		
		This is enabled by default.
		
		Name | Description
		--- | ---
		`sort` | true to enable, false to disable
    **/
    
     
    function SetSortItems(sort:Bool):Void;
    /**
        Returns an option's text based on the given data.
		
		Name | Description
		--- | ---
		`data` | The data to look up the name of. If given a number and no matching data was found, the function will test given data against each tonumber'd data entry.
		
		
		`**Returns:** The option's text value. If no matching data was found, the data itself will be returned. If multiple identical data entries exist, the first instance will be returned.
    **/
    
     
    function GetOptionTextByData(data:String):String;
    /**
        Returns the index (ID) of the currently selected option.
		
		`**Returns:** The ID of the currently selected option.
    **/
    
     
    function GetSelectedID():Float;
    /**
        Clears the combo box's text value, choices, and data values.
    **/
    
     
    function Clear():Void;
    /**
        Returns an whether the items in the dropdown will be alphabetically sorted or not. 
		
		See DComboBox:SetSortItems.
		
		`**Returns:** True if enabled, false otherwise.
    **/
    
     
    function GetSortItems():Bool;
    /**
        Returns an option's text based on the given index.
		
		Name | Description
		--- | ---
		`index` | The option index.
		
		
		`**Returns:** The option's text value.
		
		___
		### Lua Examples
		#### Example 1
		Create a combo box listing some colors and print the 3rd option's text.
		
		```lua 
		local cbox = vgui.Create("DComboBox")
		cbox:SetPos(5, 5)
		cbox:SetSize(200, 20)
		
		cbox:SetValue("Colors")
		cbox:AddChoice("Red")
		cbox:AddChoice("Green")
		cbox:AddChoice("Blue")
		cbox:AddChoice("Yellow")
		
		print(cbox:GetOptionText(3))
		```
		**Output:**
		
		Blue
    **/
    
     
    function GetOptionText(index:Float):String;
    /**
        Opens the combo box drop down menu. Called when the combo box is clicked.
    **/
    
     
    function OpenMenu():Void;
    /**
        Adds a choice to the combo box.
		
		Name | Description
		--- | ---
		`value` | The text show to the user.
		`data` | The data accompanying this string. If left empty, the value argument is used instead. Can be accessed with the second argument of DComboBox: GetSelected, DComboBox: GetOptionData and as an argument of DComboBox: OnSelect.
		`select` | Should this be the default selected text show to the user or not.
		`icon` | Adds an icon for this choice.
		
		
		`**Returns:** The index of the new option.
    **/
    
     
    function AddChoice(value:String, ?data:Dynamic, ?select:Bool, ?icon:Panel):Float;
    
}


@:multiReturn extern class DComboBoxGetSelectedReturn {
var a:String;
var b:Dynamic;

}

#end