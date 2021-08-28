package gmod.sent;


#if server
@:gclass("base_nextbot")
@:TYPE("nextbot")
extern class ENT_NEXTBOT extends gmod.macros.ENTFix<NextBot> {
    public static inline final gclass:EntityClass<ENT_NEXTBOT> = "base_nextbot";

    /**
        Called to initialize the behaviour.

        This is called automatically when the NextBot is created, you should not call it manually.
        You shouldn't override this unless you know what you are doing - it's used to kick off the coroutine that runs the bot's behaviour. See NEXTBOT:RunBehaviour instead.
    **/
    @:hook
    private function BehaveStart():Void;

    /**
        Called to update the bot's behaviour.


        Name | Description
		--- | ---
		`interval` | How long since the last update.
    **/
    @:hook
    private function BehaveUpdate(interval:Float):Void;

    /**
        Called to update the bot's animation.
    **/
    @:hook
    private function BodyUpdate():Void;

    /**
        Called when the nextbot touches another entity.

        
        Name | Description
		--- | ---
		`ent` | The entity the nextbot came in contact with.
    **/
    @:hook
    private function OnContact(ent:Entity):Void;

    /**

    **/
    @:hook
    private function OnIgnite():Void;

    /**
        Called when the bot gets hurt. This is a good place to play hurt sounds or voice lines.
        
        
        Name | Description
        --- | ---
        `info` | The damage info
    **/
    @:hook
    private function OnInjured(info:CTakeDamageInfo):Void;

    //TODO how long have these been missing?? Update 
}

#end
