package gmod.stringtypes;

enum abstract Hook<T:Function>(Dynamic) from String to String {
	public inline function new(name:String){
		this = name;
	}
}

@:build(gmod.helpers.macros.BuildGMHooks.build())
enum abstract GMHook<T:Function>(Hook<T>) to String to Hook<T> {
}

