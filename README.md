# gmodhaxe

Haxe externs for gmod + macros intended for gamemode development. [Haxe](https://haxe.org) is a strictly typed language that compiles to lua (+ many other languages like javascript/c++/c#). 

All externs are fully client/server context dependent, so will only work in proper context
(i.e only functions that exist in server/client will autocomplete/build in current context)

Externs have been generated from scraped info from gmod wiki. Things may be improperly typed

## Setup

[Download haxe](https://haxe.org/download/)

Install [vscode](https://code.visualstudio.com/) + [vshaxe](https://marketplace.visualstudio.com/items?itemName=nadako.vshaxe) (highly recommended) 

Create a new project in vscode, and build using full_compile.hxml

If all goes well, upon a successful build you should see a new folder `generated` with the following structure

```
generated
  myaddon
    gamemodes
      myaddon
        entities
          ...
        gamemode
          init.lua
          haxe_cl_init.lua
          haxe_init.lua
          cl_init.lua
```

Currently, you'll have to make your own gamemode.txt file

If the stars align, then if you include/run this code from gmod, it should print to console

```
src/Main.hx:34: Hello name
```
## Basic usage

Switch configuration between `client.hxml` and `server.hxml` (and `shared_view.hxml`) in vscode to set the autocompletion context

Build in both contexts at once using `full_compile.hxml`.

If you want to change between building for an addon/gamemode, or if you want to change the addons name, change the following lines in `client.hxml` and `server.hxml`

`-D addonname=myaddon`
`-D gamemode=myaddon`

Remove gamemode to develop for just an addon only. Haven't tested this much

If you want to automatically copy files on a successful build, head into `client.hxml` and uncomment this line
`#-D gmodAddonFolder=C:/steam/garrysmod/addons`

## Examples

### Clientside/serverside
```lua 
if CLIENT then 
... 
end
``` 
becomes 
```haxe 
#if client 
... 
#end
```
You can use this with variables and classes too, to have clientside/serverside only variables/classes. Otherwise everything is shared.

See https://haxe.org/manual/lf-condition-compilation.html

### Loops
```lua
for index,player in pairs(player.GetAll()) do 
  player:SetPos(Vector(100,50,10))
end
```
becomes
```haxe
using gmod.PairTools;
import gmod.libs.PlayerLib; //or import gmod.libs.*;
import gmod.types.Vector;
...
...
for (player in PlayerLib.GetAll()) {
  player.SetPos(new Vector(100,50,10));
}
//OR
for (index => player in PlayerLib.GetAll()) {
  player.SetPos(new Vector(100,50,10));
}
```

#### Exposing to lua

```haxe

class Test {
  
  @:expose("funky")
  static function exposedFuncShort() {
  }
  
  @:expose
  static function exposedFuncLong() {
  
  }
}
```

In lua...

```lua
myaddon_HAXE_EXPORT.funky()
myaddon_HAXE_EXPORT.Test.exposedFuncLong()
```

See https://haxe.org/manual/target-javascript-expose.html (for javascript but same rules apply)

### Overriding hooks

#### Gamemode

Create a class like so

```haxe
class MyGamemodeHooks implements gmod.gamemode.BuildOverrides extends gmod.gamemode.GM {

  override function Think() {
    trace("Thinking...");
    
    //if you need to refer to the underlying gamemode table use self instead of this
    //i.e self.Think()
  }
  
  //If you want to a haxe function to be exposed to the gamemode table (i.e can use it in lua), use the following metadata
  @:exposeGM
  function exposedFunction() {
  
  }
  
  
}
```

Functions aren't automatically overridden, so you must create a new instance of your class, preferably in main.
`new MyGamemodeHooks();`

#### Custom sent

```haxe
class MyCoolEntity implements gmod.sent.SentBuild extends gmod.sent.ENT_ANIM {
  
  //required to generate files
  final properties:EntFields = {
    Base : "base_entity"
    //other fields go here. in vscode can control + space to see fields
  }
  
  override function Initialize() {
    trace("new entity!");
    
    //again, use self to refer to underlying object
    self.SetPos(new Vector(100,-10,50));
  }
  
  @:exposeENT
  function exposedFunc() {
  
  }
}
```
Because this relies on generated files, all functions will be automatically overridden, no need to call any functions.

#### Custom swep/effect

Same as custom sent

### Networking

This is mostly for convience, and adds some overhead

```haxe
typedef MyTestMessage = {
  name : String,
  ent1 : Entity,
  pos1 : Vector,
  num1 : Float,
}

class MyClass {

  static var net_test = new gmod.net.NET_Server<"netMessageName",MyTestMessage>;
  
  #if server
  static public function send() {
    net_test.send({
      name : "test",
      ent1 : GlobalLib.Entity(0),
      pos1 : new Vector(0,0,0),
      num1: 1.5
      },PlayerLib.GetByID(1));
  }
  #end
  #if client
  static public function initmessage() {
    net_test.addReceiver("testIdent",recvTest);
  }
  
  static function recvTest(data:MyTestMessage) {
    trace(data);
  }
  #end

}
```

