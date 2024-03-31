package scripts;

import haxe.io.Path;

class Run {

    public static function main() {
        var dir = Sys.args()[0];
        var examplePath = Path.join([Sys.getCwd(),"src","gmod","helpers","macros","exampleproject"]);
        Util.recurseCopy(examplePath,dir,(str) -> true);
    }
}
