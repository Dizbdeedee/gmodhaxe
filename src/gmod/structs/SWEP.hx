package gmod.structs;
/**
    Information about a SWEP, used by [SANDBOX](https://wiki.garrysmod.com/page/Category:SANDBOX_Hooks): [PlayerGiveSWEP](https://wiki.garrysmod.com/page/SANDBOX/PlayerGiveSWEP) and SWEP creation. For list of callbacks, see [Category:WEAPON_Hooks](https://wiki.garrysmod.com/page/Category:WEAPON_Hooks). While some of the fields may be serverside or clientside only, it is recommended to provide them on both so addons could use their values.
**/
typedef SWEP = {
    /**
        (Clientside) Sets the spawnmenu content icon type for the entity, used by spawnmenu in the Sandbox-derived gamemodes. See spawnmenu.AddContentType for more information. 
		
		Default: "weapon"
    **/
    var ?ScriptedEntityType : String;
    /**
        The world model for your SWEP (what you will see in other players hands) 
		
		Default: "models/weapons/w_357.mdl"
    **/
    var ?WorldModel : String;
    /**
        (Clientside) An angle of FOV used for the view model (Half-Life value is 90; Half-Life 2 is 54; Counter-Strike: Source is 74; Day of Defeat: Source is 45) 
		
		Default: 62
    **/
    var ?ViewModelFOV : Float;
    /**
        (Serverside) Whether this weapon can be autoswitched to when the player runs out of ammo in their current weapon or they pick this weapon up 
		
		Default: true
    **/
    var ?AutoSwitchTo : Bool;
    /**
        (Clientside) Should we use Counter-Strike muzzle flashes upon firing? This is required for DoD:S or CS:S view models to fix their muzzle flashes. 
		
		Default: false
    **/
    var ?CSMuzzleFlashes : Bool;
    /**
        (Clientside) Internal variable for drawing the info box in weapon selection 
		
		Default: surface.GetTextureID( "gui/speech_lid" )
    **/
    var ?SpeechBubbleLid : Float;
    /**
        (Clientside) Should we draw the default HL2 ammo counter? 
		
		Default: true
    **/
    var ?DrawAmmo : Bool;
    /**
        Whether or not only admins can spawn the SWEP from their Q menu 
		
		Default: false
    **/
    var ?AdminOnly : Bool;
    /**
        Position in the slot, should be in the range 0-128 
		
		Default: 10
    **/
    var ?SlotPos : Float;
    /**
        (Clientside) Same as ViewModelFlip, but for the second viewmodel 
		
		Default: false
    **/
    var ?ViewModelFlip1 : Bool;
    /**
        If set to false, the weapon will not play the weapon pick up sound when picked up. 
		
		Default: true
    **/
    var ?m_bPlayPickupSound : Bool;
    /**
        (Clientside) Should the weapon icon bounce in weapon selection? 
		
		Default: true
    **/
    var ?BounceWeaponIcon : Bool;
    /**
        (Clientside) Path to an texture. Override this in your SWEP to set the icon in the weapon selection. This must be the texture ID, see surface.GetTextureID 
		
		Default: surface.GetTextureID( "weapons/swep" )
    **/
    var ?WepSelectIcon : Float;
    /**
        (Clientside) Category the SWEP is in 
		
		Default: "Other"
    **/
    var ?Category : String;
    /**
        (Clientside) Should we draw the default crosshair? 
		
		Default: true
    **/
    var ?DrawCrosshair : Bool;
    /**
        Whether this SWEP should be displayed in the Q menu 
		
		Default: false
    **/
    var ?Spawnable : Bool;
    /**
        (Clientside) Should we flip the view model? This is needed for some CS:S view models 
		
		Default: false
    **/
    var ?ViewModelFlip : Bool;
    /**
        (Clientside) The scale of the viewmodel bob (viewmodel movement from left to right when walking around) 
		
		Default: 1
    **/
    var ?BobScale : Float;
    /**
        (Clientside) The SWEP render group, see RENDERGROUP_ Enums 
		
		Default: RENDERGROUP_OPAQUE
    **/
    var ?RenderGroup : RENDERGROUP;
    /**
        (Clientside) The scale of the viewmodel sway (viewmodel position lerp when looking around). 
		
		Default: 1
    **/
    var ?SwayScale : Float;
    /**
        The base weapon to derive from. This must be a Lua weapon 
		
		Default: "weapon_base"
    **/
    var ?Base : String;
    /**
        (Clientside) The purpose of the SWEP creator to be shown in weapon selection 
		
		Default: ""
    **/
    var ?Purpose : String;
    /**
        (Clientside) Makes the default SWEP crosshair be positioned in 3D space where your aim actually is (like on Jeep), instead of simply sitting in the middle of the screen at all times 
		
		Default: false
    **/
    var ?AccurateCrosshair : Bool;
    /**
        Nice name of the SWEP 
		
		Default: "Scripted Weapon"
    **/
    var ?PrintName : String;
    /**
        Disable the ability for players to duplicate this SWEP 
		
		Default: false
    **/
    var ?DisableDuplicator : Bool;
    /**
        Primary attack settings. The table contains these fields:
    **/
    var Primary : AttackSettings;
    /**
        (Clientside) Makes the player models hands bonemerged onto the view model
		
		**Warning:** The gamemode and view models must support this feature for it to work! You can find more information here: Using Viewmodel Hands
    **/
    var ?UseHands : Bool;
    /**
        Multiplier of deploy speed 
		
		Default: 1
    **/
    var ?m_WeaponDeploySpeed : Float;
    /**
        (Serverside) Whether this weapon can be autoswitched away from when the player runs out of ammo in this weapon or picks up another weapon or ammo 
		
		Default: true
    **/
    var ?AutoSwitchFrom : Bool;
    /**
        Secondary attack settings, has same fields as Primary attack settings
    **/
    var ?Secondary : AttackSettings;
    /**
        (Clientside) Should draw the weapon selection info box, containing SWEP.Instructions, etc. 
		
		Default: true
    **/
    var ?DrawWeaponInfoBox : Bool;
    /**
        Slot in the weapon selection menu, starts with 0 
		
		Default: 0
    **/
    var ?Slot : Float;
    /**
        (Clientside) The contacts of the SWEP creator to be shown in weapon selection 
		
		Default: ""
    **/
    var ?Contact : String;
    /**
        Path to the view model for your SWEP (what the wielder will see) 
		
		Default: "models/weapons/v_pistol.mdl"
    **/
    var ?ViewModel : String;
    /**
        (Clientside) Use the X shape muzzle flash instead of the default Counter-Strike muzzle flash. Requires CSMuzzleFlashes to be set to true 
		
		Default: false
    **/
    var ?CSMuzzleX : Bool;
    /**
        (Serverside) Decides whether we should switch from/to this 
		
		Default: 5
    **/
    var ?Weight : Float;
    /**
        (Clientside) Same as ViewModelFlip, but for the third viewmodel 
		
		Default: false
    **/
    var ?ViewModelFlip2 : Bool;
    /**
        The entity that owns/wields this SWEP, if any
    **/
    var ?Owner : Entity;
    /**
        The folder from where the weapon was loaded. This should always be "weapons/weapon_myweapon", regardless whether your SWEP is stored as a file, or multiple files in a folder. It is set automatically on load
    **/
    var ?Folder : String;
    /**
        (Clientside) How to use your weapon, to be shown in weapon selection 
		
		Default: ""
    **/
    var ?Instructions : String;
    /**
        (Clientside) The author of the SWEP to be shown in weapon selection 
		
		Default: ""
    **/
    var ?Author : String;
    /**
        Entity class name of the SWEP (file or folder name of your SWEP). This is set automatically
    **/
    var ?ClassName : String;
    
}

/**
    Attack settings for primary/secondary fire of a swep
**/
typedef AttackSettings = {
    /**
        Ammo type ("Pistol", "SMG1" etc)
    **/
    var Ammo : String;
    /**
        The maximum amount of bullets one clip can hold
    **/
    var ClipSize : Int;
    /**
        Default ammo in the clip, making it higher than ClipSize will give player additional ammo on spawn
    **/
    var DefaultClip : Int;
    /**
        If true makes the weapon shoot automatically as long as the player has primary attack button held down
    **/
    var Automatic : Bool;
}