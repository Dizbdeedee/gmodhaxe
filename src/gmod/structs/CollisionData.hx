package gmod.structs;
/**
    Passed as argument of [ENTITY](https://wiki.garrysmod.com/page/Category:ENTITY_Hooks): [PhysicsCollide](https://wiki.garrysmod.com/page/ENTITY/PhysicsCollide).
	
	**Note:** Sometimes, the value of 'Speed' can be different from getting the length calculated from 'OurOldVelocity', even though they should be the same, or close to same. It's recommended to do 'OurOldVelocity:Length()' instead. ENT:PhysicsCollide( colData, collider )
	
	-- you may get two completely different values, and the second one should be more accurate.
	
	    print(colData.Speed)
	
	    print(colData.OurOldVelocity:Length())
	
	end
**/
typedef CollisionData = {
    /**
        The entity's velocity before the collision
    **/
    var OurOldVelocity : Vector;
    /**
        The collision position
    **/
    var HitPos : Vector;
    /**
        Normal of the surface that hit the other entity
    **/
    var HitNormal : Vector;
    /**
        Other entity's physics object
    **/
    var HitObject : PhysObj;
    /**
        The speed of the entity before the collision
    **/
    var Speed : Float;
    /**
        Time since the last collision with this HitEntity
    **/
    var DeltaTime : Float;
    /**
        Entity's physics object
    **/
    var PhysObject : PhysObj;
    /**
        Speed of the other entity before the collision
    **/
    var TheirOldVelocity : Vector;
    /**
        The other collision entity
    **/
    var HitEntity : Entity;
    
}
