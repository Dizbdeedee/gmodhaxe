package gmod;


/**
    This is the list of global functions.
**/
@:native("_G")extern class Gmod {
    
    /**
        ***INTERNAL** 
		
		Gets the ConVar with the specified name. This function doesn't cache the convar.
		
		Name | Description
		--- | ---
		`name` | Name of the ConVar to get
		
		
		`**Returns:** The ConVar object
    **/
    @:deprecated("INTERNAL")
    static function GetConVar_Internal(name:String):ConVar;
    
    #if client
    /**
        Registers a Derma element to be closed the next time CloseDermaMenus is called
		
		Name | Description
		--- | ---
		`menu` | Menu to be registered for closure
    **/
    
    static function RegisterDermaMenuForClose(menu:Panel):Void;
    #end
    #if client
    /**
        Automatically called by the engine when a panel is hovered over with the mouse
		
		Name | Description
		--- | ---
		`panel` | Panel that has been hovered over
    **/
    
    static function ChangeTooltip(panel:Panel):Void;
    #end
    
    /**
        Returns if the given NPC class name is a friend. 
		
		Returns true if the entity name is one of the following:
		
		Name | Description
		--- | ---
		`className` | Class name of the entity to check
		
		
		`**Returns:** Is a friend
    **/
    
    static function IsFriendEntityName(className:String):Bool;
    
    
    /**
        Returns an iterator function that can be used to loop through a table in random order
		
		Name | Description
		--- | ---
		`table` | Table to create iterator for
		`descending` | Whether the iterator should iterate descending or not
		
		
		`**Returns:** Iterator function
		
		___
		### Lua Examples
		#### Example 1
		Creates a table and prints its contents in random order
		
		```lua 
		local tab = {"a", "b", "c", "d", "e", "f"}
		
		for k, v in RandomPairs(tab) do
		    print(v)
		end
		```
		**Output:**
		
		b d f c a e
    **/
    
    static function RandomPairs(table:AnyTable, descending:Bool):Function;
    
    
    /**
        Sets the active main menu background image to a random entry from the background images pool. Images are added with AddBackgroundImage.
		
		Name | Description
		--- | ---
		`currentgm` | Apparently does nothing.
    **/
    
    static function ChangeBackground(currentgm:String):Void;
    
    
    /**
        ***Deprecated:** To send the target file to the client simply call AddCSLuaFile() in the target file itself.
		
		This function works exactly the same as include both clientside and serverside. 
		
		The only difference is that on the serverside it also calls AddCSLuaFile on the filename, so that it gets sent to the client.
		
		Name | Description
		--- | ---
		`filename` | The filename of the Lua file you want to include.
    **/
    @:deprecated("To send the target file to the client simply call AddCSLuaFile() in the target file itself.")
    static function IncludeCS(filename:String):Void;
    
    
    /**
        Precaches the particle with the specified name.
		
		Name | Description
		--- | ---
		`particleSystemName` | The name of the particle system.
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the function. Precaches "ExplosionCore_wall" particle from "particles/explosion.pcf", a Team Fortress 2 particle file.You can find a list of particles inside a .pcf file using the Particle Editor Tool
		
		```lua 
		game.AddParticles( "particles/explosion.pcf" )
		PrecacheParticleSystem( "ExplosionCore_wall" )
		
		if ( SERVER ) then
		    -- A test console command to see if the particle works, spawns the particle where the player is looking at. 
		    concommand.Add( "particleitup", function( ply, cmd, args )
		        ParticleEffect( "ExplosionCore_wall", ply:GetEyeTrace().HitPos, Angle( 0, 0, 0 ) )
		    end )
		end
		```
    **/
    
    static function PrecacheParticleSystem(particleSystemName:String):Void;
    
    #if client
    /**
        Gets the height of the game's window (in pixels).
		
		`**Returns:** The height of the game's window in pixels
		
		___
		### Lua Examples
		#### Example 1
		Prints the Height of the window.
		
		```lua 
		print(ScrH())
		```
		**Output:**
		
		1080 (Depends on your screen)
		
		#### Example 2
		Draws a white box on the top left corner of your screen
		
		```lua 
		hook.Add("HUDPaint", "WhiteBox", function()
		    surface.SetDrawColor(Color(255,255,255,255))
		    surface.DrawRect(0, 0, ScrW() / 2, ScrH() / 2)
		end)
		```
		**Output:**
		
		A white box on the top left corner of your screen
    **/
    
    static function ScrH():Float;
    #end
    
    /**
        Sets an integer that is shared between the server and all clients.
		
		**Note:** Running this function clientside will only set it clientside for the client it is called on!
		
		**Bug:** BUG This function will not round decimal values as it actually networks a float internally. Issue Tracker: #3374
		
		Name | Description
		--- | ---
		`index` | The unique index to identify the global value with.
		`value` | The value to set the global value to
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the current round number.
		
		```lua 
		SetGlobalInt("RoundNumber", 4)
		```
    **/
    
    static function SetGlobalInt(index:String, value:Float):Void;
    
    
    /**
        Attempts to compile the given file. If successful, returns a function that can be called to perform the actual execution of the script.
		
		Name | Description
		--- | ---
		`path` | Path to the file, relative to the garrysmod/lua/ directory.
		
		
		`**Returns:** The function which executes the script.
		
		___
		### Lua Examples
		#### Example 1
		Assuming our file is named example.lua and located in the garrysmod/lua/ directory, the following code would execute the script.
		
		```lua 
		local example = CompileFile("example.lua")
		example()
		```
		**Output:**
		
		Hello!
    **/
    
    static function CompileFile(path:String):Function;
    
    
    /**
        Creates a table with the specified module name and sets the function environment for said table. 
		
		Any passed loaders are called with the table as an argument. An example of this is package.seeall.
		
		Name | Description
		--- | ---
		`name` | The name of the module. This will be used to access the module table in the runtime environment.
		`loaders` | Calls each function passed with the new table as an argument.
    **/
    
    static function module(name:String, loaders:Rest<Dynamic>):Void;
    
    
    /**
        Recursively prints the contents of a table to the console.
		
		Name | Description
		--- | ---
		`tableToPrint` | The table to be printed
		`indent` | Number of tabs to start indenting at. Increases by 2 when entering another table.
		`done` | Internal argument, you shouldn't normally change this. Used to check if a nested table has already been printed so it doesn't get caught in a loop.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints the table we created.
		
		```lua 
		local tbl = {
		 "test",
		 3829.4,
		 {"foo", "baah", 20/5},
		 true
		}
		PrintTable(tbl)
		```
		**Output:**
		
		1 = test
		2 = 3829.4
		3:
		 1 = foo
		 2 = baah
		 3 = 4
		4 = true
    **/
    
    static function PrintTable(tableToPrint:AnyTable, ?indent:Float, ?done:AnyTable):Void;
    
    
    /**
        An 'if then else'. This is almost equivalent to (condition and truevar or falsevar) in Lua. The difference is that if truevar evaluates to false, the plain Lua method stated would return falsevar regardless of condition whilst this function would take condition into account.
		
		Name | Description
		--- | ---
		`condition` | The condition to check if true or false.
		`truevar` | If the condition isn't nil/false, returns this value.
		`falsevar` | If the condition is nil/false, returns this value.
		
		
		`**Returns:** The result.
		
		___
		### Lua Examples
		#### Example 1
		The following two print statements have identical results.
		
		```lua 
		local ply = Entity( 1 )
		print( "Player " .. Either( ply:IsAdmin(), "is", "is not" ) .. " an admin" )
		
		print( "Player " .. ( ply:IsAdmin() and "is" or "is not" ) .. " an admin" )
		```
		**Output:**
		
		If Player 1 is admin, it will print "Player is an admin".
		
		#### Example 2
		Plain Lua alias version.
		
		```lua 
		print("You are: "..( LocalPlayer():Alive() and "alive" or "dead" ))
		
		// conditional:
		
		print( "Halflife? "..( (LocalPlayer():Health()==50) and "halflife" or "not halflife") )
		```
    **/
    
    static function Either(condition:Dynamic, truevar:Dynamic, falsevar:Dynamic):Dynamic;
    
    
    /**
        Returns the entity with the matching Entity:EntIndex. 
		
		Indices 1 through game.MaxPlayers() are always reserved for players.
		
		**Note:** In examples on this wiki, Entity( 1 ) is used when a player entity is needed (see wiki editing guide). In singleplayer and listen servers, Entity( 1 ) will always be the first player. In dedicated servers, however, Entity( 1 ) won't always be a valid player.
		
		Name | Description
		--- | ---
		`entityIndex` | The entity index.
		
		
		`**Returns:** The entity if it exists, or NULL if it doesn't.
    **/
    
    static function Entity(entityIndex:Float):Entity;
    
    
    /**
        Returns a boolean that is shared between the server and all clients.
		
		Name | Description
		--- | ---
		`index` | The unique index to identify the global value with.
		`default` | The value to return if the global value is not set.
		
		
		`**Returns:** The global value, or the default if the global value is not set.
    **/
    
    static function GetGlobalBool(index:String, ?_default:Bool):Bool;
    
    
    /**
        ***Deprecated:** This uses the umsg library internally, which has been deprecated. Use the net library instead.
		
		Send a usermessage
		
		**Note:** Useless on client, only server can send info to client.
		
		Name | Description
		--- | ---
		`name` | The name of the usermessage
		`recipients` | Can be a CRecipientFilter, table or Player object.
		`args` | Data to send in the usermessage
    **/
    @:deprecated("This uses the umsg library internally, which has been deprecated. Use the net library instead.")
    static function SendUserMessage(name:String, recipients:Dynamic, args:Rest<Dynamic>):Void;
    
    
    /**
        Returns the environment table of either the stack level or the function specified.
		
		Name | Description
		--- | ---
		`location` | The object to get the enviroment from. Can also be a number that specifies the function at that stack level: Level 1 is the function calling getfenv.
		
		
		`**Returns:** The environment.
    **/
    
    static function getfenv(?location:Function):AnyTable;
    
    
    /**
        Returns an angle that is shared between the server and all clients.
		
		Name | Description
		--- | ---
		`index` | The unique index to identify the global value with.
		`default` | The value to return if the global value is not set.
		
		
		`**Returns:** The global value, or default if the global is not set.
    **/
    
    static function GetGlobalAngle(index:String, ?_default:Angle):Angle;
    
    
    /**
        Toggles whether or not the named map is favorited in the new game list.
		
		Name | Description
		--- | ---
		`map` | Map to toggle favorite.
    **/
    
    static function ToggleFavourite(map:String):Void;
    
    #if client
    /**
        Shows a message box in the middle of the screen, with up to 4 buttons they can press.
		
		Name | Description
		--- | ---
		`text` | The message to display.
		`title` | The title to give the message box.
		`btn1text` | The text to display on the first button.
		`btn1func` | The function to run if the user clicks the first button.
		`btn2text` | The text to display on the second button.
		`btn2func` | The function to run if the user clicks the second button.
		`btn3text` | The text to display on the third button
		`btn3func` | The function to run if the user clicks the third button.
		`btn4text` | The text to display on the third button
		`btn4func` | The function to run if the user clicks the fourth button.
		
		
		`**Returns:** The Panel object of the created window.
    **/
    
    static function Derma_Query(?text:String, ?title:String, btn1text:String, ?btn1func:Function, ?btn2text:String, ?btn2func:Function, ?btn3text:String, ?btn3func:Function, ?btn4text:String, ?btn4func:Function):Panel;
    #end
    
    /**
        ***Deprecated:** Use RunString instead.
		
		Alias of RunString.
    **/
    @:deprecated("Use RunString instead.")
    static function RunStringEx():Void;
    
    
    /**
        Gets the base class of an an object. 
		
		This is used not just by entities, but also by widgets, panels, drive modes, weapons and gamemodes (with "gamemode_" prefix). 
		
		 The keyword DEFINE_BASECLASS translates into a call to this function. In the engine, it is replaced with:
		
		Name | Description
		--- | ---
		`name` | The child class.
		
		
		`**Returns:** The base class's meta table.
		
		___
		### Lua Examples
		#### Example 1
		Inherits the weapon from weapon_csbasegun and calls its base functions
		
		```lua 
		AddCSLuaFile()
		DEFINE_BASECLASS( "weapon_csbasegun" ) //this is equivalent to local BaseClass = baseclass.Get( "weapon_csbasegun" )
		
		//omitted generic swep definitions
		
		function SWEP:Initialize()
		    BaseClass.Initialize( self ) //calls SWEP:Initialize() from weapon_csbasegun
		    self:SetHoldType( "pistol" )
		end
		
		function SWEP:Deploy()
		    self:SetAccuracy( 0.9 )
		    return BaseClass.Deploy( self ) //calls SWEP:Deploy() from weapon_csbasegun and returns its result
		end
		
		function SWEP:SetupDataTables()
		    BaseClass.SetupDataTables( self ) //calls SWEP:SetupDataTables() from weapon_csbasegun and inits its dtvars
		end
		```
    **/
    
    static function Get(name:String):AnyTable;
    
    
    /**
        Defines a global entity class variable with an automatic value in order to prevent collisions with other CLASS_ Enums. You should prefix your variable with CLASS_ for consistency.
		
		Name | Description
		--- | ---
		`name` | The name of the new enum/global variable.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a global variable named CLASS_TESTER and prints its value.
		
		```lua 
		Add_NPC_Class( "CLASS_TESTER" )
		print( CLASS_TESTER )
		```
		**Output:**
		
		36 (one greater than the current highest value of the CLASS_ Enums)
    **/
    
    static function Add_NPC_Class(name:String):Void;
    
    #if client
    /**
        Draws the texturize shader, which replaces each pixel on your screen with a different part of the texture depending on its brightness. See g_texturize for information on making the texture.
		
		Name | Description
		--- | ---
		`Scale` | Scale of the texture. A smaller number creates a larger texture.
		`BaseTexture` | This will be the texture to use in the effect. Make sure you use Material to get the texture number
		
		
		___
		### Lua Examples
		#### Example 1
		Draws the texturize shader with a pattern texture.
		
		```lua 
		function GM:RenderScreenspaceEffects()
		
		 DrawTexturize(1, Material("pp/texturize/pattern1.png"))
		
		end
		```
    **/
    
    static function DrawTexturize(Scale:Float, BaseTexture:Float):Void;
    #end
    
    /**
        Returns a VMatrix object.
		
		Name | Description
		--- | ---
		`data` | Initial data to initialize the matrix with. Leave empty to initialize an identity matrix. See examples for usage. Can be a VMatrix to copy its data.
		
		
		`**Returns:** New matrix.
		
		___
		### Lua Examples
		#### Example 1
		Initializes a matrix, translates it by Vector( 4, 5, 6 ) and then scales it by Vector( 1, 2, 3 ).
		
		```lua 
		local M = Matrix()
		M:Translate( Vector( 4, 5, 6 ) )
		M:Scale( Vector( 1, 2, 3 ) )
		
		-- This matrix is equivalent:
		local M2 = Matrix( {
		    { 1, 0, 0, 4 },
		    { 0, 2, 0, 5 },
		    { 0, 0, 3, 6 },
		    { 0, 0, 0, 1 }
		} )
		```
    **/
    
    static function Matrix(?data:AnyTable):VMatrix;
    
    #if client
    /**
        Creates a derma window to display information
		
		Name | Description
		--- | ---
		`Text` | The text within the created panel.
		`Title` | The title of the created panel.
		`Button` | The text of the button to close the panel.
		
		
		`**Returns:** The created DFrame
		
		___
		### Lua Examples
		#### Example 1
		Creates a popup informing the player that they are dead.
		
		```lua 
		Derma_Message("You are currently dead", "Death Notice", "OK")
		```
    **/
    
    static function Derma_Message(Text:String, Title:String, Button:String):Panel;
    #end
    #if client
    /**
        Creates a motion blur effect by drawing your screen multiple times.
		
		Name | Description
		--- | ---
		`AddAlpha` | How much alpha to change per frame.
		`DrawAlpha` | How much alpha the frames will have. A value of 0 will not render the motion blur effect.
		`Delay` | Determines the amount of time between frames to capture.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a motion blur effect.
		
		```lua 
		function GM:RenderScreenspaceEffects()
		
		 DrawMotionBlur(0.4, 0.8, 0.01)
		
		end
		```
    **/
    
    static function DrawMotionBlur(AddAlpha:Float, DrawAlpha:Float, Delay:Float):Void;
    #end
    #if client
    /**
        Cancels any existing DOF post-process effects. Begins the DOF post-process effect.
    **/
    
    static function DOF_Start():Void;
    #end
    #if client
    /**
        Creates a new ProjectedTexture.
		
		`**Returns:** Newly created projected texture.
		
		___
		### Lua Examples
		#### Example 1
		Creates a simple ProjectedTexture attached to a Scripted Entity.Note that this code must be ran on clientside only, not shared.
		
		```lua 
		function ENT:Initialize()
		    local lamp = ProjectedTexture() -- Create a projected texture
		    self.lamp = lamp -- Assign it to the entity table so it may be accessed later
		
		    -- Set it all up
		    lamp:SetTexture( "effects/flashlight001" )
		    lamp:SetFarZ( 500 ) -- How far the light should shine
		
		    lamp:SetPos( self:GetPos() ) -- Initial position and angles
		    lamp:SetAngles( self:GetAngles() )
		    lamp:Update()
		end
		
		function ENT:OnRemove()
		    if ( IsValid( self.lamp ) ) then
		        self.lamp:Remove()
		    end
		end
		
		function ENT:Think()
		    -- Keep updating the light so it's attached to our entity
		    -- you might want to call other functions here, you can do animations here as well
		    if ( IsValid( self.lamp ) ) then
		        self.lamp:SetPos( self:GetPos() )
		        self.lamp:SetAngles( self:GetAngles() )
		        self.lamp:Update()
		    end
		end
		```
    **/
    
    static function ProjectedTexture():ProjectedTexture;
    #end
    
    /**
        Callback function for when the client has joined a server. This function shows the server's loading URL by default.
		
		Name | Description
		--- | ---
		`servername` | Server's name.
		`serverurl` | Server's loading screen URL, or "" if the URL is not set.
		`mapname` | Server's current map's name.
		`maxplayers` | Max player count of server.
		`steamid` | The local player's Player: SteamID64.
		`gamemode` | Server's current gamemode's folder name.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints GameDetails of the server you join to console, and preserves default behavior.
		
		```lua 
		local OldGameDetails = GameDetails
		function GameDetails( servername, serverurl, mapname, maxplayers, steamid, gamemode )
		    print( 1, servername )
		    print( 2, serverurl )
		    print( 3, mapname )
		    print( 4, maxplayers )
		    print( 5, steamid )
		    print( 6, gamemode )
		    OldGameDetails( servername, serverurl, mapname, maxplayers, steamid, gamemode )
		end
		```
		**Output:**
		
		1	ZerfTestServer
		2	
		3	gm_construct
		4	8
		5	76561198052589582
		6	sandbox
    **/
    
    static function GameDetails(servername:String, serverurl:String, mapname:String, maxplayers:Float, steamid:String, gamemode:String):Void;
    
    #if client
    /**
        Renders the stereoscopic post-process effect
		
		Name | Description
		--- | ---
		`viewOrigin` | Origin to render the effect at
		`viewAngles` | Angles to render the effect at
    **/
    
    static function RenderStereoscopy(viewOrigin:Vector, viewAngles:Angle):Void;
    #end
    
    /**
        Returns if the passed object is a boolean.
		
		Name | Description
		--- | ---
		`variable` | The variable to perform the type check for.
		
		
		`**Returns:** True if the variable is a boolean.
    **/
    
    static function isbool(variable:Dynamic):Bool;
    
    
    /**
        Creates a Color structure with randomized red, green, and blue components. If the alpha argument is true, alpha will also be randomized.
		
		Name | Description
		--- | ---
		`a` | Should alpha be randomized.
		
		
		`**Returns:** The created Color structure.
    **/
    
    static function ColorRand(?a:Bool):Color;
    
    
    /**
        Returns an angle with a randomized pitch, yaw, and roll between min(inclusive), max(exclusive).
		
		Name | Description
		--- | ---
		`min` | Min bound inclusive.
		`max` | Max bound exclusive.
		
		
		`**Returns:** The randomly generated angle.
		
		___
		### Lua Examples
		#### Example 1
		Prints out a random angle.
		
		```lua 
		print( AngleRand() )
		```
		**Output:**
		
		-6.949 113.388 130.879
    **/
    
    static function AngleRand(?min:Float, ?max:Float):Angle;
    
    #if client
    /**
        Returns a number based on the Size argument and your screen's width. The screen's width is always equal to size 640. This function is primarily used for scaling font sizes.
		
		Name | Description
		--- | ---
		`Size` | The number you want to scale.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints a scaled number based on the number 96, 400 and 640.
		
		```lua 
		print( ScreenScale(96) )
		print( ScreenScale(400) )
		print( ScreenScale(640) )
		```
		**Output:**
		
		252, 1050, 1680 (This will differ depending on your screen width. Here the screen width is 1680.)
    **/
    
    static function ScreenScale(Size:Float):Void;
    #end
    
    /**
        Runs a function without stopping the whole script on error. 
		
		This function is similar to pcall and xpcall except the errors are still printed and sent to the error handler (i.e. sent to server console if clientside and GM:OnLuaError called).
		
		Name | Description
		--- | ---
		`func` | Function to run
		
		
		`**Returns:** Whether the function executed successfully or not
    **/
    
    static function ProtectedCall(func:Function):Bool;
    
    #if client
    /**
        Draws the bloom shader, which creates a glowing effect from bright objects.
		
		Name | Description
		--- | ---
		`Darken` | Determines how much to darken the effect. A lower number will make the glow come from lower light levels. A value of 1 will make the bloom effect unnoticeable. Negative values will make even pitch black areas glow.
		`Multiply` | Will affect how bright the glowing spots are. A value of 0 will make the bloom effect unnoticeable.
		`SizeX` | The size of the bloom effect along the horizontal axis.
		`SizeY` | The size of the bloom effect along the vertical axis.
		`Passes` | Determines how much to exaggerate the effect.
		`ColorMultiply` | Will multiply the colors of the glowing spots, making them more vivid.
		`Red` | How much red to multiply with the glowing color. Should be between 0 and 1
		`Green` | How much green to multiply with the glowing color. Should be between 0 and 1
		`Blue` | How much blue to multiply with the glowing color. Should be between 0 and 1
		
		
		___
		### Lua Examples
		#### Example 1
		Draws bloom effect with default settings.
		
		```lua 
		function GM:RenderScreenspaceEffects()
		    DrawBloom( 0.65, 2, 9, 9, 1, 1, 1, 1, 1 )
		end
		```
    **/
    
    static function DrawBloom(Darken:Float, Multiply:Float, SizeX:Float, SizeY:Float, Passes:Float, ColorMultiply:Float, Red:Float, Green:Float, Blue:Float):Void;
    #end
    
    /**
        Creates a Color structure.
		
		Name | Description
		--- | ---
		`r` | An integer from 0-255 describing the red value of the color.
		`g` | An integer from 0-255 describing the green value of the color.
		`b` | An integer from 0-255 describing the blue value of the color.
		`a` | An integer from 0-255 describing the alpha (transparency) of the color.
		
		
		`**Returns:** The created Color structure.
		
		___
		### Lua Examples
		#### Example 1
		Creates a color and prints the components to the console.
		
		```lua 
		PrintTable(Color(1, 2, 3, 4))
		```
		**Output:**
		
		a	=	4
		b	=	3
		g	=	2
		r	=	1
		
		#### Example 2
		Color variables can have individual channels set using the arguments
		
		```lua 
		local col = Color( 0, 255, 0, 255)
		
		col.r = 255
		
		PrintTable(col)
		```
		**Output:**
		
		a	=	255
		b	=	0
		g	=	255
		r	=	255
		
		#### Example 3
		Transforms a color object to a string, then prints it.
		
		```lua 
		local str = tostring( Color( 255, 0, 0 ) )
		print( str )
		```
		**Output:**
		
		255 0 0
		
		#### Example 4
		Prints "equal" if both colors are equal, otherwise "unequal" will be printed.
		
		```lua 
		if Color( 255, 0, 0 ) == Color( 255, 0, 0 ) then
		    print( "equal" )
		else
		    print( "unequal" )
		end
		```
		**Output:**
		
		equal
    **/
    
    static function Color(r:Float, g:Float, b:Float, ?a:Float):Color;
    
    
    /**
        Returns if the given NPC class name is an enemy. 
		
		Returns true if the entity name is one of the following:
		
		Name | Description
		--- | ---
		`className` | Class name of the entity to check
		
		
		`**Returns:** Is an enemy
    **/
    
    static function IsEnemyEntityName(className:String):Bool;
    
    #if client
    /**
        Returns the real frame-time which is unaffected by host_timescale. To be used for GUI effects (for example)
		
		`**Returns:** Real frame time
    **/
    
    static function RealFrameTime():Float;
    #end
    
    /**
        Defined a boolean to be automatically networked to clients
		
		**Note:** Running this function clientside will only set it clientside for the client it is called on!
		
		Name | Description
		--- | ---
		`index` | Index to identify the global boolean with
		`bool` | Boolean to be networked
    **/
    
    static function SetGlobalBool(index:Dynamic, bool:Bool):Void;
    
    #if client
    /**
        Returns the angle that the clients view is being rendered at
		
		`**Returns:** Render Angles
    **/
    
    static function RenderAngles():Angle;
    #end
    #if client
    /**
        Gets the width of the game's window (in pixels).
		
		`**Returns:** The width of the game's window in pixels
		
		___
		### Lua Examples
		#### Example 1
		Prints the width of the screen
		
		```lua 
		print( ScrW() )
		```
		**Output:**
		
		1280 (depends on your resolution)
    **/
    
    static function ScrW():Float;
    #end
    #if server
    /**
        Prints "ServerLog: PARAM" without a newline, to the server log and console.
		
		Name | Description
		--- | ---
		`parameter` | The value to be printed to console.
    **/
    
    static function ServerLog(parameter:String):Void;
    #end
    
    /**
        Returns a sine value that fluctuates based on CurTime. The value returned will be between the start value plus/minus the range value.
		
		**Bug:** BUG The range arguments don't work as intended. The existing (bugged) behavior is documented below.
		
		Name | Description
		--- | ---
		`frequency` | The frequency of fluctuation, in hertz
		`origin` | The center value of the sine wave.
		`max` | This argument's distance from origin defines the size of the full range of the sine wave. For example, if origin is 3 and max is 5, then the full range of the sine wave is 5-3 = 2. 3 is the center point of the sine wave, so the sine wave will range between 2 and 4.
		`offset` | Offset variable that doesn't affect the rate of change, but causes the returned value to be offset by time
		
		
		`**Returns:** Sine value
    **/
    
    static function TimedSin(frequency:Float, origin:Float, max:Float, offset:Float):Float;
    
    #if client
    /**
        Returns the amount of skins the specified model has. 
		
		See also Entity:SkinCount if you have an entity.
		
		Name | Description
		--- | ---
		`modelName` | Model to return amount of skins of
		
		
		`**Returns:** Amount of skins
    **/
    
    static function NumModelSkins(modelName:String):Float;
    #end
    #if client
    /**
        Sets whether rendering should be limited to being inside a panel or not. 
		
		See also surface.DisableClipping and Panel:NoClipping.
		
		Name | Description
		--- | ---
		`disable` | Whether or not clipping should be disabled
		
		
		___
		### Lua Examples
		#### Example 1
		Renders a white box outside of the panel
		
		```lua 
		function PANEL:Paint()
		    DisableClipping(true)
		    draw.RoundedBox(0, -50, -50, 25, 25, color_white)
		    DisableClipping(false)
		end
		```
    **/
    
    static function DisableClipping(disable:Bool):Void;
    #end
    #if client
    /**
        Creates and returns a DShape rectangle GUI element with the given dimensions.
		
		Name | Description
		--- | ---
		`x` | X position of the created element
		`y` | Y position of the created element
		`w` | Width of the created element
		`h` | Height of the created element
		
		
		`**Returns:** DShape element
    **/
    
    static function VGUIRect(x:Float, y:Float, w:Float, h:Float):Panel;
    #end
    #if client
    /**
        Draws the sharpen shader, which creates more contrast.
		
		Name | Description
		--- | ---
		`Contrast` | How much contrast to create.
		`Distance` | How large the contrast effect will be.
		
		
		___
		### Lua Examples
		#### Example 1
		Draws the sharpen shader.
		
		```lua 
		function GM:RenderScreenspaceEffects()
		
		 DrawSharpen(1.2,1.2)
		
		end
		```
    **/
    
    static function DrawSharpen(Contrast:Float, Distance:Float):Void;
    #end
    
    /**
        ***INTERNAL** 
		
		Draws the currently active main menu background image and handles transitioning between background images. This is called by default in the menu panel's Paint hook.
    **/
    @:deprecated("INTERNAL")
    static function DrawBackground():Void;
    
    #if client
    /**
        Draws a material overlay on the screen.
		
		Name | Description
		--- | ---
		`Material` | This will be the material that is drawn onto the screen.
		`RefractAmount` | This will adjust how much the material will refract your screen.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a fisheye effect on your screen.
		
		```lua 
		function GM:RenderScreenspaceEffects()
		
		    DrawMaterialOverlay("models/props_c17/fisheyelens", -0.06)
		
		end
		```
    **/
    
    static function DrawMaterialOverlay(Material:String, RefractAmount:Float):Void;
    #end
    
    /**
        Executes the specified action on the garbage collector.
		
		Name | Description
		--- | ---
		`action` | The action to run. Valid actions are "collect", "stop", "restart", "count", "step", "setpause" and "setstepmul".
		`arg` | The argument of the specified action, only applicable for "step", "setpause" and "setstepmul".
		
		
		`**Returns:** If the action is count this is the number of kilobytes of memory used by Lua. If the action is step this is true if a garbage collection cycle was finished. If the action is setpause this is the previous value for the GC's pause. If the action is setstepmul this is the previous value for the GC's step.
		
		___
		### Lua Examples
		#### Example 1
		The current floored dynamic memory usage of Lua, in kilobytes.
		
		```lua 
		print( collectgarbage( "count" ) )
		```
    **/
    
    static function collectgarbage(?action:String, arg:Float):Dynamic;
    
    #if client
    /**
        Returns the tool-tip text and tool-tip-panel (if any) of the given panel as well as itself
		
		Name | Description
		--- | ---
		`panel` | Panel to find tool-tip of
		
		
		Name | Description
		--- | ---
		`a` | tool-tip text
		`b` | tool-tip panel
		`c` | panel that the function was called with
    **/
    
    static function FindTooltip(panel:Panel):GlobalLibFindTooltipReturn;
    #end
    
    /**
        Emits the specified sound at the specified position.
		
		**Bug:** BUG Sounds must be precached serverside manually before they can be played. util.PrecacheSound does not work for this purpose, Entity.EmitSound does the trick
		
		**Bug:** BUG This does not work with soundscripts. TODO: Is this a bug or intended?
		
		Name | Description
		--- | ---
		`soundName` | The sound to play
		`position` | The position to play at
		`entity` | The entity to emit the sound from. Can be an Entity:EntIndex or one of the following: 0 - Plays sound on the world (Position set to 0,0,0) -1 - Plays sound on the local player (on server acts as 0) -2 - Plays UI sound (Position set to 0,0,0, no spatial sound,on server acts as 0)
		`channel` | The sound channel, see CHAN_ Enums.
		`volume` | The volume of the sound, from 0 to 1
		`soundLevel` | The sound level of the sound, see SNDLVL_ Enums
		`soundFlags` | The flags of the sound, see SND_ Enums
		`pitch` | The pitch of the sound, 0-255
		
		
		___
		### Lua Examples
		#### Example 1
		Plays magical sound on first player.
		
		```lua 
		EmitSound( Sound("garrysmod/save_load1.wav"), Entity(1):GetPos(), 1, CHAN_AUTO, 1, 75, 0, 100 )
		```
    **/
    
    static function EmitSound(soundName:String, position:Vector, entity:Float, ?channel:CHAN, ?volume:Float, ?soundLevel:SNDLVL, ?soundFlags:SND, ?pitch:Float):Void;
    
    
    /**
        ***Deprecated:** You should use IsUselessModel instead.
		
		Returns whether or not a model is useless by checking that the file path is that of a proper model. 
		
		If the string ".mdl" is not found in the model name, the function will return true. 
		
		 The function will also return true if any of the following strings are found in the given model name:
		
		Name | Description
		--- | ---
		`modelName` | The model name to be checked
		
		
		`**Returns:** Whether or not the model is useless
    **/
    @:deprecated("You should use IsUselessModel instead.")
    static function UTIL_IsUselessModel(modelName:String):Bool;
    
    
    /**
        Creates a Vector object.
		
		Name | Description
		--- | ---
		`x` | The x component of the vector. If this is a Vector, this function will return a copy of the given vector. If this is a string, this function will try to parse the string as a vector. If it fails, it returns a 0 vector. (See examples)
		`y` | The y component of the vector.
		`z` | The z component of the vector.
		
		
		`**Returns:** The created vector object.
		
		___
		### Lua Examples
		#### Example 1
		Creates a vector and prints the value to the console.
		
		```lua 
		print( Vector( 1, 2, 3 ) )
		print( Vector( "4 5 6" ) )
		local test = Vector( 7, 8, 9 )
		print( Vector( test ) )
		
		print( Vector( "4 5 test" ) )
		print( Vector() )
		```
		**Output:**
		
		1.000000 2.000000 3.000000
		4.000000 5.000000 6.000000
		7.000000 8.000000 9.000000
		
		0.000000 0.000000 0.000000
		0.000000 0.000000 0.000000
    **/
    
    static function Vector(?x:Float, ?y:Float, ?z:Float):Vector;
    
    
    /**
        Used to select single values from a vararg or get the count of values in it.
		
		Name | Description
		--- | ---
		`parameter` | Can be a number or string. If it's a string and starts with "#", the function will return the amount of values in the vararg (ignoring the rest of the string). If it's a positive number, the function will return all values starting from the given index. If the number is negative, it will return the amount specified from the end instead of the beginning. This mode will not be compiled by LuaJIT.
		`vararg` | The vararg. These are the values from which you want to select.
		
		
		`**Returns:** Returns a number or vararg, depending on the select method.
		
		___
		### Lua Examples
		#### Example 1
		This code shows how it works with the "#" modifier:
		
		```lua 
		print( select( '#', 'a', true, false, {}, 1 ) )
		```
		**Output:**
		
		"5", which is the count of parameters passed excluding the modifier (the "#")
		
		#### Example 2
		This prints from the 2nd vararg passed to the last
		
		```lua 
		print( select( 2, 1, 2, 3, 4, 5 ) )
		```
		**Output:**
		
		"2 3 4 5" in the console
		
		#### Example 3
		This prints the last 2 arguments passed
		
		```lua 
		print( select( -2, 1, 2, 3, 4, 5 ) )
		```
		**Output:**
		
		"4 5" in the console
    **/
    
    static function select(parameter:Dynamic, vararg:Rest<Dynamic>):Dynamic;
    
    #if client
    /**
        Creates a non physical entity that only exists on the client. See also ents.CreateClientProp.
		
		**Warning:** Model must be precached with util.PrecacheModel on the server before usage.
		
		**Bug:** BUG Parented clientside models will become detached if the parent entity leaves the PVS. Issue Tracker: #861
		
		**Bug:** BUG Clientside entities are not garbage-collected, thus you must store a reference to the object and call CSEnt:Remove manually. Issue Tracker: #1387
		
		**Bug:** BUG Clientside models will occasionally delete themselves during high server lag. Issue Tracker: #3184
		
		Name | Description
		--- | ---
		`model` | The file path to the model. WARNING Model must be precached with util.PrecacheModel on the server before usage.
		`renderGroup` | The rendergroup of the entity, see RENDERGROUP_ Enums.
		
		
		`**Returns:** Created client-side model. ( C_BaseFlex )
    **/
    
    static function ClientsideModel(model:String, ?renderGroup:RENDERGROUP):CSEnt;
    #end
    
    /**
        This function can be used in a for loop instead of pairs. It sorts all keys alphabetically. 
		
		For sorting by specific value member, use SortedPairsByMemberValue. For sorting by value, use SortedPairsByValue.
		
		Name | Description
		--- | ---
		`table` | The table to sort
		`desc` | Reverse the sorting order
		
		
		Name | Description
		--- | ---
		`a` | Iterator function
		`b` | The table being iterated over
		
		
		___
		### Lua Examples
		#### Example 1
		Example of usage.
		
		```lua 
		for id, text in SortedPairs( { "e", "b", "d", "c", "a" } ) do
		    print(id, text)
		end
		
		print( "---" )
		
		for id, text in SortedPairs( { e = 1, b = 2, d = 3, c = 4, a = 5 } ) do
		    print(id, text)
		end
		```
		**Output:**
		
		1 e
		2 b
		3 d
		4 c
		5 a
		---
		a 5
		b 2
		c 4
		d 3
		e 1
    **/
    
    static function SortedPairs(table:AnyTable, ?desc:Bool):GlobalLibSortedPairsReturn;
    
    
    /**
        Defines an entity to be automatically networked to clients
		
		**Note:** Running this function clientside will only set it clientside for the client it is called on!
		
		Name | Description
		--- | ---
		`index` | Index to identify the global entity with
		`ent` | Entity to be networked
    **/
    
    static function SetGlobalEntity(index:Dynamic, ent:Entity):Void;
    
    
    /**
        Converts a color from HSV color space into RGB color space and returns a Color structure.
		
		**Bug:** BUG The returned color will not have the color metatable. Issue Tracker: #2407
		
		Name | Description
		--- | ---
		`hue` | The hue in degrees from 0-360.
		`saturation` | The saturation from 0-1.
		`value` | The value from 0-1.
		
		
		`**Returns:** The Color structure created from the HSV color space.
		
		___
		### Lua Examples
		#### Example 1
		A helper function for drawing rainbow text.
		
		```lua 
		local function DrawRainbowText( frequency, str, font, x, y )
		    
		    surface.SetFont( font )
		    
		    for i = 1, #str do
		        surface.SetTextColor( HSVToColor( i * frequency % 360, 1, 1 ) )
		        local w = surface.GetTextSize( string.sub( str, 1, i - 1 ) )
		        surface.SetTextPos( x + w, y )
		        surface.DrawText( string.sub( str, i, i ) )
		    end
		    
		end
		```
		
		#### Example 2
		A helper function for printing rainbow text in the chat.
		
		```lua 
		local function ChatPrintRainbow( frequency, str )
		    
		    local text = {}
		    
		    for i = 1, #str do
		        table.insert( text, HSVToColor( i * frequency % 360, 1, 1 ) )
		        table.insert( text, string.sub( str, i, i ) )
		    end
		
		    chat.AddText( unpack( text ) )
		    
		end
		```
		
		#### Example 3
		A helper function for printing rainbow text in the console.
		
		```lua 
		local function ConsolePrintRainbow( frequency, str )
		    
		    local text = {}
		    
		    for i = 1, #str do
		        table.insert( text, HSVToColor( i * frequency % 360, 1, 1 ) )
		        table.insert( text, string.sub( str, i, i ) )
		    end
		    
		    table.insert( text, "\n" )
		    
		    MsgC( unpack( text ) )
		    
		end
		```
    **/
    
    static function HSVToColor(hue:Float, saturation:Float, value:Float):Color;
    
    
    /**
        Returns an integer that is shared between the server and all clients.
		
		**Bug:** BUG This function will not round decimal values as it actually networks a float internally. Issue Tracker: #3374
		
		Name | Description
		--- | ---
		`index` | The unique index to identify the global value with.
		`default` | The value to return if the global value is not set.
		
		
		`**Returns:** The global value, or the default if the global value is not set.
		
		___
		### Lua Examples
		#### Example 1
		Prints the current round number if set, otherwise 0.
		
		```lua 
		print(GetGlobalInt("RoundNumber", 0))
		```
    **/
    
    static function GetGlobalInt(index:String, ?_default:Float):Float;
    
    
    /**
        Returns the metatable of an object. This function obeys the metatable's __metatable field, and will return that field if the metatable has it set. 
		
		Use debug.getmetatable if you want the true metatable of the object.
		
		Name | Description
		--- | ---
		`object` | The value to return the metatable of.
		
		
		`**Returns:** The metatable of the value. This is not always a table.
		
		___
		### Lua Examples
		#### Example 1
		Use a table's metatable and alter it.
		
		```lua 
		print(getmetatable(Pupil).__index.GetName(Pupil))
		-- getmetatable(Pupil) will return Pupil_meta.
		-- Same as print(Pupil:GetName())
		-- This is what the Lua interpreter basically does. (When __index is a table.)
		
		getmetatable(Pupil).SetName = function(self, newName)
		 self.name = newName
		end
		-- We're adding a new method to Pupil's metatable
		
		print(getmetatable(Pupil).GetName(Pupil))
		-- Still the same, because Pupil_meta.__index is Pupil_meta.
		```
		**Output:**
		
		"John Doe"
    **/
    
    static function getmetatable(object:Dynamic):Dynamic;
    
    #if client
    /**
        Returns the origin of the current render context as calculated by GM:CalcView.
		
		**Bug:** BUG This function is only reliable inside rendering hooks. Issue Tracker: #2516
		
		`**Returns:** Camera position.
		
		___
		### Lua Examples
		#### Example 1
		Print the view position
		
		```lua 
		print(EyePos())
		```
		
		#### Example 2
		Ensuring EyePos returns the correct value outside of render hooks.
		
		```lua 
		hook.Add("PreDrawTranslucentRenderables", "FixEyePos", function() EyePos() end)
		hook.Add( "Think", "Use Eyepos outside of render function", function()
		    local start = EyePos()
		    local dir = gui.ScreenToVector(gui.MousePos())
		    local trace = util.TraceLine{
		        start = start,
		        endpos = start + ( dir * 10000 ),
		        filter = { ply },
		    }
		    debugoverlay.Box( trace.HitPos, Vector( -5, -5, -5 ), Vector( 5, 5, 5 ) )
		end )
		```
		**Output:**
		
		Draws a white box in the world where you point the mouse to. Requires the developer convar to be set to 1.
    **/
    
    static function EyePos():Vector;
    #end
    
    /**
        Executes the given console command with the parameters.
		
		**Note:** Some commands/convars are blocked from being ran/changed using this function, usually to prevent harm/annoyance to clients. For a list of blocked commands, see Blocked ConCommands.
		
		Name | Description
		--- | ---
		`command` | The command to be executed.
		`arguments` | The arguments. Note, that unlike Player: ConCommand, you must pass each argument as a new string, not separating them with a space.
		
		
		___
		### Lua Examples
		#### Example 1
		Changes the gravity to 400 (default 600).
		
		```lua 
		RunConsoleCommand("sv_gravity", "400")
		```
    **/
    
    static function RunConsoleCommand(command:String, arguments:Rest<Dynamic>):Void;
    
    
    /**
        Returns the number of files needed from the server you are currently joining.
		
		`**Returns:** The number of downloadables
    **/
    
    static function NumDownloadables():Float;
    
    
    /**
        Returns whether a ConVar with the given name exists or not
		
		Name | Description
		--- | ---
		`name` | Name of the ConVar.
		
		
		`**Returns:** True if the ConVar exists, false otherwise.
    **/
    
    static function ConVarExists(name:String):Bool;
    
    #if server
    /**
        Sends the specified Lua code to all connected clients and executes it.
		
		Name | Description
		--- | ---
		`code` | The code to be executed. Capped at length of 254 characters.
		
		
		___
		### Lua Examples
		#### Example 1
		Print "Hello World!" in the clients' console
		
		```lua 
		BroadcastLua( [[print( "Hello World!" )]] )
		```
		**Output:**
		
		Hello World!
    **/
    
    static function BroadcastLua(code:String):Void;
    #end
    
    /**
        Removes entity after delay using SafeRemoveEntity
		
		Name | Description
		--- | ---
		`entity` | Entity to be removed
		`delay` | Delay for entity removal in seconds
    **/
    
    static function SafeRemoveEntityDelayed(entity:Entity, delay:Float):Void;
    
    
    /**
        Callback function for when the client's language changes. Called by the engine.
		
		Name | Description
		--- | ---
		`lang` | The new language code.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints the new language code whenever the language changes.
		
		```lua 
		local OldLanguageChanged = LanguageChanged
		function LanguageChanged( lang )
		    print( "New language: " .. lang )
		    OldLanguageChanged( lang )
		end
		```
		**Output:**
		
		New language: en
    **/
    
    static function LanguageChanged(lang:String):Void;
    
    
    /**
        Returns the default loading screen URL (asset://garrysmod/html/loading.html)
		
		`**Returns:** Default loading url (asset://garrysmod/html/loading.html)
    **/
    
    static function GetDefaultLoadingHTML():String;
    
    #if client
    /**
        Returns the number of frames rendered since the game was launched.
		
		___
		### Lua Examples
		#### Example 1
		Prints the frame count to the console.
		
		```lua 
		print(FrameNumber())
		```
    **/
    
    static function FrameNumber():Void;
    #end
    #if client
    /**
        Returns the entity the client is using to see from (such as the player itself, the camera, or another entity).
		
		`**Returns:** The view entity.
    **/
    
    static function GetViewEntity():Entity;
    #end
    
    /**
        Aborts joining of the server you are currently joining.
    **/
    
    static function CancelLoading():Void;
    
    #if client
    /**
        Creates a new derma animation.
		
		Name | Description
		--- | ---
		`name` | Name of the animation to create
		`panel` | Panel to run the animation on
		`func` | Function to call to process the animation Arguments: Panel pnl - the panel passed to Derma_Anim table anim - the anim table number delta - the fraction of the progress through the animation any data - optional data passed to the run metatable method
		
		
		`**Returns:** A lua metatable containing four methods: Run() - Should be called each frame you want the animation to be ran. Active() - Returns if the animation is currently active (has not finished and stop has not been called) Stop() - Halts the animation at its current progress. Start( Length, Data ) - Prepares the animation to be ran for Length seconds. Must be called once before calling Run(). The data parameter will be passed to the func function.
		
		___
		### Lua Examples
		#### Example 1
		Applies an easeInQuad easing to the panel to make it glide naturally across the screen.
		
		```lua 
		local function inQuad(fraction, beginning, change)
		    return change * (fraction ^ 2) + beginning
		end
		
		local main = vgui.Create("DFrame")
		main:SetTitle("Derma_Anim Example")
		main:SetSize(250, 200)
		main:SetPos(200)
		main:MakePopup()
		local anim = Derma_Anim("EaseInQuad", main, function(pnl, anim, delta, data)
		    pnl:SetPos(inQuad(delta, 200, 600), 300) -- Change the X coordinate from 200 to 200+600
		end)
		anim:Start(2) -- Animate for two seconds
		main.Think = function(self)
		    if anim:Active() then
		        anim:Run()
		    end
		end
		```
		**Output:**
		
		Panel naturally glides across the screen from 200 x to 800 x
    **/
    
    static function Derma_Anim(name:String, panel:Panel, func:Function):AnyTable;
    #end
    #if client
    /**
        Adds javascript function 'language.Update' to an HTML panel as a method to call Lua's language.GetPhrase function.
		
		Name | Description
		--- | ---
		`htmlPanel` | Panel to add javascript function 'language.Update' to.
    **/
    
    static function JS_Language(htmlPanel:Panel):Void;
    #end
    
    /**
        Returns point between first and second angle using given fraction and linear interpolation
		
		Name | Description
		--- | ---
		`ratio` | Ratio of progress through values
		`angleStart` | Angle to begin from
		`angleEnd` | Angle to end at
		
		
		`**Returns:** angle
		
		___
		### Lua Examples
		#### Example 1
		Turns an entity 180 degrees uses lerp over ten seconds
		
		```lua 
		local startAngle = Angle(0, 0, 0)
		local endAngle = Angle(0, 180, 0)
		local ratio = 0
		
		timer.Create("Turn", 0.1, 10, function()
		    ratio = ratio + 0.1
		    entity:SetAngles(Lerp(ratio, startAngle, endAngle))
		end)
		```
    **/
    
    static function LerpAngle(ratio:Float, angleStart:Angle, angleEnd:Angle):Angle;
    
    #if menu
    /**
        Returns the loading screen panel and creates it if it doesn't exist.
		
		`**Returns:** The loading screen panel
    **/
    
    static function GetLoadPanel():Panel;
    #end
    #if client
    /**
        Loads the specified image from the /cache folder, used in combination steamworks.Download. Most addons will provide a 512x512 png image.
		
		Name | Description
		--- | ---
		`name` | The name of the file.
		
		
		`**Returns:** The material, returns nil if the cached file is not an image.
    **/
    
    static function AddonMaterial(name:String):IMaterial;
    #end
    
    /**
        Returns an entity that is shared between the server and all clients.
		
		Name | Description
		--- | ---
		`index` | The unique index to identify the global value with.
		`default` | The value to return if the global value is not set.
		
		
		`**Returns:** The global value, or the default if the global value is not set.
    **/
    
    static function GetGlobalEntity(index:String, ?_default:Entity):Entity;
    
    
    /**
        Runs util.PrecacheSound and returns the string
		
		Name | Description
		--- | ---
		`soundPath` | The soundpath to precache
		
		
		`**Returns:** The string passed as the first argument
		
		___
		### Lua Examples
		#### Example 1
		From entities/sent_ball.lua
		
		```lua 
		local BounceSound = Sound( "garrysmod/balloon_pop_cute.wav" )
		function ENT:PhysicsCollide( data, physobj )
		 -- Play sound on bounce
		 if ( data.Speed > 60 && data.DeltaTime > 0.2 ) then
		 sound.Play( BounceSound, self:GetPos(), 75, math.random( 90, 120 ), math.Clamp( data.Speed / 150, 0, 1 ) )
		 ...
		```
    **/
    
    static function Sound(soundPath:String):String;
    
    
    /**
        Creates a new PhysCollide from the given bounds.
		
		**Bug:** BUG This fails to create planes or points - no components of the mins or maxs can be the same. Issue Tracker: #3568
		
		Name | Description
		--- | ---
		`mins` | Min corner of the box. This is not automatically ordered with the maxs and must contain the smallest vector components. See OrderVectors.
		`maxs` | Max corner of the box. This is not automatically ordered with the mins and must contain the largest vector components.
		
		
		`**Returns:** The new PhysCollide. This will be a NULL PhysCollide ( PhysCollide: IsValid returns false) if given bad vectors or no more PhysCollides can be created in the physics engine.
		
		___
		### Lua Examples
		#### Example 1
		A box that interacts correctly with VPhysics objects and player movement.
		
		```lua 
		AddCSLuaFile()
		
		DEFINE_BASECLASS( "base_anim" )
		
		ENT.PrintName = "Cube"
		ENT.Spawnable = true
		
		ENT.Mins = Vector( -16, -16, -16 )
		ENT.Maxs = Vector(  16,  16,  16 )
		
		function ENT:Initialize()
		    self.PhysCollide = CreatePhysCollideBox( self.Mins, self.Maxs )
		    self:SetCollisionBounds( self.Mins, self.Maxs )
		
		    if SERVER then
		        self:PhysicsInitBox( self.Mins, self.Maxs )
		        self:SetSolid( SOLID_VPHYSICS )
		        self:PhysWake()
		    end
		
		    if CLIENT then
		        self:SetRenderBounds( self.Mins, self.Maxs )
		    end
		
		    self:EnableCustomCollisions( true )
		    self:DrawShadow( false )
		end
		
		-- Handles collisions against traces. This includes player movement.
		function ENT:TestCollision( startpos, delta, isbox, extents )
		    if not IsValid( self.PhysCollide ) then
		        return
		    end
		
		    -- TraceBox expects the trace to begin at the center of the box, but TestCollision is bad
		    local max = extents
		    local min = -extents
		    max.z = max.z - min.z
		    min.z = 0
		
		    local hit, norm, frac = self.PhysCollide:TraceBox( self:GetPos(), self:GetAngles(), startpos, startpos + delta, min, max )
		
		    if not hit then
		        return
		    end
		
		    return { 
		        HitPos = hit,
		        Normal  = norm,
		        Fraction = frac,
		    }
		end
		
		function ENT:Draw()
		    render.DrawWireframeBox( self:GetPos(), self:GetAngles(), self.Mins, self.Maxs, Color( 255, 0, 0 ), true )
		end
		```
    **/
    
    static function CreatePhysCollideBox(mins:Vector, maxs:Vector):PhysCollide;
    
    
    /**
        Returns a new Color structure with the RGB components of the given Color structure and the alpha value specified.
		
		Name | Description
		--- | ---
		`color` | The Color structure from which to take RGB values. This color will not be modified.
		`alpha` | The new alpha value, a number between 0 and 255. Values above 255 will be clamped.
		
		
		`**Returns:** The new Color structure with the modified alpha value
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		local red = Color( 255, 0, 0, 255 )
		local red2 = ColorAlpha( red, 125 )
		print( red.r, red.g, red.b, red.a )
		print( red2.r, red2.g, red2.b, red2.a )
		```
		**Output:**
		
		255	0	0	255
		255	0	0	125
    **/
    
    static function ColorAlpha(color:Color, alpha:Float):Color;
    
    
    /**
        Returns whether the passed object is a VMatrix.
		
		Name | Description
		--- | ---
		`variable` | The variable to perform the type check for.
		
		
		`**Returns:** True if the variable is a VMatrix.
    **/
    
    static function ismatrix(variable:Dynamic):Bool;
    
    
    /**
        Translates the specified position and angle from the specified local coordinate system into worldspace coordinates. 
		
		If you're working with an entity's local vectors, use Entity:LocalToWorld and/or Entity:LocalToWorldAngles instead. 
		
		 See also: WorldToLocal, the reverse of this function.
		
		Name | Description
		--- | ---
		`localPos` | The position vector in the source coordinate system, that should be translated to world coordinates
		`localAng` | The angle in the source coordinate system, that should be converted to a world angle. If you don't need to convert an angle, you can supply an arbitrary valid angle (e.g. Angle()).
		`originPos` | The origin point of the source coordinate system, in world coordinates
		`originAngle` | The angles of the source coordinate system, as a world angle
		
		
		Name | Description
		--- | ---
		`a` | The world position of the supplied local position.
		`b` | The world angles of the supplied local angle.
    **/
    
    static function LocalToWorld(localPos:Vector, localAng:Angle, originPos:Vector, originAngle:Angle):GlobalLibLocalToWorldReturn;
    
    
    /**
        Makes a clientside-only console variable
		
		**Note:** This function is a wrapper of CreateConVar, with the difference being that FCVAR_ARCHIVE and FCVAR_USERINFO are added automatically when shouldsave and userinfo are true, respectively.
		
		Name | Description
		--- | ---
		`name` | Name of the ConVar to be created and able to be accessed. This cannot be a name of existing console command or console variable. It will silently fail if it is.
		`default` | Default value of the ConVar.
		`shouldsave` | Should the ConVar be saved across sessions
		`userinfo` | Should the ConVar and its containing data be sent to the server when it has changed. This make the convar accessible from server using Player: GetInfoNum and similar functions.
		`helptext` | Help text to display in the console.
		`min` | If set, the convar cannot be changed to a number lower than this value.
		`max` | If set, the convar cannot be changed to a number higher than this value.
		
		
		`**Returns:** Created convar.
		
		___
		### Lua Examples
		#### Example 1
		Creates a ConVar that does nothing and saves.
		
		```lua 
		CreateClientConVar("superspeed_enabled", "0", true, false)
		```
    **/
    
    static function CreateClientConVar(name:String, _default:String, ?shouldsave:Bool, ?userinfo:Bool, ?helptext:String, ?min:Float, ?max:Float):ConVar;
    
    #if client
    /**
        Creates a new particle system.
		
		**Note:** The particle effect must be precached with PrecacheParticleSystem and the file its from must be added via game.AddParticles before it can be used!
		
		Name | Description
		--- | ---
		`ent` | The entity to attach the control point to.
		`effect` | The name of the effect to create. It must be precached.
		`partAttachment` | See PATTACH_ Enums.
		`entAttachment` | The attachment ID on the entity to attach the particle system to
		`offset` | The offset from the Entity: GetPos of the entity we are attaching this CP to.
		
		
		`**Returns:** The created particle system.
    **/
    
    static function CreateParticleSystem(ent:Entity, effect:String, partAttachment:PATTACH, ?entAttachment:Float, ?offset:Vector):CNewParticleEffect;
    #end
    
    /**
        Sets the value with the specified key from the table without calling the __newindex method.
		
		Name | Description
		--- | ---
		`table` | Table to get the value from.
		`index` | The index to get the value from.
		`value` | The value to set for the specified key.
    **/
    
    static function rawset(table:AnyTable, index:Dynamic, value:Dynamic):Void;
    
    
    /**
        First tries to load a binary module with the given name, if unsuccessful, it tries to load a Lua module with the given name.
		
		**Bug:** BUG Running this function with pcall or xpcall will still print an error that counts towards sv_kickerrornum. Issue Tracker: #1041 Request Tracker: #813
		
		Name | Description
		--- | ---
		`name` | The name of the module to be loaded.
    **/
    
    static function require(name:String):Void;
    
    #if client
    /**
        Returns the time in seconds it took to render the VGUI.
    **/
    
    static function VGUIFrameTime():Void;
    #end
    
    /**
        Returns the current status of the server join progress.
		
		`**Returns:** The current status
    **/
    
    static function GetLoadStatus():String;
    
    
    /**
        Returns a CEffectData object to be used with util.Effect.
		
		**Bug:** BUG This does not create a unique object, but instead returns a shared reference. That means you cannot use two or more of these objects at once. Issue Tracker: #2771
		
		`**Returns:** The CEffectData object.
    **/
    
    static function EffectData():CEffectData;
    
    #if client
    /**
        Returns the angles of the current render context as calculated by GM:CalcView.
		
		**Bug:** BUG This function is only reliable inside rendering hooks. Issue Tracker: #2516
		
		`**Returns:** The angle of the currently rendered scene.
		
		___
		### Lua Examples
		#### Example 1
		Print the view angles
		
		```lua 
		print(EyeAngles())
		```
		
		#### Example 2
		Identical to EyeVector
		
		```lua 
		print(EyeAngles():Forward())
		```
    **/
    
    static function EyeAngles():Angle;
    #end
    
    /**
        Returns a table of console command names beginning with the given text.
		
		Name | Description
		--- | ---
		`text` | Text that the console commands must begin with.
		
		
		`**Returns:** Table of console command names.
    **/
    
    static function ConsoleAutoComplete(text:String):AnyTable;
    
    
    /**
        Plays a sentence from scripts/sentences.txt
		
		Name | Description
		--- | ---
		`soundName` | The sound to play
		`position` | The position to play at
		`entity` | The entity to emit the sound from. Must be Entity: EntIndex
		`channel` | The sound channel, see CHAN_ Enums.
		`volume` | The volume of the sound, from 0 to 1
		`soundLevel` | The sound level of the sound, see SNDLVL_ Enums
		`soundFlags` | The flags of the sound, see SND_ Enums
		`pitch` | The pitch of the sound, 0-255
		
		
		___
		### Lua Examples
		#### Example 1
		Plays random combine death sound on first player.
		
		```lua 
		EmitSentence( "COMBINE_DIE" .. math.random( 0, 3 ), Entity(1):GetPos(), 1, CHAN_AUTO, 1, 75, 0, 100 )
		```
    **/
    
    static function EmitSentence(soundName:String, position:Vector, entity:Float, ?channel:CHAN, ?volume:Float, ?soundLevel:SNDLVL, ?soundFlags:SND, ?pitch:Float):Void;
    
    
    /**
        Gets the ConVar with the specified name. This function caches the ConVar object internally.
		
		Name | Description
		--- | ---
		`name` | Name of the ConVar to get
		
		
		`**Returns:** The ConVar object
    **/
    
    static function GetConVar(name:String):ConVar;
    
    #if menu
    /**
        Returns the menu overlay panel, a container for panels like the error panel created in GM:OnLuaError.
		
		`**Returns:** The overlay panel
    **/
    
    static function GetOverlayPanel():Panel;
    #end
    #if client
    /**
        Renders the post-processing effect of beams of light originating from the map's sun. Utilises the "pp/sunbeams" material
		
		Name | Description
		--- | ---
		`darken` | $darken property for sunbeams material
		`multiplier` | $multiply property for sunbeams material
		`sunSize` | $sunsize property for sunbeams material
		`sunX` | $sunx property for sunbeams material
		`sunY` | $suny property for sunbeams material
    **/
    
    static function DrawSunbeams(darken:Float, multiplier:Float, sunSize:Float, sunX:Float, sunY:Float):Void;
    #end
    
    /**
        Throws an error. This is currently an alias of ErrorNoHalt despite it once throwing a halting error like error without the stack trace appended.
		
		**Bug:** BUG This function throws a non-halting error instead of a halting error. Issue Tracker: #2113
		
		Name | Description
		--- | ---
		`arguments` | Converts all arguments to strings and prints them with no spacing or line breaks.
    **/
    
    static function Error(arguments:Rest<Dynamic>):Void;
    
    #if client
    /**
        Draws background blur around the given panel.
		
		Name | Description
		--- | ---
		`panel` | Panel to draw the background blur around
		`startTime` | Time that the blur began being painted
		
		
		___
		### Lua Examples
		#### Example 1
		Blur being drawn around a panel
		
		```lua 
		function PANEL:Init()
		    self.startTime = SysTime()
		end
		
		function PANEL:Paint()
		    Derma_DrawBackgroundBlur(self, self.startTime)
		end
		```
		**Output:**
		
		Background blur is drawn around the panel
    **/
    
    static function Derma_DrawBackgroundBlur(panel:Panel, startTime:Float):Void;
    #end
    
    /**
        Returns the name of the current server.
		
		`**Returns:** The name of the server.
    **/
    
    static function GetHostName():String;
    
    #if client
    /**
        ***INTERNAL** 
		
		Called by the engine when a model has been loaded. Caches model information with the [sqllibrary](https://wiki.garrysmod.com/page/Category:sql).
		
		Name | Description
		--- | ---
		`modelName` | Name of the model.
		`numPostParams` | Number of pose parameters the model has.
		`numSeq` | Number of sequences the model has.
		`numAttachments` | Number of attachments the model has.
		`numBoneControllers` | Number of bone controllers the model has.
		`numSkins` | Number of skins that the model has.
		`size` | Size of the model.
    **/
    @:deprecated("INTERNAL")
    static function OnModelLoaded(modelName:String, numPostParams:Float, numSeq:Float, numAttachments:Float, numBoneControllers:Float, numSkins:Float, size:Float):Void;
    #end
    
    /**
        Translates the specified position and angle into the specified coordinate system.
		
		Name | Description
		--- | ---
		`position` | The position that should be translated from the current to the new system.
		`angle` | The angles that should be translated from the current to the new system.
		`newSystemOrigin` | The origin of the system to translate to.
		`newSystemAngles` | The angles of the system to translate to.
		
		
		Name | Description
		--- | ---
		`a` | Local position
		`b` | Local angles
    **/
    
    static function WorldToLocal(position:Vector, angle:Angle, newSystemOrigin:Vector, newSystemAngles:Angle):GlobalLibWorldToLocalReturn;
    
    
    /**
        Calls game.AddParticles and returns given string.
		
		Name | Description
		--- | ---
		`file` | The particle file.
		
		
		`**Returns:** The particle file.
    **/
    
    static function Particle(file:String):String;
    
    
    /**
        Returns the CurTime-based time in seconds it took to render the last frame. 
		
		This should be used for frame/tick based timing, such as movement prediction or animations. 
		
		 For real-time-based frame time that isn't affected by host_timescale, use RealFrameTime. RealFrameTime is more suited for things like GUIs or HUDs.
		
		`**Returns:** time (in seconds)
		
		___
		### Lua Examples
		#### Example 1
		Print the frame time
		
		```lua 
		print(FrameTime())
		```
		**Output:**
		
		0.014999999664724
		
		#### Example 2
		Get the servers/clients tickrate/fps
		
		```lua 
		print("Tick: "..(1/FrameTime()))
		```
		**Output:**
		
		Tick: 66.666668156783
    **/
    
    static function FrameTime():Float;
    
    
    /**
        Throws a Lua error but does not break out of the current call stack. This function will not print a stack trace like a normal error would. Essentially similar if not equivalent to Msg.
		
		**Bug:** BUG Using this function in the menu state exits the menu. Issue Tracker: #1810
		
		Name | Description
		--- | ---
		`arguments` | Converts all arguments to strings and prints them with no spacing.
		
		
		___
		### Lua Examples
		#### Example 1
		An example of the use of this function
		
		```lua 
		local num = 11
		if ( num <= 10 and num >= 0 ) then
		    print( "The number is", num )
		else
		    ErrorNoHalt( "Number out of range!\n" )
		    print("This line will be printed")
		end
		```
    **/
    
    static function ErrorNoHalt(arguments:Rest<Dynamic>):Void;
    
    
    /**
        Returns the player with the matching Player:UserID. 
		
		For a function that returns a player based on their Entity:EntIndex, see Entity. For a function that returns a player based on their connection ID, see player.GetByID.
		
		Name | Description
		--- | ---
		`playerIndex` | The player index.
		
		
		`**Returns:** The retrieved player.
    **/
    
    static function Player(playerIndex:Float):Player;
    
    
    /**
        Launches an asynchronous http request with the given parameters.
		
		**Bug:** BUG This cannot send or receive multiple headers at once. Issue Tracker: #2232
		
		Name | Description
		--- | ---
		`parameters` | The request parameters. See HTTPRequest structure.
		
		
		`**Returns:** true if we made a request, nil if we failed.
    **/
    
    static function HTTP(parameters:HTTPRequest):Bool;
    
    
    /**
        Creates a particle effect with specialized parameters.
		
		**Note:** The particle effect must be precached with PrecacheParticleSystem and the file its from must be added via game.AddParticles before it can be used!
		
		Name | Description
		--- | ---
		`particleName` | The name of the particle effect.
		`attachType` | Attachment type using PATTACH_ Enums.
		`entity` | The entity to be used in the way specified by the attachType.
		`attachmentID` | The id of the attachment to be used in the way specified by the attachType.
    **/
    
    static function ParticleEffectAttach(particleName:String, attachType:PATTACH, entity:Entity, attachmentID:Float):Void;
    
    
    /**
        Works exactly like Msg except that, if called on the server, will print to all players consoles plus the server console.
		
		Name | Description
		--- | ---
		`args` | List of values to print.
    **/
    
    static function MsgAll(args:Rest<Dynamic>):Void;
    
    
    /**
        Returns an CTakeDamageInfo object.
		
		**Bug:** BUG This does not create a unique object, but instead returns a shared reference. That means you cannot use two or more of these objects at once. Issue Tracker: #2771
		
		`**Returns:** The CTakeDamageInfo object.
    **/
    
    static function DamageInfo():CTakeDamageInfo;
    
    
    /**
        Runs a menu command. Equivalent to RunConsoleCommand( "gamemenucommand", command ) unless the command starts with the "engine" keyword in which case it is equivalent to RunConsoleCommand( command ).
		
		Name | Description
		--- | ---
		`command` | The menu command to run Should be one of the following: Disconnect - Disconnects from the current server. OpenBenchmarkDialog - Opens the "Video Hardware Stress Test" dialog. OpenChangeGameDialog - Does not work in GMod. OpenCreateMultiplayerGameDialog - Opens the Source dialog for creating a listen server. OpenCustomMapsDialog - Does nothing. OpenFriendsDialog - Does nothing. OpenGameMenu - Does not work in GMod. OpenLoadCommentaryDialog - Opens the "Developer Commentary" selection dialog. Useless in GMod. OpenLoadDemoDialog - Does nothing. OpenLoadGameDialog - Opens the Source "Load Game" dialog. OpenNewGameDialog - Opens the "New Game" dialog. Useless in GMod. OpenOptionsDialog - Opens the options dialog. OpenPlayerListDialog - Opens the "Mute Players" dialog that shows all players connected to the server and allows to mute them. OpenSaveGameDialog - Opens the Source "Save Game" dialog. OpenServerBrowser - Opens the legacy server browser. Quit - Quits the game without confirmation (unlike other Source games). QuitNoConfirm - Quits the game without confirmation (like other Source games). ResumeGame - Closes the menu and returns to the game. engine <concommand> - Runs a console command. Equivalent to RunConsoleCommand( <concommand> ).
		
		
		___
		### Lua Examples
		#### Example 1
		Opens the options dialog.
		
		```lua 
		RunGameUICommand( "OpenOptionsDialog" )
		```
		
		#### Example 2
		Hides the game UI (menu). Equivalent to RunConsoleCommand( "gameui_hide" )
		
		```lua 
		RunGameUICommand( "engine gameui_hide" )
		```
    **/
    
    static function RunGameUICommand(command:String):Void;
    
    
    /**
        Attempts to call the first function. If the execution succeeds, this returns true followed by the returns of the function. If execution fails, this returns false and the second function is called with the error message. 
		
		Unlike in pcall, the stack is not unwound and can therefore be used for stack analyses with the debug library.
		
		**Bug:** BUG Using this function with include will break autorefresh. Issue Tracker: #1976
		
		**Bug:** BUG This cannot stop errors from hooks called from the engine. Issue Tracker: #2036
		
		**Bug:** BUG This does not stop Error and ErrorNoHalt from sending error messages to the server (if called clientside) or calling the GM:OnLuaError hook. The success boolean returned will always return true and thus you will not get the error message returned. error does not exhibit these behaviours. Issue Tracker: #2498
		
		**Bug:** BUG This does not stop errors incurred by include. Issue Tracker: #3112
		
		Name | Description
		--- | ---
		`func` | The function to call initially.
		`errorCallback` | The function to be called if execution of the first fails; the error message is passed as a string. You cannot throw an error() from this callback: it will have no effect (not even stopping the callback).
		`arguments` | Arguments to pass to the initial function.
		
		
		Name | Description
		--- | ---
		`a` | Status of the execution; true for success, false for failure.
		`b` | The returns of the first function if execution succeeded, otherwise the first return value of the error callback.
		
		
		___
		### Lua Examples
		#### Example 1
		Using xpcall to catch an error.
		
		```lua 
		local function test()
		    aisj()
		end
		
		local function catch( err )
		    print( "ERROR: ", err )
		end
		
		print( "Output: ", xpcall( test, catch ) )
		```
		**Output:**
		
		ERROR: lua/wiki/xpcall_example.lua:2: attempt to call global 'aisj' (a nil value) Output: false nil
    **/
    
    static function xpcall(func:Function, errorCallback:Function, arguments:Rest<Dynamic>):GlobalLibXpcallReturn;
    
    
    /**
        Runs util.PrecacheModel and returns the string
		
		Name | Description
		--- | ---
		`model` | The model to precache
		
		
		`**Returns:** The same string entered as an argument
		
		___
		### Lua Examples
		#### Example 1
		From entities/gmod_cameraprop.lua
		
		```lua 
		local CAMERA_MODEL = Model( "models/dav0r/camera.mdl" )
		function ENT:Initialize()
		 self:SetModel( CAMERA_MODEL )
		 ...
		```
    **/
    
    static function Model(model:String):String;
    
    
    /**
        Returns the duration of the sound specified in seconds.
		
		**Bug:** BUG This only works properly for .wav files. Issue Tracker: #936
		
		Name | Description
		--- | ---
		`soundName` | The sound file path.
		
		
		`**Returns:** Sound duration in seconds.
    **/
    
    static function SoundDuration(soundName:String):Float;
    
    #if client
    /**
        Creates a fully clientside ragdoll.
		
		**Warning:** Model must be precached with util.PrecacheModel on the server before usage.
		
		**Note:** The ragdoll initially starts as hidden and with shadows disabled, see the example for how to enable it. There's no need to call Entity:Spawn on this entity. The physics won't initialize at all if the model hasn't been precached serverside first.
		
		**Bug:** BUG Clientside entities are not garbage-collected, thus you must store a reference to the object and call CSEnt:Remove manually. Issue Tracker: #1387
		
		Name | Description
		--- | ---
		`model` | The file path to the model. WARNING Model must be precached with util.PrecacheModel on the server before usage.
		`renderGroup` | The RENDERGROUP_ Enums to assign.
		
		
		`**Returns:** The newly created client-side ragdoll. ( C_ClientRagdoll )
		
		___
		### Lua Examples
		#### Example 1
		Creates a new ragdoll with the player model of breen and enables rendering and shadows.
		
		```lua 
		local ragdoll = ClientsideRagdoll( "models/player/breen.mdl" )
		ragdoll:SetNoDraw( false )
		ragdoll:DrawShadow( true )
		```
    **/
    
    static function ClientsideRagdoll(model:String, ?renderGroup:RENDERGROUP):CSEnt;
    #end
    
    /**
        Sets, changes or removes a table's metatable. Returns Tab (the first argument).
		
		Name | Description
		--- | ---
		`Tab` | The table who's metatable to change.
		`Metatable` | The metatable to assign. If it's nil, the metatable will be removed.
		
		
		`**Returns:** The first argument.
		
		___
		### Lua Examples
		#### Example 1
		Creates a metatable and assigns it to a table.
		
		```lua 
		local Pupil_meta = {
		    GetName = function(self)
		        return self.name
		    end
		}
		Pupil_meta.__index = Pupil_meta
		-- If a key cannot be found in an object, it will look in it's metatable's __index metamethod.
		
		local Pupil = {
		    name = "John Doe"
		}
		
		setmetatable(Pupil, Pupil_meta)
		
		print( Pupil:GetName() )
		-- This will look for the "GetName" key in Pupil, but it doesn't have one. So it will look in it's metatable (Pupil_meta) __index key instead.
		```
		**Output:**
		
		"John Doe"
    **/
    
    static function setmetatable(Tab:AnyTable, Metatable:AnyTable):AnyTable;
    
    
    /**
        Defines an angle to be automatically networked to clients
		
		**Note:** Running this function clientside will only set it clientside for the client it is called on!
		
		Name | Description
		--- | ---
		`index` | Index to identify the global angle with
		`angle` | Angle to be networked
    **/
    
    static function SetGlobalAngle(index:Dynamic, angle:Angle):Void;
    
    #if client
    /**
        Creates and returns a new DSprite element with the supplied material.
		
		Name | Description
		--- | ---
		`material` | Material the sprite should draw.
		
		
		`**Returns:** The new DSprite element.
    **/
    
    static function CreateSprite(material:IMaterial):Panel;
    #end
    
    /**
        ***INTERNAL** 
		
		This function is used to get the last map and category to which the map belongs from the cookie saved with [SaveLastMap](https://wiki.garrysmod.com/page/Global/SaveLastMap).
    **/
    @:deprecated("INTERNAL")
    static function LoadLastMap():Void;
    
    
    /**
        Returns if the passed object is a Panel.
		
		Name | Description
		--- | ---
		`variable` | The variable to perform the type check for.
		
		
		`**Returns:** True if the variable is a Panel.
    **/
    
    static function ispanel(variable:Dynamic):Bool;
    
    
    /**
        Gets the value with the specified key from the table without calling the __index method.
		
		Name | Description
		--- | ---
		`table` | Table to get the value from.
		`index` | The index to get the value from.
		
		
		`**Returns:** The value.
    **/
    
    static function rawget(table:AnyTable, index:Dynamic):Dynamic;
    
    #if client
    /**
        ***Deprecated:** You should use IsValid instead
		
		Returns if a panel is safe to use.
		
		Name | Description
		--- | ---
		`panel` | The panel to validate.
    **/
    @:deprecated("You should use IsValid instead")
    static function ValidPanel(panel:Panel):Void;
    #end
    #if client
    /**
        Creates or replaces a dynamic light with the given id.
		
		**Warning:** It is not safe to hold a reference to this object after creation since its data can be replaced by another dlight at any time.
		
		**Note:** Only 32 dlights and 64 elights can be active at once.
		
		**Bug:** BUG The minlight parameter affects the world and entities differently. Issue Tracker: #3798
		
		Name | Description
		--- | ---
		`index` | An unsigned Integer. Usually an entity index is used here.
		`elight` | Allocates an elight instead of a dlight. Elights have a higher light limit and do not light the world (making the "noworld" parameter have no effect).
		
		
		`**Returns:** A DynamicLight structured table. See DynamicLight structure
		
		___
		### Lua Examples
		#### Example 1
		Emits a bright white light from local players eyes.
		
		```lua 
		hook.Add( "Think", "Think_Lights!", function()
		    local dlight = DynamicLight( LocalPlayer():EntIndex() )
		    if ( dlight ) then
		        dlight.pos = LocalPlayer():GetShootPos()
		        dlight.r = 255
		        dlight.g = 255
		        dlight.b = 255
		        dlight.brightness = 2
		        dlight.Decay = 1000
		        dlight.Size = 256
		        dlight.DieTime = CurTime() + 1
		    end
		end )
		```
    **/
    
    static function DynamicLight(index:Float, ?elight:Bool):DynamicLight;
    #end
    
    /**
        Returns an iterator function that can be used to loop through a table in order of its values. 
		
		To sort by specific value member, use SortedPairsByMemberValue. To sort by keys, use SortedPairs.
		
		Name | Description
		--- | ---
		`table` | Table to create iterator for
		`descending` | Whether the iterator should iterate in descending order or not
		
		
		Name | Description
		--- | ---
		`a` | Iterator function
		`b` | The table which will be iterated over
    **/
    
    static function SortedPairsByValue(table:AnyTable, ?descending:Bool):GlobalLibSortedPairsByValueReturn;
    
    
    /**
        Attempts to return an appropriate boolean for the given value
		
		Name | Description
		--- | ---
		`val` | The object to be converted to a boolean
		
		
		`**Returns:** false for the boolean false. false for "false". false for "0". false for numeric 0. false for nil. true otherwise.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrate the output of this function with various values.
		
		```lua 
		print("boolean true:", tobool(true))
		print("boolean false:", tobool(false))
		print("string true:", tobool("true"))
		print("string false:", tobool("false"))
		print("numeric 0:", tobool(0))
		print("string 0:", tobool("0"))
		print("string 1:", tobool("1"))
		print("nil:", tobool(nil))
		print("text string:", tobool("not a boolean"))
		print("empty string:", tobool(""))
		```
		**Output:**
		
		boolean true: true boolean false: false string true: true string false: false numeric 0: false string 0: false string 1: true nil: false text string: true empty string: true
    **/
    
    static function tobool(val:Dynamic):Bool;
    
    
    /**
        ***Deprecated:** This function was deprecated in Lua 5.1 and is removed in Lua 5.2. Use collectgarbage( "count" ) instead.
		
		Returns the current floored dynamic memory usage of Lua in kilobytes.
		
		`**Returns:** The current floored dynamic memory usage of Lua, in kilobytes.
    **/
    @:deprecated("This function was deprecated in Lua 5.1 and is removed in Lua 5.2. Use collectgarbage( \"count\" ) instead.")
    static function gcinfo():Float;
    
    
    /**
        Linear interpolation between two vectors. It is commonly used to smooth movement between two vectors.
		
		Name | Description
		--- | ---
		`fraction` | Fraction ranging from 0 to 1
		`from` | The initial Vector
		`to` | The desired Vector
		
		
		`**Returns:** The lerped vector.
		
		___
		### Lua Examples
		#### Example 1
		Get the middle point (50%) between two vectors.
		
		```lua 
		local output = LerpVector( 0.5, Vector( 0, 0, 100 ), Vector( 0, 0, 200 ) )
		```
		**Output:**
		
		Vector( 0, 0, 150 )
    **/
    
    static function LerpVector(fraction:Float, from:Vector, to:Vector):Vector;
    
    #if client
    /**
        Saves position of your cursor on screen. You can restore it by using RestoreCursorPosition.
    **/
    
    static function RememberCursorPosition():Void;
    #end
    
    /**
        Adds simple Get/Set accessor functions on the specified table. Can also force the value to be set to a number, bool or string.
		
		Name | Description
		--- | ---
		`tab` | The table to add the accessor functions too.
		`key` | The key of the table to be get/set.
		`name` | The name of the functions (will be prefixed with Get and Set).
		`force` | The type the setter should force to (uses FORCE_ Enums).
		
		
		___
		### Lua Examples
		#### Example 1
		Adds the GetFooBar and SetFooBar functions to the Player metatable and then uses them.
		
		```lua 
		local meta = FindMetaTable("Player")
		AccessorFunc(meta, "foo_bar", "FooBar", FORCE_BOOL)
		
		local ply = player.GetByID(1)
		ply:SetFooBar(true)
		
		print(not ply:GetFooBar())
		```
		**Output:**
		
		false
    **/
    
    static function AccessorFunc(tab:AnyTable, key:Dynamic, name:String, ?force:FORCE):Void;
    
    
    /**
        Returns a highly accurate time in seconds since the start up, ideal for benchmarking.
		
		`**Returns:** Uptime of the server.
		
		___
		### Lua Examples
		#### Example 1
		Prints the runtime
		
		```lua 
		print(SysTime())
		```
		**Output:**
		
		1654.4422888037
		
		#### Example 2
		Typical usage of this function for benchmarking
		
		```lua 
		local SysTime = SysTime
		local Distance = FindMetaTable("Vector").Distance
		
		local vec1 = Vector(1, 2, 3)
		local vec2 = Vector(13, 26, -10)
		
		local count = 10000
		
		local StartTime = SysTime()
		
		for i = 1, count do
		    -- Repeat an action 10,000 times to check how long it takes on average
		    -- Example action:
		    Distance(vec1 , vec2)
		end
		
		local EndTime = SysTime()
		local TotalTime = EndTime - StartTime
		local AverageTime = TotalTime / count
		
		print("Total: " .. TotalTime .. " seconds. Average: " .. AverageTime .. " seconds.")
		```
    **/
    
    static function SysTime():Float;
    
    #if server
    /**
        Creates a path for the bot to follow
		
		Name | Description
		--- | ---
		`type` | The name of the path to create. This is going to be "Follow" or "Chase" right now.
		
		
		`**Returns:** The path
    **/
    
    static function Path(type:String):PathFollower;
    #end
    
    /**
        Returns whether the given object does or doesn't have a metatable of a color.
		
		**Bug:** BUG Engine functions (i.e. those not written in plain Lua) that return color objects do not currently set the color metatable and this function will return false if you use it on them. Issue Tracker: #2407
		
		Name | Description
		--- | ---
		`Object` | The object to be tested
		
		
		`**Returns:** Whether the given object is a color or not
    **/
    
    static function IsColor(Object:Dynamic):Bool;
    
    #if client
    /**
        Closes all Derma menus that have been passed to RegisterDermaMenuForClose and calls GM:CloseDermaMenus
    **/
    
    static function CloseDermaMenus():Void;
    #end
    #if client
    /**
        Creates a derma window asking players to input a string.
		
		Name | Description
		--- | ---
		`title` | The title of the created panel.
		`subtitle` | The text above the input box
		`default` | The default text for the input box.
		`confirm` | The function to be called once the user has confirmed their input.
		`cancel` | The function to be called once the user has cancelled their input
		`confirmText` | Allows you to override text of the "OK" button
		`cancelText` | Allows you to override text of the "Cancel" button
		
		
		`**Returns:** The created DFrame
		
		___
		### Lua Examples
		#### Example 1
		Asks the user to input a string which is then printed to their console
		
		```lua 
		Derma_StringRequest(
		    "Console Print", 
		    "Input the string to print to console",
		    "",
		    function(text) print(text) end,
		    function(text) print("Cancelled input") end
		)
		```
    **/
    
    static function Derma_StringRequest(title:String, subtitle:String, _default:String, confirm:Function, ?cancel:Function, ?confirmText:String, ?cancelText:String):Panel;
    #end
    
    /**
        Calls a function and catches an error that can be thrown while the execution of the call.
		
		**Bug:** BUG Using this function with include will break autorefresh. Issue Tracker: #1976
		
		**Bug:** BUG This cannot stop errors from hooks called from the engine. Issue Tracker: #2036
		
		**Bug:** BUG This does not stop Error and ErrorNoHalt from sending error messages to the server (if called clientside) or calling the GM:OnLuaError hook. The success boolean returned will always return true and thus you will not get the error message returned. error does not exhibit these behaviours. Issue Tracker: #2498
		
		**Bug:** BUG This does not stop errors incurred by include. Issue Tracker: #3112
		
		Name | Description
		--- | ---
		`func` | Function to be executed and of which the errors should be caught of
		`arguments` | Arguments to call the function with.
		
		
		Name | Description
		--- | ---
		`a` | If the function had no errors occur within it.
		`b` | If an error occurred, this will be a string containing the error message. Otherwise, this will be the return values of the function passed in.
		
		
		___
		### Lua Examples
		#### Example 1
		Catch an error.
		
		```lua 
		local succ, err = pcall(function() aisj() end)
		print(succ, err)
		```
		**Output:**
		
		false attempt to call global 'aisj' (a nil value)
    **/
    
    static function pcall(func:Function, arguments:Rest<Dynamic>):GlobalLibPcallReturn;
    
    
    /**
        Formats the specified values into the string given. Same as string.format.
		
		Name | Description
		--- | ---
		`format` | The string to be formatted. Follows this format: http://www.cplusplus.com/reference/cstdio/printf/
		`formatParameters` | Values to be formatted into the string.
		
		
		`**Returns:** The formatted string
    **/
    
    static function Format(format:String, formatParameters:Rest<Dynamic>):String;
    
    
    /**
        ***INTERNAL** 
		
		This function is used to save the last map and category to which the map belongs as a cookie.
		
		Name | Description
		--- | ---
		`map` | The name of the map.
		`category` | The name of the category to which this map belongs.
    **/
    @:deprecated("INTERNAL")
    static function SaveLastMap(map:String, category:String):Void;
    
    #if client
    /**
        ***INTERNAL** 
		
		Returns a new WorkshopFileBase element
		
		Name | Description
		--- | ---
		`namespace` | Namespace for the file base
		`requiredTags` | Tags required for a Workshop submission to be interacted with by the filebase
		
		
		`**Returns:** WorkshopFileBase element
    **/
    @:deprecated("INTERNAL")
    static function WorkshopFileBase(namespace:String, requiredTags:AnyTable):AnyTable;
    #end
    #if client
    /**
        Creates a scene entity based on the scene name and the entity.
		
		Name | Description
		--- | ---
		`name` | The name of the scene.
		`targetEnt` | The entity to play the scene on.
		
		
		`**Returns:** C_SceneEntity
		
		___
		### Lua Examples
		#### Example 1
		Plays "I guess you should go with Alyx" line from HL2.
		
		```lua 
		ClientsideScene( "scenes/eli_lab/mo_gowithalyx01.vcd", LocalPlayer() )
		```
    **/
    
    static function ClientsideScene(name:String, targetEnt:Entity):CSEnt;
    #end
    
    /**
        Returns if the passed object is an Entity. Alias of isentity.
		
		Name | Description
		--- | ---
		`variable` | The variable to check.
		
		
		`**Returns:** True if the variable is an Entity.
    **/
    
    static function IsEntity(variable:Dynamic):Bool;
    
    
    /**
        Returns the ordinal suffix of a given number.
		
		Name | Description
		--- | ---
		`number` | The number to find the ordinal suffix of.
		
		
		`**Returns:** suffix
		
		___
		### Lua Examples
		#### Example 1
		Returns the ordinal suffix of 72.
		
		```lua 
		print( 72 .. STNDRD(72) )
		```
		**Output:**
		
		72nd
    **/
    
    static function STNDRD(number:Float):String;
    
    #if server
    /**
        Precaches a scene file.
		
		Name | Description
		--- | ---
		`scene` | Path to the scene file to precache.
    **/
    
    static function PrecacheScene(scene:String):Void;
    #end
    
    /**
        Returns a new userdata object.
		
		Name | Description
		--- | ---
		`addMetatable` | If true, the userdata will get its own metatable automatically.
		
		
		`**Returns:** The newly created userdata.
    **/
    
    static function newproxy(?addMetatable:Bool):UserData;
    
    
    /**
        Returns the meta table for the class with the matching name. 
		
		Internally returns debug.getregistry()[metaName] 
		
		 You can learn more about meta tables on the Meta Tables page. 
		
		 You can find a list of meta tables that can be retrieved with this function on TYPE_ Enums. The name in the description is the string to use with this function.
		
		Name | Description
		--- | ---
		`metaName` | The object type to retrieve the meta table of.
		
		
		`**Returns:** The corresponding meta table.
		
		___
		### Lua Examples
		#### Example 1
		Adds a very simple function for checking if a player is sick to the player metatable.
		
		```lua 
		local meta = FindMetaTable("Player")
		
		function meta:IsSick()
		    return true
		end
		
		-- Sometime later...
		local ply = Entity(1)
		if ( ply:IsSick() ) then
		    ply:ChatPrint( "Get well soon, " .. ply:Nick() .. "!" )
		    ply:ChatPrint( "I just don't understand how you're always sick..." )
		end
		```
    **/
    
    static function FindMetaTable(metaName:String):AnyTable;
    
    
    /**
        Returns a sound parented to the specified entity.
		
		**Note:** You can only create one CSoundPatch per audio file, per entity at the same time.
		
		**Note:** This argument only works serverside.
		
		Name | Description
		--- | ---
		`targetEnt` | The target entity.
		`soundName` | The sound to play.
		`filter` | A CRecipientFilter of the players that will have this sound networked to them. NOTE This argument only works serverside.
		
		
		`**Returns:** The sound object
		
		___
		### Lua Examples
		#### Example 1
		Play a sound everywhere, similar to surface.PlaySound but available clientside and serverside.
		
		```lua 
		local LoadedSounds
		if CLIENT then
		    LoadedSounds = {} -- this table caches existing CSoundPatches
		end
		
		local function ReadSound( FileName )
		    local sound
		    local filter
		    if SERVER then
		        filter = RecipientFilter()
		        filter:AddAllPlayers()
		    end
		    if SERVER or !LoadedSounds[FileName] then
		        -- The sound is always re-created serverside because of the RecipientFilter.
		        sound = CreateSound( game.GetWorld(), FileName, filter ) -- create the new sound, parented to the worldspawn (which always exists)
		        if sound then
		            sound:SetSoundLevel( 0 ) -- play everywhere
		            if CLIENT then
		                LoadedSounds[FileName] = { sound, filter } -- cache the CSoundPatch
		            end
		        end
		    else
		        sound = LoadedSounds[FileName][1]
		        filter = LoadedSounds[FileName][2]
		    end
		    if sound then
		        if CLIENT then
		            sound:Stop() -- it won't play again otherwise
		        end
		        sound:Play()
		    end
		    return sound -- useful if you want to stop the sound yourself
		end
		
		-- When we are ready, we play the sound:
		ReadSound( "phx/hmetal1.wav" )
		```
    **/
    #if server
    static function CreateSound(targetEnt:Entity, soundName:String, ?filter:CRecipientFilter):CSoundPatch;
	#else
	static function CreateSound(targetEnt:Entity, soundName:String):CSoundPatch;
	#end
	
    #if client
    /**
        Does the removing of the tooltip panel. Called by EndTooltip.
    **/
    
    static function RemoveTooltip():Void;
    #end
    
    /**
        Returns a table with the names of all maps and categories that you have on your client.
		
		`**Returns:** table of map names and categories
    **/
    
    static function GetMapList():AnyTable;
    
    
    /**
        Called by the engine to set which constraint system [1] the next created constraints should use
		
		Name | Description
		--- | ---
		`constraintSystem` | Constraint system to use
    **/
    
    static function SetPhysConstraintSystem(constraintSystem:Entity):Void;
    
    #if client
    /**
        Returns a localisation for the given token, if none is found it will return the default(second) parameter.
		
		Name | Description
		--- | ---
		`localisationToken` | The token to find a translation for.
		`default` | The default value to be returned if no translation was found.
    **/
    
    static function Localize(localisationToken:String, _default:String):Void;
    #end
    #if client
    /**
        Creates a DMenu and closes any current menus.
		
		Name | Description
		--- | ---
		`parent` | The panel to parent the created menu to.
		
		
		`**Returns:** The created DMenu
		
		___
		### Lua Examples
		#### Example 1
		Creates a DMenu with buttons to commit suicide or close it.
		
		```lua 
		local menu = DermaMenu() 
		menu:AddOption("Die", function() RunConsoleCommand("kill") end)
		menu:AddOption("Close", function() print("Close pressed") end) -- The menu will remove itself, we don't have to do anything.
		menu:Open()
		```
    **/
    
    static function DermaMenu(parent:Panel):Panel;
    #end
    
    /**
        Returns a vector that is shared between the server and all clients.
		
		Name | Description
		--- | ---
		`Index` | The unique index to identify the global value with.
		`Default` | The value to return if the global value is not set.
		
		
		`**Returns:** The global value, or the default if the global value is not set.
    **/
    
    static function GetGlobalVector(Index:String, Default:Vector):Vector;
    
    
    /**
        Returns the next key and value pair in a table.
		
		**Note:** Table keys in Lua have no specific order, and will be returned in whatever order they exist in memory. This may not always be in ascending order or alphabetical order. If you need to iterate over an array in order, use ipairs.
		
		Name | Description
		--- | ---
		`tab` | The table
		`prevKey` | The previous key in the table.
		
		
		Name | Description
		--- | ---
		`a` | The next key for the table. If the previous key was nil, this will be the first key in the table. If the previous key was the last key in the table, this will be nil.
		`b` | The value associated with that key. If the previous key was the last key in the table, this will be nil.
		
		
		___
		### Lua Examples
		#### Example 1
		Returns whether the table is empty or not
		
		```lua 
		local function IsEmptyTable( t )
		    return next( t ) == nil
		end
		
		local mytable = {}
		print( "mytable is empty:", IsEmptyTable( mytable ) )
		mytable["hello"]=true
		print( "mytable is empty:", IsEmptyTable( mytable ) )
		```
    **/
    
    static function next(tab:AnyTable, ?prevKey:Dynamic):GlobalLibNextReturn;
    
    #if server
    /**
        Creates a new CRecipientFilter.
		
		`**Returns:** The new created recipient filter.
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the function
		
		```lua 
		local rf = RecipientFilter()
		rf:AddAllPlayers()
		print( rf:GetCount() )
		PrintTable( rf:GetPlayers() )
		```
		**Output:**
		
		2 1 = Player [1][Player #1] 2 = Player [2][Player #2]
    **/
    
    static function RecipientFilter():CRecipientFilter;
    #end
    
    /**
        Writes every given argument to the console. 
		
		Automatically attempts to convert each argument to a string. (See tostring) 
		
		 Unlike print, arguments are not separated by anything. They are simply concatenated. 
		
		 Additionally, a newline isn't added automatically to the end, so subsequent Msg or print operations will continue the same line of text in the console. See MsgN for a version that does add a newline. 
		
		 The text is blue on the server, orange on the client, and green on the menu:
		
		Name | Description
		--- | ---
		`args` | List of values to print.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints "Hello World!" to the console.
		
		```lua 
		Msg("Hello", " World!")
		```
		**Output:**
		
		Hello World!
    **/
    
    static function Msg(args:Rest<Dynamic>):Void;
    
    
    /**
        Creates a console variable (ConVar), in general these are for things like gamemode/server settings.
		
		Name | Description
		--- | ---
		`name` | Name of the convar. This cannot be a name of an engine console command or console variable. It will silently fail if it is. If it is the same name as another lua ConVar, it will return that ConVar object.
		`value` | Default value of the convar. Can also be a number.
		`flags` | Flags of the convar, see FCVAR_ Enums, either as bitflag or as table.
		`helptext` | The help text to show in the console.
		`min` | If set, the ConVar cannot be changed to a number lower than this value.
		`max` | If set, the ConVar cannot be changed to a number higher than this value.
		
		
		`**Returns:** The convar created.
    **/
    
    static function CreateConVar(name:String, value:String, ?flags:FCVAR, ?helptext:String, ?min:Float, ?max:Float):ConVar;
    
    
    /**
        ***INTERNAL** 
		
		***Deprecated:** 
		
		Returns "Lua Cache File" if the given file name is in a certain string table, nothing otherwise.
		
		Name | Description
		--- | ---
		`filename` | File name to test
		
		
		`**Returns:** "Lua Cache File" if the given file name is in a certain string table, nothing otherwise.
    **/
    @:deprecated("INTERNAL")
    static function TranslateDownloadableName(filename:String):String;
    
    
    /**
        Defines a floating point number to be automatically networked to clients
		
		**Note:** Running this function clientside will only set it clientside for the client it is called on!
		
		Name | Description
		--- | ---
		`index` | Index to identify the global float with
		`float` | Float to be networked
    **/
    
    static function SetGlobalFloat(index:Dynamic, float:Float):Void;
    
    #if client
    /**
        Adds the given string to the computers clipboard, which can then be pasted in or outside of GMod with Ctrl + V.
		
		Name | Description
		--- | ---
		`text` | The text to add to the clipboard.
		
		
		___
		### Lua Examples
		#### Example 1
		Sets the clipboards text to "Hello!".
		
		```lua 
		SetClipboardText( "Hello!" )
		```
    **/
    
    static function SetClipboardText(text:String):Void;
    #end
    
    /**
        Converts a Color structure into HSV color space.
		
		Name | Description
		--- | ---
		`color` | The Color structure.
		
		
		Name | Description
		--- | ---
		`a` | The hue in degrees [0, 360).
		`b` | The saturation in the range [0, 1].
		`c` | The value in the range [0, 1].
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a color and prints the HSV values to the console.
		
		```lua 
		print(ColorToHSV(Color(255, 255, 0)))
		```
		**Output:**
		
		60 1 1
    **/
    
    static function ColorToHSV(color:Color):GlobalLibColorToHSVReturn;
    
    
    /**
        Returns a random vector whose components are each between min(inclusive), max(exclusive).
		
		Name | Description
		--- | ---
		`min` | Min bound inclusive.
		`max` | Max bound exclusive.
		
		
		`**Returns:** The random direction vector.
    **/
    
    static function VectorRand(?min:Float, ?max:Float):Vector;
    
    
    /**
        Same as print, except it concatinates the arguments without inserting any whitespace in between them. 
		
		See also Msg, which doesn't add a newline ("\n") at the end.
		
		Name | Description
		--- | ---
		`args` | List of values to print. They can be of any type and will be converted to strings with tostring.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints "Hello, World!" in two lines to the console.
		
		```lua 
		MsgN("Hello,")
		MsgN("World!")
		```
    **/
    
    static function MsgN(args:Rest<Dynamic>):Void;
    
    #if client
    /**
        Returns a new mesh object.
		
		Name | Description
		--- | ---
		`mat` | The material the mesh is intended to be rendered with. It's merely a hint that tells that mesh what vertex format it should use.
		
		
		`**Returns:** The created object.
		
		___
		### Lua Examples
		#### Example 1
		Draws a triangle near Vector( 0, 0, 0 ) in the map.
		
		```lua 
		local mat = Material( "editor/wireframe" ) -- The material (a wireframe)
		local obj = Mesh() -- Create the IMesh object
		
		local verts = { -- A table of 3 vertices that form a triangle
		    { pos = Vector( 0,  0,  0 ), u = 0, v = 0 }, -- Vertex 1
		    { pos = Vector( 10, 0,  0 ), u = 1, v = 0 }, -- Vertex 2
		    { pos = Vector( 10, 10, 0 ), u = 1, v = 1 }, -- Vertex 3
		}
		
		obj:BuildFromTriangles( verts ) -- Load the vertices into the IMesh object
		
		hook.Add( "PostDrawOpaqueRenderables", "IMeshTest", function()
		
		    render.SetMaterial( mat ) -- Apply the material
		    obj:Draw() -- Draw the mesh
		
		end )
		```
    **/
    
    static function Mesh(?mat:IMaterial):IMesh;
    #end
    
    /**
        Loads and registers the specified gamemode, setting the GM table's DerivedFrom field to the value provided, if the table exists. The DerivedFrom field is used post-gamemode-load as the "derived" parameter for gamemode.Register.
		
		Name | Description
		--- | ---
		`base` | Gamemode name to derive from.
		
		
		___
		### Lua Examples
		#### Example 1
		Retrieves data from sandbox.
		
		```lua 
		DeriveGamemode("sandbox")
		```
    **/
    
    static function DeriveGamemode(base:String):Void;
    
    
    /**
        Returns an iterator function(next) for a for loop that will return the values of the specified table in an arbitrary order. 
		
		For alphabetical key order use SortedPairs. For alphabetical value order use SortedPairsByValue.
		
		Name | Description
		--- | ---
		`tab` | The table to iterate over
		
		
		Name | Description
		--- | ---
		`a` | The iterator ( next)
		`b` | The table being iterated over
		`c` | nil (for the constructor)
		
		
		___
		### Lua Examples
		#### Example 1
		Iterates through all players on the server and prints their names.
		
		```lua 
		for k, v in pairs( player.GetAll() ) do
		    print( v:Nick() )
		end
		```
		**Output:**
		
		A list of players in console.
    **/
    
    static function pairs(tab:AnyTable):GlobalLibPairsReturn;
    
    #if server
    /**
        Displays a message in the chat, console, or center of screen of every player. 
		
		This uses the archaic user message system (umsg library) and hence is limited to ≈250 characters.
		
		Name | Description
		--- | ---
		`type` | Which type of message should be sent to the players (see HUD_ Enums)
		`message` | Message to be sent to the players
		
		
		___
		### Lua Examples
		#### Example 1
		Prints into the every player's chat: "I'm new here."
		
		```lua 
		PrintMessage(HUD_PRINTTALK, "I'm new here.")
		```
		**Output:**
		
		I'm new here.
    **/
    
    static function PrintMessage(type:HUD, message:String):Void;
    #end
    
    /**
        Converts a Color structure into HSL color space.
		
		Name | Description
		--- | ---
		`color` | The Color structure.
		
		
		Name | Description
		--- | ---
		`a` | The hue in degrees [0, 360).
		`b` | The saturation in the range [0, 1].
		`c` | The lightness in the range [0, 1].
    **/
    
    static function ColorToHSL(color:Color):GlobalLibColorToHSLReturn;
    
    
    /**
        Joins the server with the specified IP.
		
		Name | Description
		--- | ---
		`IP` | The IP of the server to join
		
		
		___
		### Lua Examples
		#### Example 1
		Joins the server running on your machine.
		
		```lua 
		JoinServer("localhost")
		```
    **/
    
    static function JoinServer(IP:String):Void;
    
    #if client
    /**
        Returns named color defined in resource/ClientScheme.res.
		
		Name | Description
		--- | ---
		`name` | Name of color
		
		
		`**Returns:** A Color structure or nil
    **/
    
    static function NamedColor(name:String):Color;
    #end
    #if client
    /**
        Renders a Depth of Field effect
		
		Name | Description
		--- | ---
		`origin` | Origin to render the effect at
		`angle` | Angle to render the effect at
		`usableFocusPoint` | Point to focus the effect at
		`angleSize` | Angle size of the effect
		`radialSteps` | Amount of radial steps to render the effect with
		`passes` | Amount of render passes
		`spin` | Whether to cycle the frame or not
		`inView` | Table of view data
		`fov` | FOV to render the effect with
    **/
    
    static function RenderDoF(origin:Vector, angle:Angle, usableFocusPoint:Vector, angleSize:Float, radialSteps:Float, passes:Float, spin:Bool, inView:AnyTable, fov:Float):Void;
    #end
    
    /**
        Writes every given argument to the console. Automatically attempts to convert each argument to a string. (See tostring) Separates arguments with a tab character ("\t").
		
		Name | Description
		--- | ---
		`args` | List of values to print.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints "Hello World! Yay!" to the console.
		
		```lua 
		print("Hello World!", "Yay!")
		```
    **/
    
    static function print(args:Rest<Dynamic>):Void;
    
    
    /**
        Performs a linear interpolation from the start number to the end number. 
		
		This function provides a very efficient and easy way to smooth out movements.
		
		Name | Description
		--- | ---
		`t` | The fraction for finding the result. This number is clamped between 0 and 1.
		`from` | The starting number. The result will be equal to this if delta is 0.
		`to` | The ending number. The result will be equal to this if delta is 1.
		
		
		`**Returns:** The result of the linear interpolation, (1 - t) * from + t * to.
    **/
    
    static function Lerp(t:Float, from:Float, to:Float):Float;
    
    
    /**
        Returns a string that is shared between the server and all clients.
		
		Name | Description
		--- | ---
		`index` | The unique index to identify the global value with.
		`default` | The value to return if the global value is not set.
		
		
		`**Returns:** The global value, or the default if the global value is not set.
		
		___
		### Lua Examples
		#### Example 1
		Prints the current server name if set, otherwise "Garry's Mod 13".
		
		```lua 
		print( GetGlobalString("ServerName", "Garry's Mod 13") )
		```
    **/
    
    static function GetGlobalString(index:String, ?_default:String):String;
    
    
    /**
        Executes a Lua script.
		
		**Warning:** The file you are attempting to include MUST NOT be empty or the include will fail. Files over a certain size may fail as well.
		
		**Warning:** If the file you are including is clientside or shared, it must be AddCSLuaFile'd or this function will error saying the file doesn't exist.
		
		**Note:** Addon files (.gma files) do not support relative parent folders (.. notation).
		
		**Note:** Please make sure your file names are unique, the filesystem is shared across all addons, so a file named "lua/config.lua" in your addon may be overwritten by the same file in another addon.
		
		**Bug:** BUG pcalling this function will break autorefresh. Issue Tracker: #1976
		
		Name | Description
		--- | ---
		`fileName` | The name of the script to be executed. The path must be either relative to the current file, or be an absolute path (relative to and excluding the lua/ folder). NOTE Please make sure your file names are unique, the filesystem is shared across all addons, so a file named "lua/config.lua" in your addon may be overwritten by the same file in another addon.
		
		
		`**Returns:** Anything that the executed Lua script returns.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates correct and incorrect usage.
		
		```lua 
		-- Correct usage:
		-- Will look for "lua/myLuaFolder/myLuaFile.lua" in all addons and then the base game lua/ folder
		include( "myLuaFolder/myLuaFile.lua" )
		
		-- This is incorrect, and will NOT work
		include(               "lua/myLuaFolder/myLuaFile.lua" )
		include(         "addons/lua/myLuaFolder/myLuaFile.lua" )
		include( "addons/MyAddon/lua/myLuaFolder/myLuaFile.lua" )
		include(       "MyAddon/lua/myLuaFolder/myLuaFile.lua" )
		```
    **/
    
    static function include(fileName:String):Rest<Dynamic>;
    
    
    /**
        Returns a float that is shared between the server and all clients.
		
		Name | Description
		--- | ---
		`index` | The unique index to identify the global value with.
		`default` | The value to return if the global value is not set.
		
		
		`**Returns:** The global value, or the default if the global value is not set.
    **/
    
    static function GetGlobalFloat(index:String, ?_default:Float):Float;
    
    #if client
    /**
        Convenience function that creates a DLabel, sets the text, and returns it
		
		Name | Description
		--- | ---
		`text` | The string to set the label's text to
		`parent` | Optional. The panel to parent the DLabel to
		
		
		`**Returns:** The created DLabel
		
		___
		### Lua Examples
		#### Example 1
		Create a label
		
		```lua 
		local lbl = Label( "The quick brown fox" )
		```
		
		#### Example 2
		Create a label and parents it to a DPanel
		
		```lua 
		local pnl = vgui.Create("DPanel")
		local lbl = Label( "The quick brown fox", pnl )
		```
    **/
    
    static function Label(text:String, ?parent:Panel):Panel;
    #end
    
    /**
        This function will compile the code argument as lua code and return a function that will execute that code. 
		
		Please note that this function will not automatically execute the given code after compiling it.
		
		Name | Description
		--- | ---
		`code` | The code to compile.
		`identifier` | An identifier in case an error is thrown. (The same identifier can be used multiple times)
		`HandleError` | If false this function will return an error string instead of throwing an error.
		
		
		Name | Description
		--- | ---
		`a` | A function that, when called, will execute the given code. Returns nil if there was an error.
		`b` | The error string. Will be nil if there were no errors or the function handles errors (third argument is true).
		
		
		___
		### Lua Examples
		#### Example 1
		Code that will not compile, with ErrorHandling set to false.
		
		```lua 
		local code = "MsgN('Hi)"
		local func = CompileString(code, "TestCode", false)
		MsgN(func)
		```
		**Output:**
		
		TestCode:1: unfinished string near '<eof>' (this is not a script error - it is a returned string)
		
		#### Example 2
		Code that will compile.
		
		```lua 
		local code = "MsgN('Hi')"
		local func = CompileString(code, "TestCode")
		
		if func then -- Compile String returns nil if 3rd argument is true and code has errors.
		   func()
		end
		```
		**Output:**
		
		Hi
		
		#### Example 3
		Compiled code with custom arguments; captured with the varargs identifier.
		
		```lua 
		local code = [[
		    local args = { ... } 
		    print( unpack( args ) )
		    print( args[ 2 ] + args[ 3 ])
		    print( args[ 4 ] .. args[ 5 ])
		
		    local first, second = ...
		    print( first, second )
		]]
		local func = CompileString( code, "VarargCodeTest" )
		func( 1, 2, 3, "A", "B", "C" )
		```
		**Output:**
		
		1	2	3	A	B	C
		5
		AB
		1   2
    **/
    
    static function CompileString(code:String, identifier:String, ?HandleError:Bool):GlobalLibCompileStringReturn;
    
    
    /**
        Empties the pool of main menu background images.
    **/
    
    static function ClearBackgroundImages():Void;
    
    
    /**
        Returns an iterator function that can be used to loop through a table in order of member values, when the values of the table are also tables and contain that member. 
		
		To sort by value, use SortedPairsByValue. To sort by keys, use SortedPairs.
		
		Name | Description
		--- | ---
		`table` | Table to create iterator for.
		`memberKey` | Key of the value member to sort by.
		`descending` | Whether the iterator should iterate in descending order or not.
		
		
		Name | Description
		--- | ---
		`a` | Iterator function
		`b` | The table the iterator was created for.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a table and prints its contents in order of the age member descending
		
		```lua 
		local tab = {
		    {
		        Name = "Adam",
		        Age = 16
		    },
		    {
		        Name = "Charles",
		        Age = 18
		    }
		}
		
		for k, v in SortedPairsByMemberValue(tab, "Age", true) do
		    print(v.Name)
		end
		```
		**Output:**
		
		Charles
		Adam
    **/
    
    static function SortedPairsByMemberValue(table:AnyTable, memberKey:Dynamic, ?descending:Bool):GlobalLibSortedPairsByMemberValueReturn;
    
    
    /**
        Returns whether or not a model is useless by checking that the file path is that of a proper model. 
		
		If the string ".mdl" is not found in the model name, the function will return true. 
		
		 The function will also return true if any of the following strings are found in the given model name:
		
		Name | Description
		--- | ---
		`modelName` | The model name to be checked
		
		
		`**Returns:** Whether or not the model is useless
    **/
    
    static function IsUselessModel(modelName:String):Bool;
    
    
    /**
        Sets the enviroment for a function or a stack level, if a function is passed, the return value will be the function, otherwise nil.
		
		Name | Description
		--- | ---
		`location` | The function to set the enviroment for or a number representing stack level.
		`enviroment` | Table to be used as enviroment.
		
		
		___
		### Lua Examples
		#### Example 1
		Create a new environment and setfenv Display inside it
		
		```lua 
		local newenvironment = {}
		
		function newenvironment.log( msg )
		    print( msg )
		end
		
		local function Display()
		    log( "yay" )
		end
		
		setfenv( Display , newenvironment )
		
		Display()
		```
    **/
    
    static function setfenv(location:Function, enviroment:AnyTable):Void;
    
    #if client
    /**
        Creates panel method that calls the supplied Derma skin hook via derma.SkinHook
		
		Name | Description
		--- | ---
		`panel` | Panel to add the hook to
		`functionName` | Name of panel function to create
		`hookName` | Name of Derma skin hook to call within the function
		`typeName` | Type of element to call Derma skin hook for
		
		
		___
		### Lua Examples
		#### Example 1
		Creates PANEL.Paint function to call Derma skin hook 'Paint' with type 'Panel'
		
		```lua 
		Derma_Hook( PANEL, "Paint", "Paint", "Panel" )
		```
		**Output:**
		
		Panel is painted with correct derma hooks
    **/
    
    static function Derma_Hook(panel:Panel, functionName:String, hookName:String, typeName:String):Void;
    #end
    
    /**
        Returns a cosine value that fluctuates based on the current time
		
		Name | Description
		--- | ---
		`frequency` | The frequency of fluctuation
		`min` | Minimum value
		`max` | Maxmimum value
		`offset` | Offset variable that doesn't affect the rate of change, but causes the returned value to be offset by time
		
		
		`**Returns:** Cosine value
    **/
    
    static function TimedCos(frequency:Float, min:Float, max:Float, offset:Float):Float;
    
    
    /**
        Attempts to convert the value to a number. 
		
		Returns nil on failure.
		
		Name | Description
		--- | ---
		`value` | The value to convert. Can be a number or string.
		`base` | The numeric base used in the string. Can be any integer between 2 and 36, inclusive.
		
		
		`**Returns:** The numeric representation of the value with the given base, or nil if the conversion failed.
    **/
    
    static function tonumber(value:Dynamic, ?base:Float):Float;
    
    #if server
    /**
        Adds the specified vector to the PVS which is currently building. This allows all objects in visleafs visible from that vector to be drawn.
		
		Name | Description
		--- | ---
		`position` | The origin to add.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds an RTCamera's current position to all player's PVS, causing props near it to always render on an rtscreen
		
		```lua 
		hook.Add("SetupPlayerVisibility", "AddRTCamera", function(pPlayer, pViewEntity)
		    -- Adds any view entity
		    if (pViewEntity:IsValid()) then
		        AddOriginToPVS(pViewEntity:GetPos())
		    end
		end)
		```
    **/
    
    static function AddOriginToPVS(position:Vector):Void;
    #end
    
    /**
        Either returns the material with the given name, or loads the material interpreting the first argument as the path.
		
		**Note:** When using .png or .jpg textures, try to make their sizes Power Of 2 (1, 2, 4, 8, 16, 32, 64, etc). While images are no longer scaled to Power of 2 sizes since February 2019, it is a good practice for things like icons, etc.
		
		**Note:** Since paths are relative to the materials folder, resource paths like ../data/MyImage.jpg will work since ".." translates to moving up a parent directory in the file tree.
		
		**Note:** This feature only works when importing .png or .jpeg image files
		
		Name | Description
		--- | ---
		`materialName` | The material name or path. The path is relative to the materials/ folder. You do not need to add materials/ to your path. To retrieve a Lua material created with CreateMaterial, just prepend a "!" to the material name. NOTE Since paths are relative to the materials folder, resource paths like ../data/MyImage.jpg will work since ".." translates to moving up a parent directory in the file tree.
		`pngParameters` | A string containing space separated keywords which will be used to add material parameters. See Material Parameters for more information. NOTE This feature only works when importing .png or .jpeg image files
		
		
		Name | Description
		--- | ---
		`a` | Generated material
		`b` | How long it took for the function to run
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a PNG material with noclamp and smooth parameters set and then draws on screen.In this example the .png file is located in materials/vgui/wave.png
		
		```lua 
		local wave = Material( "vgui/wave.png", "noclamp smooth" )
		
		hook.Add( "HUDPaint", "HUDPaint_DrawATexturedBox", function()
		    surface.SetMaterial( wave )
		    surface.SetDrawColor( 255, 255, 255, 255 )
		    surface.DrawTexturedRect( 50, 50, 128, 128 )
		end )
		```
		
		#### Example 2
		Acquires and uses one of the Post-Processing Materials to make the screen darker and more saturated
		
		```lua 
		local mat_color = Material( "pp/colour" )  -- used outside of the hook for performance
		
		hook.Add("RenderScreenspaceEffects", "ColorExample", function()
		    render.UpdateScreenEffectTexture()
		
		    mat_color:SetTexture( "$fbtexture", render.GetScreenEffectTexture() )
		
		    mat_color:SetFloat( "$pp_colour_addr", 0 )
		    mat_color:SetFloat( "$pp_colour_addg", 0 )
		    mat_color:SetFloat( "$pp_colour_addb", 0 )
		    mat_color:SetFloat( "$pp_colour_mulr", 0 )
		    mat_color:SetFloat( "$pp_colour_mulg", 0 )
		    mat_color:SetFloat( "$pp_colour_mulb", 0 )
		    mat_color:SetFloat( "$pp_colour_brightness", 0 )
		    mat_color:SetFloat( "$pp_colour_contrast", 0.5 )
		    mat_color:SetFloat( "$pp_colour_colour", 5 )
		
		    render.SetMaterial( mat_color )
		    render.DrawScreenQuad()
		end )
		```
    **/
    
    static function Material(materialName:String, ?pngParameters:String):GlobalLibMaterialReturn;
    
    
    /**
        Opens a folder with the given name in the garrysmod folder using the operating system's file browser.
		
		**Bug:** BUG This does not work on OSX or Linux. Issue Tracker: #1532
		
		Name | Description
		--- | ---
		`folder` | The subdirectory to open in the garrysmod folder.
		
		
		___
		### Lua Examples
		#### Example 1
		Opens the "saves" folder.
		
		```lua 
		OpenFolder( "saves" )
		```
    **/
    
    static function OpenFolder(folder:String):Void;
    
    #if client
    /**
        Restores position of your cursor on screen. You can save it by using RememberCursorPosition.
    **/
    
    static function RestoreCursorPosition():Void;
    #end
    
    /**
        Returns whether or not every element within a table is a valid entity
		
		Name | Description
		--- | ---
		`table` | Table containing entities to check
		
		
		`**Returns:** All entities valid
    **/
    
    static function IsTableOfEntitiesValid(table:AnyTable):Bool;
    
    
    /**
        Returns the uptime of the game/server in seconds (to at least 4 decimal places)
		
		**Note:** This is not synchronised or affected by the game.
		
		**Note:** This will be affected by precision loss if the uptime is more than 30+(?) days, and effectively cease to be functional after 50+(?) days.
		
		`**Returns:** Uptime of the game/server.
    **/
    
    static function RealTime():Float;
    
    
    /**
        Returns if the passed object is a function.
		
		Name | Description
		--- | ---
		`variable` | The variable to perform the type check for.
		
		
		`**Returns:** True if the variable is a function.
    **/
    
    static function isfunction(variable:Dynamic):Bool;
    
    
    /**
        Checks whether or not a game is currently mounted. Uses data given by engine.GetGames.
		
		Name | Description
		--- | ---
		`game` | The game string/app ID to check.
		
		
		`**Returns:** True if the game is mounted.
		
		___
		### Lua Examples
		#### Example 1
		Check if Counter-Strike: Source is mounted.
		
		```lua 
		IsMounted('cstrike')
		```
    **/
    
    static function IsMounted(game:String):Bool;
    
    
    /**
        Writes text to the right hand side of the screen, like the old error system. Messages disappear after a couple of seconds.
		
		Name | Description
		--- | ---
		`slot` | The location on the right hand screen to write the debug info to. Starts at 0, no upper limit
		`info` | The debugging information to be written to the screen
    **/
    
    static function DebugInfo(slot:Float, info:String):Void;
    
    #if client
    /**
        Creates a new material with the specified name and shader.
		
		**Note:** Materials created with this function can be used in Entity:SetMaterial and Entity:SetSubMaterial by prepending a "!" to their material name argument.
		
		**Note:** Unlike IMaterial:SetTexture, this table will not accept ITexture values. Instead, use the texture's name (see ITexture:GetName).
		
		**Bug:** BUG .pngs must be loaded with Material before being used with this function. Issue Tracker: #1531
		
		**Bug:** BUG This does not work with patch materials. Issue Tracker: #2511
		
		**Bug:** BUG This will not create a new material if another material object with the same name already exists. Issue Tracker: #3103
		
		Name | Description
		--- | ---
		`name` | The material name. Must be unique.
		`shaderName` | The shader name. See Category: Shaders.
		`materialData` | Key-value table that contains shader parameters and proxies. See: List of Shader Parameters on Valve Developers Wiki and each shader's page from Category: Shaders. NOTE Unlike IMaterial:SetTexture, this table will not accept ITexture values. Instead, use the texture's name (see ITexture:GetName).
		
		
		`**Returns:** Created material
		
		___
		### Lua Examples
		#### Example 1
		Alternative to render.SetColorMaterial, mainly for use with Entity:SetMaterial
		
		```lua 
		CreateMaterial( "colortexshp", "VertexLitGeneric", {
		  ["$basetexture"] = "color/white",
		  ["$model"] = 1,
		  ["$translucent"] = 1,
		  ["$vertexalpha"] = 1,
		  ["$vertexcolor"] = 1
		} )
		```
    **/
    
    static function CreateMaterial(name:String, shaderName:String, materialData:AnyTable):IMaterial;
    #end
    
    /**
        Retrieves data about the demo with the specified filename. Similar to GetSaveFileDetails.
		
		Name | Description
		--- | ---
		`filename` | The file name of the demo.
		
		
		`**Returns:** Demo data.
    **/
    
    static function GetDemoFileDetails(filename:String):AnyTable;
    
    
    /**
        Defines a string with a maximum of 199 characters to be automatically networked to clients
		
		**Note:** Running this function clientside will only set it clientside for the client it is called on!
		
		Name | Description
		--- | ---
		`index` | Index to identify the global string with
		`string` | String to be networked
    **/
    
    static function SetGlobalString(index:Dynamic, string:String):Void;
    
    #if client
    /**
        Draws the toy town shader, which blurs the top and bottom of your screen. This can make very large objects look like toys, hence the name.
		
		Name | Description
		--- | ---
		`Passes` | An integer determining how many times to draw the effect. A higher number creates more blur.
		`Height` | The amount of screen which should be blurred on the top and bottom.
		
		
		___
		### Lua Examples
		#### Example 1
		Draws toy town effect.
		
		```lua 
		function GM:RenderScreenspaceEffects()
		
		 DrawToyTown(2, ScrH()/2)
		
		end
		```
    **/
    
    static function DrawToyTown(Passes:Float, Height:Float):Void;
    #end
    
    /**
        Adds the specified image path to the main menu background pool. Image can be png or jpeg.
		
		Name | Description
		--- | ---
		`path` | Path to the image.
    **/
    
    static function AddBackgroundImage(path:String):Void;
    
    
    /**
        Returns a string representing the name of the type of the passed object.
		
		Name | Description
		--- | ---
		`var` | The object to get the type of.
		
		
		`**Returns:** The name of the object's type.
		
		___
		### Lua Examples
		#### Example 1
		Print the name of a few types.
		
		```lua 
		print( type(2) )
		print( type("hai") )
		print( type({}) )
		```
		
		#### Example 2
		Returns "no value" if called with 0 arguments/parameters.
		
		```lua 
		print( type() )
		```
		
		#### Example 3
		A list of code showing how you can use the type function in replacement with any of the "is" functions. (example being istable, isentity, etc.)
		
		```lua 
		print(type(LocalPlayer()))
		print(type(Vector()))
		print(type(Angle()))
		print(type(Entity(num))) -- -> num is the EntIndex for the entity
		print(type(vgui.Create("DFrame")))
		```
    **/
    
    static function type(_var:Dynamic):String;
    
    #if client
    /**
        Creates (or gets if it already exsits) the rendertarget with the given name, this function allows to adjust the creation of a rendertarget more than GetRenderTarget. 
		
		See also render.PushRenderTarget and render.SetRenderTarget.
		
		**Warning:** The name is treated like a path and gets its extension discarded. "name.1" and "name.2" are considered the same name and will result in the same render target being reused.
		
		Name | Description
		--- | ---
		`name` | The internal name of the render target. WARNING The name is treated like a path and gets its extension discarded. "name.1" and "name.2" are considered the same name and will result in the same render target being reused.
		`width` | The width of the render target, must be power of 2.
		`height` | The height of the render target, must be power of 2.
		`sizeMode` | Bitflag that influences the sizing of the render target, see RT_SIZE_ Enums.
		`depthMode` | Bitflag that determines the depth buffer usage of the render target MATERIAL_RT_DEPTH_ Enums.
		`textureFlags` | Bitflag that configurates the texture, see TEXTUREFLAGS_ Enums. List of flags can also be found on the Valve's Developer Wiki: https://developer.valvesoftware.com/wiki/Valve_Texture_Format
		`rtFlags` | Flags that controll the HDR behaviour of the render target, see CREATERENDERTARGETFLAGS_ Enums.
		`imageFormat` | Image format, see IMAGE_FORMAT_ Enums.
		
		
		`**Returns:** The new render target.
    **/
    
    static function GetRenderTargetEx(name:String, width:Float, height:Float, sizeMode:RT_SIZE, depthMode:MATERIAL_RT_DEPTH, textureFlags:TEXTUREFLAGS, rtFlags:CREATERENDERTARGETFLAGS, imageFormat:IMAGE_FORMAT):ITexture;
    #end
    #if client
    /**
        Returns the normal vector of the current render context as calculated by GM:CalcView, similar to EyeAngles.
		
		**Bug:** BUG This function is only reliable inside rendering hooks. Issue Tracker: #2516
		
		`**Returns:** View direction of the currently rendered scene.
		
		___
		### Lua Examples
		#### Example 1
		Print the view angles
		
		```lua 
		print( EyeVector() )
		```
    **/
    
    static function EyeVector():Vector;
    #end
    #if client
    /**
        Adds workshop related javascript functions to an HTML panel, used by the "Dupes" and "Saves" tabs in the spawnmenu.
		
		Name | Description
		--- | ---
		`htmlPanel` | Panel to add javascript functions to.
    **/
    
    static function JS_Workshop(htmlPanel:Panel):Void;
    #end
    #if server
    /**
        Precache a sentence group in a sentences.txt definition file.
		
		Name | Description
		--- | ---
		`group` | The group to precache.
		
		
		___
		### Lua Examples
		#### Example 1
		Precache all metropolice sentences.
		
		```lua 
		PrecacheSentenceGroup( "METROPOLICE" )
		```
		**Output:**
		
		Precaches sounds used in all sentences starting with "METROPOLICE".
    **/
    
    static function PrecacheSentenceGroup(group:String):Void;
    #end
    #if client
    /**
        Clears focus from any text entries player may have focused.
    **/
    
    static function TextEntryLoseFocus():Void;
    #end
    #if client
    /**
        Loads all preset settings for the presets library and returns them in a table
		
		`**Returns:** Preset data
		
		___
		### Lua Examples
		#### Example 1
		Prints all of the presets in to the console
		
		```lua 
		PrintTable(LoadPresets())
		```
    **/
    
    static function LoadPresets():AnyTable;
    #end
    #if server
    /**
        Load and precache a custom sentence file.
		
		Name | Description
		--- | ---
		`filename` | The path to the custom sentences.txt.
		
		
		___
		### Lua Examples
		#### Example 1
		Precache a file named "customsentences.txt" in the data directory.
		
		```lua 
		PrecacheSentenceFile( "data/customsentences.txt" )
		```
		**Output:**
		
		Loads and precaches the sentences.
    **/
    
    static function PrecacheSentenceFile(filename:String):Void;
    #end
    
    /**
        Dumps the networked variables of all entities into one table and returns it.
		
		`**Returns:** Format: key = Entity for NWVars or number (always 0) for global vars value = table formatted as: key = string var name value = any type var value
    **/
    
    static function BuildNetworkedVarsTable():AnyTable;
    
    
    /**
        Returns if the passed object is a table.
		
		Name | Description
		--- | ---
		`variable` | The variable to perform the type check for.
		
		
		`**Returns:** True if the variable is a table.
    **/
    
    static function istable(variable:Dynamic):Bool;
    
    
    /**
        Creates an Angle object.
		
		Name | Description
		--- | ---
		`pitch` | The pitch value of the angle. If this is an Angle, this function will return a copy of the given angle. If this is a string, this function will try to parse the string as a angle. If it fails, it returns a 0 angle. (See examples)
		`yaw` | The yaw value of the angle.
		`roll` | The roll value of the angle.
		
		
		`**Returns:** Created angle
		
		___
		### Lua Examples
		#### Example 1
		Creates an angle and prints the value to the console.
		
		```lua 
		print( Angle( 1, 2, 3 ) )
		print( Angle( "4 5 6" ) )
		local test = Angle( 7, 8, 9 )
		print( Angle( test ) )
		
		print( Angle( "4 5 test" ) )
		print( Angle() )
		```
		**Output:**
		
		1.00 2.00 3.00
		4.00 5.00 6.00
		7.00 8.00 9.00
		
		0.00 0.00 0.00
		0.00 0.00 0.00
    **/
    
    static function Angle(?pitch:Float, ?yaw:Float, ?roll:Float):Angle;
    
    
    /**
        Returns if the passed object is a number.
		
		Name | Description
		--- | ---
		`variable` | The variable to perform the type check for.
		
		
		`**Returns:** True if the variable is a number.
    **/
    
    static function isnumber(variable:Dynamic):Bool;
    
    #if client
    /**
        Creates or gets the rendertarget with the given name. 
		
		See GetRenderTargetEx for an advanced version of this function with more options.
		
		**Bug:** BUG This crashes when used on a cubemap texture. Issue Tracker: #2885
		
		Name | Description
		--- | ---
		`name` | The internal name of the render target.
		`width` | The width of the render target, must be power of 2. If not set to PO2, the size will be automatically converted to the nearest PO2 size.
		`height` | The height of the render target, must be power of 2. If not set to PO2, the size will be automatically converted to the nearest PO2 size.
		`additive` | Sets whenever the rt should be additive.
		
		
		`**Returns:** The render target
    **/
    
    static function GetRenderTarget(name:String, width:Float, height:Float, ?additive:Bool):ITexture;
    #end
    #if server
    /**
        Suppress any networking from the server to the specified player. This is automatically called by the engine before/after a player fires their weapon, reloads, or causes any other similar shared-predicted event to occur.
		
		Name | Description
		--- | ---
		`suppressPlayer` | The player to suppress any networking to.
    **/
    
    static function SuppressHostEvents(suppressPlayer:Player):Void;
    #end
    #if client
    /**
        Draws the sobel shader, which detects edges and draws a black border.
		
		Name | Description
		--- | ---
		`Threshold` | Determines the threshold of edges. A value of 0 will make your screen completely black.
		
		
		___
		### Lua Examples
		#### Example 1
		Draws the sobel shader.
		
		```lua 
		function GM:RenderScreenspaceEffects()
		
		 DrawSobel(0.5)
		
		end
		```
    **/
    
    static function DrawSobel(Threshold:Float):Void;
    #end
    
    /**
        Returns a table with the names of files needed from the server you are currently joining.
		
		`**Returns:** table of file names
		
		___
		### Lua Examples
		#### Example 1
		Returns a table with the file names.
		
		```lua 
		PrintTable( GetDownloadables() )
		```
    **/
    
    static function GetDownloadables():AnyTable;
    
    #if client
    /**
        Overwrites all presets with the supplied table. Used by the presets library for preset saving
		
		Name | Description
		--- | ---
		`presets` | Presets to be saved
    **/
    
    static function SavePresets(presets:AnyTable):Void;
    #end
    
    /**
        Returns if the passed object is an Angle.
		
		Name | Description
		--- | ---
		`variable` | The variable to perform the type check for.
		
		
		`**Returns:** True if the variable is an Angle.
    **/
    
    static function isangle(variable:Dynamic):Bool;
    
    
    /**
        Gets the associated type ID of the variable.
		
		**Bug:** BUG This returns garbage for _LOADLIB objects. Request Tracker: #1120
		
		**Bug:** BUG This returns TYPE_NIL for protos. Request Tracker: #1459
		
		Name | Description
		--- | ---
		`variable` | The variable to get the type ID of.
		
		
		`**Returns:** The type ID of the variable. See the TYPE_ Enums.
    **/
    
    static function TypeID(variable:Dynamic):TYPE;
    
    
    /**
        ***INTERNAL** 
		
		Used internally to check if the current server the player is on can be added to favorites or not. Does not check if the server is ALREADY in the favorites.
		
		`**Returns:** 
    **/
    @:deprecated("INTERNAL")
    static function CanAddServerToFavorites():Bool;
    
    #if client
    /**
        ***Deprecated:** You should be using ScreenScale instead.
		
		Returns a number based on the Size argument and your screen's width. Alias of ScreenScale.
		
		Name | Description
		--- | ---
		`Size` | The number you want to scale.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints a scaled number based on the number 40.
		
		```lua 
		print( SScale(40) )
		```
		**Output:**
		
		105 (This will differ depending on your screen size.)
    **/
    @:deprecated("You should be using ScreenScale instead.")
    static function SScale(Size:Float):Void;
    #end
    
    /**
        Evaluates and executes the given code, will throw an error on failure.
		
		**Note:** Local variables are not passed to the given code.
		
		Name | Description
		--- | ---
		`code` | The code to execute.
		`identifier` | The name that should appear in any error messages caused by this code.
		`handleError` | If false, this function will return a string containing any error messages instead of throwing an error.
		
		
		`**Returns:** If handleError is false, the error message (if any).
    **/
    
    static function RunString(code:String, ?identifier:String, ?handleError:Bool):String;
    
    
    /**
        Attempts to convert the value to a string. If the value is an object and its metatable has defined the __tostring metamethod, this will call that function. 
		
		print also uses this functionality.
		
		Name | Description
		--- | ---
		`value` | The object to be converted to a string.
		
		
		`**Returns:** The string representation of the value.
		
		___
		### Lua Examples
		#### Example 1
		Convert a number to a string.
		
		```lua 
		print(tostring(0x16))
		```
		**Output:**
		
		22
    **/
    
    static function tostring(value:Dynamic):String;
    
    
    /**
        Removes the given entity unless it is a player or the world entity
		
		Name | Description
		--- | ---
		`ent` | Entity to safely remove.
    **/
    
    static function SafeRemoveEntity(ent:Entity):Void;
    
    #if client
    /**
        ***INTERNAL** 
		
		A hacky method used to fix some bugs regarding DoF.
		
		Name | Description
		--- | ---
		`enable` | Enables or disables depth-of-field mode
    **/
    @:deprecated("INTERNAL")
    static function DOFModeHack(enable:Bool):Void;
    #end
    
    /**
        Compares the two values without calling their __eq operator.
		
		Name | Description
		--- | ---
		`value1` | The first value to compare.
		`value2` | The second value to compare.
		
		
		`**Returns:** Whether or not the two values are equal.
    **/
    
    static function rawequal(value1:Dynamic, value2:Dynamic):Bool;
    
    #if client
    /**
        Renders the Super Depth of Field post-process effect
		
		Name | Description
		--- | ---
		`viewOrigin` | Origin to render the effect at
		`viewAngles` | Angles to render the effect at
		`viewFOV` | Field of View to render the effect at
    **/
    
    static function RenderSuperDoF(viewOrigin:Vector, viewAngles:Angle, viewFOV:Float):Void;
    #end
    
    /**
        If the result of the first argument is false or nil, an error is thrown with the second argument as the message.
		
		Name | Description
		--- | ---
		`expression` | The expression to assert.
		`errorMessage` | The error message to throw when assertion fails. This is only type-checked if the assertion fails.
		`returns` | Any arguments past the error message will be returned by a successful assert.
		
		
		Name | Description
		--- | ---
		`a` | If successful, returns the first argument.
		`b` | If successful, returns the error message. This will be nil if the second argument wasn't specified. Since the second argument is only type-checked if the assertion fails, this doesn't have to be a string.
		`c` | Returns any arguments past the error message.
		
		
		___
		### Lua Examples
		#### Example 1
		The assertion is successful, and the result of the first argument is returned.
		
		```lua 
		local ABC = assert(print)
		print(ABC)
		```
		**Output:**
		
		function: builtin#25
		
		#### Example 2
		Since the first argument evaluates to false, an error is thrown.
		
		```lua 
		assert(print == 1, "print is not equal to 1!")
		```
		**Output:**
		
		[ERROR] lua_run:1: print is not equal to 1!
		
		#### Example 3
		Examples of return behaviour.
		
		```lua 
		print(assert(5))
		print(assert(true, "foo", 2, {}))
		```
    **/
    
    static function assert(expression:Dynamic, ?errorMessage:String, returns:Rest<Dynamic>):GlobalLibAssertReturn;
    
    
    /**
        ***INTERNAL** 
		
		Adds a frame to the currently recording demo.
    **/
    @:deprecated("INTERNAL")
    static function RecordDemoFrame():Void;
    
    
    /**
        Defines a vector to be automatically networked to clients
		
		**Note:** Running this function clientside will only set it clientside for the client it is called on!
		
		Name | Description
		--- | ---
		`index` | Index to identify the global vector with
		`vec` | Vector to be networked
    **/
    
    static function SetGlobalVector(index:Dynamic, vec:Vector):Void;
    
    
    /**
        Marks a Lua file to be sent to clients when they join the server. Doesn't do anything on the client - this means you can use it in a shared file without problems.
		
		**Warning:** If the file trying to be added is empty, an error will occur, and the file will not be sent to the client.
		
		**Note:** This function is not needed for scripts located in lua/autorun/ and lua/autorun/client/: they are automatically sent to clients.
		
		**Note:** You can add up to 8192 files.
		
		Name | Description
		--- | ---
		`file` | The name/path to the Lua file that should be sent, relative to the garrysmod/lua folder. If no parameter is specified, it sends the current file. The file path can be relative to the script it is ran from. For example, if your script is in lua/myfolder/stuff.lua, calling AddCSLuaFile("otherstuff.lua") and AddCSLuaFile("myfolder/otherstuff.lua") is the same thing.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds the cl_init.lua file in the "lua" folder to be downloaded by connecting clients. This is required, and is normally done in init.lua.
		
		```lua 
		AddCSLuaFile( "cl_init.lua" )
		```
		
		#### Example 2
		Adds the current file to the list of files to be downloaded by clients. This is usually done at the top of a shared file.
		
		```lua 
		AddCSLuaFile()
		```
    **/
    
    static function AddCSLuaFile(?file:String):Void;
    
    #if client
    /**
        Returns the player object of the current client. 
		
		LocalPlayer() will return NULL until all entities have been initialized. See GM:InitPostEntity.
		
		`**Returns:** The player object representing the client.
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates the use of this function.
		
		```lua 
		print( LocalPlayer() )
		```
		**Output:**
		
		[Player][1][Player1]
    **/
    
    static function LocalPlayer():Player;
    #end
    #if client
    /**
        Draws the Color Modify shader, which can be used to adjust colors on screen.
		
		Name | Description
		--- | ---
		`modifyParameters` | Color modification parameters. See g_colourmodify shader and the example below. Note that if you leave out a field, it will retain its last value which may have changed if another caller uses this function.
		
		
		___
		### Lua Examples
		#### Example 1
		Draws color modify with bright yellow and green colors.
		
		```lua 
		local tab = {
		    [ "$pp_colour_addr" ] = 0.02,
		    [ "$pp_colour_addg" ] = 0.02,
		    [ "$pp_colour_addb" ] = 0,
		    [ "$pp_colour_brightness" ] = 0,
		    [ "$pp_colour_contrast" ] = 1,
		    [ "$pp_colour_colour" ] = 3,
		    [ "$pp_colour_mulr" ] = 0,
		    [ "$pp_colour_mulg" ] = 0.02,
		    [ "$pp_colour_mulb" ] = 0
		}
		
		hook.Add( "RenderScreenspaceEffects", "color_modify_example", function()
		
		    DrawColorModify( tab )
		
		end )
		```
    **/
    
    static function DrawColorModify(modifyParameters:AnyTable):Void;
    #end
    
    /**
        ***Deprecated:** Store the ConVar object retrieved with GetConVar and call ConVar: GetInt or ConVar: GetFloat on it.
		
		Gets the numeric value ConVar with the specified name.
		
		Name | Description
		--- | ---
		`name` | Name of the ConVar to get.
		
		
		`**Returns:** The ConVar's value.
    **/
    @:deprecated("Store the ConVar object retrieved with GetConVar and call ConVar: GetInt or ConVar: GetFloat on it.")
    static function GetConVarNumber(name:String):Float;
    
    
    /**
        Returns true if the client is currently playing either a singleplayer or multiplayer game.
		
		`**Returns:** True if we are in a game.
    **/
    
    static function IsInGame():Bool;
    
    
    /**
        ***INTERNAL** Use concommand. Add instead.
		
		Tells the engine to register a console command. If the command was ran, the engine calls [concommand](https://wiki.garrysmod.com/page/Category:concommand). [Run](https://wiki.garrysmod.com/page/concommand/Run).
		
		Name | Description
		--- | ---
		`name` | The name of the console command to add.
		`helpText` | The help text.
		`flags` | Concommand flags using FCVAR_ Enums
    **/
    @:deprecated("INTERNAL: Use concommand. Add instead.")
    static function AddConsoleCommand(name:String, helpText:String, flags:FCVAR):Void;
    
    
    /**
        Returns the current asynchronous in-game time.
		
		`**Returns:** The asynchronous in-game time.
    **/
    
    static function UnPredictedCurTime():Float;
    
    
    /**
        Converts a color from HSL color space into RGB color space and returns a Color structure.
		
		**Bug:** BUG The returned color will not have the color metatable. Issue Tracker: #2407
		
		Name | Description
		--- | ---
		`hue` | The hue in degrees from 0-360.
		`saturation` | The saturation from 0-1.
		`value` | The lightness from 0-1.
		
		
		`**Returns:** The Color structure created from the HSL color space.
    **/
    
    static function HSLToColor(hue:Float, saturation:Float, value:Float):Color;
    
    
    /**
        Throws a Lua error and breaks out of the current call stack.
		
		Name | Description
		--- | ---
		`message` | The error message to throw.
		`errorLevel` | The level to throw the error at.
		
		
		___
		### Lua Examples
		#### Example 1
		
		
		```lua 
		error("garry")
		```
		**Output:**
		
		[ERROR] lua_run:1: garry
    **/
    
    static function error(message:String, ?errorLevel:Float):Void;
    
    
    /**
        Modifies the given vectors so that all of vector2's axis are larger than vector1's by switching them around. Also known as ordering vectors.
		
		**Note:** This function will irreversibly modify the given vectors
		
		Name | Description
		--- | ---
		`vector1` | Bounding box min resultant
		`vector2` | Bounding box max resultant
    **/
    
    static function OrderVectors(vector1:Vector, vector2:Vector):Void;
    
    
    /**
        Returns an iterator function for a for loop, to return ordered key-value pairs from a table. 
		
		This will only iterate though numerical keys, and these must also be sequential; starting at 1 with no gaps. 
		
		 For unordered pairs, see pairs. For pairs sorted by key in alphabetical order, see SortedPairs.
		
		Name | Description
		--- | ---
		`tab` | The table to iterate over.
		
		
		Name | Description
		--- | ---
		`a` | The iterator function.
		`b` | The table being iterated over
		`c` | The origin index =0
		
		
		___
		### Lua Examples
		#### Example 1
		Demonstrates how this differs from pairs.
		
		```lua 
		local tbl = { two = 2, one = 1, "alpha", "bravo", [3] = "charlie", [5] = "echo", [6] = "foxtrot" }
		
		print( "pairs:" )
		for k, v in pairs( tbl ) do
		    print( k, v )
		end
		print( "\nipairs:" )
		for k, v in ipairs( tbl ) do
		    print( k, v )
		end
		```
		**Output:**
		
		pairs:
		1	alpha
		2	bravo
		3	charlie
		5	echo
		6	foxtrot
		one	1
		two	2
		
		ipairs:
		1	alpha
		2	bravo
		3	charlie
		
		#### Example 2
		From UpdateUI in undo.lua, this adds the first 32 undo entries to the Undo panel in the spawnmenu.
		
		```lua 
		local NUM = 32
		local Count = 0
		for k, v in ipairs( ClientUndos ) do
		    local Item = ComboBox:AddItem( tostring( v.Name ) )
		    Item.DoClick = function() RunConsoleCommand( "gmod_undonum", tostring( v.Key ) ) end
		
		    Count = Count + 1
		    if ( Count > NUM ) then break end
		end
		```
    **/
    
    static function ipairs(tab:AnyTable):GlobalLibIpairsReturn;
    
    #if client
    /**
        Adds javascript function 'util.MotionSensorAvailable' to an HTML panel as a method to call Lua's motionsensor.IsAvailable function.
		
		Name | Description
		--- | ---
		`htmlPanel` | Panel to add javascript function 'util.MotionSensorAvailable' to.
    **/
    
    static function JS_Utility(htmlPanel:Panel):Void;
    #end
    #if client
    /**
        Returns the panel that is used as a wrapper for the HUD. 
		
		See also vgui.GetWorldPanel
		
		`**Returns:** The HUD panel
    **/
    
    static function GetHUDPanel():Panel;
    #end
    
    /**
        Returns a TauntCamera object
		
		`**Returns:** TauntCamera
    **/
    
    static function TauntCamera():AnyTable;
    
    
    /**
        Creates PhysCollide objects for every physics object the model has. The model must be precached with util.PrecacheModel before being used with this function.
		
		Name | Description
		--- | ---
		`modelName` | Model path to get the collision objects of.
		
		
		`**Returns:** Table of PhysCollide objects. The number of entries will match the model's physics object count. See also Entity: GetPhysicsObjectCount. Returns no value if the model doesn't exist, or has not been precached.
    **/
    
    static function CreatePhysCollidesFromModel(modelName:String):AnyTable;
    
    
    /**
        ***Deprecated:** Store the ConVar object retrieved with GetConVar and call ConVar: GetString on it.
		
		Gets the string value ConVar with the specified name.
		
		Name | Description
		--- | ---
		`name` | Name of the ConVar to get.
		
		
		`**Returns:** The ConVar's value.
    **/
    @:deprecated("Store the ConVar object retrieved with GetConVar and call ConVar: GetString on it.")
    static function GetConVarString(name:String):String;
    
    #if client
    /**
        Removes the currently active tool tip from the screen.
		
		Name | Description
		--- | ---
		`panel` | This is the panel that has a tool tip.
    **/
    
    static function EndTooltip(panel:Panel):Void;
    #end
    #if client
    /**
        Briefly displays layout details of the given panel on-screen
		
		Name | Description
		--- | ---
		`panel` | Panel to display layout details of
    **/
    
    static function VisualizeLayout(panel:Panel):Void;
    #end
    
    /**
        Creates a particle effect.
		
		**Note:** The particle effect must be precached with PrecacheParticleSystem and the file its from must be added via game.AddParticles before it can be used!
		
		Name | Description
		--- | ---
		`particleName` | The name of the particle effect.
		`position` | The start position of the effect.
		`angles` | The orientation of the effect.
		`parent` | If set, the particle will be parented to the entity.
		
		
		___
		### Lua Examples
		#### Example 1
		Example usage of the function. Precaches ExplosionCore_wall particle from particles/explosion.pcf, a Team Fortress 2 particle file.You can then test the particle by using the particleitup console command.You can find a list of particles inside a .pcf file using the Particle Editor Tool
		
		```lua 
		game.AddParticles( "particles/explosion.pcf" )
		PrecacheParticleSystem( "ExplosionCore_wall" )
		
		if ( SERVER ) then
		    -- A test console command to see if the particle works, spawns the particle where the player is looking at. 
		    concommand.Add( "particleitup", function( ply, cmd, args )
		        ParticleEffect( "ExplosionCore_wall", ply:GetEyeTrace().HitPos, Angle( 0, 0, 0 ) )
		    end )
		end
		```
    **/
    
    static function ParticleEffect(particleName:String, position:Vector, angles:Angle, ?parent:Entity):Void;
    
    
    /**
        Runs JavaScript on the loading screen panel (GetLoadPanel).
		
		Name | Description
		--- | ---
		`javascript` | JavaScript to run on the loading panel.
    **/
    
    static function UpdateLoadPanel(javascript:String):Void;
    
    
    /**
        Returns if the passed object is a Vector.
		
		Name | Description
		--- | ---
		`variable` | The variable to perform the type check for.
		
		
		`**Returns:** True if the variable is a Vector.
    **/
    
    static function isvector(variable:Dynamic):Bool;
    
    #if client
    /**
        Cancels current DOF post-process effect started with DOF_Start
    **/
    
    static function DOF_Kill():Void;
    #end
    #if client
    /**
        Moves the given model to the given position and calculates appropriate camera parameters for rendering the model to an icon. 
		
		The output table interacts nicely with Panel:RebuildSpawnIconEx with a few key renames.
		
		Name | Description
		--- | ---
		`model` | Model that is being rendered to the spawn icon
		`position` | Position that the model is being rendered at
		`noAngles` | If true the function won't reset the angles to 0 for the model.
		
		
		`**Returns:** Table of information of the view which can be used for rendering
		
		___
		### Lua Examples
		#### Example 1
		Creates a clientside model and then PositionSpawnIcon is used to figure out the appropriate camera parameters for rendering this model.
		
		```lua 
		local ent = ClientsideModel("models/props_wasteland/cafeteria_table001a.mdl", RENDERGROUP_BOTH)
		local tab = PositionSpawnIcon(ent, vector_origin)
		ent:Remove()
		
		PrintTable(tab)
		```
    **/
    
    static function PositionSpawnIcon(model:Entity, position:Vector, noAngles:Bool):AnyTable;
    #end
    
    /**
        Returns the uptime of the server in seconds (to at least 4 decimal places) 
		
		This is a synchronised value and affected by various factors such as host_timescale (or game.GetTimeScale) and the server being paused - either by sv_pausable or all players disconnecting. 
		
		 You should use this function for timing in-game events but not for real-world events. 
		
		 See also: RealTime, SysTime
		
		**Note:** This is internally defined as a float, and as such it will be affected by precision loss if your server uptime is more than 6 hours, which will cause jittery movement of players and props and inaccuracy of timers, it is highly encouraged to refresh or change the map when that happens (a server restart is not necessary). This is NOT easy as it sounds to fix in the engine, so please refrain from posting issues about this
		
		**Bug:** BUG This returns 0 in GM:PlayerAuthed. Issue Tracker: #3026
		
		`**Returns:** Time synced with the game server.
		
		___
		### Lua Examples
		#### Example 1
		Simple delay timer.
		
		```lua 
		local delay = 0
		hook.Add( "Think", "CurTimeDelay", function()
		 if CurTime() < delay then return end
		    print( "This message will repeat every 5 seconds." )
		     delay = CurTime() + 5
		 end)
		```
		**Output:**
		
		This message will repeat every 5 seconds.
    **/
    
    static function CurTime():Float;
    
    
    /**
        Returns if the passed object is an Entity.
		
		Name | Description
		--- | ---
		`variable` | The variable to perform the type check for.
		
		
		`**Returns:** True if the variable is an Entity.
    **/
    
    static function isentity(variable:Dynamic):Bool;
    
    
    /**
        Retrieves data about the save with the specified filename. Similar to GetDemoFileDetails.
		
		Name | Description
		--- | ---
		`filename` | The file name of the save.
		
		
		`**Returns:** Save data.
    **/
    
    static function GetSaveFileDetails(filename:String):AnyTable;
    
    
    /**
        Returns whether an object is valid or not. (Such as Entitys, Panels, custom table objects and more) Checks that an object is not nil, has an IsValid method and if this method returns true.
		
		**Note:** Due to vehicles being technically valid the moment they're spawned, also use Vehicle:IsValidVehicle to make sure they're fully initialized
		
		Name | Description
		--- | ---
		`toBeValidated` | The table or object to be validated.
		
		
		`**Returns:** True if the object is valid.
    **/
    
    static function IsValid(toBeValidated:Dynamic):Bool;
    
    
    /**
        Returns if this is the first time this hook was predicted. 
		
		This is useful for one-time logic in your SWEPs PrimaryAttack, SecondaryAttack and Reload and other predicted hooks (to prevent those hooks from being called rapidly in succession). It's also useful in a Move hook for when the client predicts movement. 
		
		 Visit Prediction for more information about this behavior.
		
		**Note:** This is already used internally for Entity:EmitSound, Weapon:SendWeaponAnim and Entity:FireBullets, but NOT in util.Effect.
		
		`**Returns:** Whether or not this is the first time being predicted.
		
		___
		### Lua Examples
		#### Example 1
		An override for GM:KeyPress in the gamemode Trouble in Terrorist Town, to work around the hook being called multiple times.
		
		```lua 
		-- Note that for some reason KeyPress and KeyRelease are called multiple times
		-- for the same key event in multiplayer.
		function GM:KeyPress(ply, key)
		   if not IsFirstTimePredicted() then return end
		   if not IsValid(ply) or ply != LocalPlayer() then return end
		
		   if key == IN_SPEED and ply:IsActiveTraitor() then
		      timer.Simple(0.05, function() RunConsoleCommand("+voicerecord") end)
		   end
		end
		```
    **/
    
    static function IsFirstTimePredicted():Bool;
    
    #if client
    /**
        This function creates a World Tip, similar to the one shown when aiming at a Thruster where it shows you its force. 
		
		This function will make a World Tip that will only last 50 milliseconds (1/20th of a second), so you must call it continuously as long as you want the World Tip to be shown. It is common to call it inside a Think hook. 
		
		 Contrary to what the function's name implies, it is impossible to create more than one World Tip at the same time. A new World Tip will overwrite the old one, so only use this function when you know nothing else will also be using it. See SANDBOX:PaintWorldTips for more information.
		
		**Note:** This function is only available in Sandbox and its derivatives
		
		Name | Description
		--- | ---
		`entindex` | This argument is no longer used; it has no effect on anything. You can use nil in this argument.
		`text` | The text for the world tip to display.
		`dieTime` | This argument is no longer used; when you add a World Tip it will always last only 0.05 seconds. You can use nil in this argument.
		`pos` | Where in the world you want the World Tip to be drawn. If you add a valid Entity in the next argument, this argument will have no effect on the actual World Tip.
		`ent` | Which entity you want to associate with the World Tip. This argument is optional. If set to a valid entity, this will override the position set in pos with the Entity's position.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a World Tip where the player is looking. If the player is looking at an entity, the World Tip is positioned on the entity.
		
		```lua 
		hook.Add( "Think", "draw World Tip", function()
		    local ply = Entity( 1 )
		    local tr = ply:GetEyeTrace()
		    
		    local pos = tr.HitPos -- will be unused if ent is valid
		    local ent = tr.Entity
		    
		    AddWorldTip( nil, "Hello world!", nil, pos, ent )
		end )
		```
    **/
    
    static function AddWorldTip(?entindex:Float, text:String, ?dieTime:Float, ?pos:Vector, ?ent:Entity):Void;
    #end
    
    /**
        Returns the input value in an escaped form so that it can safely be used inside of queries. The returned value is surrounded by quotes unless noQuotes is true. Alias of sql.SQLStr
		
		Name | Description
		--- | ---
		`input` | String to be escaped
		`noQuotes` | Whether the returned value should be surrounded in quotes or not
		
		
		`**Returns:** Escaped input
    **/
    
    static function SQLStr(input:String, ?noQuotes:Bool):String;
    
    
    /**
        Returns if the passed object is a string.
		
		Name | Description
		--- | ---
		`variable` | The variable to perform the type check for.
		
		
		`**Returns:** True if the variable is a string.
    **/
    
    static function isstring(variable:Dynamic):Bool;
    
    
    /**
        Just like Msg, except it can also print colored text, just like chat.AddText.
		
		Name | Description
		--- | ---
		`args` | Values to print. If you put in a color, all text after that color will be printed in that color.
		
		
		___
		### Lua Examples
		#### Example 1
		Prints "Hello World!" in red to the console.
		
		```lua 
		MsgC( Color( 255, 0, 0 ), "Hello World!" )
		```
		
		#### Example 2
		Shows the built in colors for server and client
		
		```lua 
		MsgC( Color( 137, 222, 255 ), "Default server color" )
		MsgC( Color( 255, 222, 102 ), "Default client color" )
		```
    **/
    
    static function MsgC(args:Rest<Dynamic>):Void;
    
    #if client
    /**
        Makes the panel (usually an input of sorts) respond to changes in console variables by adding next functions to the panel:
		
		Name | Description
		--- | ---
		`target` | The panel the functions should be added to.
		
		
		___
		### Lua Examples
		#### Example 1
		Adds the functions to a panel (snippet of vgui/dcheckbox.lua)
		
		```lua 
		local PANEL = {}
		
		Derma_Install_Convar_Functions( PANEL )
		
		function PANEL:Init()
		    -- Init function here
		end
		function PANEL:Think()
		    self:ConVarStringThink()
		end
		```
		**Output:**
		
		The PANEL table now contains the functions SetConVar, ConVarChanged, ConVarStringThink and ConVarNumberThink (and an Init function and a Think function)
    **/
    
    static function Derma_Install_Convar_Functions(target:Panel):Void;
    #end
    
    /**
        This function takes a numeric indexed table and return all the members as a vararg. If specified, it will start at the given index and end at end index.
		
		Name | Description
		--- | ---
		`tbl` | The table to generate the vararg from.
		`startIndex` | Which index to start from. Optional.
		`endIndex` | Which index to end at. Optional, even if you set StartIndex.
		
		
		`**Returns:** Output values
		
		___
		### Lua Examples
		#### Example 1
		Prints a vararg
		
		```lua 
		print( unpack({"a", "b", "c"}) )
		```
    **/
    
    static function unpack(tbl:AnyTable, ?startIndex:Float, ?endIndex:Float):Rest<Dynamic>;
    
    #if client
    /**
        Creates a new CLuaEmitter.
		
		**Note:** Do not forget to delete the emitter with CLuaEmitter:Finish once you are done with it
		
		Name | Description
		--- | ---
		`position` | The start position of the emitter. This is only used to determine particle drawing order for translucent particles.
		`use3D` | Whenever to render the particles in 2D or 3D mode.
		
		
		`**Returns:** The new particle emitter.
		
		___
		### Lua Examples
		#### Example 1
		Creates a simple spark particle effect 100 units above where the local player is looking at.
		
		```lua 
		local tr =  LocalPlayer():GetEyeTrace()
		local pos = tr.HitPos + tr.HitNormal * 100 -- The origin position of the effect
		
		local emitter = ParticleEmitter( pos ) -- Particle emitter in this position
		
		for i = 0, 100 do -- Do 100 particles
		    local part = emitter:Add( "effects/spark", pos ) -- Create a new particle at pos
		    if ( part ) then
		        part:SetDieTime( 1 ) -- How long the particle should "live"
		
		        part:SetStartAlpha( 255 ) -- Starting alpha of the particle
		        part:SetEndAlpha( 0 ) -- Particle size at the end if its lifetime
		
		        part:SetStartSize( 5 ) -- Starting size
		        part:SetEndSize( 0 ) -- Size when removed
		
		        part:SetGravity( Vector( 0, 0, -250 ) ) -- Gravity of the particle
		        part:SetVelocity( VectorRand() * 50 ) -- Initial velocity of the particle
		    end
		end
		
		emitter:Finish()
		```
    **/
    
    static function ParticleEmitter(position:Vector, use3D:Bool):CLuaEmitter;
    #end
    
    /**
        Drops the specified entity if it is being held by any player with Gravity Gun or +use pickup.
		
		Name | Description
		--- | ---
		`ent` | The entity to drop.
    **/
    
    static function DropEntityIfHeld(ent:Entity):Void;
    
    

}


