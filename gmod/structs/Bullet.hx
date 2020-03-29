package gmod.structs;
/**
    Tables used for bullets see [Entity](https://wiki.garrysmod.com/page/Category:Entity): [FireBullets](https://wiki.garrysmod.com/page/Entity/FireBullets) and [GM](https://wiki.garrysmod.com/page/Category:GM_Hooks): [EntityFireBullets](https://wiki.garrysmod.com/page/GM/EntityFireBullets).
**/
typedef Bullet = {
    /**
        The entity that the bullet will ignore when it will be shot. 
		
		Default: NULL
    **/
    var ?IgnoreEntity : Entity;
    /**
        The tracer name. You can find a list of default effects here. 
		
		Default: nil
    **/
    var ?TracerName : String;
    /**
        Show tracer for every x bullets 
		
		Default: 1
    **/
    var ?Tracer : Float;
    /**
        The fire direction 
		
		Default: Vector( 0, 0, 0 )
    **/
    var ?Dir : Vector;
    /**
        Maximum distance the bullet can travel 
		
		Default: 56756
    **/
    var ?Distance : Float;
    /**
        The position to fire the bullets from 
		
		Default: Vector( 0, 0, 0 )
    **/
    var ?Src : Vector;
    /**
        The ammunition name 
		
		Default: ""
    **/
    var ?AmmoType : String;
    /**
        The damage dealt by the bullet 
		
		Default: 1
    **/
    var ?Damage : Float;
    /**
        The spread, only x and y are needed 
		
		Default: Vector( 0, 0, 0 )
    **/
    var ?Spread : Vector;
    /**
        The force of the bullets 
		
		Default: 1
    **/
    var ?Force : Float;
    /**
        The entity that should be reported as attacker eg. a player 
		
		By default this would be set to the entity Entity:FireBullets is called on. 
		
		Default: self
    **/
    var ?Attacker : Entity;
    /**
        The hull size of the bullet 
		
		Default: 0
    **/
    var ?HullSize : Float;
    /**
        Function to be called after the bullet was fired. The arguments are:
    **/
    var ?Callback : TraceResult;
    /**
        The amount of bullets to fire 
		
		Default: 1
    **/
    var ?Num : Float;
    
}
