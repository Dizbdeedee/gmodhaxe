package gmod.sent;
#if server
class ENT_AI extends gmod.sent.ENT {
    
    var self(default,never):gmod.gclass.NPC;
	public final TYPE = "ai";

    /**
        ***INTERNAL:**  
		
		Called just before :  for "ai" type entities only. 
		
    **/
    @:deprecated
    @:hook
    private function CreateSchedulesInternal():Void {}

    /**
        Called whenever an engine schedule is being ran. 
		
		
		
    **/
    
    @:hook
    private function DoingEngineSchedule():Void {}
    
   
    /**
        Runs a Lua schedule. Runs tasks inside the schedule. 
		
		
		Name | Description
		--- | ---
		`sched` | The schedule to run.
		
		
		
    **/
    
    @:hook
    private function DoSchedule(sched:AnyTable):Void {}

    /**
        Called when the entity stops touching another entity. 
		
		
		Name | Description
		--- | ---
		`entity` | The entity which was touched.
		
		
		
        **/
        
        @:hook
    private function EndTouch(entity:Entity):Void {}

    /**
        Called whenever an engine schedule is finished. 
		
		
		
    **/
    
    @:hook
    private function EngineScheduleFinish():Void {}

     /**
        Called when an NPC's expression has finished.   
		Name | Description
		--- | ---
		`strExp` | The path of the expression.
		
		
		
    **/
        
    @:hook
    private function ExpressionFinished(strExp:String):Void {}

    /**
        Called to determine how good an NPC is at using a particular weapon. 
		
		
		Name | Description
		--- | ---
		`wep` | The weapon being used by the NPC.
		`target` | The target the NPC is attacking
		
		
		**Returns:** The number of degrees of inaccuracy in the NPC's attack.
		
		
    **/
    
    @:hook
    private function GetAttackSpread(wep:Entity, target:Entity):Float {return null;}

    /**
        Called when scripted NPC needs to check how he "feels" against another entity, such as when NPC:Disposition is called. 
		
		
		Name | Description
		--- | ---
		`ent` | The entity in question
		
		
		**Returns:** How our scripter NPC "feels" towards the entity in question. See D_ Enums.
		
		
    **/
    
    @:hook
    private function GetRelationship(ent:Entity):Float {return null;}

    /**
        Start the next task in specific schedule. 
		
		
		Name | Description
		--- | ---
		`sched` | The schedule to start next task in.
		
		
		
    **/
    
    @:hook
    private function NextTask(sched:AnyTable):Void {}

    /**
        Called each time the NPC updates its condition. 
		
		
		Name | Description
		--- | ---
		`conditionID` | The ID of condition. See NPC: ConditionName.
		
		
		
    **/
    
    @:hook
    private function OnCondition(conditionID:Float):Void {}

    /**
        Called when the entity is taking damage. 
		
		
		Name | Description
		--- | ---
		`damage` | The damage to be applied to the entity.
		
		
		___
		### Lua Examples
		#### Example 1
		All damage taken by this entity is applied twice. This will count the damage taken as two distinctive hits as opposed to just scaling it in GM:EntityTakeDamage.
		
		```lua 
		function ENT:OnTakeDamage( dmginfo )
		    -- Make sure we're not already applying damage a second time
		    -- This prevents infinite loops
		    if ( not self.m_bApplyingDamage ) then
		        self.m_bApplyingDamage = true
		        self:TakeDamageInfo( dmginfo )
		        self.m_bApplyingDamage = false
		    end
		end
		```
		
		
    **/
    
    @:hook
    private function OnTakeDamage(damage:CTakeDamageInfo):Void {}

     /**
        Called from the engine when TaskComplete is called. This allows us to move onto the next task - even when TaskComplete was called from an engine side task. 
		
		
		
    **/
    
    @:hook
    private function OnTaskComplete():Void {}

    /**
        Called from the engine every 0.1 seconds. 
		
		
		
    **/
    
    @:hook
    private function RunAI():Void {}

    /**
        Called when an engine task is ran on the entity. 
		
		
		Name | Description
		--- | ---
		`taskID` | The task ID, see ai_task.h
		`taskData` | The task data.
		
		
		**Returns:** true to prevent default action
		
		
    **/
    
    @:hook
    private function RunEngineTask(taskID:Float, taskData:Float):Bool {return null;}

    /**
        Called every think on running task. The actual task function should tell us when the task is finished. 
		
		
		Name | Description
		--- | ---
		`task` | The task to run
		
		
		
    **/
    
    @:hook
    private function RunTask(task:AnyTable):Void {}

    /**
        Called whenever a schedule is finished. 
		
		
		
    **/
    
    @:hook
    private function ScheduleFinished():Void {}

    /**
        Set the schedule we should be playing right now. 
		
		
		Name | Description
		--- | ---
		`iNPCState` | 
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a new schedule and assigns it to a scripted NPC.
		
		```lua 
		local schdTest = ai_schedule.New( "Test Schedule" )
		 
		schdTest:EngTask( "TASK_GET_PATH_TO_RANDOM_NODE",  128 )
		schdTest:EngTask( "TASK_RUN_PATH",            0   )
		schdTest:EngTask( "TASK_WAIT_FOR_MOVEMENT",        0   )
		 
		 
		function ENT:SelectSchedule()
		 
		    self:StartSchedule( schdTest )
		 
		end
		```
		**Output:**
		
		The scripted NPC will run around when spawned.
		
		
    **/
    
