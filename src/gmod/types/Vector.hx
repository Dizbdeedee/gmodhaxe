package gmod.types;
import gmod.Gmod;
import gmod.gclass.Vector as GVec;
@:forward
extern abstract Vector(GVec) from GVec to GVec {

    public inline function new(?x:Float,?y:Float,?z:Float) {
        this = Gmod.Vector(x,y,z);
    }

    @:op(A + B)
    public inline function add(otherVec:Vector):Vector {
        return untyped __lua__("{0} + {1}",this,otherVec);
    }

    @:op(A - B)
    public inline function sub(otherVec:Vector):Vector {
        return untyped __lua__("{0} - {1}",this,otherVec);
    }

    @:op(A * B)
    @:commutative
    public inline function mult(other:Float):Vector {
        return untyped __lua__("{0} * {1}",this,other);
    }

    @:op(A / B)
    public inline function div(other:Float):Vector {
        return untyped __lua__("{0} / {1}",this,other);
    }

}