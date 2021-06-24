# gmodhaxe

Haxe externs for gmod + macros intended for gamemode development. [Haxe](https://haxe.org) is a strictly typed language that compiles to lua (+ many other languages like javascript/c++/c#). 

All externs are fully client/server context dependent, so will only work in proper context
(i.e only functions that exist in server/client will autocomplete/build in current context)

Externs have been generated from scraped info from an older version of the gmod wiki. Things may be improperly typed, and therefore if you see any out of date documentation, definition or need to use a new function not avaliable, please submit a pull request or an issue.

This has been developed alongside a new gamemode I hope to release soon, you can check it out if you want more detailed examples on how to use this library.

## Why?
Haxe comes with some advantages over just plain (gmod) lua development

### Pros

- Free autocompletion and compiler 

Not just hacked onto lua, and so a lot more reliable

- Typing

Type all the things! Compile errors instead of runtime errors! Horray!

When developing a gamemode, nothing is worse than being trapped in the cycle of save code -> run through game -> mispelled variable name -> back to square one

This might be because I'm a bad developer though...
    
- Target defines for server + client

Goodbye shared.lua, and unavaliable functions cluttering your autocompletion solution

- Macros mean we can take post compile steps 

This enables gmodhaxe to copy your build on save, meaning you can develop a lua addon from your documents folder instead of delving into the depths of your gmod installation each time

- Consistent definition of classes

Class syntax is free, and always the same instead of being DIY

- Cross compilation 

This means you can create projects that talk to gmod lua in one consistent language + syntax. Less context switching required

As a bonus, you can also utilise great haxe libraries that are cross platform compatabile!

Also, it seems S&Box is going to have C# as it's scripting language. Haxe compiles to C#, and as such it should be totally possible to create an addon that compiles to both S&Box and gmod! This won't solve the issue of library compatability between the two games, it is likely you would have to make your own layer between the two APIs, however, you can be assured that the bulk of your logic is not locked to one platform.

### Cons
However, Haxe -> lua is not free of flaws, and certainly does not fit every use case. Here are some reasons why you shouldn't use it

- The compiled code has a larger file size, and is slower.

There's no getting away from it, the code that is made using Haxe -> lua is going to be larger (see -dce full for mitigations), and less efficient than    handwritten lua code. If your code is performance critical and is not a large project, you're better of just using lua directly instead.

- You're not making a large project

If your're making something small, or maybe even medium sized and you already know and love lua, then there's not much point in learning haxe.

- Edge cases

There will be edge cases where incorrect lua is generated, or what you're trying to do hasn't been properly mapped into this library. If this is the case, please file an issue! Anything that helps this library be more accessible and easier to use is appreciated.

- Not intrested in typing

If you like lua because of it's dynamic typing, there's not much point in using haxe.

## Changelog

### 0.2.2

- Ability to add the `@:gmodHook` metadata to a function to attempt to automatically add a hook for it. See examples for more detail

- Proper hxbit support in progress
### 0.2.1

- Now has a proper post compile step. Please add the following line to your hxml file next to the `--macro` line

`--cmd haxe -lib gmodhaxe --run gmod.helpers.macros.PostCompileMacro`

- This should fix issues where you had to build twice for the lua files to copy over/update

- Fix for redfined types error


## Setup

[Download haxe](https://haxe.org/download/)

Install [vscode](https://code.visualstudio.com/) + [vshaxe](https://marketplace.visualstudio.com/items?itemName=nadako.vshaxe) (highly recommended) 

Install gmodhaxe by running the following command
`haxelib install gmodhaxe`

Run this command in an empty folder to get started
`haxelib run gmodhaxe`

## Basic Usage

Switch between developing for the server/client/both by switching the autocompletion context to `server.hxml`, `client.hxml` and `shared_view.hxml`.

<img src="https://user-images.githubusercontent.com/46794914/109648654-ca823e00-7b52-11eb-8cb1-2f43bd541c1b.gif" width="893" height="702">

Build your overall project using the `build.hxml` task, or hit CTRL-SHIFT-B

To get started, see the examples section below.

### Further details

Build individual targets by building `server.hxml` and `client.hxml`. `shared_view.hxml` is not a valid build target, and no `shared.lua` type files will be generated by gmodhaxe. See non starter pack usage for more details.

If you want to change between building for an addon/gamemode, or if you want to change the addons name, change the following lines in `args.hxml`

`-D addonname=myaddon`

`-D gamemode=myaddon`

Remove `-D gamemode` if you are developing an addon rather than a gamemode

If you want to automatically copy files on a successful build, uncomment this line and replace with your garrysmod addon directory

`#-D gmodAddonFolder=C:/steam/garrysmod/addons`

### Non starter pack usage

If you have your own custom hxml setup, ensure you include the lines

`--macro gmod.helpers.macros.InitMacro.init()` 

`--cmd haxe -lib gmodhaxe --run gmod.helpers.macros.PostCompileMacro`

somewhere in every build, otherwise this libraries helpers and folder generation will not work.

To use server functions, add `-D server` to your build and vice versa. Do not add both `-D server` and `-D client` to one build, as this could have undefined effects on the build process. Instead, use two seperate builds for both the server and the client. Haxe code that is included from both builds will appear in both lua files, effectively filling the role of a traditional `shared.lua` file. To make this double build process easier, you can always include a `buildall.hxml` type file, that contains `server.hxml --next client.hxml`. Upon building through buildall, both builds will be executed in order.

To use `-D addonname` and `-D gamemode` properly, ensure they are located in both `server.hxml` and `client.hxml`. See also `--each`

For more details, check [here](https://haxe.org/manual/compiler-usage-hxml.html)

## Layout

`gmod.Gmod` 

All the global library functions of Gmod, and some variables. e.g [IsValid](https://wiki.facepunch.com/gmod/Global.IsValid), [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime), [GAMEMODE](https://wiki.facepunch.com/gmod/gmod.GetGamemode)

`gmod/gclass`

Contains gmod classes e.g [Entity](https://wiki.facepunch.com/gmod/Entity), [Player](https://wiki.facepunch.com/gmod/Player). You can't use these classes without going through a `gmod/libs` function first. (Exceptions being `Vector` and `Angle`)

`gmod/libs`

Gmod libraries e.g [ents.](https://wiki.facepunch.com/gmod/ents) , [hook.](https://wiki.facepunch.com/gmod/hook)

`gmod/structs`

Different types of structs/tables. Most of these return from gmod's library functions

`gmod/enums`

Gmod enums. These are always retrieved from the global table.

`gmod/stringtypes`

Stringly typed gmod helper abstracts. You'll find abstracts like `Hook` and `EntityClass` here. If you combine them with thier respective `gmod.libs` functions, you'll have more type safe results. 

For example, using a `Hook` abstract e.g `gmod.stringtypes.Hook.GMHooks.Think` (corresponding to the string `"Think"`) along with the library function `gmod.libs.HookLib.Add` will only allow you to add a function that conforms to a `Think` hook - a function that takes no arguments and returns nothing.

See [abstracts](https://haxe.org/manual/types-abstract.html) for more details on what an abstract is

`gmod/effects` | `gmod/gamemode` | `gmod/sent` | `gmod/panels` | `gmod/swep`

Mostly intended for use with building macros. You can safely ignore if you're not using them.

`gmod/helpers`

Helper classes and macros that can make development a lot simpler. `PairTools` and `TableTools` allow you to treat treat lua tables as haxe tables in for loops, and are automatically imported by default. Classes ending with `Tools` are [static extensions](https://haxe.org/manual/lf-static-extension.html) and need to be imported using the `using` keyword.

`gmod/helpers/gamemode` | `gmod/helpers/effects` | `gmod/helpers/swep` | `gmod/helpers/sent` | `gmod/helpers/swep`

Building macros. If you want to build a custom version of one of these, then extending the classes contained is a good place to start. See examples for more details.

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

### Global functions

```lua
local time = CurTime()
if time > 0 then
  print("The server time is " .. time)
end
```
becomes
```haxe
import gmod.Gmod;
...
...
var time = Gmod.CurTime();
if (time > 0) {
  trace('The server time is $time');
  //or lua.Lua.print if you prefer
}
```
### Loops
```lua
for index,player in pairs(player.GetAll()) do 
  player:SetPos(Vector(100,50,10))
end
```
becomes
```haxe
import gmod.libs.PlayerLib; //or import gmod.libs.*;
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
### Exposing to lua

If you wish to access haxe functions, variables or classes from a different lua file then you must expose them.

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

### Hooks

#### Static functions

To automatically add a hook on script startup, add the following metadata on top of your function.

`@:gmodHook()`

For example, to add a think hook to your function

```haxe

class Example {
  
  @:gmodHook(Think)
  @:gmodHook(Think,"myhookname") //if you wish to name the hook
  static function myThinkHook() {

  }

}
```

#### Gamemode

Create a class like so

```haxe
class MyGamemodeHooks extends gmod.helpers.gamemode.GMBuild<gmod.gamemode.GM> {

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
class MyCoolEntity extends gmod.helpers.sent.SentBuild<gmod.sent.ENT_ANIM> {
  
  //required
  final properties:gmod.sent.SentBuild.EntFields = {
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
Because this relies on generated files, all functions will be automatically overridden, no need to call any functions. However, you must make sure to import it somewhere in your code, otherwise it won't generate.

#### Custom panel

Extend from `gmod.helpers.panels.PanelBuild<panel here>`

Register your custom panel by calling .register() on your custom panel class.

To create a new custom panel, use VguiLib.Create(`gclass`) where `gclass` is located on your panel class or alternatively use the name of your custom panel class.

#### Custom swep/effect

Same as entity, `extends gmod.helpers.swep.SwepBuild` and `extends gmod.helpers.effects.EffectBuild`

### Networking

`gmod.helpers.net.NET_Server/NET_Client`

Automatically builds net messages from a given typedef, with the ability to add more than one reciever. Probably adds some overhead.
```haxe
typedef MyTestMessage = {
  name : String,
  ent1 : Entity,
  pos1 : Vector,
  num1 : Float,
}

class MyClass {

  static var net_test = new gmod.helpers.net.NET_Server<"netMessageName",MyTestMessage>;
  
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

### Lambda

Functional programming (ish) for lua tables!

To use, add an `using Lambda` import somewhere in your code.

See haxe [Lambda](https://haxe.org/manual/std-Lambda.html)
