package gmod.libs;
#if server

/**
    Allows you to set up a schedule for NPCs to follow. This lets you dictate their actions.
**/
@:native("_G.ai_schedule")extern class Ai_scheduleLib {
    
    /**
        Creates a schedule for scripted NPC.
		
		Name | Description
		--- | ---
		`name` | Name of the schedule.
		
		
		`**Returns:** A table containing schedule information to be used with ENTITY: StartSchedule.
    **/
    
    public static function New(name:String):AnyTable;
    
    

}



#end