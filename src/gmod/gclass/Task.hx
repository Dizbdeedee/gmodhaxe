package gmod.gclass;
#if server

/**
    A single AI task. Returned by ai_task.New.
**/
extern class Task {
    
    /**
        ***INTERNAL** 
		
		Starts the AI task as an NPC method.
		
		Name | Description
		--- | ---
		`target` | The NPC to start the task on.
    **/
    @:deprecated("INTERNAL")
    function Start_FName(target:NPC):Void;
    
    
    /**
        Determines if the task is an engine task (TYPE_ENGINE, 1).
    **/
    
    function IsEngineType():Void;
    
    
    /**
        Determines if the task is an NPC method-based task (TYPE_FNAME, 2).
    **/
    
    function IsFNameType():Void;
    
    
    /**
        Initialises the AI task as NPC method-based.
		
		Name | Description
		--- | ---
		`startname` | The name of the NPC method to call on task start.
		`runname` | The name of the NPC method to call on task run.
		`taskdata` | 
    **/
    
    function InitFunctionName(startname:String, runname:String, taskdata:Float):Void;
    
    
    /**
        Starts the AI task.
		
		Name | Description
		--- | ---
		`target` | The NPC to start the task on.
    **/
    
    function Start(target:NPC):Void;
    
    
    /**
        ***INTERNAL** 
		
		Initialises the AI task. Called by [ai_task](https://wiki.garrysmod.com/page/Category:ai_task).[New](https://wiki.garrysmod.com/page/ai_task/New).
    **/
    @:deprecated("INTERNAL")
    function Init():Void;
    
    
    /**
        Runs the AI task.
		
		Name | Description
		--- | ---
		`target` | The NPC to run the task on.
    **/
    
    function Run(target:NPC):Void;
    
    
    /**
        ***INTERNAL** 
		
		Runs the AI task as an NPC method. This requires the task to be of type .
		
		Name | Description
		--- | ---
		`target` | The NPC to run the task on.
    **/
    @:deprecated("INTERNAL")
    function Run_FName(target:NPC):Void;
    
    
    /**
        Initialises the AI task as an engine task.
		
		Name | Description
		--- | ---
		`taskname` | The name of the task.
		`taskdata` | 
    **/
    
    function InitEngine(taskname:String, taskdata:Float):Void;
    
    
}



#end