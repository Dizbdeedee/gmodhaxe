package gmod.helpers;
typedef HLinked<G,H:HLinked<G,H>> = {
    final self:GLinked<G,H>;
}
/**
    A gmod object containing a custom haxe class equivalent
    If you create a custom entity using SentBuild, you will be able to get the haxe class equivalent from this
**/
@:forward
@:transitive
abstract GLinked<GBASE,HAXE:HLinked<GBASE,HAXE>>(GBASE) from GBASE to GBASE {

    public var linkedHaxe(get,never):HAXE;
    
    @:noCompletion
    extern inline function get_linkedHaxe():HAXE {
        return untyped this._gHaxeBurrow;
    }

    @:to
    public extern inline function toHaxe():HAXE {
        return untyped this._gHaxeBurrow;
    }

    @:from
    public inline static function fromHaxe<GBASE,HAXE:HLinked<GBASE,HAXE>>(x:HAXE):GLinked<GBASE,HAXE> {
        return x.self;
    }

}
