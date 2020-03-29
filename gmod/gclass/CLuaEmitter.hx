package gmod.gclass;
#if client

/**
    List of all possible functions available for LuaEmitters. This is the object returned by the ParticleEmitter function.
**/
extern class CLuaEmitter {
    
    /**
        Sets the bounding box for this emitter. 
		
		Usually the bounding box is automatically determined by the particles, but this function overrides it.
		
		Name | Description
		--- | ---
		`mins` | The minimum position of the box
		`maxs` | The maximum position of the box
    **/
    
    public function SetBBox(mins:Vector, maxs:Vector):Void;
    
    
    /**
        Creates a new CLuaParticle with the given material and position.
		
		Name | Description
		--- | ---
		`material` | The particles material. Can also be an IMaterial.
		`position` | The position to spawn the particle on.
		
		
		`**Returns:** The created particle, if any.
    **/
    
    public function Add(material:String, position:Vector):CLuaParticle;
    
    
    /**
        Returns the position of this emitter. This is set when creating the emitter with ParticleEmitter.
		
		`**Returns:** Position of this particle emitter.
    **/
    
    public function GetPos():Vector;
    
    
    /**
        Returns whether this emitter is 3D or not. This is set when creating the emitter with ParticleEmitter.
		
		`**Returns:** Whether this emitter is 3D or not.
    **/
    
    public function Is3D():Bool;
    
    
    /**
        This function sets the the distance between the render camera and the emitter at which the particles should start fading and at which distance fade ends ( alpha becomes 0 ).
		
		Name | Description
		--- | ---
		`distanceMin` | Min distance where the alpha becomes 0.
		`distanceMax` | Max distance where the alpha starts fading.
    **/
    
    public function SetNearClip(distanceMin:Float, distanceMax:Float):Void;
    
    
    /**
        Prevents all particles of the emitter from automatically drawing.
		
		Name | Description
		--- | ---
		`noDraw` | Whether we should draw the particles ( false ) or not ( true )
    **/
    
    public function SetNoDraw(noDraw:Bool):Void;
    
    
    /**
        Manually renders all particles the emitter has created.
    **/
    
    public function Draw():Void;
    
    
    /**
        The function name has not much in common with its actual function, it applies a radius to every particles that affects the building of the bounding box, as it, usually is constructed by the particle that has the lowest x, y and z and the highest x, y and z, this function just adds/subtracts the radius and inflates the bounding box.
		
		Name | Description
		--- | ---
		`radius` | Particle radius.
    **/
    
    public function SetParticleCullRadius(radius:Float):Void;
    
    
    /**
        Removes the emitter and all its particles.
    **/
    
    public function Finish():Void;
    
    
    /**
        Sets the position of the particle emitter.
		
		Name | Description
		--- | ---
		`position` | New position.
    **/
    
    public function SetPos(position:Vector):Void;
    
    
    /**
        Returns the amount of active particles of this emitter.
		
		`**Returns:** The amount of active particles of this emitter
    **/
    
    public function GetNumActiveParticles():Float;
    
    
    /**
        Returns whether this CLuaEmitter is valid or not.
		
		`**Returns:** Whether this CLuaEmitter is valid or not.
    **/
    
    public function IsValid():Bool;
    
    
}



#end