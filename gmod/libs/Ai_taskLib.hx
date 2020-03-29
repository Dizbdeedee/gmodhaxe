package gmod.libs;
#if server

/**
    Used to create tasks for scripted NPCs.
**/
@:native("_G.ai_task")extern class Ai_taskLib {
    
    /**
        Create a new empty task. Used by Schedule:AddTask and Schedule:EngTask.
		
		`**Returns:** The new task object.
    **/
    
    public static function New():Task;
    
    

}



#end