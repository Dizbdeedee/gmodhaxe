package gmod.enums;
/**
    Used by Entity:SetRenderFX and returned by Entity:GetRenderFX. 
	
	Most of these require alpha value of entitys color to be less than 255 to have any visible effect.
**/
@:native("_G")
extern enum abstract KRenderFx(Int) {
    /**
        Very quickly switches the entitys transparency between its alpha and 0.
    **/
    var kRenderFxStrobeFaster;
    /**
        Quickly pulses the entitys transparency, from 0 to 255.
    **/
    var kRenderFxPulseFastWider;
    /**
        Same as Strobe Slow, but the interval is more randomized.
    **/
    var kRenderFxFlickerSlow;
    /**
        
    **/
    var kRenderFxNoDissipation;
    /**
        Quickly fades away the entity, making it completely invisible.Starts from whatever alpha the entity currently has set.
    **/
    var kRenderFxFadeFast;
    /**
        
    **/
    var kRenderFxExplode;
    /**
        
    **/
    var kRenderFxGlowShell;
    /**
        Same as Distort, but fades the entity away the farther you are from it.
    **/
    var kRenderFxHologram;
    /**
        
    **/
    var kRenderFxRagdoll;
    /**
        
    **/
    var kRenderFxSpotlight;
    /**
        Same as Strobe Fast, but the interval is more randomized.
    **/
    var kRenderFxFlickerFast;
    /**
        Slowly pulses the entitys transparency, +-15 to the current alpha.
    **/
    var kRenderFxPulseSlow;
    /**
        
    **/
    var kRenderFxEnvSnow;
    /**
        Quickly switches the entitys transparency between its alpha and 0.
    **/
    var kRenderFxStrobeFast;
    /**
        Slowly fades away the entity, making it completely invisible.Starts from whatever alpha the entity currently has set.
    **/
    var kRenderFxFadeSlow;
    /**
        Slowly pulses the entitys transparency, +-60 to the current alpha.
    **/
    var kRenderFxPulseSlowWide;
    /**
        Slowly switches the entitys transparency between its alpha and 0.
    **/
    var kRenderFxStrobeSlow;
    /**
        
    **/
    var kRenderFxEnvRain;
    /**
        Quickly solidifies the entity, making it fully opaque.Starts from whatever alpha the entity currently has set.
    **/
    var kRenderFxSolidFast;
    /**
        Quickly pulses the entitys transparency, +-60 to the current alpha.
    **/
    var kRenderFxPulseFastWide;
    /**
        Slowly solidifies the entity, making it fully opaque.Starts from whatever alpha the entity currently has set.
    **/
    var kRenderFxSolidSlow;
    /**
        None. No change.
    **/
    var kRenderFxNone;
    /**
        
    **/
    var kRenderFxClampMinScale;
    /**
        Quickly pulses the entitys transparency, +-15 to the current alpha.
    **/
    var kRenderFxPulseFast;
    /**
        Flickers ( randomizes ) the entitys transparency
    **/
    var kRenderFxDistort;
    
}