package gmod.gclass;


/**
    This is a list of all methods only available for NPCs. It is also possible to call Entity functions on NPCs.
**/
extern class NPC extends Entity {
    #if server
    /**
        Sets the hull type for the NPC.
		
		Name | Description
		--- | ---
		`hullType` | Hull type. See HULL_ Enums
    **/
    
    public function SetHullType(hullType:HULL):Void;
    #end
    #if server
    /**
        Resets the NPC's movement animation and velocity. Does not actually stop the NPC from moving.
    **/
    
    public function StopMoving():Void;
    #end
    #if server
    /**
        Sets an NPC condition.
		
		Name | Description
		--- | ---
		`condition` | The condition index, see COND_ Enums.
		
		
		___
		### Lua Examples
		#### Example 1
		Freezes an NPC for a period of time.
		
		```lua 
		COND_NPC_UNFREEZE = 68    -- Delete this line when COND_ enums are added
		
		function FreezeNPCTemporarily(npc, delay)
		    
		    if(!IsValid(npc)) then return end
		    
		    delay = delay or 1
		    
		    npc:SetSchedule(SCHED_NPC_FREEZE)
		
		    timer.Simple(delay, function()
		        if(IsValid(npc)) then npc:SetCondition(COND_NPC_UNFREEZE) end
		    end)
		    
		end
		```
    **/
    
    public function SetCondition(condition:COND):Void;
    #end
    #if server
    /**
        Forces the NPC to play a sentence from scripts/sentences.txt
		
		Name | Description
		--- | ---
		`sentence` | The sentence string to speak.
		`delay` | Delay in seconds until the sentence starts playing.
		`volume` | The volume of the sentence, from 0 to 1.
		
		
		`**Returns:** Returns the sentence index, -1 if the sentence couldn't be played.
    **/
    
    public function PlaySentence(sentence:String, delay:Float, volume:Float):Float;
    #end
    #if server
    /**
        Returns NPCs hull type set by NPC:SetHullType.
		
		`**Returns:** Hull type, see HULL_ Enums
    **/
    
    public function GetHullType():HULL;
    #end
    #if server
    /**
        Sets the NPC's current schedule.
		
		Name | Description
		--- | ---
		`schedule` | The NPC schedule, see SCHED_ Enums.
		
		
		___
		### Lua Examples
		#### Example 1
		Function which forces an NPC to walk to an entity.
		
		```lua 
		function NPCMoveTo(npc, ent)
		
		    if(!IsValid(npc) or !IsValid(ent)) then return end
		        
		    npc:SetSaveValue("m_vecLastPosition", ent:GetPos())
		    npc:SetSchedule(SCHED_FORCED_GO)
		    
		end
		```
    **/
    
    public function SetSchedule(schedule:SCHED):Void;
    #end
    #if server
    /**
        Clears the current NPC goal or target.
    **/
    
    public function ClearGoal():Void;
    #end
    #if server
    /**
        Only usable on "ai" base entities.
		
		`**Returns:** If we succeeded setting the behavior.
    **/
    
    public function UseFollowBehavior():Bool;
    #end
    #if server
    /**
        Returns whether the entity given can be reached by this NPC.
		
		Name | Description
		--- | ---
		`testEntity` | The entity to test.
		
		
		`**Returns:** If the entity is reachable or not.
    **/
    
    public function IsUnreachable(testEntity:Entity):Bool;
    #end
    #if server
    /**
        Forces the NPC to start an engine task, this has different results for every NPC.
		
		Name | Description
		--- | ---
		`task` | The id of the task to start, see ai_task.h
		`taskData` | The task data as a float, not all tasks make use of it.
    **/
    
    public function StartEngineTask(task:Float, taskData:Float):Void;
    #end
    #if server
    /**
        Remove a certain capability.
		
		Name | Description
		--- | ---
		`capabilities` | Capabilities to remove, see CAP_ Enums
		
		
		___
		### Lua Examples
		#### Example 1
		Removes the CAP_USE_SHOT_REGULATOR capability, if the NPC has it.
		
		```lua 
		self:CapabilitiesRemove(CAP_USE_SHOT_REGULATOR)
		```
    **/
    
    public function CapabilitiesRemove(capabilities:CAP):Void;
    #end
    #if server
    /**
        Stops any sounds (speech) the NPC is currently palying. 
		
		Equivalent to
    **/
    
    public function SentenceStop():Void;
    #end
    #if server
    /**
        Causes the NPC to temporarily forget the current enemy and switch on to a better one.
    **/
    
    public function MarkEnemyAsEluded():Void;
    #end
    #if server
    /**
        Adds a capability to the NPC.
		
		Name | Description
		--- | ---
		`capabilities` | Capabilities to add, see CAP_ Enums
		
		
		___
		### Lua Examples
		#### Example 1
		Adds the CAP_USE_SHOT_REGULATOR to the NPC's capabilities.
		
		```lua 
		self:CapabilitiesAdd(CAP_USE_SHOT_REGULATOR)
		```
    **/
    
    public function CapabilitiesAdd(capabilities:CAP):Void;
    #end
    #if server
    /**
        Returns the amount of time it will take for the NPC to get to its Target Goal.
		
		`**Returns:** The amount of time to get to the target goal.
    **/
    
    public function GetPathTimeToGoal():Float;
    #end
    #if server
    /**
        
    **/
    
    public function SetArrivalSequence():Void;
    #end
    #if server
    /**
        Sets the NPC's .vcd expression. Similar to Entity:PlayScene except the scene is looped until it's interrupted by default NPC behavior or NPC:ClearExpression.
		
		Name | Description
		--- | ---
		`expression` | The expression filepath.
		
		
		`**Returns:** 
		
		___
		### Lua Examples
		#### Example 1
		Function which makes the NPC whom the player is looking at repeat an annoying scene.
		
		```lua 
		function GrenadesScene(ply)
		
		    if(!IsValid(ply)) then return end
		    
		    local npc = ply:GetEyeTrace().Entity
		    
		    if(IsValid(npc) && npc:IsNPC()) then
		        npc:SetExpression("scenes/streetwar/sniper/ba_nag_grenade0"..math.random(1, 5)..".vcd")
		    end
		    
		end
		```
    **/
    
    public function SetExpression(expression:String):Float;
    #end
    #if server
    /**
        Returns the NPC's state.
		
		`**Returns:** The NPC's current state, see NPC_STATE_ Enums.
		
		___
		### Lua Examples
		#### Example 1
		Function which prints out a list of idle NPCs to the server console.
		
		```lua 
		function ReportIdleNPCs()
		
		    for _, npc in pairs(ents.FindByClass("npc_*")) do
		    
		        if(IsValid(npc) && npc:IsNPC() &&
		            npc:GetNPCState() == NPC_STATE_IDLE) then
		        
		            print("Ent #"..npc:EntIndex()..": "..npc:GetClass().." is idle.")
		            
		        end
		        
		    end
		
		end
		```
		**Output:**
		
		(To server console) Ent #111: npc_citizen is idle. Ent #120: npc_citizen is idle. Ent #122: npc_citizen is idle. Ent #124: npc_citizen is idle.
    **/
    
    public function GetNPCState():NPC_STATE;
    #end
    #if server
    /**
        Checks if the NPC is running an ai_goal. ( e.g. An npc_citizen NPC following the Player. )
		
		`**Returns:** Returns true if running an ai_goal, otherwise returns false.
    **/
    
    public function IsRunningBehavior():Bool;
    #end
    
    /**
        Returns the weapon the NPC is currently carrying, or NULL.
		
		`**Returns:** The NPCs current weapon
    **/
    
    public function GetActiveWeapon():Entity;
    
    #if server
    /**
        Returns the NPC's current schedule.
		
		`**Returns:** The NPCs schedule, see SCHED_ Enums or -1 if we failed for some reason
    **/
    
    public function GetCurrentSchedule():SCHED;
    #end
    #if server
    /**
        Makes the NPC walk toward the given position. The NPC will return to the player after amount of time set by player_squad_autosummon_time ConVar. 
		
		Only works on Citizens (npc_citizen) and is a part of the Half-Life 2 squad system. 
		
		 The NPC must be in the player's squad for this to work.
		
		Name | Description
		--- | ---
		`position` | The target position for the NPC to walk to.
		
		
		___
		### Lua Examples
		#### Example 1
		A console command that makes all Citizens on the map (if they are in the player's squad) try to go to where the player is looking at.
		
		```lua 
		concommand.Add( "movenpcs", function( ply )
		    for id, npc in pairs( ents.FindByClass( "npc_citizen" ) ) do
		        npc:MoveOrder( ply:GetEyeTrace().HitPos )
		    end
		end )
		```
    **/
    
    public function MoveOrder(position:Vector):Void;
    #end
    #if server
    /**
        Force an NPC to play its FoundEnemy sound.
    **/
    
    public function FoundEnemySound():Void;
    #end
    #if server
    /**
        Makes the NPC like, hate, feel neutral towards, or fear the entity in question. If you want to setup relationship towards a certain entity class, use NPC:AddRelationship.
		
		Name | Description
		--- | ---
		`target` | The entity for the relationship to be applied to.
		`disposition` | A D_ Enums representing the relationship type.
		`priority` | How strong the relationship is.
		
		
		___
		### Lua Examples
		#### Example 1
		Spawns a manhack and makes it fear player 1.
		
		```lua 
		local hack = ents.Create( "npc_manhack" )
		hack:Spawn()
		hack:AddEntityRelationship( player.GetByID(1), D_FR, 99 )
		```
		
		#### Example 2
		Find wanted NPC class name and make them hate the entity.
		
		```lua 
		function ENT:Think()
		local enemy = ents.FindByClass("npc_*") --Find any spawned entity in map with class beginning at npc
		    for _, x in pairs(enemy) do --for every found entity do
		       if !x:IsNPC() then return end -- if found entity is not NPC then do nothing 
		       if x:GetClass() != self:GetClass() then -- if found entity is not self entity then continue
		        x:AddEntityRelationship( self, D_HT, 99 ) -- found entity will hate self entity
		        self:AddEntityRelationship( x, D_HT, 99 ) -- self entity will hate found entity          
		       end
		    end 
		end
		```
    **/
    
    public function AddEntityRelationship(target:Entity, disposition:D, priority:Float):Void;
    #end
    #if server
    /**
        Force an NPC to play his Idle sound.
    **/
    
    public function IdleSound():Void;
    #end
    #if server
    /**
        ***Deprecated:** 
		
		This function crashes the game no matter how it is used and will be removed in a future update. 
		
		Use NPC:ClearEnemyMemory instead.
    **/
    @:deprecated("")
    public function RemoveMemory():Void;
    #end
    #if server
    /**
        
		
		`**Returns:** 
    **/
    
    public function GetArrivalSequence():Float;
    #end
    #if server
    /**
        Starts an engine task. 
		
		Used internally by the ai_task library.
		
		Name | Description
		--- | ---
		`taskID` | The task ID, see ai_task.h
		`taskData` | The task data.
    **/
    
    public function RunEngineTask(taskID:Float, taskData:Float):Void;
    #end
    #if server
    /**
        Makes an NPC exit a scripted sequence, if one is playing.
    **/
    
    public function ExitScriptedSequence():Void;
    #end
    #if server
    /**
        
		
		`**Returns:** 
    **/
    
    public function UseLeadBehavior():Bool;
    #end
    #if server
    /**
        Only usable on "ai" base entities.
		
		`**Returns:** If we succeeded setting the behavior.
    **/
    
    public function UseActBusyBehavior():Bool;
    #end
    #if server
    /**
        Returns the way the NPC "feels" about the entity.
		
		Name | Description
		--- | ---
		`ent` | The entity to get the disposition from.
		
		
		`**Returns:** The NPCs disposition, see D_ Enums.
		
		___
		### Lua Examples
		#### Example 1
		If a player is hurt by a friendly NPC, announce it.
		
		```lua 
		function FriendlyFireAnnouncement( ply, atk )
		   if atk:IsNPC() and atk:Disposition(ply) == D_LI then --like
		      PrintMessage("A "..atk:GetClass().." attacked "..ply:Nick().."!", HUD_PRINTTALK)
		   end
		end
		
		hook.Add( "PlayerHurt", "FriendlyFire", FriendlyFireAnnouncement )
		```
		**Output:**
		
		Prints "A ____ attacked ____!" to everyones chat.
    **/
    
    public function Disposition(ent:Entity):D;
    #end
    #if server
    /**
        Returns the NPC's current movement activity.
		
		`**Returns:** Current NPC movement activity, see ACT_ Enums.
    **/
    
    public function GetMovementActivity():ACT;
    #end
    #if server
    /**
        Returns the NPC class. Do not confuse with Entity:GetClass!
		
		`**Returns:** See CLASS_ Enums
    **/
    
    public function Classify():CLASS;
    #end
    #if server
    /**
        Returns the expression file the NPC is currently playing.
		
		`**Returns:** The file path of the expression.
    **/
    
    public function GetExpression():String;
    #end
    #if server
    /**
        Sets a goal in x, y offsets for the npc to wander to
		
		Name | Description
		--- | ---
		`xoffset` | X offset
		`yoffset` | Y offset
		
		
		___
		### Lua Examples
		#### Example 1
		Given an npc makes them wander to a location 100 units in both the x and y directions
		
		```lua 
		if npc:IsValid() then
		    npc:NavSetWanderGoal(100, 100)
		    npc:SetSchedule(SCHED_IDLE_WANDER)
		end
		```
    **/
    
    public function NavSetWanderGoal(xoffset:Float, yoffset:Float):Void;
    #end
    #if server
    /**
        Returns the activity to be played when the NPC arrives at its goal
		
		`**Returns:** 
    **/
    
    public function GetArrivalActivity():Float;
    #end
    #if server
    /**
        Clears the NPC's current expression which can be set with NPC:SetExpression.
    **/
    
    public function ClearExpression():Void;
    #end
    #if server
    /**
        Cancels NPC:MoveOrder basically. 
		
		Only works on Citizens (npc_citizen) and is a part of the Half-Life 2 squad system. 
		
		 The NPC must be in the player's squad for this to work.
		
		Name | Description
		--- | ---
		`target` | Must be a player, does nothing otherwise.
		
		
		___
		### Lua Examples
		#### Example 1
		A console command that once used cancels Move Orders and makes the NPCs return to the player.
		
		```lua 
		concommand.Add( "targetnpcs", function( ply )
		    for id, npc in pairs( ents.FindByClass( "npc_citizen" ) ) do
		        npc:TargetOrder( ply )
		    end
		end )
		```
    **/
    
    public function TargetOrder(target:Entity):Void;
    #end
    #if server
    /**
        Removes all of Capabilities the NPC has.
		
		___
		### Lua Examples
		#### Example 1
		Removes all of the Capabilities that the NPC has.
		
		```lua 
		self:CapabilitiesClear()
		```
    **/
    
    public function CapabilitiesClear():Void;
    #end
    #if server
    /**
        Returns whether or not the NPC has the given condition.
		
		Name | Description
		--- | ---
		`condition` | The condition index, see COND_ Enums.
		
		
		`**Returns:** True if the NPC has the given condition, false otherwise.
		
		___
		### Lua Examples
		#### Example 1
		Function that prints a list of conditions an NPC has.
		
		```lua 
		function ListConditions(npc)
		    
		    if(!IsValid(npc)) then return end
		    
		    print(npc:GetClass().." ("..npc:EntIndex()..") has conditions:")
		    
		    for c = 0, 100 do
		    
		        if(npc:HasCondition(c)) then
		        
		            print(npc:ConditionName(c))
		            
		        end
		        
		    end
		    
		end
		```
		**Output:**
		
		(To server console): npc_antlion (120) has conditions: COND_IN_PVS COND_NO_WEAPON COND_HAVE_ENEMY_LOS COND_TOO_FAR_TO_ATTACK COND_NO_HEAR_DANGER COND_FLOATING_OFF_GROUND
    **/
    
    public function HasCondition(condition:COND):Bool;
    #end
    #if server
    /**
        Returns the index of the sequence the NPC uses to move.
		
		`**Returns:** The movement sequence index
    **/
    
    public function GetMovementSequence():Float;
    #end
    #if server
    /**
        Force the NPC to update information on the supplied enemy, as if it had line of sight to it.
		
		Name | Description
		--- | ---
		`enemy` | The enemy to update.
		`pos` | The last known position of the enemy.
    **/
    
    public function UpdateEnemyMemory(enemy:Entity, pos:Vector):Void;
    #end
    #if server
    /**
        
    **/
    
    public function SetArrivalSpeed():Void;
    #end
    #if server
    /**
        Force an NPC to play his LostEnemy sound.
    **/
    
    public function LostEnemySound():Void;
    #end
    #if server
    /**
        
		
		`**Returns:** 
    **/
    
    public function UseAssaultBehavior():Bool;
    #end
    #if server
    /**
        Returns the aim vector of the NPC. NPC alternative of Player:GetAimVector.
		
		`**Returns:** The aim direction of the NPC.
    **/
    
    public function GetAimVector():Vector;
    #end
    #if server
    /**
        Tries to achieve our ideal animation state, playing any transition sequences that we need to play to get there.
    **/
    
    public function MaintainActivity():Void;
    #end
    #if server
    /**
        Returns the NPC's capabilities along the ones defined on its weapon.
		
		`**Returns:** The capabilities as a bitflag. See CAP_ Enums
    **/
    
    public function CapabilitiesGet():CAP;
    #end
    #if server
    /**
        Clears out the specified COND_ Enums on this NPC.
		
		Name | Description
		--- | ---
		`condition` | The COND_ Enums to clear out.
    **/
    
    public function ClearCondition(condition:COND):Void;
    #end
    #if server
    /**
        Sets the last registered or memorized position for an npc. When using scheduling, the NPC will focus on navigating to the last position via nodes.
		
		**Note:** The navigation requires ground nodes to function properly, otherwise the NPC could only navigate in a small area. (https://developer.valvesoftware.com/wiki/Info_node)
		
		Name | Description
		--- | ---
		`Position` | Where the NPC's last position will be set.
		
		
		___
		### Lua Examples
		#### Example 1
		Make an NPC chase a player
		
		```lua 
		function NPCGoGoRun(npc, ply)
		    npc:SetLastPosition( ply:GetPos() )
		    npc:SetSchedule( SCHED_FORCED_GO_RUN )
		end
		```
		**Output:**
		
		The NPC will chase the player.
    **/
    
    public function SetLastPosition(Position:Vector):Void;
    #end
    #if server
    /**
        Forces the NPC to drop the specified weapon.
		
		Name | Description
		--- | ---
		`weapon` | Weapon to be dropped. If unset, will default to the currently equipped weapon.
		`target` | If set, launches the weapon at given position. There is a limit to how far it is willing to throw the weapon. Overrides velocity argument.
		`velocity` | If set and previous argument is unset, launches the weapon with given velocity. If the velocity is higher than 400, it will be clamped to 400.
		
		
		___
		### Lua Examples
		#### Example 1
		A console command that makes all NPCs on the map throw their weapons at the player who executed the console command
		
		```lua 
		concommand.Add( "dropall",function( ply )
		    for id, ent in pairs( ents.GetAll() ) do
		        if ( ent:IsNPC() ) then
		            -- Some NPCs on some maps delete their weapons when the weapon is dropped, we don't want that.
		            ent:SetKeyValue( "spawnflags", bit.band( ent:GetSpawnFlags(), bit.bnot( SF_NPC_NO_WEAPON_DROP ) ) )
		            ent:DropWeapon( nil, ply:GetPos() )
		        end
		    end
		end )
		```
    **/
    
    public function DropWeapon(?weapon:Weapon, ?target:Vector, ?velocity:Vector):Void;
    #end
    #if server
    /**
        Returns how proficient (skilled) an NPC is with its current weapon.
		
		`**Returns:** NPC's proficiency for current weapon. See WEAPON_PROFICIENCY_ Enums.
    **/
    
    public function GetCurrentWeaponProficiency():WEAPON_PROFICIENCY;
    #end
    #if server
    /**
        Sets the weapon proficiency of an NPC (how skilled an NPC is with its current weapon).
		
		Name | Description
		--- | ---
		`proficiency` | The proficiency for the NPC's current weapon. See WEAPON_PROFICIENCY_ Enums.
		
		
		___
		### Lua Examples
		#### Example 1
		Makes all NPCs suck at using their current weapons.
		
		```lua 
		for _, v in pairs( ents.FindByClass( "npc_*" ) ) do
		    v:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_POOR )
		end
		```
    **/
    
    public function SetCurrentWeaponProficiency(proficiency:WEAPON_PROFICIENCY):Void;
    #end
    #if server
    /**
        Used to give a weapon to an already spawned NPC.
		
		Name | Description
		--- | ---
		`weapon` | Class name of the weapon to equip to the NPC.
		
		
		`**Returns:** The weapon entity given to the NPC.
    **/
    
    public function Give(weapon:String):Weapon;
    #end
    #if server
    /**
        
		
		`**Returns:** 
    **/
    
    public function UseFuncTankBehavior():Bool;
    #end
    #if server
    /**
        
		
		Name | Description
		--- | ---
		`act` | 
    **/
    
    public function SetArrivalActivity(act:Float):Void;
    #end
    #if server
    /**
        Sets the distance to goal at which the NPC should stop moving and continue to other business such as doing the rest of their tasks in a schedule.
		
		Name | Description
		--- | ---
		`dist` | The distance to goal that is close enough for the NPC
    **/
    
    public function SetArrivalDistance(dist:Float):Void;
    #end
    #if server
    /**
        Undoes the other Use*Behavior functions. 
		
		Only usable on "ai" base entities.
    **/
    
    public function UseNoBehavior():Void;
    #end
    #if server
    /**
        Sets how how long to try rebuilding path before failing task.
		
		Name | Description
		--- | ---
		`time` | How long to try rebuilding path before failing task
    **/
    
    public function SetMaxRouteRebuildTime(time:Float):Void;
    #end
    #if server
    /**
        Returns whether the NPC is moving or not.
		
		`**Returns:** Whether the NPC is moving or not.
    **/
    
    public function IsMoving():Bool;
    #end
    #if server
    /**
        Returns the entity that this NPC is trying to fight.
		
		**Bug:** BUG This returns nil if the NPC has no enemy. You should use IsValid (which accounts for nil and NULL) on the return to verify validity of the enemy. Issue Tracker: #3132
		
		`**Returns:** Enemy NPC.
		
		___
		### Lua Examples
		#### Example 1
		Kill any npc that sets the first player as its enemy.
		
		```lua 
		local function Think( )
		    for k, v in pairs( ents.GetAll( ) ) do
		        if v:IsNPC( ) and v:GetEnemy( ) == Entity( 1 ) then
		            v:TakeDamage( 999 )
		        end
		    end
		end
		
		hook.Add( "Think", "Kill My Enemies", Think )
		```
		**Output:**
		
		Any npc that sets their enemy to Entity( 1 ) dies.
		
		#### Example 2
		Make every NPC that does not have an enemy (and preferably a D_HT relationship agains Players) start attacking a random Player. This code is copied from the gamemode My Base Defence:
		
		```lua 
		-- ...
		local function _SetRandomPlayerTargetForNPC(npc)
		    if (npc:IsNPC()) then
		        if (!IsValid(npc:GetEnemy())) then
		            local _allPlayers    = player.GetAll()
		            local _winnerPlNr    = math.random(1, #_allPlayers)
		
		            timer.Simple(0.15, function()
		                local __Player = _allPlayers[_winnerPlNr]
		                --
		                --- Set the enemy for the NPC, so it does not just stand there doing nothing
		                -- lika young lazy teen or something
		                if (!npc:IsValid() or !__Player:IsValid()) then return end
		                npc:SetEnemy(__Player)
		                npc:UpdateEnemyMemory(__Player, __Player:GetPos())
		                npc:SetSchedule(SCHED_SHOOT_ENEMY_COVER)
		            end)
		        end
		    end
		end
		-- - - ---
		-- --
		-- Make every NPC that might not have a target, recive one random Player..:>>
		-- (..you can place this loop inside an interval timer or something...)
		for _, v in pairs(ents.GetAll('npc_*')) do
		    if v:IsValid() then _SetRandomPlayerTargetForNPC(v) end
		end
		```
		**Output:**
		
		All NPCs on the SERVER will get their memory updated if they don't already have an enemy, and start moving to the last know position of the enemy and try to attack. This enemy will be a random Player. They will also try and shoot enemy cover.
    **/
    
    public function GetEnemy():NPC;
    #end
    #if server
    /**
        Clears the Enemy from the NPC's memory, effectively forgetting it until met again with either the NPC vision or with NPC:UpdateEnemyMemory.
    **/
    
    public function ClearEnemyMemory():Void;
    #end
    #if server
    /**
        Returns the entity blocking the NPC along its path.
		
		`**Returns:** Blocking entity
    **/
    
    public function GetBlockingEntity():Entity;
    #end
    #if server
    /**
        Returns whether or not the NPC is performing the given schedule.
		
		Name | Description
		--- | ---
		`schedule` | The schedule number, see SCHED_ Enums.
		
		
		`**Returns:** True if the NPC is performing the given schedule, false otherwise.
		
		___
		### Lua Examples
		#### Example 1
		Function which returns the schedule an NPC is performing.
		
		```lua 
		function GetNPCSchedule(npc)
		
		    if(!IsValid(npc)) then return end
		    
		    for s = 0, LAST_SHARED_SCHEDULE-1 do
		        if(npc:IsCurrentSchedule(s)) then return s end
		    end
		    
		    return 0
		    
		end
		```
    **/
    
    public function IsCurrentSchedule(schedule:SCHED):Bool;
    #end
    #if server
    /**
        Creates a random path of specified minimum length between a closest start node and random node in the specified direction.
		
		Name | Description
		--- | ---
		`minPathLength` | Minimum length of path in units
		`dir` | Unit vector pointing in the direction of the target random node
    **/
    
    public function NavSetRandomGoal(minPathLength:Float, dir:Vector):Void;
    #end
    #if server
    /**
        Returns the NPC's current target set by NPC:SetTarget.
		
		**Bug:** BUG This returns nil if the NPC has no target. You should use IsValid (which accounts for nil and NULL) on the return to verify validity of the target. Issue Tracker: #3132
		
		`**Returns:** Target entity
    **/
    
    public function GetTarget():Entity;
    #end
    #if server
    /**
        Returns the NPC's current activity.
		
		`**Returns:** Current activity, see ACT_ Enums.
    **/
    
    public function GetActivity():ACT;
    #end
    #if server
    /**
        Translates condition ID to a string.
		
		Name | Description
		--- | ---
		`cond` | The NPCs condition ID, see COND_ Enums
		
		
		`**Returns:** A human understandable string equivalent of that condition.
    **/
    
    public function ConditionName(cond:COND):String;
    #end
    #if server
    /**
        Returns the shooting position of the NPC.
		
		**Note:** This only works properly when called on an NPC that can hold weapons, otherwise it will return the same value as Entity:GetPos.
		
		`**Returns:** The NPC's shooting position.
    **/
    
    public function GetShootPos():Vector;
    #end
    #if server
    /**
        Marks the current NPC task as failed. 
		
		This is meant to be used alongside NPC:TaskComplete to complete or fail custom Lua defined tasks. (Schedule:AddTask)
		
		Name | Description
		--- | ---
		`task` | A string most likely defined as a Source Task, for more information on Tasks go to https://developer.valvesoftware.com/wiki/Task
    **/
    
    public function TaskFail(task:String):Void;
    #end
    #if server
    /**
        Sets the target for an NPC.
		
		Name | Description
		--- | ---
		`enemy` | The enemy that the NPC should target
		`newenemy` | Calls NPC: SetCondition(COND_NEW_ENEMY) if the new enemy is valid and not equal to the last enemy.
		
		
		___
		### Lua Examples
		#### Example 1
		If an NPC has no specific target, they will start to target the closest player they are hostile to, or nothing if there are none. This is run every tick on the server and can be a bottleneck if player and/or entity counts are high, so consider adding a CurTime cooldown if you plan on using this in-game.
		
		```lua 
		hook.Add( "Think", "NPCAutoSeekPlayer", function()
		    local npcs = ents.GetAll()
		    local plys = player.GetAll()
		    local plyCount = #plys
		
		    -- No point trying to give NPCs a player when there are none
		    if ( plyCount == 0 ) then
		        return
		    end
		
		    -- Loop over all entities and check for NPCs
		    for i = 1, #npcs do
		        local npc = npcs[ i ]
		
		        -- If this entity is an NPC without an enemy, give them one
		        if ( npc:IsNPC() && !IsValid( npc:GetEnemy() ) ) then
		            local curPly = nil            -- Closest player
		            local curPlyPos = nil        -- Position of closest player
		            local curDist = math.huge    -- Lowest distance between npc and player
		            
		            local npcPos = npc:GetPos()    -- Position of the NPC
		
		            -- Loop over all players to check their distance from the NPC
		            for i = 1, plyCount do
		                local ply = plys[ i ]
		
		                -- Only consider players that this NPC hates
		                if ( npc:Disposition( ply ) == D_HT ) then
		                    -- TODO: You can optimise looking up each player's position (constant)
		                    -- for every NPC by generating a table of:
		                    --- key = player identifier (entity object, UserID, EntIndex, etc.)
		                    --- value = player's position vector
		                    -- for the first NPC that passes to this part of the code,
		                    -- then reuse it for other NPCs
		                    local plyPos = ply:GetPos()
		                    
		                    -- Use DistToSqr for distance comparisons since
		                    -- it's more efficient than Distance, and the
		                    -- non-squared distance isn't needed for anything
		                    local dist = npcPos:DistToSqr( plyPos )
		
		                    -- If the new distance is lower, update the player information
		                    if ( dist < curDist ) then
		                        curPly = ply
		                        curPlyPos = plyPos
		                        curDist = dist
		                    end
		                end
		            end
		
		            -- curPly is guarenteed to be valid since this code
		            -- will only run if there is at least one player
		            npc:SetEnemy( curPly )
		            npc:UpdateEnemyMemory( curPly, curPlyPos )
		        end
		    end
		end )
		```
    **/
    
    public function SetEnemy(enemy:Entity, ?newenemy:Bool):Void;
    #end
    #if server
    /**
        Force an NPC to play his Fear sound.
    **/
    
    public function FearSound():Void;
    #end
    #if server
    /**
        Returns the distance the NPC is from Target Goal.
		
		`**Returns:** The number of hammer units the NPC is away from the Goal.
    **/
    
    public function GetPathDistanceToGoal():Float;
    #end
    #if server
    /**
        Set the goal target for an NPC.
		
		Name | Description
		--- | ---
		`target` | The targeted entity to set the goal to.
		`offset` | The offset to apply to the targeted entity's position.
    **/
    
    public function NavSetGoalTarget(target:Entity, offset:Vector):Void;
    #end
    #if server
    /**
        Sets the sequence the NPC navigation path uses for speed calculation. Doesn't seem to have any visible effect on NPC movement.
		
		Name | Description
		--- | ---
		`sequenceId` | The movement sequence index
    **/
    
    public function SetMovementSequence(sequenceId:Float):Void;
    #end
    #if server
    /**
        Stops the current schedule that the NPC is doing.
    **/
    
    public function ClearSchedule():Void;
    #end
    #if server
    /**
        Changes how an NPC feels towards another NPC. If you want to setup relationship towards a certain entity, use NPC:AddEntityRelationship.
		
		Name | Description
		--- | ---
		`relationstring` | A string representing how the relationship should be set up. Should be formatted as "npc_class D_ Enums numberPriority".
		
		
		___
		### Lua Examples
		#### Example 1
		Spawns a manhack and makes it hate floor turrets.
		
		```lua 
		local hack = ents.Create( "npc_manhack" )
		hack:Spawn()
		hack:AddRelationship( "npc_turret_floor D_HT 99" )
		```
    **/
    
    public function AddRelationship(relationstring:D):Void;
    #end
    #if server
    /**
        Sets the state the NPC is in to help it decide on a ideal schedule.
		
		Name | Description
		--- | ---
		`state` | New NPC state, see NPC_STATE_ Enums
    **/
    
    public function SetNPCState(state:NPC_STATE):Void;
    #end
    #if server
    /**
        Force an NPC to play his Alert sound.
    **/
    
    public function AlertSound():Void;
    #end
    #if server
    /**
        Sets the goal position for the NPC.
		
		Name | Description
		--- | ---
		`position` | The position to set as the goal
    **/
    
    public function NavSetGoal(position:Vector):Void;
    #end
    #if server
    /**
        Updates the NPC's hull and physics hull in order to match its model scale. Entity:SetModelScale seems to take care of this regardless.
    **/
    
    public function SetHullSizeNormal():Void;
    #end
    #if server
    /**
        Sets the activity the NPC uses when it moves.
		
		Name | Description
		--- | ---
		`activity` | The movement activity, see ACT_ Enums.
		
		
		___
		### Lua Examples
		#### Example 1
		Makes all NPCs walk instead of run.
		
		```lua 
		function GM:Think()
		    
		    for _, npc in pairs(ents.FindByClass("npc_*")) do
		
		        if(IsValid(npc) && npc:IsNPC() && npc:GetMovementActivity() != ACT_WALK) then
		            npc:SetMovementActivity(ACT_WALK)
		        end
		
		    end
		    
		end
		```
    **/
    
    public function SetMovementActivity(activity:ACT):Void;
    #end
    #if server
    /**
        Marks the current NPC task as completed. 
		
		This is meant to be used alongside NPC:TaskFail to complete or fail custom Lua defined tasks. (Schedule:AddTask)
    **/
    
    public function TaskComplete():Void;
    #end
    #if server
    /**
        Sets the NPC's target. This is used in some engine schedules.
		
		Name | Description
		--- | ---
		`entity` | The target of the NPC.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the NPC's target to first player.
		
		```lua 
		npc:SetTarget( Entity( 1 ) )
		```
    **/
    
    public function SetTarget(entity:Entity):Void;
    #end
    #if server
    /**
        
    **/
    
    public function SetArrivalDirection():Void;
    #end
    
}



