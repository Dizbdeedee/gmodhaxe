package gmod.sent;


extern class ENT_BRUSH extends gmod.sent.ENT {
	
	public static inline final TYPE = "brush";

    public static inline final gclass = "base_brush";

    @:hook
    function StartTouch(ent:Entity):Void;

    @:hook
    function EndTouch(ent:Entity):Void;

    @:hook
    function Touch(ent:Entity):Void;
}
