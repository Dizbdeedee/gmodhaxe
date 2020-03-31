package gmod.sent;

typedef EntFields = {
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

    var ?RenderGroup : gmod.enums.RENDERGROUP;
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
    var ?DoNotDuplicate : Bool;
    /**
        (Clientside) The contacts of the entity creator 
		
		Default: ""
    **/
    var ?Contact : String;
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
}
@:autoBuild(gmod.macros.SentMacro.build())
@:remove
/**
    Build your custom scripted entity using this interface.
    Don't forget to import the file as well
**/
interface SentBuild {
    private final properties:EntFields;
    private final TYPE:String;
}