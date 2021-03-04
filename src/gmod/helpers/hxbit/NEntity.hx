package gmod.helpers.hxbit;

import gmod.libs.NetLib;
import gmod.gclass.Entity as GEnt;

@:transitive
abstract NEntity(Int) {

    @:from
    public inline static function from(x:GEnt) {
        return cast x.EntIndex();
    }

    @:to
    public inline function to():GEnt {
        return Gmod.Entity(this);
    }
}