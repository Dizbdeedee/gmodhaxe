--gmodhaxe overrides
local haxeEnv = {}
setmetatable(haxeEnv,{__index = _G})
setfenv(1,haxeEnv) --if using more than one project + dce, global collisions and missing indexes will ensue. don't want that 
_hx_exports = {__env = haxeEnv}

_hx_print_2 = function(str)
    local len = #str
    if (len > 1000) then
        --print("splitting")
        for i=0,len - 1,1000 do
            local p = math.min(i + 1000,len)
            print(string.sub(str,i + 1,p))
        end
    else
        ---print("not splitting")
        print(str)
    end
end or (function() end)
debug.setmetatable(_hx_print_2,{printHandler = true}) -- TODO remove

function _hx_print_class(obj, depth)
    local first = true
    local result = ''
    local x = 0
    for k,v in pairs(obj) do
        if _hx_hidden[k] == nil then
            x = x + 1;
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

function _hx_tostring(obj, depth)
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
        elseif obj.toString ~= nil and not _hx_is_array(obj) then return obj:toString()
        elseif _hx_is_array(obj) then
            if obj.length > 5 then
                return "[...]"
            else
                str = ""
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
            return _hx_print_class(obj, depth)
        else
            first = true
            buffer = {}
            for k,v in pairs(obj) do
                if _hx_hidden[k] == nil then
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

if not _G._oldRequire then
    _G._oldRequire = _G.require
end

_G.require = function (str) local val,rtn = xpcall(_G._oldRequire,function (err) print("Failed to load module:" .. str .. " but did not halt" ) end,str) if val then print("loaded :)" .. str) return _G[str] end end

local _hx_obj_mt = {__newindex=_hx_obj_newindex, __tostring=_hx_tostring}
--end
