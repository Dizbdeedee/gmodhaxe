package gmod.panels;
#if client

/**
    A checkbox panel similar to DCheckBox and DImageButton with customizable checked state image. 
	
	Uses the Material panel internally. Can't have a label.
	
	**Note:** Will error if no material was set.
**/
extern class ImageCheckBox extends Button {
    /**
        Sets the material that will be visible when the ImageCheckBox is checked. 
		
		Internally calls Material:SetMaterial.
		
		**Note:** Will error if no material was set.
		
		Name | Description
		--- | ---
		`mat` | The file path of the material to set (relative to "garrysmod/materials/").
    **/
    
     
    function SetMaterial(mat:String):Void;
    /**
        Sets the checked state of the checkbox. 
		
		Checked state can be obtained via ImageCheckBox:GetChecked
		
		Name | Description
		--- | ---
		`bOn` | true for checked, false otherwise
    **/
    
     
    function SetChecked(bOn:Bool):Void;
    /**
        Sets the checked state of the checkbox. 
		
		Checked state can be obtained by ImageCheckBox.State.
		
		Name | Description
		--- | ---
		`OnOff` | true for checked, false otherwise
    **/
    
     
    function Set(OnOff:Bool):Void;
    /**
        Returns the checked state of the ImageCheckBox
		
		`**Returns:** true for checked, false otherwise
    **/
    
     
    function GetChecked():Bool;
    
}



#end