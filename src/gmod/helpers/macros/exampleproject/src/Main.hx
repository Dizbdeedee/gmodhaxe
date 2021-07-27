import gmod.libs.PlayerLib;

class Main {
	public static function main() {
		for (player in PlayerLib.GetAll()) {
			trace('Hello ${player.GetName()}');
        }
        trace("Hello world!");
    }
}