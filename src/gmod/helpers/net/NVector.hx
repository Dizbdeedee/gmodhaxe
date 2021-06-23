package gmod.helpers.net;

abstract NVector(Array<Float>) from Array<Float> to Array<Float> {

    @:from
    public static function from(x:Vector):NVector {
        return [x.x,x.y,x.z];
    }

    @:to
    public function to():Vector {
        return Gmod.Vector(this[0],this[1],this[2]);
    }
}
