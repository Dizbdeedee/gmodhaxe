package gmod.helpers;


@:access(haxe.ds.ObjectMap)
class WeakTools {

	@:noUsing
	static function createMTIfNotExists(table:lua.Table.AnyTable) {
		var prevMeta:lua.Table.AnyTable = Gmod.getmetatable(table);
		if (prevMeta == null) {
			prevMeta = Table.create();
			Gmod.setmetatable(table,prevMeta);
		}
		return prevMeta;
	}
	
    public static function setWeakKeys(table:lua.Table.AnyTable):Void {
		final meta = createMTIfNotExists(table)
		meta.__mode = "k";
    }
  
    public static function setWeakValues(table:lua.Table.AnyTable):Void {
		final meta = createMTIfNotExists(table)
		meta.__mode = "v";
    }

    public static function setWeakKeyValues(table:lua.Table.AnyTable):Void {
		final meta = createMTIfNotExists(table)
		meta.__mode = "kv";
    }

	public static function setGCMethod(table:lua.Table.AnyTable, meth:Dynamic) {
		final meta = createMTIfNotExists(table)
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