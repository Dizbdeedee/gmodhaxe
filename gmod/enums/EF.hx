package gmod.enums;
/**
    Enumerations used by Entity:AddEffects, Entity:RemoveEffects and Entity:IsEffectActive.
**/
@:native("_G")
extern enum abstract EF(Int) {
    /**
        Don't interpolate the next frame
    **/
    var EF_NOINTERP;
    /**
        Performs bone merge on client side
    **/
    var EF_BONEMERGE;
    /**
        Don't receive shadows
    **/
    var EF_NORECEIVESHADOW;
    /**
        Internal flag that is set by [Entity](https://wiki.garrysmod.com/page/Category:Entity):[FollowBone](https://wiki.garrysmod.com/page/Entity/FollowBone)
    **/
    var EF_FOLLOWBONE;
    /**
        Disables shadow
    **/
    var EF_NOSHADOW;
    /**
        Makes the entity blink
    **/
    var EF_ITEM_BLINK;
    /**
        Always assume that the parent entity is animating
    **/
    var EF_PARENT_ANIMATES;
    /**
        DLIGHT centered at entity origin
    **/
    var EF_BRIGHTLIGHT;
    /**
        Player flashlight
    **/
    var EF_DIMLIGHT;
    /**
        Prevents the entity from drawing and networking.
    **/
    var EF_NODRAW;
    /**
        For use with EF_BONEMERGE. If this is set, then it places this ents origin at its parent and uses the parent's bbox + the max extents of the aiment. Otherwise, it sets up the parent's bones every frame to figure out where to place the aiment, which is inefficient because it'll setup the parent's bones even if the parent is not in the PVS.
    **/
    var EF_BONEMERGE_FASTCULL;
    
}