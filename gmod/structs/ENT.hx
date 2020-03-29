package gmod.structs;
/**
    Information about the ENT structure.  To learn more about scripted entities, see this page. For list of callbacks, see ENT Hooks. 
	
	While some of the fields may be serverside or clientside only, it is recommended to provide them on both so addons could use their values.
**/
typedef ENT = {
    /**
        (Clientside) Sets the spawnmenu content icon type for the entity, used by spawnmenu in the Sandbox-derived gamemodes. See spawnmenu.AddContentType for more information. 
		
		Default: "entity"
    **/
    var ?ScriptedEntityType : String;
    /**
        Whether or not only admins can spawn the entity from their spawn menu 
		
		Default: false
    **/
    var ?AdminOnly : Bool;
    /**
        Whether the entity supports Editing. See Editable Entities for more info. 
		
		Default: false
    **/
    var ?Editable : Bool;
    /**
        (Clientside) Spawnmenu category to put the entity into 
		
		Default: Other
    **/
    var ?Category : String;
    /**
        Whether this entity should be displayed and is spawnable in the spawn menu 
		
		Default: false
    **/
    var ?Spawnable : Bool;
    /**
        (Clientside) The entity's render group, see RENDERGROUP_ Enums. 
		
		Default: RENDERGROUP_OPAQUE
    **/
    var ?RenderGroup : RENDERGROUP;
    /**
        The base entity to derive from. This must be a valid Lua entity
    **/
    var Base : String;
    /**
        (Clientside) The purpose of the entity creation 
		
		Default: ""
    **/
    var ?Purpose : String;
    /**
        (Clientside) Nice name of the entity to appear in the spawn menu 
		
		Default: ""
    **/
    var ?PrintName : String;
    /**
        (Serverside) Disable the ability for players to duplicate this entity. 
		
		Default: false
    **/
    var ?DisableDuplicator : Bool;
    /**
        (Serverside) If set, the entity will not be duplicated via the built-in duplicator system.
    **/
    var DoNotDuplicate : Bool;
    /**
        Type of the entity. This must be one of these:
    **/
    var Type : String;
    /**
        (Clientside) The contacts of the entity creator 
		
		Default: ""
    **/
    var ?Contact : String;
    /**
        The folder from where the entity was loaded. This should always be "entity/ent_myentity", regardless whether your entity is stored as a file, or multiple files in a folder. This is set automatically before the entity file is loaded.
    **/
    var Folder : String;
    /**
        (Clientside) Set this to true if your entity has animations. You should also apply changes to the ENTITY:Think function from the example on that page. 
		
		Default: false
    **/
    var ?AutomaticFrameAdvance : Bool;
    /**
        (Clientside) How to use your entity 
		
		Default: ""
    **/
    var ?Instructions : String;
    /**
        (Clientside) The author of the entity 
		
		Default: ""
    **/
    var ?Author : String;
    /**
        Entity class name of the entity (File or folder name of your entity). This is set automatically after the entity file is loaded.
    **/
    var ClassName : String;
    
}
