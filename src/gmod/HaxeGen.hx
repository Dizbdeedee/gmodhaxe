package gmod;

typedef HaxeExtend<T,X:HaxeExtend<T,X>> = {
    final self:HaxeGen<T,X>;
}
@:forward
abstract HaxeGen<T,X:HaxeExtend<T,X>>(T) from T to T {

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
    public inline static function from<T,X:HaxeExtend<T,X>>(x:X):HaxeGen<T,X> {
        return x.self;
    }

}
