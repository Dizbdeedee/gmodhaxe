package gmod.panels;
#if client

/**
    A SpawnIcon displays an image for the given model path. It is mostly used in the Spawn Menu (Q).
**/
extern class SpawnIcon extends DButton {
    /**
        Causes a SpawnIcon to rebuild its model image.
    **/
    
     
    function RebuildSpawnIcon():Void;
    /**
        Sets the model to be displayed by [SpawnIcon](https://wiki.garrysmod.com/page/Category:SpawnIcon).
		
		**Note:** This must be called after setting size if you wish to use a different size spawnicon
		
		Name | Description
		--- | ---
		`ModelPath` | The path of the model to set
		`skin` | The skin to set
		`bodygroups` | The body groups to set. Each single-digit number in the string represents a separate bodygroup, up to 9 in total.
    **/
    
     
    function SetModel(ModelPath:String, ?skin:Float, ?bodygroups:String):Void;
    /**
        Re-renders a spawn icon with customized cam data. 
		
		PositionSpawnIcon can be used to easily calculate the necessary camera parameters.
		
		**Note:** This function does not accept the standard CamData structure.
		
		Name | Description
		--- | ---
		`data` | A four-membered table containing the information needed to re-render: Vector cam_pos - The relative camera position the model is viewed from. Angle cam_ang - The camera angle the model is viewed from. number cam_fov - The camera's field of view (FOV). Entity ent - The entity object of the model. See the example below for how to retrieve these values.
		
		
		___
		### Lua Examples
		#### Example 1
		The RenderIcon method used by IconEditor. SpawnIcon is a SpawnIcon and ModelPanel is a DAdjustableModelPanel.
		
		```lua 
		function PANEL:RenderIcon()
		    
		    local ent = self.ModelPanel:GetEntity()
		    
		    local tab = {}
		    tab.ent        = ent
		    tab.cam_pos = self.ModelPanel:GetCamPos()
		    tab.cam_ang = self.ModelPanel:GetLookAng()
		    tab.cam_fov = self.ModelPanel:GetFOV()
		
		    self.SpawnIcon:RebuildSpawnIconEx( tab )
		end
		```
    **/
    
     
    function RebuildSpawnIconEx(data:AnyTable):Void;
    /**
        Sets the .png image to be displayed on a [SpawnIcon](https://wiki.garrysmod.com/page/Category:SpawnIcon) or the panel it is based on [ModelImage](https://wiki.garrysmod.com/page/Category:ModelImage). Only .png images can be used with this function.
		
		Name | Description
		--- | ---
		`icon` | A path to the .png material, for example one of the Silkicons shipped with the game.
    **/
    
     
    function SetSpawnIcon(icon:String):Void;
    
}



#end