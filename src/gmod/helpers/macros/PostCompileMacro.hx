package gmod.helpers.macros;
import haxe.macro.Context;
import sys.FileSystem;
import haxe.io.Path;
import sys.io.File;
import sys.FileSystem;

class PostCompileMacro {

	static final pos = Context.makePosition({min : 0, max: 0, file : "gmodhaxe - FinalMacro.hx"});

    static final nato = [
        "Alpha", 
        "Bravo", 
        "Charlie", 
        "Delta", 
        "Echo", 
        "Foxtrot", 
        "Golf", 
        "Hotel", 
        "India", 
        "Juliett", 
        "Kilo", 
        "Lima", 
        "Mike", 
        "November", 
        "Oscar", 
        "Papa", 
        "Quebec", 
        "Romeo", 
        "Sierra", 
        "Tango", 
        "Uniform", 
        "Victor", 
        "Whiskey", 
        "Xray", 
        "Yankee", 
        "Zulu"
    ];

	public static function main() {
		if (Sys.getEnv("gmodhaxe_addonName") != null && Sys.getEnv("gmodhaxe_output") != null) {
			envPatch();
			if (Sys.getEnv("gmodhaxe_gmodAddonFolder") != null) {
				updateAddonFolder();
			}
            if (Sys.getEnv("gmodhaxe_buildIdent") != null && Sys.getEnv("gmodhaxe_printIdent") != null) {
                printIdent();
            }
		}
	}

    static function printIdent() {
        trace("build ident: " + buildStr(Sys.getEnv("gmodhaxe_buildIdent")));
    }    

    static function recurseCopy(curFolder:String,output:String) {
        for (name in FileSystem.readDirectory(curFolder)) {
            var curFile = Path.join([curFolder,name]);
            var otherFile = Path.join([output,name]);
            if (FileSystem.isDirectory(Path.join([curFolder,name]))) {
                FileSystem.createDirectory(otherFile);
                recurseCopy(Path.join([curFolder,name]),Path.join([output,name]));
            } else {
                File.copy(curFile,otherFile);
            }
        }
    }

	static function clearEnvs() {
		Sys.putEnv("gmodhaxe_gmodAddonFolder","");
		Sys.putEnv("gmodhaxe_addonName","");
        Sys.putEnv("gmodhaxe_output","");
        Sys.putEnv("gmodhaxe_buildIdent","");
		Sys.putEnv("gmodhaxe_printIdent","");
	}

	static function updateAddonFolder() {
        var gmodAddonFolder = Sys.getEnv("gmodhaxe_gmodAddonFolder");
        var exists = FileSystem.exists(gmodAddonFolder);
        var abs = Path.isAbsolute(gmodAddonFolder);
        var isdir = FileSystem.isDirectory(gmodAddonFolder);
        switch ([exists,abs,isdir]) {
            case [true,true,true]:
                recurseCopy("generated",gmodAddonFolder);
            case [false,_,_]:
                Context.warning("gmodAddonFolder defined but does not exist",pos);
            case [_,false,_]:
                Context.warning("gmodAddonFolder defined but is in invalid format",pos);
            case [_,_,false]:
                Context.warning("gmodAddonFolder defined but is not a directory",pos);
        }
    }

	static function envPatch() {
        final addonName = Sys.getEnv("gmodhaxe_addonName").toLowerCase();
        final curoutput = File.getBytes(Sys.getEnv("gmodhaxe_output"));
        final fl = File.write(Sys.getEnv("gmodhaxe_output"));
        fl.writeString('--gmod haxe environment patch
local haxeEnv = {}
local _hx_exports = {}
_G.HAXE_$addonName = haxeEnv 
setmetatable(_hx_exports,{__index = _G,__newindex = _G})
setmetatable(haxeEnv,{__index = _G})
setfenv(1,haxeEnv) --if using more than one project + dce, global collisions and missing indexes will ensue. dont want that 
'); //TODO move to template system
        if (Sys.getEnv("gmodhaxe_buildIdent") != null) {
            fl.writeString('--build ident: ${buildStr(Sys.getEnv("gmodhaxe_buildIdent"))}\n');
        }
        fl.write(curoutput);
        fl.close();
    }

    static function buildStr(s:String) {
        final buildIdent = Std.parseInt(s);
        return nato[Math.floor(buildIdent / 27)] + " " + nato[buildIdent % 27];
    }
}