# gmodhaxe

Haxe externs for gmod + macros intended for gamemode development. [Haxe](https://haxe.org) is a strictly typed language that compiles to lua (+ many other languages like javascript/c++/c#). 

All externs are fully client/server context dependent, so will only work in proper context
(i.e only functions that exist in server/client will autocomplete/build in current context)

Externs have been generated from scraped info from gmod wiki. Things may be improperly typed

Macros are wip

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

Switch configuration between client.hxml and server.hxml (and shared_view.hxml) in vscode to set the autocompletion context

Build in both contexts at once using full_compile.hxml

### Examples

#### Clientside/serverside
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

#### Loops
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

#### Escape hatch

```haxe
untyped __lua__("print({0})","Test");
```




