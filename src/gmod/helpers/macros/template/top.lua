--gmod haxe environment patch
local haxeEnv = {}
setmetatable(haxeEnv,{__index = _G})
setfenv(1,haxeEnv) --context for patches

--used by _ptch_hx_tostring. and it's a local
local _hx_hidden = {__id__=true, hx__closures=true, super=true, prototype=true, __fields__=true, __ifields__=true, __class__=true, __properties__=true, __fields__=true, __name__=true}

local function _ptch_hx_print_class(obj,depth)
	local first = true
	local result = ''
	local x = 0
	for k,v in pairs(obj) do
		if _hx_hidden[k] == nil then
			x = x + 1
			if x > 5 then result = result .. ', <...>' break end
			if first then
				first = false
			else
				result = result .. ', '
			end
			if _hx_hidden[k] == nil then
				result = result .. k .. ':' .. _hx_tostring(v, depth+1)
			end
		end
	end
	return '{ ' .. result .. ' }'
end

local _haxelookupClass = {}
local __m = {["__mode"] = "k"}

local function _ptch_hx_obj_newindex(t,k,v)
   _haxelookupClass[v] = t
	t.__fields__[k] = true
	rawset(t,k,v)
end

local function _ptch_hx_tostring(obj, depth)
	if depth == nil then
		depth = 0
	elseif depth > 5 then
		return "<...>"
	end

	local tstr = _G.type(obj)
	if tstr == "string" then return obj
	elseif tstr == "nil" then return "null"
	elseif tstr == "number" then
		if obj == _G.math.POSITIVE_INFINITY then return "Infinity"
		elseif obj == _G.math.NEGATIVE_INFINITY then return "-Infinity"
		elseif obj == 0 then return "0"
		elseif obj ~= obj then return "NaN"
		else return _G.tostring(obj)
		end
	elseif tstr == "boolean" then return _G.tostring(obj)
	elseif tstr == "userdata" then
		local mt = _G.getmetatable(obj)
		if mt ~= nil and mt.__tostring ~= nil then
			return _G.tostring(obj)
		else
			return "<userdata>"
		end
	elseif tstr == "function" then return "<function>"
	elseif tstr == "thread" then return "<thread>"
	elseif tstr == "table" then
		if obj.__enum__ ~= nil then
			return _hx_print_enum(obj, depth)
		--elseif obj.toString ~= nil and not _hx_is_array(obj) then return obj:toString() --run into some problems with gmdebug, so it can go on the backbench
		elseif _hx_is_array(obj) then
			if obj.length > 5 then
				return "[...]"
			else
				local str = ""
				for i=0, (obj.length-1) do
					if i == 0 then
						str = str .. _hx_tostring(obj[i], depth+1)
					else
						str = str .. "," .. _hx_tostring(obj[i], depth+1)
					end
				end
				return "[" .. str .. "]"
			end
		elseif obj.__class__ ~= nil then
			return _hx_print_class(obj, depth+1) --ran into some issues. Not sure if +1 is 'correct' but it solves it.
		else
			local buffer = {}
			local ref = obj
			if obj.__fields__ ~= nil then
			   ref = obj.__fields__
			end
			local len = 0
			for k,v in pairs(ref) do
			   len = len + 1
			   if (len > 5) then return "<...>" end --might as well treat all identically.
			   if _hx_hidden[k] == nil and _hx_hidden[v] == nil then
				   _G.table.insert(buffer, _hx_tostring(k, depth+1) .. ' : ' .. _hx_tostring(obj[k], depth+1))
			   end
			end
			return "{ " .. table.concat(buffer, ", ") .. " }"
		end
	else
		if (_G.TypeID(obj) == _G.TYPE_NONE) then
			_G.error("Unknown lua type")
			return ""
		  else
			return _G.tostring(obj)
		  end
	end
end

local function _ptch_hx_handle_error(obj)
  local message = tostring(obj)
  if _G.debug and _G.debug.traceback then
	-- level 2 to skip _hx_handle_error
	message = _G.debug.traceback(message, 2)
  end
  -- return setmetatable({}, { __tostring = function() return message end })
  return message --i don't think our _G.error takes objects
end


::if (haxeVersion != "4.3.2")::
if not _G._oldRequire then
	_G._oldRequire = _G.require
end

-- haxe is a little too eager to require modules sometimes, so this prevents script shutdown
-- TODO figure out a way to make this not affect global workspace
-- we could use functions, or proxy tables, profile this plz
_G.require = function (str)
   local info = _G.debug.getinfo(2,"n")
   if (info ~= nil and info.name == "pcall") then
	  -- print(info.name)
	  local val,rtn = pcall(_G.oldRequire,str)
	  -- print("RETURN" .. val)
	  -- print("RETURN2" .. rtn)
	  return val,rtn
   end
   local val,rtn = pcall(_G._oldRequire,str)
   if val then
		print("safe require loaded " .. str)
		return _G[str]
   else
		print("failed to load safe require " .. str)
   end
end
::end::

local require = function (str)
   if str == "bit" then
	  print("BIT PATCHED")
	  return _G.bit,true
   else
	  return _G.require(str)
   end
end

--COMMITAREA, add old error
--sorry, but this is probably for the best for now. Need to do more version checks
if not _G._haxeOldError then
	_G._haxeOldError = _G.error
end

_G.error = function (val,level)
   if level ~= nil then
	  level = level + 2
   else
	  level = 2
   end
  if (__lua_Boot.__instanceof(val, __haxe_Exception)) then
	   _G._haxeOldError(__gmod_helpers_macros_include_ForceInclude.exceptionToString(val),level)
  else
	 _G._haxeOldError(val,level)
  end;
end

local function patchFuncs(tbl,key,val)
   if (key == "_hx_print_class") then
	  rawset(haxeEnv,"_hx_print_class",_ptch_hx_print_class)
   elseif (key == "_hx_tostring") then
	  rawset(haxeEnv,"_hx_tostring",_ptch_hx_tostring)
   elseif (key == "_hx_handle_error") then
	  rawset(haxeEnv,"_hx_handle_error",_ptch_hx_handle_error)
   else
	  rawset(haxeEnv,key,val)
   end
end


local _hx_exports = {}
_G.HAXE_::addonName:: = haxeEnv
setmetatable(_hx_exports,{__index = _G,__newindex = _G})
setmetatable(haxeEnv,{__index = _G, __newindex = patchFuncs})
setfenv(1,haxeEnv) --if using more than one project + dce, global collisions and missing indexes will ensue. dont want that, so we use our env