    @:hook
    private function SelectSchedule(iNPCState:Float):Void {}

    /**
        Sets the current task. 
		
		
		Name | Description
		--- | ---
		`task` | The task to set.
		
		
		
    **/
    
    @:hook
    private function SetTask(task:AnyTable):Void {}

    /**
        Starts an engine schedule. 
		
		
		Name | Description
		--- | ---
		`scheduleID` | Schedule ID to start. See SCHED_ Enums
		
		
		
    **/
    
    @:hook
    private function StartEngineSchedule(scheduleID:Float):Void {}

    /**
        Called when an engine task has been started on the entity. 
		
		
		Name | Description
		--- | ---
		`taskID` | Task ID to start, see ai_task.h
		`TaskData` | Task data
		
		
		**Returns:** true to stop default action
		
		
    **/
    
    @:hook
    private function StartEngineTask(taskID:Float, TaskData:Float):Bool {return null;}

    /**
        Starts a schedule previously created by ai_schedule.New. 
		
		Not to be confused with ENTITY:StartEngineSchedule or NPC:SetSchedule which start an Engine-based schedule. 
		
		 
		Name | Description
		--- | ---
		`sched` | Schedule to start.
		
		
		
    **/
    
    @:hook
    private function StartSchedule(sched:Schedule):Void {}

    /**
        Called once on starting task. 
		
		
		Name | Description
		--- | ---
		`task` | The task to start, created by ai_task. New.
		
		
		___
		### Lua Examples
		#### Example 1
		How it is defined:
		
		```lua 
		function ENT:StartTask( task )
		    task:Start( self.Entity )
		end
		```
		
		
    **/
    
    @:hook
    private function StartTask(task:Task):Void {}

    /**
        Called when the entity starts touching another entity. 
		
		
		Name | Description
		--- | ---
		`entity` | The entity which is being touched.
		
		
		
    **/
    
    @:hook
    private function StartTouch(entity:Entity):Void {}

    /**
        Returns true if the current running Task is finished. 
		
		
		**Returns:** Is the current running Task is finished or not.
		
		
    **/
    
    @:hook
    private function TaskFinished():Bool {return null;}

    /**
        Returns how many seconds we've been doing this current task 
		
		
		**Returns:** How many seconds we've been doing this current task
		
		
    **/
    
    @:hook
    private function TaskTime():Float {return null;}

    /**
        Called every tick for every entity being "touched". 
		
		See also ENTITY:StartTouch and ENTITY:EndTouch. 
		
		 
		Name | Description
		--- | ---
		`entity` | The entity that touched it.
		
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		function ENTITY:Touch(entity)
		    self:EmitSound("ambient/explosions/explode_" .. math.random(1, 9) .. ".wav")
		    self:Remove()
		end
		```
		
		
    **/
    
    @:hook
    private function Touch(entity:Entity):Void {}

    /**
        Called whenever the transmit state should be updated. 
		
		
		**Returns:** Transmit state to set, see TRANSMIT_ Enums.
		
		___
		### Lua Examples
		#### Example 1
		Entity pickup example, stops the entity from being networked after it's been picked up, and restores it once it "respawns".
		
		```lua 
		function ENT:Touch( other )
		    if ( self.NextRespawn > CurTime() ) then return end
		    
		    self.NextRespawn = CurTime() + 5
		    self:AddEFlags( EFL_FORCE_CHECK_TRANSMIT )
		end
		
		function ENT:UpdateTransmitState()
		    if ( self.NextRespawn > CurTime() ) then
		        return TRANSMIT_NEVER
		    end
		    
		    return TRANSMIT_PVS
		end
		
		function ENT:Think()
		    if ( self.NextRespawn != -1 && self.NextRespawn < CurTime() ) then
		        self.NextRespawn = -1
		        self:AddEFlags( EFL_FORCE_CHECK_TRANSMIT )
		    end
		end
		```
		
		
    **/
    
    @:hook
    private function UpdateTransmitState():Float {return null;}

    /**
        Called when another entity uses this entity, example would be a player pressing "+use" this entity. 
		
		To change how often the function is called, see Entity:SetUseType. 
		
		 
		Name | Description
		--- | ---
		`activator` | The entity that caused this input. This will usually be the player who pressed their use key
		`caller` | The entity responsible for the input. This will typically be the same as activator unless some other entity is acting as a proxy
		`useType` | Use type, see USE_ Enums.
		`value` | Any passed value.
		
		
		___
		### Lua Examples
		#### Example 1
		Kills any player that uses this entity.
		
		```lua 
		function ENT:Use( activator )
		
		    if activator:IsPlayer() then 
		
		        activator:Kill()
		
		    end
		
		end
		```
		
		
    **/
    
    @:hook
    private function Use(activator:Entity, caller:Entity, useType:Float, value:Float):Void {}

    
    





}

#end