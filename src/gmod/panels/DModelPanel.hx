package gmod.panels;
#if client

/**
    DModelPanel is a VGUI element that projects a 3D model onto a 2D plane.
**/
extern class DModelPanel extends DButton {
    /**
        Sets the directional lighting used on the rendered entity.
		
		Name | Description
		--- | ---
		`direction` | The light direction, see BOX_ Enums.
		`color` | The color of the directional lighting.
		
		
		___
		### Lua Examples
		#### Example 1
		Displays a model panel with no directional lighting. Dr. Kleiner is only lit by the ambient light set by DModelPanel:SetAmbientLight.
		
		```lua 
		-- Black background panel
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetPos(20, 20)
		BGPanel:SetSize(400, 400)
		BGPanel:SetBackgroundColor(Color(0, 0, 0, 255))
		
		local mdl = vgui.Create("DModelPanel", BGPanel)
		mdl:SetSize(BGPanel:GetSize())
		    
		-- Setup model and camera
		mdl:SetModel("models/kleiner.mdl")
		mdl:SetCamPos(Vector(20, 20, 60))
		mdl:SetLookAt(Vector(0, 0, 60))
		
		-- Make Kleiner pace
		mdl:GetEntity():SetSequence(mdl:GetEntity():LookupSequence("pace_all"))
		
		-- Disable directional lighting
		mdl:SetDirectionalLight(BOX_TOP, Color(0, 0, 0))
		mdl:SetDirectionalLight(BOX_FRONT, Color(0, 0, 0))
		
		-- Spin around faster and play animation
		function mdl:LayoutEntity(ent)
		    ent:SetAngles(Angle( 0, self.LastPaint*60,  0))
		    self:RunAnimation()
		end
		```
    **/
    
     
    function SetDirectionalLight(direction:BOX, color:AnyTable):Void;
    /**
        Sets the model of the rendered entity.
		
		Name | Description
		--- | ---
		`model` | The model to apply to the entity
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a new DModelPanel with the Kleiner playermodel.
		
		```lua 
		local modelPanel = vgui.Create( "DModelPanel" )
		modelPanel:SetPos( 0, 0 )
		modelPanel:SetSize( 200, 200 )
		modelPanel:SetModel( "models/player/kleiner.mdl" )
		```
    **/
    
     
    function SetModel(model:String):Void;
    /**
        Returns the entity being rendered by the model panel.
		
		`**Returns:** The rendered entity (client-side)
		
		___
		### Lua Examples
		#### Example 1
		Creates an antlion model panel and sets the antlion's skin to 1.
		
		```lua 
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetPos(20, 20)
		BGPanel:SetSize(200, 200)
		    
		local mdl = vgui.Create("DModelPanel", BGPanel)
		mdl:SetSize(200, 200)
		mdl:SetModel("models/antlion.mdl")
		mdl:SetLookAt(Vector(0, 0, 20))
		
		mdl:GetEntity():SetSkin(1)
		```
    **/
    
     
    function GetEntity():CSEnt;
    /**
        
		
		Name | Description
		--- | ---
		`path` | The path to the scene file. (.vcd)
    **/
    
     
    function StartScene(path:String):Void;
    /**
        Returns the ambient lighting used on the rendered entity.
		
		`**Returns:** The color of the ambient lighting.
		
		___
		### Lua Examples
		#### Example 1
		Prints out the default ambient lighting used on models.
		
		```lua 
		local mdl = vgui.Create("DModelPanel")
		mdl:SetPos(20, 20)
		mdl:SetSize(200, 200)
		mdl:SetModel("models/props_junk/watermelon01.mdl")
		
		print(mdl:GetAmbientLight())
		```
		**Output:**
		
		50 50 50 255
    **/
    
     
    function GetAmbientLight():AnyTable;
    /**
        Sets the position of the camera.
		
		Name | Description
		--- | ---
		`pos` | The position to set the camera at.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a model panel focused on Gman's face while he adjusts his tie.
		
		```lua 
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetPos(20, 20)
		BGPanel:SetSize(200, 200)
		BGPanel:SetBackgroundColor(Color(0, 0, 0, 255))
		    
		local mdl = vgui.Create("DModelPanel", BGPanel)
		mdl:SetSize(BGPanel:GetSize())
		mdl:SetModel("models/player/gman_high.mdl")
		
		function mdl:LayoutEntity(ent)
		    ent:SetSequence(ent:LookupSequence("menu_gman"))
		    mdl:RunAnimation()        
		    return
		end
		
		local eyepos = mdl.Entity:GetBonePosition(mdl.Entity:LookupBone("ValveBiped.Bip01_Head1"))
		
		eyepos:Add(Vector(0, 0, 2))    -- Move up slightly
		
		mdl:SetLookAt(eyepos)
		
		mdl:SetCamPos(eyepos-Vector(-12, 0, 0))    -- Move cam in front of eyes
		
		mdl.Entity:SetEyeTarget(eyepos-Vector(-12, 0, 0))
		```
		
		#### Example 2
		Sets a model panel's camera position so the model won't go outside it
		
		```lua 
		local mdlpnl = vgui.Create( "DModelPanel" )
		
		local mn, mx = mdlpnl.Entity:GetRenderBounds()
		local size = 0
		size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
		size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
		size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )
		
		mdlpnl:SetFOV( 45 )
		mdlpnl:SetCamPos( Vector( size, size, size ) )
		mdlpnl:SetLookAt( (mn + mx) * 0.5 )
		```
    **/
    
     
    function SetCamPos(pos:Vector):Void;
    /**
        Gets the model of the rendered entity.
		
		`**Returns:** The model of the rendered entity.
    **/
    
     
    function GetModel():String;
    /**
        Sets the ambient lighting used on the rendered entity.
		
		Name | Description
		--- | ---
		`color` | The color of the ambient lighting.
		
		
		___
		### Lua Examples
		#### Example 1
		Displays a model panel with a watermelon that has red ambient lighting.
		
		```lua 
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetPos(20, 20)
		BGPanel:SetSize(200, 200)
		    
		local mdl = vgui.Create("DModelPanel", BGPanel)
		mdl:SetSize(BGPanel:GetSize())
		mdl:SetModel("models/props_junk/watermelon01.mdl")
		
		mdl:SetCamPos(Vector(15, 15, 0))
		mdl:SetLookAt(Vector(0, 0, 0))
		
		mdl:SetAmbientLight(Color(255, 0, 0, 255))
		```
    **/
    
     
    function SetAmbientLight(color:AnyTable):Void;
    /**
        Sets the panel camera's FOV (field of view).
		
		Name | Description
		--- | ---
		`fov` | The field of view value.
		
		
		___
		### Lua Examples
		#### Example 1
		The best FOV demo you've ever seen.
		
		```lua 
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetPos(20, 20)
		BGPanel:SetSize(200, 200)
		    
		local mdl = vgui.Create("DModelPanel", BGPanel)
		mdl:Dock(FILL)
		mdl:SetModel("models/player/barney.mdl")
		
		local fov = 10    -- starting value
		local offset = 0.1    -- amount to increment by
		
		function mdl:LayoutEntity(ent)
		    
		    mdl:SetFOV(fov)    -- update FOV
		    
		    fov = fov + offset    -- increment
		    
		    if(fov >= 120 or fov <= 10) then
		        offset = offset*-1    -- inverse increment amount
		    end
		    
		    ent:SetSequence(ent:LookupSequence("taunt_muscle"))    -- FLEX
		    if(ent:GetCycle() >= 0.95) then ent:SetCycle(0.05) end    -- YOUR
		    mdl:RunAnimation()    -- MUSCLES
		    
		end
		```
    **/
    
     
    function SetFOV(fov:Float):Void;
    /**
        Returns the FOV (field of view) the camera is using.
		
		`**Returns:** The FOV of the camera.
		
		___
		### Lua Examples
		#### Example 1
		Prints out the default camera FOV.
		
		```lua 
		local mdl = vgui.Create("DModelPanel")
		mdl:SetPos(20, 20)
		mdl:SetSize(200, 200)
		mdl:SetModel("models/props_junk/watermelon01.mdl")
		
		print(mdl:GetFOV())
		```
		**Output:**
		
		70
    **/
    
     
    function GetFOV():Float;
    /**
        Sets the entity to be rendered by the model panel.
		
		**Note:** If you set ent to a shared entity you must set ent to nil before removing this panel or else a "Trying to remove server entity on client!" error is thrown
		
		Name | Description
		--- | ---
		`ent` | The new panel entity.
		
		
		___
		### Lua Examples
		#### Example 1
		Implementation of a function called StartBreencast which makes Dr. Breen recite his instinct speech within a model panel that's displayed to all clients. This mainly demonstrates how even shared entities such as NPCs can be used with DModelPanel as long as they're networked properly.
		
		```lua 
		g_Breen = nil    -- Breen NPC
		
		if(SERVER) then
		    -- Broadcast propaganda to clients
		    util.AddNetworkString("BreencastSentence")
		end
		
		-- Broadcast Breen to clients each time he starts a new sentence.
		function GM:EntityEmitSound(data)
		
		    if(data.Entity == g_Breen) then
		    
		        local st, en = string.find(data.SoundName, "vo/")
		        local sentence = "sound/"..string.sub(data.SoundName, st)    -- Properly format sound name
		    
		        net.Start("BreencastSentence")
		            net.WriteEntity(data.Entity)
		            net.WriteString(sentence)
		        net.Broadcast()
		        
		    end
		    
		    return nil
		    
		end
		
		if(CLIENT) then
		
		    -- Receive latest breencast sound byte and update screen
		    function BreencastSentence()
		    
		        -- Client-side reference to Breen NPC
		        g_Breen = net.ReadEntity()
		        
		        local soundname = net.ReadString()
		        
		        -- Play sound byte
		        sound.PlayFile(soundname, "", function(sentence, errnum, err)
		        
		            if(err) then
		                Error(err)
		            else
		                sentence:Play()
		                StartBreencast()    -- Update breencast monitor
		            end
		        
		        end)
		    
		    end
		    
		    net.Receive("BreencastSentence", BreencastSentence)
		    
		end
		
		-- Call this server-side to begin Breencast
		function StartBreencast()
		
		    if(SERVER) then
		
		        -- Remove existing Breen NPC
		        if(g_Breen && IsValid(g_Breen)) then
		            g_Breen:Remove()
		        end
		
		        -- Create new Breen NPC
		        g_Breen = ents.Create("npc_breen")
		        g_Breen:Spawn()
		        
		        -- Hide NPC everywhere except inside model panel
		        g_Breen:SetSaveValue("m_takedamage", 0)
		        g_Breen:SetMoveType(MOVETYPE_NONE)
		        g_Breen:SetSolid(SOLID_NONE)
		        g_Breen:SetRenderMode(RENDERMODE_TRANSALPHA)
		        g_Breen:SetColor(Color(255, 255, 255, 0))
		        
		        -- Play propaganda        
		        g_Breen:PlayScene("scenes/breencast/instinct_tv.vcd")
		        g_Breen:SetEyeTarget(Vector(100, 0, 60))
		
		    elseif(CLIENT) then
		
		        -- Remove existing panel and clear model entity to prevent error
		        if(BGPanel) then
		            if(BGPanel:GetChild(0)) then BGPanel:GetChild(0):SetEntity(nil) end
		            BGPanel:Remove()
		            BGPanel = nil            
		        end
		        
		        -- Don't continue if Breen is undefined
		        if(!g_Breen or !IsValid(g_Breen)) then return end
		        
		        -- Black background panel
		        BGPanel = vgui.Create("DPanel")
		        BGPanel:SetPos(20, 20)
		        BGPanel:SetSize(200, 200)
		        BGPanel:SetBackgroundColor(Color(0, 0, 0, 255))
		        
		        -- Model panel
		        local mdl = vgui.Create("DModelPanel", BGPanel)
		        mdl:SetSize(BGPanel:GetSize())
		        mdl:SetFOV(40)    -- Default FOV is too jarring
		        
		        mdl:SetEntity(g_Breen)    -- Add Breen NPC to model panel
		        
		        -- Focus camera on Breen's head
		        function mdl:LayoutEntity(ent)
		        
		            -- If Breen has been removed somehow then remove screen
		            if(!IsValid(ent)) then
		                if(mdl:GetParent()) then mdl:GetParent():Remove() end
		                return
		            end
		        
		            local eyepos = ent:GetBonePosition(ent:LookupBone("ValveBiped.Bip01_Head1"))
		        
		            mdl:SetLookAt(eyepos)
		            mdl:SetCamPos(eyepos+Vector(35, 0, -4))
		            
		            return
		            
		        end
		        
		    end
		    
		end
		```
		**Output:**
		
		"I find it helpful at times like these to remind myself that our true enemy is: Instinct."
    **/
    
     
    function SetEntity(ent:Entity):Void;
    /**
        This function is used in the DModelPanel:LayoutEntity. It will set the active model to the last set animation using Entity:SetSequence. By default, it is the walking animation.
		
		___
		### Lua Examples
		#### Example 1
		Sets the model to alyx and puts her in a walking animation
		
		```lua 
		local ModelPanel = vgui.Create( "DModelPanel", Panel )
		ModelPanel:SetModel( "models/player/alyx.mdl" )
		function ModelPanel:LayoutEntity( ent )
		     ModelPanel:RunAnimation()
		end
		```
    **/
    
     
    function RunAnimation():Void;
    /**
        Sets the speed used by DModelPanel:RunAnimation to advance frame on an entity sequence.
		
		**Note:** Entity:FrameAdvance doesn't seem to have any functioning arguments and therefore changing this will not have any affect on the panel entity's sequence speed without reimplementation. It only affects the value returned by DModelPanel:GetAnimSpeed
		
		Name | Description
		--- | ---
		`animSpeed` | The animation speed.
		
		
		___
		### Lua Examples
		#### Example 1
		A reimplementation of DModelPanel:LayoutEntity which will modify the entity's sequence playback rate based on the set animation speed. This example has Alyx run twice as fast as normal.
		
		```lua 
		local mdl = vgui.Create("DModelPanel")
		mdl:SetPos(20, 20)
		mdl:SetSize(200, 200)
		mdl:SetModel("models/alyx.mdl")
		
		-- Play sequence twice as fast
		mdl:SetAnimSpeed(2)
		    
		-- Make Alyx run
		mdl:GetEntity():SetSequence(mdl:GetEntity():LookupSequence("run_all"))
		
		-- Play animation
		function mdl:LayoutEntity(ent)
		
		    -- Playback rate based on anim speed
		    ent:SetPlaybackRate(self:GetAnimSpeed())
		    
		    -- Advance frame
		    ent:FrameAdvance()
		
		end
		```
    **/
    
     
    function SetAnimSpeed(animSpeed:Float):Void;
    /**
        Returns the animation speed of the panel entity, see DModelPanel:SetAnimSpeed.
		
		`**Returns:** The animation speed.
		
		___
		### Lua Examples
		#### Example 1
		Prints out the default animation speed.
		
		```lua 
		local mdl = vgui.Create("DModelPanel")
		mdl:SetPos(20, 20)
		mdl:SetSize(200, 200)
		mdl:SetModel("models/props_junk/watermelon01.mdl")
		
		print(mdl:GetAnimSpeed())
		```
		**Output:**
		
		0.5
    **/
    
     
    function GetAnimSpeed():Float;
    /**
        Returns the angles of the model viewing camera. Is nil until changed with DModelPanel:SetLookAng.
		
		`**Returns:** The angles of the camera.
		
		___
		### Lua Examples
		#### Example 1
		Prints out the default camera angles.
		
		```lua 
		local mdl = vgui.Create("DModelPanel")
		mdl:SetPos(20, 20)
		mdl:SetSize(200, 200)
		mdl:SetModel("models/props_junk/watermelon01.mdl")
		
		print(mdl:GetLookAng())
		```
		**Output:**
		
		nil
    **/
    
     
    function GetLookAng():Angle;
    /**
        Returns the position of the model viewing camera.
		
		`**Returns:** The position of the camera.
		
		___
		### Lua Examples
		#### Example 1
		Prints out the default camera position.
		
		```lua 
		local mdl = vgui.Create("DModelPanel")
		mdl:SetPos(20, 20)
		mdl:SetSize(200, 200)
		mdl:SetModel("models/props_junk/watermelon01.mdl")
		
		print(mdl:GetCamPos())
		```
		**Output:**
		
		50.000000 50.000000 50.000000
    **/
    
     
    function GetCamPos():Vector;
    /**
        ***INTERNAL** 
		
		Used by the DModelPanel's paint hook to draw the model and background.
    **/
    @:deprecated("INTERNAL")
     
    function DrawModel():Void;
    /**
        Called before the entity of the DModelPanel is drawn.
		
		Name | Description
		--- | ---
		`ent` | The clientside entity of the DModelPanel that has been drawn.
		
		
		`**Returns:** Return false to stop the entity from being drawn. This will also cause DModelPanel: PostDrawModel to stop being called.
    **/
    
     
    function PreDrawModel(ent:Entity):Bool;
    /**
        Returns the position the viewing camera is pointing toward.
		
		`**Returns:** The position the camera is pointing toward.
		
		___
		### Lua Examples
		#### Example 1
		Prints out the default camera look-at position.
		
		```lua 
		local mdl = vgui.Create("DModelPanel")
		mdl:SetPos(20, 20)
		mdl:SetSize(200, 200)
		mdl:SetModel("models/props_junk/watermelon01.mdl")
		
		print(mdl:GetLookAt())
		```
		**Output:**
		
		0.000000 0.000000 40.000000
    **/
    
     
    function GetLookAt():Vector;
    /**
        Makes the panel's camera face the given position.
		
		Name | Description
		--- | ---
		`pos` | The position to orient the camera toward.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a model panel focused on Colonel Odessa Cubbage's face.
		
		```lua 
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetPos(20, 20)
		BGPanel:SetSize(200, 200)        
		    
		local mdl = vgui.Create("DModelPanel", BGPanel)
		mdl:SetSize(BGPanel:GetSize())
		mdl:SetModel("models/player/odessa.mdl")
		
		function mdl:LayoutEntity( Entity ) return end    -- Disable cam rotation
		
		local headpos = mdl.Entity:GetBonePosition(mdl.Entity:LookupBone("ValveBiped.Bip01_Head1"))
		mdl:SetLookAt(headpos)
		
		mdl:SetCamPos(headpos-Vector(-15, 0, 0))    -- Move cam in front of face
		
		--mdl.Entity:SetEyeTarget(headpos-Vector(-15, 0, 0))
		
		-- ^^ Makes Odessa look at the camera
		-- Commented out because the result is funnier without this
		```
    **/
    
     
    function SetLookAt(pos:Vector):Void;
    /**
        Sets the angles of the camera.
		
		Name | Description
		--- | ---
		`ang` | The angles to set the camera to.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a model panel with Eli rotating normally and the camera angles rotating sideways.
		
		```lua 
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetPos(20, 20)
		BGPanel:SetSize(400, 400)
		BGPanel:SetBackgroundColor(Color(0, 0, 0, 255))
		
		local mdl = vgui.Create("DModelPanel", BGPanel)
		mdl:SetSize(BGPanel:GetSize())
		mdl:SetModel("models/eli.mdl")
		
		-- Position camera
		mdl:SetCamPos(Vector(0, 60, 36))
		
		local yaw = 0
		
		function mdl:LayoutEntity(ent)
		
		    -- Point camera toward the look pos
		    local lookAng = (self.vLookatPos-self.vCamPos):Angle()
		    
		    -- Rotate the look angles based on incrementing yaw value
		    lookAng:RotateAroundAxis(Vector(0, 1, 0), yaw)
		    
		    -- Set camera look angles
		    self:SetLookAng(lookAng)
		    
		    -- Make entity rotate like normal
		    ent:SetAngles(Angle(0, RealTime()*30,  0))
		    
		    yaw = yaw + 1
		
		end
		```
    **/
    
     
    function SetLookAng(ang:Angle):Void;
    /**
        Called when the entity of the DModelPanel was drawn. 
		
		This is a rendering hook with 3d drawing context.
		
		Name | Description
		--- | ---
		`ent` | The clientside entity of the DModelPanel that has been drawn.
    **/
    
     
    function PostDrawModel(ent:Entity):Void;
    /**
        Returns the color of the rendered entity.
		
		`**Returns:** The color of the entity, see Color structure.
		
		___
		### Lua Examples
		#### Example 1
		Prints out the default entity color.
		
		```lua 
		local mdl = vgui.Create("DModelPanel")
		mdl:SetPos(20, 20)
		mdl:SetSize(200, 200)
		mdl:SetModel("models/props_junk/watermelon01.mdl")
		
		print(mdl:GetColor())
		```
		**Output:**
		
		255 255 255 255
    **/
    
     
    function GetColor():Color;
    /**
        ***INTERNAL** 
		
		By default, this function slowly rotates and animates the entity being rendered. If you want to change this behavior, you should override it.
		
		Name | Description
		--- | ---
		`entity` | The entity that is being rendered.
		
		
		___
		### Lua Examples
		#### Example 1
		Stops the rendered entity from rotating.
		
		```lua 
		local modelPanel = vgui.Create( "DModelPanel" )
		modelPanel:SetPos( 0, 0 )
		modelPanel:SetSize( 200, 200 )
		modelPanel:SetModel( "models/player/kleiner.mdl" )
		
		function modelPanel:LayoutEntity( ent )
		    -- do nothing
		end
		```
    **/
    @:deprecated("INTERNAL")
     
    function LayoutEntity(entity:Entity):Void;
    /**
        Sets whether or not to animate the entity when the default DModelPanel:LayoutEntity is called.
		
		Name | Description
		--- | ---
		`animated` | True to animate, false otherwise.
		
		
		___
		### Lua Examples
		#### Example 1
		A comparison between 2 model panels: the first one has animated set to false and the second one has it set to true. Both are using the default DModelPanel:LayoutEntity method.
		
		```lua 
		BGPanel = vgui.Create("DPanel")
		BGPanel:SetPos(20, 20)
		BGPanel:SetSize(400, 200)
		    
		-- Left panel
		local mdl1 = vgui.Create("DModelPanel", BGPanel)
		mdl1:SetPos(0, 0)
		mdl1:SetSize(200, 200)
		mdl1:SetModel("models/player/mossman.mdl")
		mdl1:SetCamPos(Vector(40, 40, 40))
		
		mdl1:SetAnimated(false)
		
		-- Right panel
		local mdl2 = vgui.Create("DModelPanel", BGPanel)
		mdl2:SetPos(200, 0)
		mdl2:SetSize(200, 200)
		mdl2:SetModel("models/player/mossman.mdl")
		mdl2:SetCamPos(Vector(40, 40, 40))
		
		mdl2:SetAnimated(true)
		
		-- Dance sequence    
		local dance = mdl1:GetEntity():LookupSequence("taunt_dance")
		
		-- Make both dance
		mdl1:GetEntity():SetSequence(dance)
		mdl2:GetEntity():SetSequence(dance)
		```
    **/
    
     
    function SetAnimated(animated:Bool):Void;
    /**
        Returns whether or not the panel entity should be animated when the default DModelPanel:LayoutEntity function is called.
		
		`**Returns:** True if the panel entity can be animated with Entity: SetSequence directly, false otherwise.
		
		___
		### Lua Examples
		#### Example 1
		Prints out the default boolean value for this function.
		
		```lua 
		local mdl = vgui.Create("DModelPanel")
		mdl:SetPos(20, 20)
		mdl:SetSize(200, 200)
		mdl:SetModel("models/props_junk/watermelon01.mdl")
		
		print(mdl:GetAnimated())
		```
		**Output:**
		
		false
    **/
    
     
    function GetAnimated():Bool;
    /**
        Sets the color of the rendered entity.
		
		**Note:** This does not work on Garry's Mod player models since they use a different color system. To modify a player model color, see Example 2 on the DModelPanel page
		
		Name | Description
		--- | ---
		`color` | The render color of the entity.
		
		
		___
		### Lua Examples
		#### Example 1
		Creates a model panel with a red watermelon inside.
		
		```lua 
		local panel = vgui.Create("DPanel")
		panel:SetPos(20, 20)
		panel:SetSize(200, 200)
		    
		local mdl = vgui.Create("DModelPanel", panel)
		mdl:SetSize(panel:GetSize())
		mdl:SetModel("models/props_junk/watermelon01.mdl")
		mdl:SetLookAt(Vector(0, 0, 0))
		mdl:SetCamPos(Vector(10, 10, 10))
		mdl:SetColor(Color(255, 0, 0))
		```
    **/
    
     
    function SetColor(color:AnyTable):Void;
    
}



#end