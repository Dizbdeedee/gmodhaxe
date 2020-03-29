package gmod.panels;
#if client

/**
    Used to show an icon for any of the Garry's Mod Steam achievements. 
	
	If the viewer has not unlocked the achievement on Steam, the icon will be grayed out.
**/
extern class AchievementIcon extends Panel {
    /**
        Sets the achievement to be displayed by AchievementIcon.
		
		Name | Description
		--- | ---
		`id` | Achievement number ID
    **/
    
     
    function SetAchievement(id:Float):Void;
    
}



#end