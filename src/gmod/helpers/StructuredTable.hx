package gmod.helpers;

import lua.Lua;
import gmod.helpers.PairTools;


@:forward
@:transitive
abstract StructuredTable<S,K,V>(S) to S  {

    /**
        Uses `Lua.pairs`
    **/
    public inline function keyValueIterator():KeyValueIterator<K,V> {
      return PairTools.keyValueIterator(cast this);
    }
    /**
        Uses `Lua.pairs`
    **/
    public inline function iterator():Iterator<V> {
      return PairTools.iterator(cast this);
    }

    @:op([])
    inline function arrAccess(key:K) {
		  return untyped this[key];
    }

    @:op([])
    inline function arrAcessSet(key:K,val:V) {
		  return untyped this[key] = val;
    }

	  @:to
    public inline function toTbl():lua.Table<K,V> {
		  return cast this;
    }
    
}

@:forward
@:transitive
abstract StructuredLuaArray<S,V>(S) to S {

	  public inline function keyValueIterator():KeyValueIterator<Int,V> {
      return new LuaKVIPIterator(cast this);
    }

    public inline function iterator():Iterator<V> {
      return new LuaIPIterator(cast this);
    }

    @:op([])
    inline function arrAccess(key:Int) {
		  return untyped this[key];
    }

    @:op([])
    inline function arrAcessSet(key:Int ,val:V) {
		  return untyped this[key] = val;
    }

    @:to
    public inline function toTbl():lua.Table<Int,V> {
		  return cast this;
    }

    @:to
    public inline function toLuaArr():LuaArrayExt<V> {
		  return cast this;
    }
}

typedef AnyStructuredTable<S> = StructuredTable<S,Dynamic,Dynamic>;

typedef AnyStructuredLuaArray<S> = StructuredLuaArray<S,Dynamic>;