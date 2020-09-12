--gmod haxe environment patch
local _hx_exports = {__env = haxeEnv}
local haxeEnv = {}
setmetatable(haxeEnv,{__index = _G})
setfenv(1,haxeEnv) --if using more than one project + dce, global collisions and missing indexes will ensue. don't want that 
