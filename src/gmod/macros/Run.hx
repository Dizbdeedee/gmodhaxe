package gmod.macros;

import sys.FileSystem;
import haxe.io.Path;
import sys.io.File;

class Run {

    static var client = 
"-cp src
-D client

#Use this to generate a folder structure for an addon
-D addonName=myaddon 
#Use this + above to generate a folder structure for a gamemode
-D gamemode=myaddon 
-D generateLuaInit

#A fully qualified path to your addon folder. Will automatically copy everything inside generated to it
#-D gmodAddonFolder=

-lib gmodhaxe
-main Main
--lua lua/client.lua";

    static var server =
"-cp src
-D server

#Use this to generate a folder structure for an addon
-D addonName=myaddon 
#Use this + above to generate a folder structure for a gamemode
-D gamemode=myaddon 
-D generateLuaInit

-main Main
-lib gmodhaxe
--lua lua/server.lua";

    static var shared =
"-cp src
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
}";

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
    static var settingjson = 
"{
    \"haxe.configurations\": [
        [\"server.hxml\"],
        [\"client.hxml\"],
        [\"shared_view.hxml\"]
    ],
}
";
    static var tasksjson = 
"{
	\"version\": \"2.0.0\",
	\"tasks\": [
        {

            \"type\": \"hxml\",
            \"file\": \"build.hxml\",
            \"problemMatcher\": [
                \"$haxe-absolute\",
                \"$haxe\",
                \"$haxe-error\",
                \"$haxe-trace\"
            ],
            
            \"group\": {
                \"kind\": \"build\",
                \"isDefault\": true
            },
            \"label\": \"gmodhaxe: build server + client\"
        },
        {
            \"type\": \"hxml\",
            \"file\": \"server.hxml\",
            \"problemMatcher\": [
                \"$haxe-absolute\",
                \"$haxe\",
                \"$haxe-error\",
                \"$haxe-trace\"
            ],
            
            \"group\": \"build\",
            \"label\": \"gmodhaxe: build server\"
        },
        {
            \"type\": \"hxml\",
            \"file\": \"client.hxml\",
            \"problemMatcher\": [
                \"$haxe-absolute\",
                \"$haxe\",
                \"$haxe-error\",
                \"$haxe-trace\"
            ],
            \"group\": \"build\",
            \"label\": \"gmodhaxe: build client\"
        }
    ]
}";

    public static function main() {
        var dir = Sys.args()[0];
        File.saveContent(Path.join([dir,"client.hxml"]),client);
        File.saveContent(Path.join([dir,"server.hxml"]),server);
        File.saveContent(Path.join([dir,"shared_view.hxml"]),shared);
        File.saveContent(Path.join([dir,"build.hxml"]),full);
        FileSystem.createDirectory(Path.join([dir,"src"]));
        File.saveContent(Path.join([dir,"src","Main.hx"]),_main);
        FileSystem.createDirectory(Path.join([dir,"examples"]));
        File.saveContent(Path.join([dir,"examples","ExampleEntity.hx"]),exampleent);
        File.saveContent(Path.join([dir,"examples","ExampleGMOverride.hx"]),exampleGM);
        FileSystem.createDirectory(Path.join([dir,".vscode"]));
        File.saveContent(Path.join([dir,".vscode","settings.json"]),settingjson);
        File.saveContent(Path.join([dir,".vscode","tasks.json"]),tasksjson);
    }
}