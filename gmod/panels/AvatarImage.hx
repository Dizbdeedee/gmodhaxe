package gmod.panels;
#if client

/**
    Used to show a player's Steam avatar. You are recommended but not limited to pick one of the following sizes: 16, 32, 64, 84, 128, 184.
**/
extern class AvatarImage extends Panel {
    /**
        Used by AvatarImage panels to load an avatar by its 64-bit Steam ID (community ID).
		
		Name | Description
		--- | ---
		`steamid` | The 64bit SteamID of the player to load avatar of
		`size` | The size of the avatar to use. Acceptable sizes are 32, 64, 184.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a grid of randomly generated Steam avatars which link to their corresponding Steam user pages.
		
		```lua 
		-- Returns a random 64-bit Steam ID between STEAM_0:0:1 and STEAM_0:1:100000000
		function GetRandomSteamID()
		    return "7656119"..tostring(7960265728+math.random(1, 200000000))
		end
		
		-- Create the Steam User Grid
		-- Arg1: the size of each avatar
		-- Arg2: the size to load each avatar (16, 32, 64, 84, 128, 184)
		function CreateSteamUserGrid(av_size, av_res)
		
		    -- Remove this block of code if you do not mind loading thousands of avatars
		    if(av_size < 64) then
		        Error("Avatar size cannot be less than 64 square pixels.\n")
		        return
		    end
		    
		    -- Delete existing grid
		    if(SteamUserGrid) then SteamUserGrid:Remove() end
		    
		    -- The amount of avatars we can fit width-wise and height-wise
		    local w_count = math.floor(ScrW()/av_size)
		    local h_count = math.floor((ScrH()-25)/av_size)    -- 25 = frame header size
		        
		    -- Container panel
		    SteamUserGrid = vgui.Create("DFrame")
		    SteamUserGrid:SetSize(w_count*av_size, (h_count*av_size)+25)
		    SteamUserGrid:Center()
		    SteamUserGrid:SetTitle("Randomly Generated Grid of Steam Users")
		    SteamUserGrid:MakePopup()
		    
		    -- Loop variables
		    local avatar, random_id
		    
		    -- Create enough avatars to fill up screen without overflowing
		    for i = 0, (w_count*h_count)-1 do
		    
		        random_id = GetRandomSteamID()
		        
		        -- Add avatar to container panel
		        avatar = vgui.Create("AvatarImage", SteamUserGrid)
		        
		        -- Layout the avatars in a grid
		        avatar:SetPos((i%w_count)*av_size, 25+math.floor(i/w_count)*av_size)
		        
		        -- Load the avatar image
		        avatar:SetSteamID(random_id, av_res)
		
		        avatar:SetSize(av_size, av_size)
		        
		        -- Open user's Steam page on avatar click
		        avatar.OnMousePressed = function(self)
		            
		            local url = "http://steamcommunity.com/profiles/"..random_id
		            
		            gui.OpenURL(url)
		            
		        end
		        
		    end
		    
		end
		```
		**Output:**
		
		CreateSteamUserGrid(64, 64) The white question mark avatars mean no custom icon used or the user hasn't set up a community profile. The blue question mark avatars mean the user doesn't exist.
    **/
    
     
    function SetSteamID(steamid:String, size:Float):Void;
    /**
        Used by AvatarImage to load an avatar for given player.
		
		Name | Description
		--- | ---
		`player` | The player to use avatar of.
		`size` | The size of the avatar to use. Acceptable sizes are 32, 64, 184.
    **/
    
     
    function SetPlayer(player:Player, size:Float):Void;
    
}



#end