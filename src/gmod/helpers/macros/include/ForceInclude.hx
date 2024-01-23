package gmod.helpers.macros.include;

@:keep
class ForceInclude {

	@:rtti
	static var exceptionToString:Dynamic;

	@:keep
	static function __init__() {
		@:privateAccess exceptionToString = haxe.CallStack.exceptionToString;
	}

}