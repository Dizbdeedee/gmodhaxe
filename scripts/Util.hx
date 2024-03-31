package scripts;

import sys.FileSystem;
import haxe.io.Path;
import sys.io.File;
using StringTools;
using Lambda;

/**
    Recursecopy copies all files IN the target dir
**/
function recurseCopy(curFolder:String,output:String,copyFilePred:(String) -> Bool) {
    for (name in FileSystem.readDirectory(curFolder)) {
        var curFile = Path.join([curFolder,name]);
        var otherFile = Path.join([output,name]);
        if (FileSystem.isDirectory(Path.join([curFolder,name]))) {
            FileSystem.createDirectory(otherFile);
            recurseCopy(Path.join([curFolder,name]),Path.join([output,name]),copyFilePred);
        } else {
            final curname = Path.withoutExtension(Path.withoutDirectory(curFile));
            if (copyFilePred(curname)) {
                File.copy(curFile,otherFile);
            }
        }
    }
}