@:multiReturn extern class GlobalLibXpcallReturn {
var a:Bool;
var b:Rest<Dynamic>;

}
@:multiReturn extern class GlobalLibWorldToLocalReturn {
var a:Vector;
var b:Angle;

}
@:multiReturn extern class GlobalLibSortedPairsByValueReturn {
var a:Function;
var b:AnyTable;

}
@:multiReturn extern class GlobalLibSortedPairsByMemberValueReturn {
var a:Function;
var b:AnyTable;

}
@:multiReturn extern class GlobalLibSortedPairsReturn {
var a:Function;
var b:AnyTable;

}
@:multiReturn extern class GlobalLibPcallReturn {
var a:Bool;
var b:Rest<Dynamic>;

}
@:multiReturn extern class GlobalLibPairsReturn {
var a:Function;
var b:AnyTable;
var c:Dynamic;

}
@:multiReturn extern class GlobalLibNextReturn {
var a:Dynamic;
var b:Dynamic;

}
@:multiReturn extern class GlobalLibMaterialReturn {
var a:IMaterial;
var b:Float;

}
@:multiReturn extern class GlobalLibLocalToWorldReturn {
var a:Vector;
var b:Angle;

}
@:multiReturn extern class GlobalLibIpairsReturn {
var a:Function;
var b:AnyTable;
var c:Float;

}
#if client
@:multiReturn extern class GlobalLibFindTooltipReturn {
var a:String;
var b:Panel;
var c:Panel;

}
#end
@:multiReturn extern class GlobalLibCompileStringReturn {
var a:Function;
var b:String;

}
@:multiReturn extern class GlobalLibColorToHSVReturn {
var a:Float;
var b:Float;
var c:Float;

}
@:multiReturn extern class GlobalLibColorToHSLReturn {
var a:Float;
var b:Float;
var c:Float;

}
@:multiReturn extern class GlobalLibAssertReturn {
var a:Dynamic;
var b:Dynamic;
var c:Rest<Dynamic>;

}

