package gmod.helpers;

import gmod.libs.TableLib;
using gmod.helpers.PairTools;


/*
	I really hope no one was using this.
	Turns out, using the existing meta table is A VERY BAD IDEA!
	ESPECIALLY IF THAT'S SHARED BETWEEN ALL HAXE OBJECTS
	Someone needs to take computers away from me, I clearly do not deserve them
	I am very very sorry.
*/
@:access(haxe.ds.ObjectMap)
class WeakTools {

	@:noUsing
	static function createNewMT(table:lua.Table.AnyTable) {
		var prevMeta:lua.Table.AnyTable = Gmod.getmetatable(table);
		var newMeta = if (prevMeta == null) {
			Table.create();
		} else {
			var copy = Table.create();
			for (k => v in prevMeta) {
				copy[k] = v;
			}
			copy;
		}
		Gmod.setmetatable(table,newMeta);
		return newMeta;
	}
	
    public static function setWeakKeys(table:lua.Table.AnyTable):Void {
		final meta = createNewMT(table);
		meta.__mode = "k";
    }
  
    public static function setWeakValues(table:lua.Table.AnyTable):Void {
		final meta = createNewMT(table);
		meta.__mode = "v";
    }

    public static function setWeakKeyValues(table:lua.Table.AnyTable):Void {
		final meta = createNewMT(table);
		meta.__mode = "kv";
    }

	public static function setGCMethod(table:lua.Table.AnyTable, meth:Dynamic) {
		final meta = createNewMT(table);
		meta.__gc = meth;
	}


    public static function setWeakKeysM(objMap:haxe.ds.ObjectMap<Dynamic,Dynamic>) {
		setWeakKeys(objMap.h);
		setWeakKeys(objMap.k);
    }

    public static function setWeakValuesM(objMap:haxe.ds.ObjectMap<Dynamic,Dynamic>) {
		setWeakValues(objMap.h);
    }
    
    public static function setWeakKeyValuesM(objMap:haxe.ds.ObjectMap<Dynamic,Dynamic>) {
		setWeakKeyValues(objMap.h);
		setWeakKeys(objMap.k);
    }

	public static function setWeakValuesArr(arr:Array<Dynamic>) {
		setWeakValues(cast arr);
	}
}