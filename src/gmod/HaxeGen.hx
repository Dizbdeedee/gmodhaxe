package gmod;

typedef HaxeExtend<T,X:HaxeExtend<T,X>> = {
    final self:HaxeGen<T,X>;
}
@:forward
abstract HaxeGen<ENT,HAXE:HaxeExtend<ENT,HAXE>>(ENT) from ENT to ENT {

    public var haxeGen(get,never):HAXE;
    
    @:noCompletion
    extern inline function get_haxeGen():HAXE {
        return untyped this._gHaxeBurrow;
    }

    @:to
    public extern inline function toHaxe():HAXE {
        return untyped this._gHaxeBurrow;
    }

    @:from
    public inline static function fromHaxe<ENT,HAXE:HaxeExtend<ENT,HAXE>>(x:HAXE):HaxeGen<ENT,HAXE> {
        return x.self;
    }

}
