package gmod.types;

import gmod.libs.GlobalLib;
import gmod.gclass.Angle as GAng;

@:forward
extern abstract Angle(GAng) from GAng to GAng {

    public inline function new(?x:Float,?y:Float,?z:Float) {
        this = GlobalLib.Angle(x,y,z);
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