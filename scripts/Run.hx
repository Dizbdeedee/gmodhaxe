package scripts;

import sys.io.Process;
import haxe.io.Path;

class Run {

    public static function main() {
        var dir = Sys.args()[0];
        var p = new Process("lix --version");
        var examplePath = if (p.exitCode() != 0) {
            Path.join([Sys.getCwd(),"src","gmod","helpers","macros","exampleproject"]);
        } else {
            Path.join([Sys.getCwd(),"src","gmod","helpers","macros","exampleprojectlix"]);
        }
        Util.recurseCopy(examplePath,dir,(str) -> true);
    }
}
