package gmod;

typedef HaxeExtend<X> = {
    final self:X;
}

/**
    Represents a gmod object with a haxe representation.
    Use `haxeGen` to get the haxe rep.
**/
@:forward
abstract HaxeGen<T,X:HaxeExtend<T>>(T) from T to T {

    public var haxeGen(get,never):X;
    
    @:noCompletion
    extern inline function get_haxeGen():X {
        return untyped this._gHaxeBurrow;
    }

    @:to
    public extern inline function to():X {
        return untyped this._gHaxeBurrow;
    }

    @:from
    public extern inline static function from<T,X:HaxeExtend<T>>(x:X):HaxeGen<T,X> {
        return x.self;
    }

}