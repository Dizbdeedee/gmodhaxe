package gmod.types;

import gmod.libs.GlobalLib;
import gmod.gclass.Angle as GAng;

@:forward
extern abstract Angle(GAng) from GAng to GAng {

    public var p(get,set):Float;

    public var y(get,set):Float;

    public var r(get,set):Float;
    
    @:noCompletion
    public extern inline function get_p():Float {
        return untyped this[1];
    }
    @:noCompletion
    public extern inline function set_p(x:Float):Float {
        return untyped this[1] = x;
    }
    @:noCompletion
    public extern inline function get_y():Float {
        return untyped this[2];
    }
    @:noCompletion
    public extern inline function set_y(x:Float):Float {
        return untyped this[2] = x;
    }
    @:noCompletion
    public extern inline function get_r():Float {
        return untyped this[3];
    }
    @:noCompletion
    public extern inline function set_r(x:Float):Float {
        return untyped this[3] = x;
    }

    public inline function new(?p:Float,?y:Float,?r:Float) {
        this = GlobalLib.Angle(p,y,r);
    }

    @:op(A + B)
    public inline function add(otherVec:Angle):Angle {
        return untyped __lua__("{0} + {1}",this,otherVec);
    }

    @:op(A - B)
    public inline function sub(otherVec:Angle):Angle {
        return untyped __lua__("{0} - {1}",this,otherVec);
    }

    @:op(A * B)
    @:commutative
    public inline function mult(other:Float):Angle {
        return untyped __lua__("{0} * {1}",this,other);
    }

    @:op(A / B)
    public inline function div(other:Float):Angle {
        return untyped __lua__("{0} / {1}",this,other);
    }

}