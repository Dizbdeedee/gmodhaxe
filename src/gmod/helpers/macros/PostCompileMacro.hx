package gmod.helpers.macros;
import sys.io.FileInput;
import haxe.io.Bytes;
import haxe.io.BytesData;
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

    static final sizeLimit = 600000;

	public static function main() {
		if (Sys.getEnv("gmodhaxe_addonName") != null && Sys.getEnv("gmodhaxe_output") != null) {
			envPatch();
			if (Sys.getEnv("gmodhaxe_gmodAddonFolder") != null) {
				updateAddonFolder();
			}
            if (Sys.getEnv("gmodhaxe_buildIdent") != null && Sys.getEnv("gmodhaxe_printIdent") != null) {
                printIdent();
            }
            // if (FileSystem.stat(Sys.getEnv("gmodhaxe_output")).size > sizeLimit) {
            //     splitFiles();
            // }
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
                final curname = Path.withoutExtension(Path.withoutDirectory(curFile));
                if (Sys.getEnv("gmodhaxe_notCopy") != curname) {
                    File.copy(curFile,otherFile);
                }
            }
        }
    }

	static function clearEnvs() {
		Sys.putEnv("gmodhaxe_gmodAddonFolder","");
		Sys.putEnv("gmodhaxe_addonName","");
        Sys.putEnv("gmodhaxe_output","");
        Sys.putEnv("gmodhaxe_buildIdent","");
		Sys.putEnv("gmodhaxe_printIdent","");
        Sys.putEnv("gmodhaxe_notCopy","");
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

    static function readUntilBlankNewLine(f:FileInput) {
        final str = "";
        while (!f.eof()) {
            final one = f.readString(1);
            final two = f.readString(1);
            f.seek(-1,SeekCur);
            str += one;
            if (one == "\n" && two == "\n") {
                return str;
            }
        }
        throw "Reached eof without two newlines...";
    }


    static function splitFiles() {
        final addonName = Sys.getEnv("gmodhaxe_addonName").toLowerCase();
        final outputName = Sys.getEnv("gmodhaxe_output");
        final read = File.read(outputName);
        final beforeBytes = {
            final before = read.read(sizeLimit);
            final beforeLineStr = readUntilBlankNewLine(read);
            final beforeLine = Bytes.ofString(beforeLineStr);
            final newBytes = new haxe.io.Bytes(before.length + beforeLine.length,before);
            newBytes.blit(before.length,beforeLine,0,beforeLine.length);
//             final include = Bytes.ofString("
// CompileFile(\"deceptinfect/gamemode/\")")
            final directory = Path.join([addonName,"gamemode",outputName]);
            final include = Bytes.ofString('
local compenv = {}
for i=1,9999 do
    local n,v = debug.getlocal(1,i)
    if n == nil then break end
    compenv[n] = l
end
local compenv = setmetatable({},{__index})
final result = CompileFile("$directory")

');
            newBytes;
        }
        read.seek(sizeLimit,SeekBegin);
        readUntilBlankNewLine(read);
        if (read.eof()) throw "Invalid..";
        final cutBytes = read.readAll();
        read.close();
        FileSystem.deleteFile(outputName);
        File.saveBytes(outputName,beforeBytes);
        File.saveBytes(outputName.substr(0,outputName.length - 4) + "_1.lua",cutBytes);
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