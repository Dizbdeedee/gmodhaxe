package gmod.helpers.sent;

typedef EntFields = {
    /**
        (Clientside) Sets the spawnmenu content icon type for the entity, used by spawnmenu in the Sandbox-derived gamemodes. See spawnmenu.AddContentType for more information. 
		
		Default: "entity"
    **/
    final ?ScriptedEntityType : String;
    /**
        Whether or not only admins can spawn the entity from their spawn menu 
		
		Default: false
    **/
    final ?AdminOnly : Bool;
    /**
        Whether the entity supports Editing. See Editable Entities for more info. 
		
		Default: false
    **/
    final ?Editable : Bool;
    /**
        (Clientside) Spawnmenu category to put the entity into 
		
		Default: Other
    **/
    final ?Category : String;
    /**
        Whether this entity should be displayed and is spawnable in the spawn menu 
		
		Default: false
    **/
    final ?Spawnable : Bool;
    /**
        (Clientside) The entity's render group, see RENDERGROUP_ Enums. 
		
		Default: RENDERGROUP_OPAQUE
    **/

    final ?RenderGroup : gmod.enums.RENDERGROUP;
    /**
        The base entity to derive from. This must be a valid Lua entity
    **/
    final ?Base : String;
    /**
        (Clientside) The purpose of the entity creation 
		
		Default: ""
    **/
    final ?Purpose : String;
    /**
        (Clientside) Nice name of the entity to appear in the spawn menu 
		
		Default: ""
    **/
    final ?PrintName : String;
    /**
        (Serverside) Disable the ability for players to duplicate this entity. 
		
		Default: false
    **/
    final ?DisableDuplicator : Bool;
    /**
        (Serverside) If set, the entity will not be duplicated via the built-in duplicator system.
    **/
    final ?DoNotDuplicate : Bool;
    /**
        (Clientside) The contacts of the entity creator 
		
		Default: ""
    **/
    final ?Contact : String;
    /**
        (Clientside) Set this to true if your entity has animations. You should also apply changes to the ENTITY:Think function from the example on that page. 
		
		Default: false
    **/
    final ?AutomaticFrameAdvance : Bool;
    /**
        (Clientside) How to use your entity 
		
		Default: ""
    **/
    final ?Instructions : String;
    /**
        (Clientside) The author of the entity 
		
		Default: ""
    **/
    final ?Author : String;
}

@:genericBuild(gmod.helpers.macros.PanelMacro.buildSent())
@:keepSub
class SentBuild<T:gmod.sent.ENT> {

}
