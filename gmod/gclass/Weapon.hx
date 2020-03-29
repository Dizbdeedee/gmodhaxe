package gmod.gclass;


/**
    This is a list of all methods only available for weapons. It is also possible to call Entity functions on weapons.
**/
extern class Weapon extends Entity {
    
    /**
        Lets you change the number of bullets in the given weapons primary clip.
		
		Name | Description
		--- | ---
		`ammo` | The amount of bullets the clip should contain
    **/
    
    public function SetClip1(ammo:Float):Void;
    
    
    /**
        Sets when the weapon can alt-fire again. Time should be based on CurTime.
		
		Name | Description
		--- | ---
		`time` | Time when player should be able to use secondary fire again
    **/
    
    public function SetNextSecondaryFire(time:Float):Void;
    
    
    /**
        Calls a SWEP function on client.
		
		**Warning:** This uses the usermessage library internally, because of that, the combined length of the arguments of this function may not exceed 254 bytes/characters or the function will cease to function!
		
		**Note:** Only the second argument is passed as argument and must be a string
		
		Name | Description
		--- | ---
		`functionName` | Name of function to call. If you want to call SWEP:MyFunc() on client, you type in "MyFunc"
		`arguments` | Arguments for the function, separated by spaces. NOTE Only the second argument is passed as argument and must be a string
    **/
    
    public function CallOnClient(functionName:String, ?arguments:String):Void;
    
    
    /**
        Returns maximum primary clip size
		
		`**Returns:** Maximum primary clip size
    **/
    
    public function GetMaxClip1():Float;
    
    
    /**
        Returns the hold type of the weapon.
		
		`**Returns:** The hold type of the weapon. You can find a list of default hold types here.
    **/
    
    public function GetHoldType():String;
    
    
    /**
        Sets when the weapon can fire again. Time should be based on CurTime.
		
		**Bug:** BUG This will fire extra bullets if the time is set to less than CurTime. Issue Tracker: #3786
		
		Name | Description
		--- | ---
		`time` | Time when player should be able to use primary fire again
    **/
    
    public function SetNextPrimaryFire(time:Float):Void;
    
    
    /**
        Returns whether the weapon allows to being switched to when a better ( Weapon:GetWeight ) weapon is being picked up.
		
		`**Returns:** Whether the weapon allows to being switched to.
    **/
    
    public function AllowsAutoSwitchTo():Bool;
    
    
    /**
        Forces weapon to play activity/animation.
		
		Name | Description
		--- | ---
		`act` | Activity to play. See the ACT_ Enums (specifically ACT_VM_).
    **/
    
    public function SendWeaponAnim(act:ACT):Void;
    
    
    /**
        Returns how much secondary ammo is in magazine.
		
		`**Returns:** The amount of secondary ammo in the magazine.
		
		___
		### Lua Examples
		#### Example 1
		Prints the amount of seconday ammo in the magazine of the weapon the 1st player has equipped.
		
		```lua 
		print( player.GetByID( 1 ):GetActiveWeapon():Clip2() )
		```
		**Output:**
		
		Will print -1 for all HL2 weapons.
    **/
    
    public function Clip2():Float;
    
    
    /**
        Returns how much primary ammo is in the magazine.
		
		`**Returns:** The amount of primary ammo in the magazine.
		
		___
		### Lua Examples
		#### Example 1
		Prints the amount of primary ammo in the magazine of the weapon the 1st player has equipped.
		
		```lua 
		print( player.GetByID( 1 ):GetActiveWeapon():Clip1() )
		```
		**Output:**
		
		Will print 45 for fully loaded SMG1.
    **/
    
    public function Clip1():Float;
    
    
    /**
        Returns the view model of the weapon.
		
		`**Returns:** The view model of the weapon.
    **/
    
    public function GetWeaponViewModel():String;
    
    
    /**
        Returns whether the weapon is visible. The term visibility is not exactly what gets checked here, first it checks if the owner is a player, then checks if the active view model has EF_NODRAW flag NOT set.
		
		`**Returns:** Is visible or not
    **/
    
    public function IsWeaponVisible():Bool;
    
    
    /**
        Lets you change the number of bullets in the given weapons secondary clip.
		
		Name | Description
		--- | ---
		`ammo` | The amount of bullets the clip should contain
    **/
    
    public function SetClip2(ammo:Float):Void;
    
    
    /**
        Returns the "weight" of the weapon, which is used when deciding which Weapon is better by the engine.
		
		`**Returns:** The weapon "weight".
    **/
    
    public function GetWeight():Float;
    
    
    /**
        Returns maximum secondary clip size
		
		`**Returns:** Maximum secondary clip size
    **/
    
    public function GetMaxClip2():Float;
    
    #if client
    /**
        Returns whenever the weapon is carried by the local player.
		
		`**Returns:** Is the weapon is carried by the local player or not
    **/
    
    public function IsCarriedByLocalPlayer():Bool;
    #end
    
    /**
        Sets the time since this weapon last fired in seconds. Used in conjunction with Weapon:LastShootTime
		
		Name | Description
		--- | ---
		`time` | The time in seconds when the last time the weapon was fired.
    **/
    
    public function SetLastShootTime(?time:Float):Void;
    
    
    /**
        Checks if the weapon is a SWEP or a built-in weapon.
		
		`**Returns:** Returns true if weapon is scripted ( SWEP ), false if not ( A built-in HL2 weapon )
    **/
    
    public function IsScripted():Bool;
    
    
    /**
        Returns whether the weapon has ammo left or not. It will return false when there's no ammo left in the magazine and when there's no reserve ammo left.
		
		**Note:** This will return true for weapons like crowbar, gravity gun, etc.
		
		`**Returns:** Whether the weapon has ammo or not.
    **/
    
    public function HasAmmo():Bool;
    
    
    /**
        Returns the slot of the weapon (slot numbers start from 0)
		
		`**Returns:** The slot of the weapon
		
		___
		### Lua Examples
		#### Example 1
		How you could use this function to check if a weapon slot was empty or not
		
		```lua 
		local function IsSlotEmpty( ply, slot )
		
		    slot = slot - 1 -- take away 1 from the slot number you want since it starts from 0
		
		    local weptbl = ply:GetWeapons() -- get all the weapons the player has
		
		    for k,v in pairs( weptbl ) do -- loop through them
		        if v:GetSlot() == slot then return false end -- check if the slot is the slot you wanted to check, if it is, return false
		    end
		
		    return true -- otherwise return true
		
		end
		```
    **/
    
    public function GetSlot():Float;
    
    
    /**
        Gets the ammo type of the given weapons secondary fire.
		
		`**Returns:** The secondary ammo type ID, or -1 if not found.
    **/
    
    public function GetSecondaryAmmoType():Float;
    
    
    /**
        Returns the time since this weapon last fired a bullet with Entity:FireBullets in seconds. It is not networked.
		
		`**Returns:** The time in seconds when the last bullet was fired.
    **/
    
    public function LastShootTime():Float;
    
    
    /**
        Returns the non-internal name of the weapon, that should be for displaying.
		
		**Note:** If that returns an untranslated message (#HL2_XX), use language.GetPhrase to see the "nice" name.
		
		**Note:** If SWEP.PrintName is not set in the Weapon or the Weapon Base then "<MISSING SWEP PRINT NAME>" will be returned.
		
		`**Returns:** The "nice" name of the weapon.
    **/
    
    public function GetPrintName():String;
    
    
    /**
        Returns slot position of the weapon
		
		`**Returns:** The slot position of the weapon
    **/
    
    public function GetSlotPos():Float;
    
    
    /**
        Gets the next time the weapon can primary fire. ( Can call WEAPON:PrimaryAttack )
		
		`**Returns:** The time, relative to CurTime
    **/
    
    public function GetNextPrimaryFire():Float;
    
    
    /**
        Returns the sequence enumeration number that the weapon is playing.
		
		**Bug:** BUG This can return inconsistent results between the server and client. Issue Tracker: #2543
		
		`**Returns:** Current activity, see ACT_ Enums. Returns 0 if the weapon doesn't have active sequence.
		
		___
		### Lua Examples
		#### Example 1
		This will return the ACT_ENUM that is currently active for the weapon.
		
		```lua 
		local wep = Entity(1):GetActiveWeapon()
		 
		if ( IsValid( wep ) ) then // Makes sure that wep exists
		 
		    print( wep:GetActivity() ) // Prints the sequence number
		 
		end
		```
    **/
    
    public function GetActivity():ACT;
    
    
    /**
        Gets the next time the weapon can secondary fire. ( Can call WEAPON:SecondaryAttack )
		
		`**Returns:** The time, relative to CurTime
    **/
    
    public function GetNextSecondaryFire():Float;
    
    
    /**
        Gets the primary ammo type of the given weapon.
		
		`**Returns:** The ammo type ID, or -1 if not found.
    **/
    
    public function GetPrimaryAmmoType():Float;
    
    
    /**
        Returns whether the weapon allows to being switched from when a better ( Weapon:GetWeight ) weapon is being picked up.
		
		`**Returns:** Whether the weapon allows to being switched from.
    **/
    
    public function AllowsAutoSwitchFrom():Bool;
    
    
    /**
        Sets the hold type of the weapon. This function also calls WEAPON:SetWeaponHoldType and properly networks it to all clients.
		
		**Note:** This only works on scripted weapons.
		
		**Bug:** BUG Using this function on weapons held by bots will not network holdtype changes to clients if the world model is set to an empty string (SWEP.WorldModel = "").
		
		Name | Description
		--- | ---
		`name` | Name of the hold type. You can find all default hold types here
		
		
		___
		### Lua Examples
		#### Example 1
		Puts a players hands down by its sides on reload.
		
		```lua 
		function SWEP:Reload()
		    self:SetHoldType( "normal" )
		end
		```
    **/
    
    public function SetHoldType(name:String):Void;
    
    
    /**
        Forces the weapon to reload while playing given animation.
		
		Name | Description
		--- | ---
		`act` | Sequence to use as reload animation. Uses the ACT_ Enums.
		
		
		`**Returns:** Did reloading actually take place
    **/
    
    public function DefaultReload(act:ACT):Bool;
    
    
    /**
        Returns the world model of the weapon.
		
		`**Returns:** The world model of the weapon.
    **/
    
    public function GetWeaponWorldModel():String;
    
    
}



