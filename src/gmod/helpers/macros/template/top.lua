--gmod haxe environment patch
local haxeEnv = {}
local _hx_exports = {}
_G.HAXE_::addonName:: = haxeEnv 
setmetatable(_hx_exports,{__index = _G,__newindex = _G})
setmetatable(haxeEnv,{__index = _G})
setfenv(1,haxeEnv) --if using more than one project + dce, global collisions and missing indexes will ensue. dont want that 