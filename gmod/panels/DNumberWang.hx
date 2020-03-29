package gmod.panels;
#if client

/**
    DNumberWang is a VGUI element that allows you to input a numeric value using up and down arrows or direct entry.
**/
extern class DNumberWang extends DTextEntry {
    /**
        Sets the minimum numeric value allowed by the number selector.
		
		Name | Description
		--- | ---
		`min` | The minimum value.
    **/
    
     
    function SetMin(min:Float):Void;
    /**
        Internal function which is called when the number selector value is changed. This function is empty by default so it needs to be overridden in order to provide functionality.
		
		Name | Description
		--- | ---
		`val` | The new value of the number selector.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a panel with two number selectors that play a male question sound byte and a female answer sound byte based on the new value of each number selector.
		
		```lua 
		-- Background panel
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetPos(20, 20)
		BGPanel:SetSize(100, 55)
		
		-- Statement label
		local lbl1 = vgui.Create("DLabel", BGPanel)
		lbl1:SetPos(5, 5)
		lbl1:SetSize(100, 20)
		lbl1:SetText("Statement: ")
		lbl1:SetColor(Color(64, 64, 255))
		
		-- Response label
		local lbl2 = vgui.Create("DLabel", BGPanel)
		lbl2:SetPos(5, 30)
		lbl2:SetSize(100, 20)
		lbl2:SetText("Response: ")
		lbl2:SetColor(Color(255, 0, 255))
		
		-- Number selector for "questions"
		local question = vgui.Create("DNumberWang", BGPanel)
		question:SetPos(65, 5)
		question:SetSize(30, 20)
		question:SetMinMax(1, 30)
		
		-- Number selector for answers
		local answer = vgui.Create("DNumberWang", BGPanel)
		answer:SetPos(65, 30)
		answer:SetSize(30, 20)
		answer:SetMinMax(1, 40)
		
		-- This is used to prevent overlapping talking
		local null = Sound("common/null.wav")
		
		-- Abstraction = cleaner code
		function TalkSound(snd)
		    EmitSound(snd, LocalPlayer():GetPos(), LocalPlayer():EntIndex(), CHAN_VOICE, 1, 80, 0, 100)
		end
		
		-- Play a statement based on new number
		function question:OnValueChanged(val)
		    TalkSound(null)
		    TalkSound(Sound("vo/npc/male01/question"..string.format("%02d", val)..".wav"))
		end
		
		-- Play an answer based on new number
		function answer:OnValueChanged(val)
		    TalkSound(null)
		    TalkSound(Sound("vo/npc/female01/answer"..string.format("%02d", val)..".wav"))
		end
		```
    **/
    
    @:hook 
    function OnValueChanged(val:Float):Void;
    /**
        ***Deprecated:** 
		
		Returns whatever is set by DNumberWang:SetFloatValue or 0.
		
		`**Returns:** 
    **/
    @:deprecated("")
     
    function GetFloatValue():Float;
    /**
        Resizes the panel so that its width and height fit all of the content inside.
		
		**Warning:** You must call this function AFTER setting text/font, adjusting child panels or otherwise altering the panel.
		
		**Note:** Only works on Label derived panels such as DLabel by default, and on any panel that manually implemented the Panel:SizeToContents method, such as DNumberWang and DImage.
    **/
    
     
    function SizeToContents():Void;
    /**
        Sets the maximum numeric value allowed by the number selector.
		
		Name | Description
		--- | ---
		`max` | The maximum value.
    **/
    
     
    function SetMax(max:Float):Void;
    /**
        Sets the value of the number selector based on the given fraction number.
		
		Name | Description
		--- | ---
		`val` | The fraction of the number selector's range.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets and prints out the value of a quarter, half, and three-fourths of the number selector range.
		
		```lua 
		local numinput = vgui.Create("DNumberWang")
		numinput:SetPos(5, 5)
		numinput:SetSize(90, 20)
		
		numinput:SetMinMax(0, 500)
		
		numinput:SetFraction(0.25)
		print(numinput:GetValue())
		
		numinput:SetFraction(0.5)
		print(numinput:GetValue())
		
		numinput:SetFraction(0.75)
		print(numinput:GetValue())
		```
		**Output:**
		
		125
		250
		375
    **/
    
     
    function SetFraction(val:Float):Void;
    /**
        ***Deprecated:** 
		
		This function returns the panel it is used on.
		
		`**Returns:** self
    **/
    @:deprecated("")
     
    function GetTextArea():Panel;
    /**
        Sets the value of the DNumberWang and triggers DNumberWang:OnValueChanged
		
		Name | Description
		--- | ---
		`val` | The value to set.
    **/
    
     
    function SetValue(val:Float):Void;
    /**
        Sets the minimum and maximum value allowed by the number selector.
		
		Name | Description
		--- | ---
		`min` | The minimum value.
		`max` | The maximum value.
    **/
    
     
    function SetMinMax(min:Float, max:Float):Void;
    /**
        Returns the minimum numeric value allowed by the number selector.
		
		`**Returns:** The minimum number.
    **/
    
     
    function GetMin():Float;
    /**
        Hides the number selector arrows.
    **/
    
     
    function HideWang():Void;
    /**
        Returns the maximum numeric value allowed by the number selector.
		
		`**Returns:** The maximum value.
    **/
    
     
    function GetMax():Float;
    /**
        Returns the amount of decimal places allowed in the number selector, set by DNumberWang:SetDecimals
		
		`**Returns:** The amount of decimal places allowed in the number selector.
    **/
    
     
    function GetDecimals():Float;
    /**
        Returns a fraction representing the current number selector value to number selector min/max range ratio. If argument val is supplied, that number will be computed instead.
		
		Name | Description
		--- | ---
		`val` | The fraction numerator.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints out some fractions based on a number selector with a min/max range of 0 to 255.
		
		```lua 
		local numinput = vgui.Create("DNumberWang")
		numinput:SetPos(5, 5)
		numinput:SetSize(90, 20)
		
		numinput:SetMinMax(0, 255)
		
		numinput:SetValue(64)
		
		print(numinput:GetFraction())    -- Should return ~0.25
		print(numinput:GetFraction(128))    -- Should return ~0.5
		print(numinput:GetFraction(192))    -- Should return ~0.75
		print(numinput:GetFraction(255))    -- Should return 1
		```
		**Output:**
		
		0.25098039215686
		0.50196078431373
		0.75294117647059
		1
    **/
    
     
    function GetFraction(val:Float):Void;
    /**
        ***Deprecated:** 
		
		Appears to do nothing.
		
		Name | Description
		--- | ---
		`val` | 
    **/
    @:deprecated("")
     
    function SetFloatValue(val:Float):Void;
    /**
        Returns the numeric value inside the number selector.
		
		`**Returns:** The numeric value.
    **/
    
     
    function GetValue():Float;
    /**
        Sets the amount of decimal places allowed in the number selector.
		
		Name | Description
		--- | ---
		`num` | The amount of decimal places.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the number selector to 3 decimal places and sets the value to a random number between 0 and 1.
		
		```lua 
		local numinput = vgui.Create("DNumberWang")
		numinput:SetPos(5, 5)
		numinput:SetSize(90, 20)
		numinput:SetDecimals(3)
		
		numinput:SetValue(math.random())
		```
    **/
    
     
    function SetDecimals(num:Float):Void;
    
}



#end