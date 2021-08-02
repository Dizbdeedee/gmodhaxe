package gmod.sent;


#if server
extern class ENT_NEXTBOT extends gmod.macros.ENTFix<NextBot> {
    public static inline final gclass = "base_nextbot";
    public static inline final TYPE = "nextbot";

    /**
        Called to initialize the behaviour.

        This is called automatically when the NextBot is created, you should not call it manually.
        You shouldn't override this unless you know what you are doing - it's used to kick off the coroutine that runs the bot's behaviour. See NEXTBOT:RunBehaviour instead.
    **/
    @:hook
    function BehaveStart():Void;

    /**
        Called to update the bot's behaviour.


        Name | Description
		--- | ---
		`interval` | How long since the last update.
    **/
    @:hook
    function BehaveUpdate(interval:Float):Void;

    /**
        Called to update the bot's animation.
    **/
    @:hook
    function BodyUpdate():Void;

    /**
        Called when the nextbot touches another entity.

        
        Name | Description
		--- | ---
		`ent` | The entity the nextbot came in contact with.
    **/
    @:hook
    function OnContact(ent:Entity):Void;

    /**

    **/
    function OnIgnite():Void;

    /**
        Called when the bot gets hurt. This is a good place to play hurt sounds or voice lines.
        
        
        Name | Description
        --- | ---
        `info` | The damage info
    **/
    function OnInjured(info:CTakeDamageInfo):Void;
}

#end
