# gmodhaxe

Haxe externs for gmod + macros intended for gamemode development. [Haxe](https://haxe.org) is a strictly typed language that compiles to lua (+ many other languages like javascript/c++/c#). 

All externs are fully client/server context dependent, so will only work in proper context
(i.e only functions that exist in server/client will autocomplete/build in current context)

Externs have been generated from scraped info from gmod wiki. Things may be improperly typed

## Setup

[Download haxe](https://haxe.org/download/)

Install [vscode](https://code.visualstudio.com/) + [vshaxe](https://marketplace.visualstudio.com/items?itemName=nadako.vshaxe) (highly recommended) 

Install gmodhaxe by running the following command
`haxelib install gmodhaxe`

Run this command in an empty folder to get started
`haxelib run gmodhaxe`

## Basic usage

Switch between developing for the server/client/both by switching the autocompletion context to `server.hxml` and `client.hxml`.

Build your project using `build.hxml`

If you want to change between building for an addon/gamemode, or if you want to change the addons name, change the following lines in `args.hxml`

`-D addonname=myaddon`

`-D gamemode=myaddon`

Remove `-D gamemode` if you are developing an addon rather than a gamemode

If you want to automatically copy files on a successful build, uncomment this line and replace with your garrysmod addon directory

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
You can use this with variables and classes too, to have clientside/serverside only variables/classes. Otherwise, everything is shared.

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

Ipairs versions are also avaliable from gmod.PairTools
#### Exposing to lua
```haxe

class Test {
  
  @:expose("func")
  static function exposedFuncShort() {
  }
  
  @:expose
  static function exposedFuncLong() {
  
  }
}
```

In lua...

```lua
func()
Test.exposedFuncLong()
```

You can add paths to any exposure, and expose classes if you wish

```haxe
@:expose("myaddon.MyClass")
class Test {

  static var myString:String = "hello";

}
```

```lua
print(myaddon.MyClass.myString)
>hello
```

See https://haxe.org/manual/target-javascript-expose.html (for javascript but same rules apply)

### Overriding hooks

#### Gamemode

Create a class like so

```haxe
class MyGamemodeHooks extends gmod.gamemode.GMBuild<gmod.gamemode.GM> {

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
class MyCoolEntity extends gmod.sent.SentBuild<gmod.sent.ENT_ANIM> {
  
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
Because this relies on generated files, all functions will be automatically overridden, no need to call any functions. Make sure to import it somewhere in your code, otherwise it won't generate.

#### Custom panel

Extend from `gmod.cpanel.PanelBuild<panel here>`

Register your custom panel by calling .register() on your custom panel class.

To create a new custom panel, use VguiLib.Create(`gclass`) where `gclass` is located on your panel class or alternatively use the name of your custom panel class.

#### Custom swep/effect

Same as entity, `extends gmod.swep.SwepBuild` and `extends gmod.effects.EffectBuild`

### Networking

#### NET_Server/NET_Client
Automatically builds net messages from a given typedef, with the ability to add more than one reciever. Probably adds some overhead.
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
