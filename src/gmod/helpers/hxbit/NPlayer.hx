package gmod.helpers.hxbit;

@:transitive
abstract NPlayer(Int) {

    @:from
    public inline static function from(x:Player) {
        return cast x.UserID();
    }

    @:to
    public inline function to():Player {
        return Gmod.Player(this);
    }
}