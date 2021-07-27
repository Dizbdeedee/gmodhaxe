import gmod.helpers.gamemode.GMBuild;

class ExampleGMOverride extends gmod.helpers.gamemode.GMBuild<gmod.gamemode.GM> {

    override function Initialize() {
        trace('Example GM override!');
    }
    
}