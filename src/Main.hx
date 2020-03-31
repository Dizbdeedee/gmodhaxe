import gmod.libs.PlayerLib;
using gmod.PairTools;

class Main {
	public static function main() {
		for (player in PlayerLib.GetAll()) {
			trace('Hello ${player.GetName()}');
		}
		trace('Hello world');
  	}
}