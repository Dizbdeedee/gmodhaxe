package gmod.helpers;


@:access(haxe.ds.ObjectMap)
class WeakTools {

    public static function setWeakKeys(table:lua.Table.AnyTable):Void {
		var prevMeta:lua.Table.AnyTable = Gmod.getmetatable(table);
		if (prevMeta == null) {
			prevMeta = Table.create();
			Gmod.setmetatable(table,prevMeta);
		} 
		prevMeta.__mode = "k";
    }
  
    public static function setWeakValues(table:lua.Table.AnyTable):Void {
		var prevMeta:lua.Table.AnyTable = Gmod.getmetatable(table);
		if (prevMeta == null) {
			prevMeta = Table.create();
			Gmod.setmetatable(table,prevMeta);
		} 
		prevMeta.__mode = "v";
    }

    public static function setWeakKeyValues(table:lua.Table.AnyTable):Void {
		var prevMeta:lua.Table.AnyTable = Gmod.getmetatable(table);
		if (prevMeta == null) {
			prevMeta = Table.create();
			Gmod.setmetatable(table,prevMeta);
		} 
		prevMeta.__mode = "kv";
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