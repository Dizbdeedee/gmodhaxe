local exports 
if SERVER then 
    AddCSLuaFile("@(addonName)/@(clientName).lua") 
    exports = include("@(addonName)/@(serverName).lua") 
end
if CLIENT then 
    exports = include("@(addonName)/@(clientName).lua") 
end
