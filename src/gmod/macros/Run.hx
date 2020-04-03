package gmod.macros;

import sys.FileSystem;
import haxe.io.Path;
import sys.io.File;

class Run {

    static var client = 
"-cp src
-D lua-5.1
-D lua-vanilla
-D luajit
-D client

#Use this to generate a folder structure for an addon
-D addonName=myaddon 
#Use this + above to generate a folder structure for a gamemode
-D gamemode=myaddon 

-D generateLuaInit
#A fully qualified path to your addon folder. Will automatically copy everything inside generated to it
#-D gmodAddonFolder= 
--macro gmod.macros.InitMacro.init()
-main Main
--lua lua/client.lua";

    static var server =
"-cp src
-D lua-5.1
-D lua-vanilla
-D luajit
-D server

#Use this to generate a folder structure for an addon
-D addonName=myaddon 
#Use this + above to generate a folder structure for a gamemode
-D gamemode=myaddon 

-D generateLuaInit
--macro gmod.macros.InitMacro.init()
-main Main
--lua lua/server.lua";

    static var shared =
"-cp src
-D lua-5.1
-D luajit
-D lua-vanilla
-main Main
--lua lua/shared.lua
--no-output
";

    static var full =
"server.hxml

--next

client.hxml";

    static var _main = 
"import gmod.libs.PlayerLib;

using gmod.PairTools;

class Main {
	public static function main() {
		for (player in PlayerLib.GetAll()) {
			trace('Hello ${player.GetName()}');
        }
        trace(\"Hello world!\");
    }
";

    static var exampleent =
"import gmod.sent.SentBuild;

class ExampleEnt extends gmod.sent.ENT_ANIM implements SentBuild {

    final properties:EntFields = {
        Base : \"base_entity\"
    }

    override function Initialize() {
        trace(\"Example entity spawned\");
    }
    
}
";

    static var exampleGM =
"import gmod.gamemode.BuildOverrides;

class ExampleGMOverride implements BuildOverrides extends gmod.gamemode.GM {

    override function Initialize() {
        trace('Example GM override!');
    }
    
}
";

    public static function init(dir:String) {
        File.saveContent(Path.join([dir,"client.hxml"]),client);
        File.saveContent(Path.join([dir,"server.hxml"]),server);
        File.saveContent(Path.join([dir,"shared_view.hxml"]),shared);
        File.saveContent(Path.join([dir,"full_compile.hxml"]),full);
        FileSystem.createDirectory(Path.join([dir,"src"]));
        File.saveContent(Path.join([dir,"src","Main.hx"]),_main);
        FileSystem.createDirectory(Path.join([dir,"examples"]));
        File.saveContent(Path.join([dir,"examples","ExampleEntity"]),exampleent);
        File.saveContent(Path.join([dir,"examples","ExampleGMOverride"]),exampleGM);
    }
}