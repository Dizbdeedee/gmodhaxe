package gmod.enums;
/**
    Enumerations used by net.ReadType and returned by TypeID
**/
@:native("_G")
extern enum abstract TYPE(Int) {
    /**
        [CUserCmd](https://wiki.garrysmod.com/page/Category:CUserCmd)
    **/
    var TYPE_USERCMD;
    /**
        dlight_t. Metatable of a [DynamicLightstructure](https://wiki.garrysmod.com/page/Structures/DynamicLight)
    **/
    var TYPE_DLIGHT;
    /**
        [Panel](https://wiki.garrysmod.com/page/Category:Panel)
    **/
    var TYPE_PANEL;
    /**
        [PhysCollide](https://wiki.garrysmod.com/page/Category:PhysCollide)
    **/
    var TYPE_PHYSCOLLIDE;
    /**
        [CMoveData](https://wiki.garrysmod.com/page/Category:CMoveData)
    **/
    var TYPE_MOVEDATA;
    /**
        [Vector](https://wiki.garrysmod.com/page/Category:Vector)
    **/
    var TYPE_VECTOR;
    /**
        [CEffectData](https://wiki.garrysmod.com/page/Category:CEffectData)
    **/
    var TYPE_EFFECTDATA;
    /**
        Amount of TYPE_* enums
    **/
    var TYPE_COUNT;
    /**
        [SurfaceInfo](https://wiki.garrysmod.com/page/Category:SurfaceInfo)
    **/
    var TYPE_SURFACEINFO;
    /**
        [CNavLadder](https://wiki.garrysmod.com/page/Category:CNavLadder)
    **/
    var TYPE_NAVLADDER;
    /**
        [VMatrix](https://wiki.garrysmod.com/page/Category:VMatrix)
    **/
    var TYPE_MATRIX;
    /**
        [pixelvis_handle_t](https://wiki.garrysmod.com/page/Category:pixelvis_handle_t)
    **/
    var TYPE_PIXELVISHANDLE;
    /**
        [CLuaParticle](https://wiki.garrysmod.com/page/Category:CLuaParticle)
    **/
    var TYPE_PARTICLE;
    /**
        [CTakeDamageInfo](https://wiki.garrysmod.com/page/Category:CTakeDamageInfo)
    **/
    var TYPE_DAMAGEINFO;
    /**
        
    **/
    var TYPE_SCRIPTEDVEHICLE;
    /**
        [CNewParticleEffect](https://wiki.garrysmod.com/page/Category:CNewParticleEffect)
    **/
    var TYPE_PARTICLESYSTEM;
    /**
        [function](https://wiki.garrysmod.com/page/Category:function)
    **/
    var TYPE_FUNCTION;
    /**
        [boolean](https://wiki.garrysmod.com/page/Category:boolean)
    **/
    var TYPE_BOOL;
    /**
        [PhysObj](https://wiki.garrysmod.com/page/Category:PhysObj)
    **/
    var TYPE_PHYSOBJ;
    /**
        [CRecipientFilter](https://wiki.garrysmod.com/page/Category:CRecipientFilter)
    **/
    var TYPE_RECIPIENTFILTER;
    /**
        
    **/
    var TYPE_INVALID;
    /**
        [ISave](https://wiki.garrysmod.com/page/Category:ISave)
    **/
    var TYPE_SAVE;
    /**
        [CNavArea](https://wiki.garrysmod.com/page/Category:CNavArea)
    **/
    var TYPE_NAVAREA;
    /**
        [table](https://wiki.garrysmod.com/page/Category:table)
    **/
    var TYPE_TABLE;
    /**
        [string](https://wiki.garrysmod.com/page/Category:string)
    **/
    var TYPE_STRING;
    /**
        [nil](https://wiki.garrysmod.com/page/Category:nil)
    **/
    var TYPE_NIL;
    /**
        [IMesh](https://wiki.garrysmod.com/page/Category:IMesh)
    **/
    var TYPE_IMESH;
    /**
        Invalid type
    **/
    var TYPE_NONE;
    /**
        [lightuserdata](https://wiki.garrysmod.com/page/Category:light_userdata)
    **/
    var TYPE_LIGHTUSERDATA;
    /**
        [Entity](https://wiki.garrysmod.com/page/Category:Entity) and entity sub-classes including [Player](https://wiki.garrysmod.com/page/Category:Player), [Weapon](https://wiki.garrysmod.com/page/Category:Weapon), [NPC](https://wiki.garrysmod.com/page/Category:NPC), [Vehicle](https://wiki.garrysmod.com/page/Category:Vehicle), [CSEnt](https://wiki.garrysmod.com/page/Category:CSEnt), and [NextBot](https://wiki.garrysmod.com/page/Category:NextBot)
    **/
    var TYPE_ENTITY;
    /**
        [ITexture](https://wiki.garrysmod.com/page/Category:ITexture)
    **/
    var TYPE_TEXTURE;
    /**
        [IMaterial](https://wiki.garrysmod.com/page/Category:IMaterial)
    **/
    var TYPE_MATERIAL;
    /**
        [CSoundPatch](https://wiki.garrysmod.com/page/Category:CSoundPatch)
    **/
    var TYPE_SOUND;
    /**
        [IVideoWriter](https://wiki.garrysmod.com/page/Category:IVideoWriter)
    **/
    var TYPE_VIDEO;
    /**
        [CLuaLocomotion](https://wiki.garrysmod.com/page/Category:CLuaLocomotion)
    **/
    var TYPE_LOCOMOTION;
    /**
        [IGModAudioChannel](https://wiki.garrysmod.com/page/Category:IGModAudioChannel)
    **/
    var TYPE_SOUNDHANDLE;
    /**
        [CLuaEmitter](https://wiki.garrysmod.com/page/Category:CLuaEmitter)
    **/
    var TYPE_PARTICLEEMITTER;
    /**
        [Angle](https://wiki.garrysmod.com/page/Category:Angle)
    **/
    var TYPE_ANGLE;
    /**
        [ConVar](https://wiki.garrysmod.com/page/Category:ConVar)
    **/
    var TYPE_CONVAR;
    /**
        [PathFollower](https://wiki.garrysmod.com/page/Category:PathFollower)
    **/
    var TYPE_PATH;
    /**
        [userdata](https://wiki.garrysmod.com/page/Category:userdata)
    **/
    var TYPE_USERDATA;
    /**
        [number](https://wiki.garrysmod.com/page/Category:number)
    **/
    var TYPE_NUMBER;
    /**
        Metatable of a [Colorstructure](https://wiki.garrysmod.com/page/Structures/Color).
		
		**Note:** This doesn't actually represent a unique type returned by TypeID, but instead is a hack for networking colors with net.WriteType.
    **/
    var TYPE_COLOR;
    /**
        [ProjectedTexture](https://wiki.garrysmod.com/page/Category:ProjectedTexture)
    **/
    var TYPE_PROJECTEDTEXTURE;
    /**
        [File](https://wiki.garrysmod.com/page/Category:File)
    **/
    var TYPE_FILE;
    /**
        [IRestore](https://wiki.garrysmod.com/page/Category:IRestore)
    **/
    var TYPE_RESTORE;
    /**
        [thread](https://wiki.garrysmod.com/page/Category:thread)
    **/
    var TYPE_THREAD;
    /**
        [bf_read](https://wiki.garrysmod.com/page/Category:bf_read)
    **/
    var TYPE_USERMSG;
    
}