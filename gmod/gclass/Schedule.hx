package gmod.gclass;
#if server

/**
    The object returned by ai_schedule.New.
**/
extern class Schedule {
    
    /**
        Returns the number of tasks in the schedule.
		
		`**Returns:** The number of tasks in this schedule.
    **/
    
    public function NumTasks():Float;
    
    
    /**
        Adds a task to the schedule. See also Schedule:AddTaskEx if you wish to customize task start and run function names. 
		
		See also ENTITY:StartSchedule, NPC:StartEngineTask, and NPC:RunEngineTask.
		
		Name | Description
		--- | ---
		`taskname` | Custom task name
		`taskdata` | Task data to be passed into the NPC's functions
		
		
		___
		### Lua Examples
		#### Example 1
		This creates a new schedule with a task named "HelloWorld" that is defined to print the taskdata passed in.
		
		```lua 
		local schdHello = ai_schedule.New( "SayHello" )
		schdHello:AddTask( "HelloWorld", "HELLO" )
		
		-- Called when the task is initiated (started)
		function ENT:TaskStart_HelloWorld( data )
		    print(data)
		
		    -- Set a variable that is 5 seconds in the future so the task can complete when we tick past it
		    self.TaskEndTime = CurTime() + 5
		end
		
		-- Called every think until the task is completed
		function ENT:Task_HelloWorld(data)
		    print( data, "again" )
		
		    -- Check if the 5 seconds have passed
		    if CurTime() < self.TaskEndTime then
		        self:TaskComplete()
		    end
		end
		```
		**Output:**
		
		Prints "HELLO" in the console, then prints "HELLO again" on every NPC think until 5 seconds have passed.
    **/
    
    public function AddTask(taskname:String, taskdata:Dynamic):Void;
    
    
    /**
        Adds a task to the schedule with completely custom function names. 
		
		See also Schedule:AddTask.
		
		Name | Description
		--- | ---
		`start` | The full name of a function on the entity's table to be ran when the task is started.
		`run` | The full name of a function on the entity's table to be ran when the task is continuously running.
		`data` | Task data to be passed into the NPC's functions
    **/
    
    public function AddTaskEx(start:String, run:String, data:Float):Void;
    
    
    /**
        ***INTERNAL** 
		
		Initialises the Schedule. Called by [ai_schedule](https://wiki.garrysmod.com/page/Category:ai_schedule). [New](https://wiki.garrysmod.com/page/ai_schedule/New) when the Schedule is created.
		
		Name | Description
		--- | ---
		`debugName` | The name passed from ai_schedule. New.
    **/
    @:deprecated("INTERNAL")
    public function Init(debugName:String):Void;
    
    
    /**
        Adds an engine task to the schedule.
		
		Name | Description
		--- | ---
		`taskname` | Task name, see ai_task.h
		`taskdata` | Task data, can be a float.
    **/
    
    public function EngTask(taskname:String, taskdata:Float):Void;
    
    
    /**
        Returns the task at the given index.
		
		Name | Description
		--- | ---
		`num` | Task index.
    **/
    
    public function GetTask(num:Float):Void;
    
    
}



#end