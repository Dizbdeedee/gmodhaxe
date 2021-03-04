package gmod.helpers.macros.include;


class Build {

	#if !macro
	@:expose("buildIdent") //TODO improve
	static var buildIdent:String = getBuildIdent();
	#end

	static macro function getBuildIdent() {
		return macro $v{gmod.helpers.macros.InitMacro.buildIdent}
	}
}
