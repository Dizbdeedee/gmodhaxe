package gmod.gclass;


/**
    A class used to store and modify all the data concerning a damage event. An empty CTakeDamageInfo object can be created with DamageInfo 
	
	List of hooks that this object is passed to:
**/
extern class CTakeDamageInfo {
    
    /**
        Returns the initial, unmodified position where the damage occured.
		
		`**Returns:** position
    **/
    
    public function GetReportedPosition():Vector;
    
    
    /**
        Sets the custom damage type. This is used by Day of Defeat: Source and Team Fortress 2 for extended damage info, but isn't used in Garry's Mod by default.
		
		Name | Description
		--- | ---
		`DamageType` | Any integer - can be based on your own custom enums.
    **/
    
    public function SetDamageCustom(DamageType:Float):Void;
    
    
    /**
        Returns true if the damage was caused by a bullet.
		
		`**Returns:** isBulletDmg
    **/
    
    public function IsBulletDamage():Bool;
    
    
    /**
        Sets the inflictor of the damage for example a weapon. 
		
		For hitscan/bullet weapons this should the weapon. For projectile ( rockets, etc ) weapons this should be the projectile.
		
		Name | Description
		--- | ---
		`inflictor` | The new inflictor.
    **/
    
    public function SetInflictor(inflictor:Entity):Void;
    
    
    /**
        Returns the inflictor of the damage. This is not necessarily a weapon. 
		
		For hitscan weapons this is the weapon. For projectile weapons this is the projectile. For a more reliable method of getting the weapon that damaged an entity, use GetAttacker with GetActiveWeapon.
		
		`**Returns:** The inflictor
    **/
    
    public function GetInflictor():Entity;
    
    
    /**
        Sets the attacker ( character who originated the attack ) of the damage, for example a player or an NPC.
		
		Name | Description
		--- | ---
		`ent` | The entity to be set as the attacker.
    **/
    
    public function SetAttacker(ent:Entity):Void;
    
    
    /**
        Gets the custom damage type. This is used by Day of Defeat: Source and Team Fortress 2 for extended damage info, but isn't used in Garry's Mod by default.
		
		`**Returns:** The custom damage type
    **/
    
    public function GetDamageCustom():Float;
    
    
    /**
        Returns the attacker ( character who originated the attack ), for example a player or an NPC that shot the weapon.
		
		`**Returns:** The attacker
    **/
    
    public function GetAttacker():Entity;
    
    
    /**
        Returns the initial unmodified by skill level ( game.GetSkillLevel ) damage.
		
		`**Returns:** baseDamage
    **/
    
    public function GetBaseDamage():Float;
    
    
    /**
        Sets the bonus damage. Bonus damage isn't automatically applied, so this will have no outer effect by default.
		
		Name | Description
		--- | ---
		`damage` | The extra damage to be added.
    **/
    
    public function SetDamageBonus(damage:Float):Void;
    
    
    /**
        Sets the damage type.
		
		Name | Description
		--- | ---
		`type` | The damage type, see DMG_ Enums.
    **/
    
    public function SetDamageType(type:DMG):Void;
    
    
    /**
        Returns whenever the damageinfo contains the damage type specified.
		
		Name | Description
		--- | ---
		`dmgType` | Damage type to test. See DMG_ Enums.
		
		
		`**Returns:** Whether this damage contains specified damage type or not
    **/
    
    public function IsDamageType(dmgType:DMG):Bool;
    
    
    /**
        Sets the position of where the damage gets applied to.
		
		Name | Description
		--- | ---
		`pos` | The position where the damage will be applied.
    **/
    
    public function SetDamagePosition(pos:Vector):Void;
    
    
    /**
        Changes the ammo type used by the weapon that inflicted the damage.
		
		Name | Description
		--- | ---
		`ammoType` | Ammo type ID
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a new DamageInfo object and sets the ammo that caused the damage to AR2 ammo
		
		```lua 
		local dmginfo = DamageInfo()
		
		dmginfo:SetAmmoType( game.GetAmmoID( 'AR2' ) )
		```
    **/
    
    public function SetAmmoType(ammoType:Float):Void;
    
    
    /**
        Returns the position where the damage was or is going to be applied to. 
		
		Can be set using CTakeDamageInfo:SetDamagePosition.
		
		`**Returns:** The damage position
    **/
    
    public function GetDamagePosition():Vector;
    
    
    /**
        Returns the ammo type used by the weapon that inflicted the damage.
		
		`**Returns:** Ammo type ID
    **/
    
    public function GetAmmoType():Float;
    
    
    /**
        Sets the directional force of the damage.
		
		Name | Description
		--- | ---
		`force` | The vector to set the force to.
    **/
    
    public function SetDamageForce(force:Vector):Void;
    
    
    /**
        Returns whenever the damageinfo contains explosion damage.
		
		`**Returns:** isExplDamage
    **/
    
    public function IsExplosionDamage():Bool;
    
    
    /**
        Scales the damage by the given value.
		
		Name | Description
		--- | ---
		`scale` | Value to scale the damage with.
    **/
    
    public function ScaleDamage(scale:Float):Void;
    
    
    /**
        Returns a bitflag which indicates the damage type(s) of the damage. 
		
		Consider using CTakeDamageInfo:IsDamageType instead. Value returned by this function can contain multiple damage types.
		
		`**Returns:** Damage type(s), a combination of DMG_ Enums
    **/
    
    public function GetDamageType():DMG;
    
    
    /**
        Increases the damage by damageIncrease.
		
		Name | Description
		--- | ---
		`damageIncrease` | The damage to add.
    **/
    
    public function AddDamage(damageIncrease:Float):Void;
    
    
    /**
        Gets the current bonus damage.
		
		`**Returns:** Bonus damage
    **/
    
    public function GetDamageBonus():Float;
    
    
    /**
        Returns the maximum damage.
		
		`**Returns:** maxDmg
    **/
    
    public function GetMaxDamage():Float;
    
    
    /**
        Returns a vector representing the damage force. 
		
		Can be set with CTakeDamageInfo:SetDamageForce.
		
		`**Returns:** The damage force
    **/
    
    public function GetDamageForce():Vector;
    
    
    /**
        Sets the maximum damage the object can cause.
		
		Name | Description
		--- | ---
		`maxDamage` | Maximum damage value.
    **/
    
    public function SetMaxDamage(maxDamage:Float):Void;
    
    
    /**
        Subtracts the specified amount from the damage.
		
		Name | Description
		--- | ---
		`damage` | Value to subtract.
    **/
    
    public function SubtractDamage(damage:Float):Void;
    
    
    /**
        Sets the amount of damage.
		
		Name | Description
		--- | ---
		`damage` | The value to set the absolute damage to.
    **/
    
    public function SetDamage(damage:Float):Void;
    
    
    /**
        Sets the origin of the damage.
		
		Name | Description
		--- | ---
		`pos` | The location of where the damage is originating
    **/
    
    public function SetReportedPosition(pos:Vector):Void;
    
    
    /**
        Returns the total damage.
		
		`**Returns:** damage
    **/
    
    public function GetDamage():Float;
    
    
    /**
        Returns whenever the damageinfo contains fall damage.
		
		`**Returns:** isFallDmg
    **/
    
    public function IsFallDamage():Bool;
    
    
}



