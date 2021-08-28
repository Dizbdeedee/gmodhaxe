package gmod.sent;


@:TYPE("brush")
@:gclass("base_brush")
extern class ENT_BRUSH extends gmod.sent.ENT {
	
    public static inline final gclass:EntityClass<ENT_BRUSH> = "base_brush";

    @:hook
    function StartTouch(ent:Entity):Void;

    @:hook
    function EndTouch(ent:Entity):Void;

    @:hook
    function Touch(ent:Entity):Void;
}
