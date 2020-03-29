package gmod.libs;
#if server

/**
    The construct library is used to control the physical properties of entities.
**/
@:native("_G.construct")extern class ConstructLib {
    
    /**
        Creates a magnet.
		
		Name | Description
		--- | ---
		`ply` | Player that will have the numpad control over the magnet
		`pos` | The position of the magnet
		`ang` | The angles of the magnet
		`model` | The model of the maget
		`material` | Material of the magnet ( texture )
		`key` | The key to toggle the magnet, see KEY_ Enums
		`maxObjects` | Maximum amount of objects the magnet can hold
		`strength` | Strength of the magnet
		`nopull` | If > 0, disallows the magnet to pull objects towards it
		`allowrot` | If > 0, allows rotation of the objects attached
		`startOn` | If > 0, enabled from spawn
		`toggle` | If != 0, pressing the key toggles the magnet, otherwise you'll have to hold the key to keep it enabled
		`vel` | Velocity to set on spawn
		`aVel` | Angular velocity to set on spawn
		`frozen` | Freeze the magnet on start
		
		
		`**Returns:** The magnet
    **/
    
    public static function Magnet(ply:Player, pos:Vector, ang:Angle, model:String, material:String, key:KEY, maxObjects:Float, strength:Float, ?nopull:Float, ?allowrot:Float, ?startOn:Float, toggle:Float, ?vel:Vector, ?aVel:Angle, ?frozen:Bool):Entity;
    
    
    /**
        Sets props physical properties.
		
		Name | Description
		--- | ---
		`ply` | The player. This variable is not used and can be left out.
		`ent` | The entity to apply properties to
		`physObjID` | You can use this or the argument below. This will be used in case you don't provide argument below.
		`physObj` | The physics object to apply the properties to
		`data` | The table containing properties to apply. See PhysProperties structure
    **/
    
    public static function SetPhysProp(ply:Player, ent:Entity, physObjID:Float, physObj:PhysObj, data:PhysProperties):Void;
    
    

}



#end