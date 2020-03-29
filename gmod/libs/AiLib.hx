package gmod.libs;
#if server

/**
    The ai library.
**/
@:native("_G.ai")extern class AiLib {
    
    /**
        Translates a schedule name to its corresponding ID.
		
		Name | Description
		--- | ---
		`sched` | Then schedule name. In most cases, this will be the same as the SCHED_ Enums name.
		
		
		`**Returns:** The schedule ID, see SCHED_ Enums. Returns -1 if the schedule name isn't valid.
    **/
    
    public static function GetScheduleID(sched:SCHED):SCHED;
    
    
    /**
        Translates a task name to its corresponding ID.
		
		Name | Description
		--- | ---
		`task` | The task name.
		
		
		`**Returns:** The task ID, see ai_task.h. Returns -1 if the schedule name isn't valid.
    **/
    
    public static function GetTaskID(task:String):Float;
    
    

}



#end