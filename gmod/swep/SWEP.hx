package gmod.swep;


/**
    Default weapon methods, that are available for use in SWEPs. These functions/hooks will not work on non-scripted weapons, such as the Half-Life 2 weapons. 
	
	You can find all available SWEP fields here: SWEP structure
**/
class SWEP {

	var self(default,never):gmod.gclass.Weapon;
    #if client
    /**
        Called after the view model has been drawn while the weapon in use. This hook is called from the default implementation of GM:PostDrawViewModel, and as such, will not occur if it has been overridden. 
		
		WEAPON:ViewModelDrawn is an alternative hook which is always called before GM:PostDrawViewModel.
		
		Name | Description
		--- | ---
		`vm` | This is the view model entity after it is drawn
		`weapon` | This is the weapon that is from the view model (same as self)
		`ply` | The owner of the view model
    **/
    
    @:hook
    function PostDrawViewModel(vm:Entity, weapon:Weapon, ply:Player):Void {}
    #end
    
    /**
        Called when player has just switched to this weapon.
		
		**Note:** Due to this hook being predicted, it is not called clientside in singleplayer at all, and in multiplayer it will not be called clientside if the weapon is switched with Player:SelectWeapon or the "use" console command, however it will be called clientside with the default weapon selection menu and when using CUserCmd:SelectWeapon
		
		`**Returns:** Return true to allow switching away from this weapon using lastinv command
    **/
    
    @:hook
    function Deploy():Bool {return null;}
    
    #if client
    /**
        This hook allows you to adjust view model position and angles.
		
		Name | Description
		--- | ---
		`EyePos` | Current position
		`EyeAng` | Current angle
		
		
		Name | Description
		--- | ---
		`a` | New position
		`b` | New angle
		
		
		___
		### Lua Examples
		#### Example 1
		This moves and rotates the original viewmodel based on fixed offsets, changing its idle position in front of the player.
		
		```lua 
		-- Adjust these variables to move the viewmodel's position
		SWEP.IronSightsPos  = Vector(9.49, 10.5, -12.371)
		SWEP.IronSightsAng  = Vector(12, 65, -22.19)
		
		function SWEP:GetViewModelPosition(EyePos, EyeAng)
		    local Mul = 1.0
		
		    local Offset = self.IronSightsPos
		
		    if (self.IronSightsAng) then
		        EyeAng = EyeAng * 1
		        
		        EyeAng:RotateAroundAxis(EyeAng:Right(),     self.IronSightsAng.x * Mul)
		        EyeAng:RotateAroundAxis(EyeAng:Up(),         self.IronSightsAng.y * Mul)
		        EyeAng:RotateAroundAxis(EyeAng:Forward(),   self.IronSightsAng.z * Mul)
		    end
		
		    local Right     = EyeAng:Right()
		    local Up         = EyeAng:Up()
		    local Forward     = EyeAng:Forward()
		
		    EyePos = EyePos + Offset.x * Right * Mul
		    EyePos = EyePos + Offset.y * Forward * Mul
		    EyePos = EyePos + Offset.z * Up * Mul
		    
		    return EyePos, EyeAng
		end
		```
    **/
    
    @:hook
    function GetViewModelPosition(EyePos:Vector, EyeAng:Angle):Dynamic {return null;}
    #end
    
    /**
        A convenience function to remove primary ammo from clip.
		
		Name | Description
		--- | ---
		`amount` | Amount of primary ammo to remove
		
		
		___
		### Lua Examples
		#### Example 1
		As defined in weapon_base
		
		```lua 
		function SWEP:TakePrimaryAmmo( num )
		    
		    -- Doesn't use clips
		    if ( self.Weapon:Clip1() <= 0 ) then 
		    
		        if ( self:Ammo1() <= 0 ) then return end
		        
		        self.Owner:RemoveAmmo( num, self.Weapon:GetPrimaryAmmoType() )
		    
		    return end
		    
		    self.Weapon:SetClip1( self.Weapon:Clip1() - num )    
		    
		end
		```
    **/
    
    @:hook
    function TakePrimaryAmmo(amount:Float):Void {}
    
    #if client
    /**
        Allows you to modify viewmodel while the weapon in use before it is drawn. This hook only works if you haven't overridden GM:PreDrawViewModel.
		
		Name | Description
		--- | ---
		`vm` | This is the view model entity before it is drawn.
		`weapon` | This is the weapon that is from the view model.
		`ply` | The the owner of the view model.
    **/
    
    @:hook
    function PreDrawViewModel(vm:Entity, weapon:Weapon, ply:Player):Void {}
    #end
    
    /**
        Helper function for checking for no ammo.
		
		`**Returns:** Can use secondary attack
		
		___
		### Lua Examples
		#### Example 1
		As defined in weapon_base
		
		```lua 
		function SWEP:CanSecondaryAttack()
		
		    if ( self.Weapon:Clip2() <= 0 ) then
		    
		        self.Weapon:EmitSound( "Weapon_Pistol.Empty" )
		        self.Weapon:SetNextSecondaryFire( CurTime() + 0.2 )
		        return false
		        
		    end
		
		    return true
		
		end
		```
    **/
    
    @:hook
    function CanSecondaryAttack():Bool {return null;}
    
    #if client
    /**
        This hook allows you to draw on screen while this weapon is in use. 
		
		If you want to draw a custom crosshair, consider using WEAPON:DoDrawCrosshair instead.
		
		___
		### Lua Examples
		#### Example 1
		Weapon:DrawHud() as defined in weapon_cs_base, with more notes
		
		```lua 
		function SWEP:DrawHUD()
		
		    -- No crosshair when ironsights is on
		    if ( self.Weapon:GetNWBool( "Ironsights" ) ) then return end
		
		    local x, y -- local, always
		
		    -- If we're drawing the local player, draw the crosshair where they're aiming
		    -- instead of in the center of the screen.
		    if ( self.Owner == LocalPlayer() && self.Owner:ShouldDrawLocalPlayer() ) then
		        local tr = util.GetPlayerTrace( self.Owner )
		        tr.mask = ( CONTENTS_SOLID+CONTENTS_MOVEABLE+CONTENTS_MONSTER+CONTENTS_WINDOW+CONTENTS_DEBRIS+CONTENTS_GRATE+CONTENTS_AUX ) -- List the enums that should mask the crosshair on camrea/thridperson
		        local trace = util.TraceLine( tr )
		        
		        local coords = trace.HitPos:ToScreen()
		        x, y = coords.x, coords.y
		
		    else
		        x, y = ScrW() / 2.0, ScrH() / 2.0 -- Center of screen
		    end
		    
		    local scale = 10 * self.Primary.Cone
		    local LastShootTime = self.Weapon:GetNWFloat( "LastShootTime", 0 )
		        -- Scale the size of the crosshair according to how long ago we fired our weapon
		    scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))
		    --                    R   G    B  Alpha
		    surface.SetDrawColor( 0, 255, 0, 255 ) -- Sets the color of the lines we're drawing
		    
		-- Draw a crosshair
		    local gap = 40 * scale
		    local length = gap + 20 * scale
		        --                 x1,        y1, x2,     y2
		    surface.DrawLine( x - length, y, x - gap, y )    -- Left
		    surface.DrawLine( x + length, y, x + gap, y )    -- Right
		    surface.DrawLine( x, y - length, x, y - gap )    -- Top
		    surface.DrawLine( x, y + length, x, y + gap )    -- Bottom
		
		end
		```
		**Output:**
		
		Draws 4 lines for crosshairs
    **/
    
    @:hook
    function DrawHUD():Void {}
    #end
    
    /**
        Called when secondary attack button ( +attack2 ) is pressed. 
		
		For issues with this hook being called rapidly on the client side, see the global function IsFirstTimePredicted.
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		___
		### Lua Examples
		#### Example 1
		This is how it is defined in weapon_base
		
		```lua 
		function SWEP:SecondaryAttack()
		
		    -- Make sure we can shoot first
		    if ( !self:CanSecondaryAttack() ) then return end
		
		    -- Play shoot sound
		    self.Weapon:EmitSound("Weapon_Shotgun.Single")
		    
		    -- Shoot 9 bullets, 150 damage, 0.75 aimcone
		    self:ShootBullet( 150, 9, 0.2 )
		    
		    -- Remove 1 bullet from our clip
		    self:TakeSecondaryAmmo( 1 )
		    
		    -- Punch the player's view
		    self.Owner:ViewPunch( Angle( -10, 0, 0 ) )
		
		end
		```
    **/
    
    @:hook
    function SecondaryAttack():Void {}
    
    #if client
    /**
        This hook draws the selection icon in the weapon selection menu.
		
		Name | Description
		--- | ---
		`x` | X coordinate of the selection panel
		`y` | Y coordinate of the selection panel
		`width` | Width of the selection panel
		`height` | Height of the selection panel
		`alpha` | Alpha value of the selection panel
		
		
		___
		### Lua Examples
		#### Example 1
		As defined in weapon_base
		
		```lua 
		function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
		    
		    -- Set us up the texture
		    surface.SetDrawColor( 255, 255, 255, alpha )
		    surface.SetTexture( self.WepSelectIcon )
		    
		    -- Lets get a sin wave to make it bounce
		    local fsin = 0
		    
		    if ( self.BounceWeaponIcon == true ) then
		        fsin = math.sin( CurTime() * 10 ) * 5
		    end
		    
		    -- Borders
		    y = y + 10
		    x = x + 10
		    wide = wide - 20
		    
		    -- Draw that mother
		    surface.DrawTexturedRect( x + (fsin), y - (fsin),  wide-fsin*2 , ( wide / 2 ) + (fsin) )
		    
		    -- Draw weapon info box
		    self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
		    
		end
		```
    **/
    
    @:hook
    function DrawWeaponSelection(x:Float, y:Float, width:Float, height:Float, alpha:Float):Void {}
    #end
    #if client
    /**
        A convenience function that draws the weapon info box, used in WEAPON:DrawWeaponSelection.
		
		Name | Description
		--- | ---
		`x` | The x co-ordinate of box position
		`y` | The y co-ordinate of box position
		`alpha` | Alpha value for the box
		
		
		___
		### Lua Examples
		#### Example 1
		As defined in weapon_base
		
		```lua 
		function SWEP:PrintWeaponInfo( x, y, alpha )
		
		    if ( self.DrawWeaponInfoBox == false ) then return end
		
		    if (self.InfoMarkup == nil ) then
		        local str
		        local title_color = "<color=230,230,230,255>"
		        local text_color = "<color=150,150,150,255>"
		        
		        str = "<font=HudSelectionText>"
		        if ( self.Author != "" ) then str = str .. title_color .. "Author:</color>\t"..text_color..self.Author.."</color>\n" end
		        if ( self.Contact != "" ) then str = str .. title_color .. "Contact:</color>\t"..text_color..self.Contact.."</color>\n\n" end
		        if ( self.Purpose != "" ) then str = str .. title_color .. "Purpose:</color>\n"..text_color..self.Purpose.."</color>\n\n" end
		        if ( self.Instructions != "" ) then str = str .. title_color .. "Instructions:</color>\n"..text_color..self.Instructions.."</color>\n" end
		        str = str .. "</font>"
		        
		        self.InfoMarkup = markup.Parse( str, 250 )
		    end
		    
		    surface.SetDrawColor( 60, 60, 60, alpha )
		    surface.SetTexture( self.SpeechBubbleLid )
		    
		    surface.DrawTexturedRect( x, y - 64 - 5, 128, 64 ) 
		    draw.RoundedBox( 8, x - 5, y - 6, 260, self.InfoMarkup:GetHeight() + 18, Color( 60, 60, 60, alpha ) )
		    
		    self.InfoMarkup:Draw( x+5, y+5, nil, nil, alpha )
		    
		end
		```
    **/
    
    @:hook
    function PrintWeaponInfo(x:Float, y:Float, alpha:Float):Void {}
    #end
    
    /**
        Called so the weapon can override the impact effects it makes.
		
		Name | Description
		--- | ---
		`tr` | A TraceResult structure from player's eyes to the impact point
		`damageType` | The damage type of bullet. See DMG_ Enums
		
		
		`**Returns:** Return true to not do the default thing - which is to call UTIL_ImpactTrace in C++
		
		___
		### Lua Examples
		#### Example 1
		Makes the SWEP have the AR2 bullet impact effect.
		
		```lua 
		function SWEP:DoImpactEffect( tr, nDamageType )
		
		    if ( tr.HitSky ) then return end
		    
		    local effectdata = EffectData()
		    effectdata:SetOrigin( tr.HitPos + tr.HitNormal )
		    effectdata:SetNormal( tr.HitNormal )
		    util.Effect( "AR2Impact", effectdata )
		
		end
		```
    **/
    
    @:hook
    function DoImpactEffect(tr:TraceResult, damageType:DMG):Bool {return null;}
    
    #if server
    /**
        Called when the engine sets a value for this scripted weapon. 
		
		See GM:EntityKeyValue for a hook that works for all entities. See ENTITY:KeyValue for an SENT hook that works for scripted entities.
		
		Name | Description
		--- | ---
		`key` | The key that was affected.
		`value` | The new value.
		
		
		`**Returns:** Return true to suppress this KeyValue or return false or nothing to apply this key value.
    **/
    
    @:hook
    function KeyValue(key:String, value:String):Bool {return null;}
    #end
    
    /**
        Allows to change players field of view while player holds the weapon.
		
		**Note:** This hook must be defined shared and return same value on both to properly affect Area Portals.
		
		Name | Description
		--- | ---
		`fov` | The current/default FOV.
		
		
		`**Returns:** The target FOV.
		
		___
		### Lua Examples
		#### Example 1
		Reduces players FOV by 30.
		
		```lua 
		function SWEP:TranslateFOV( fov )
		    return fov - 30
		end
		```
		**Output:**
		
		Players view is zoomed in.
    **/
    
    @:hook
    function TranslateFOV(fov:Float):Float {return null;}
    
    #if client
    /**
        Called every frame just before GM:RenderScene. 
		
		Used by the Tool Gun to render view model screens (TOOL:DrawToolScreen).
		
		**Note:** Materials rendered in this hook require $ignorez parameter to draw properly.
    **/
    
    @:hook
    function RenderScreen():Void {}
    #end
    #if client
    /**
        This hook determines which parts of the HUD to draw.
		
		Name | Description
		--- | ---
		`element` | The HUD element in question
		
		
		`**Returns:** Return false to hide this HUD element
    **/
    
    @:hook
    function HUDShouldDraw(element:String):Bool {return null;}
    #end
    #if server
    /**
        Called when a Citizen NPC is looking around to a (better) weapon to pickup.
		
		`**Returns:** Return true to allow this weapon to be picked up by NPCs.
    **/
    
    @:hook
    function CanBePickedUpByNPCs():Bool {return null;}
    #end
    #if server
    /**
        Called when the weapon is used by NPCs to tell the NPC how to use this weapon. Controls amount of time the NPC can rest (not shoot) between bursts.
		
		Name | Description
		--- | ---
		`a` | Minimum amount of time the NPC can rest (not shoot) between bursts in seconds. Default is 0.3 seconds.
		`b` | Maximum amount of time the NPC can rest (not shoot) between bursts in seconds. Default is 0.66 seconds.
    **/
    
    @:hook
    function GetNPCRestTimes():Dynamic {return null;}
    #end
    #if server
    /**
        Called when the weapon is used by NPCs to determine how accurate the bullets fired should be. 
		
		The inaccuracy is simulated by changing the NPC:GetAimVector based on the value returned from this hook.
		
		Name | Description
		--- | ---
		`proficiency` | How proficient the NPC is with this gun. See WEAPON_PROFICIENCY_ Enums
		
		
		`**Returns:** An amount of degrees the bullets should deviate from the NPC's NPC: GetAimVector. Default is 15.
    **/
    
    @:hook
    function GetNPCBulletSpread(proficiency:WEAPON_PROFICIENCY):Float {return null;}
    #end
    #if client
    /**
        Called when we are about to draw the translucent world model.
		
		___
		### Lua Examples
		#### Example 1
		Do the default action - render it without any changes.
		
		```lua 
		function SWEP:DrawWorldModelTranslucent()
		    self:DrawModel()
		end
		```
    **/
    
    @:hook
    function DrawWorldModelTranslucent():Void {}
    #end
    #if server
    /**
        This hook is for NPCs, you return what they should try to do with it.
		
		`**Returns:** A number defining what NPC should do with the weapon. Use the CAP_ Enums.
		
		___
		### Lua Examples
		#### Example 1
		As defined in weapon_base
		
		```lua 
		function SWEP:GetCapabilities()
		
		    return bit.bor( CAP_WEAPON_RANGE_ATTACK1, CAP_INNATE_RANGE_ATTACK1 )
		
		end
		```
    **/
    
    @:hook
    function GetCapabilities():CAP {return null;}
    #end
    
    /**
        Returns how much of secondary ammo the player has.
		
		`**Returns:** The amount of secondary ammo player has
		
		___
		### Lua Examples
		#### Example 1
		As defined in weapon_base
		
		```lua 
		function SWEP:Ammo2()
		    return self.Owner:GetAmmoCount( self.Weapon:GetSecondaryAmmoType() )
		end
		```
    **/
    
    @:hook
    function Ammo2():Float {return null;}
    
    
    /**
        A convenience function to create shoot effects.
		
		___
		### Lua Examples
		#### Example 1
		As defined in weapon_base
		
		```lua 
		function SWEP:ShootEffects()
		
		    self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )  -- View model animation
		    self.Owner:MuzzleFlash() -- Crappy muzzle light
		    self.Owner:SetAnimation( PLAYER_ATTACK1 ) -- 3rd Person Animation
		
		end
		```
    **/
    
    @:hook
    function ShootEffects():Void {}
    
    
    /**
        A convenience function to remove secondary ammo from clip.
		
		Name | Description
		--- | ---
		`amount` | How much of secondary ammo to remove
		
		
		___
		### Lua Examples
		#### Example 1
		As defined in weapon_base
		
		```lua 
		function SWEP:TakeSecondaryAmmo( num )
		    
		    -- Doesn't use clips
		    if ( self.Weapon:Clip2() <= 0 ) then 
		    
		        if ( self:Ammo2() <= 0 ) then return end
		        
		        self.Owner:RemoveAmmo( num, self.Weapon:GetSecondaryAmmoType() )
		    
		    return end
		    
		    self.Weapon:SetClip2( self.Weapon:Clip2() - num )    
		    
		end
		```
    **/
    
    @:hook
    function TakeSecondaryAmmo(amount:Float):Void {}
    
    
    /**
        Helper function for checking for no ammo.
		
		`**Returns:** Can use primary attack
		
		___
		### Lua Examples
		#### Example 1
		As defined in weapon_base
		
		```lua 
		function SWEP:CanPrimaryAttack()
		
		    if ( self.Weapon:Clip1() <= 0 ) then
		    
		        self:EmitSound( "Weapon_Pistol.Empty" )
		        self:SetNextPrimaryFire( CurTime() + 0.2 )
		        self:Reload()
		        return false
		        
		    end
		
		    return true
		
		end
		```
    **/
    
    @:hook
    function CanPrimaryAttack():Bool {return null;}
    
    
    /**
        Called when the reload key ( +reload ) is pressed.
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
    **/
    
    @:hook
    function Reload():Void {}
    
    
    /**
        A convenience function to shoot bullets.
		
		Name | Description
		--- | ---
		`damage` | The damage of the bullet
		`num_bullets` | Amount of bullets to shoot
		`aimcone` | Spread of bullets
		`ammo_type` | Ammo type of the bullets
		`force` | Force of the bullets
		`tracer` | Show a tracer on every x bullets
    **/
    
    @:hook
    function ShootBullet(damage:Float, num_bullets:Float, aimcone:Float, ?ammo_type:String, ?force:Float, ?tracer:Float):Void {}
    
    #if server
    /**
        Called when another entity fires an event to this entity.
		
		Name | Description
		--- | ---
		`inputName` | The name of the input that was triggered.
		`activator` | The initial cause for the input getting triggered.
		`called` | The entity that directly trigger the input.
		`data` | The data passed.
		
		
		`**Returns:** Should we suppress the default action for this input?
		
		___
		### Lua Examples
		#### Example 1
		A workaround for weapons created by maps not taking into account spawnflags.
		
		```lua 
		function SWEP:AcceptInput( name, activator, caller, data )
		
		    -- Check for input and spawnflag
		    if ( name == "ConstraintBroken" && self:HasSpawnFlags( 1 ) ) then
		
		        -- Freeze the weapon
		        local phys = self:GetPhysicsObject()
		        if ( IsValid( phys ) ) then phys:EnableMotion( false ) end
		    
		        -- Remove the spawnflag so it doesn't freeze the weapon when it is dropped
		        local newflags = bit.band( self:GetSpawnFlags(), bit.bnot( 1 ) )
		        self:SetKeyValue( "spawnflags", newflags )
		    end
		end
		```
    **/
    
    @:hook
    function AcceptInput(inputName:String, activator:Entity, called:Entity, data:String):Bool {return null;}
    #end
    #if client
    /**
        Allows you to adjust the mouse sensitivity. This hook only works if you haven't overridden GM:AdjustMouseSensitivity.
		
		`**Returns:** Sensitivity scale
		
		___
		### Lua Examples
		#### Example 1
		Makes your sensitivity twice slower
		
		```lua 
		function SWEP:AdjustMouseSensitivity()
		    return 0.5
		end
		```
    **/
    
    @:hook
    function AdjustMouseSensitivity():Float {return null;}
    #end
    #if client
    /**
        Allows you to use any numbers you want for the ammo display on the HUD. 
		
		Can be useful for weapons that don't use standard ammo.
		
		`**Returns:** The new ammo display settings. A table with 4 possible keys: boolean Draw - Whether to draw the ammo display or not number PrimaryClip - Amount of primary ammo in the clip number PrimaryAmmo - Amount of primary ammo in the reserves number SecondaryAmmo - Amount of secondary ammo. It is shown like alt-fire for SMG1 and AR2 are shown. There is no SecondaryClip!
		
		___
		### Lua Examples
		#### Example 1
		How it would look with standard information
		
		```lua 
		function SWEP:CustomAmmoDisplay()
		    self.AmmoDisplay = self.AmmoDisplay or {} 
		 
		    self.AmmoDisplay.Draw = true //draw the display?
		 
		    if self.Primary.ClipSize > 0 then
		        self.AmmoDisplay.PrimaryClip = self:Clip1() //amount in clip
		        self.AmmoDisplay.PrimaryAmmo = self:Ammo1() //amount in reserve
		    end
		    if self.Secondary.ClipSize > 0 then
		        self.AmmoDisplay.SecondaryAmmo = self:Ammo2() // amount of secondary ammo
		    end
		 
		    return self.AmmoDisplay //return the table
		end
		```
    **/
    
    @:hook
    function CustomAmmoDisplay():AnyTable {return null;}
    #end
    
    /**
        Called when the swep is about to be removed.
    **/
    
    @:hook
    function OnRemove():Void {}
    
    
    /**
        Called when weapon is dropped or picked up by a new player. 
		
		See also WEAPON:OnDrop.
    **/
    
    @:hook
    function OwnerChanged():Void {}
    
    
    /**
        Called when the weapon entity is created.
		
		**Note:** Entity:GetOwner will return NULL at this point because the weapon is not equpped by a player or NPC yet. Use WEAPON:Equip or WEAPON:Deploy if you need the owner to be valid.
		
		**Bug:** BUG This is sometimes not called clientside. You can work around this by setting a variable in Initialize and check if it exists in WEAPON:Think. See the example below. Issue Tracker: #2732
		
		**Bug:** BUG This is not called serverside after a quicksave. Issue Tracker: #3015
		
		___
		### Lua Examples
		#### Example 1
		Sets the weapon hold type to SWEP.HoldType.
		
		```lua 
		function SWEP:Initialize()
		
		    self:SetHoldType( self.HoldType )
		
		end
		```
		
		#### Example 2
		Fixes the function not being called clientside.
		
		```lua 
		function SWEP:Initialize()
		    self.m_bInitialized = true
		
		    -- Other code
		end
		
		function SWEP:Think()
		    if (not self.m_bInitialized) then
		        self:Initialize()
		    end
		
		    -- Other code
		end
		```
    **/
    
    @:hook
    function Initialize():Void {}
    
    #if server
    /**
        The player has picked up the weapon and has taken the ammo from it. The weapon will be removed immidiately after this call.
		
		Name | Description
		--- | ---
		`ply` | The player who picked up the weapon
    **/
    
    @:hook
    function EquipAmmo(ply:Player):Void {}
    #end
    #if client
    /**
        Allows overriding the position and angle of the viewmodel. This hook only works if you haven't overridden GM:CalcViewModelView.
		
		Name | Description
		--- | ---
		`ViewModel` | The viewmodel entity
		`OldEyePos` | Original position (before viewmodel bobbing and swaying)
		`OldEyeAng` | Original angle (before viewmodel bobbing and swaying)
		`EyePos` | Current position
		`EyeAng` | Current angle
		
		
		Name | Description
		--- | ---
		`a` | New position
		`b` | New angle
		
		
		___
		### Lua Examples
		#### Example 1
		One way to change the viewmodel texture (skin) for your SWEP. Changing it from 0 to 1.Remember to define the base path ($cdmaterials) for your model when e.g. using Crowbar to compile .smd to .mdl; or else you won't get any texture(s) applied. (the game won't know where to look) QC CommandsAnd remember to use $texturegroup for multiple skins.
		
		```lua 
		function SWEP:CalcViewModelView(ViewModel, OldEyePos, OldEyeAng, EyePos, EyeAng)
		    -- Set skin to the SWEPs second skin; 1. Starts at 0
		    ViewModel:SetSkin(1)
		end
		```
		**Output:**
		
		Skin 0 Skin 1
    **/
    
    @:hook
    function CalcViewModelView(ViewModel:Entity, OldEyePos:Vector, OldEyeAng:Angle, EyePos:Vector, EyeAng:Angle):Dynamic {return null;}
    #end
    #if client
    /**
        Allows you to override where the tracer effect comes from. ( Visual bullets )
		
		`**Returns:** The new position to start tracer effect from
    **/
    
    @:hook
    function GetTracerOrigin():Vector {return null;}
    #end
    #if client
    /**
        Allows you to adjust player view while this weapon in use. 
		
		This hook is called from the default implementation of GM:CalcView ([1]). Therefore, it will not be called if any other hook added to CalcView returns any value, or if the current gamemode overrides the default hook and does not call the SWEP function.
		
		**Bug:** BUG SWEPs that define this function will not work with the taunt camera. Pull Request: #1348
		
		Name | Description
		--- | ---
		`ply` | The owner of weapon
		`pos` | Current position of players view
		`ang` | Current angles of players view
		`fov` | Current FOV of players view
		
		
		Name | Description
		--- | ---
		`a` | New position of players view
		`b` | New angle of players view
		`c` | New FOV of players view
    **/
    
    @:hook
    function CalcView(ply:Player, pos:Vector, ang:Angle, fov:Float):Dynamic {return null;}
    #end
    
    /**
        Translate a player's Activity into a weapon's activity, depending on how you want the player to be holding the weapon. 
		
		For example, ACT_MP_RUN becomes ACT_HL2MP_RUN_PISTOL.
		
		Name | Description
		--- | ---
		`act` | The activity to translate
		
		
		`**Returns:** The translated activity
		
		___
		### Lua Examples
		#### Example 1
		Default action
		
		```lua 
		function SWEP:TranslateActivity( act )
		
		    if ( self.Owner:IsNPC() ) then
		        if ( self.ActivityTranslateAI[ act ] ) then
		            return self.ActivityTranslateAI[ act ]
		        end
		        return -1
		    end
		
		    if ( self.ActivityTranslate[ act ] != nil ) then
		        return self.ActivityTranslate[ act ]
		    end
		
		    return -1
		
		end
		```
    **/
    
    @:hook
    function TranslateActivity(act:Float):Float {return null;}
    
    
    /**
        Called when weapon tries to holster.
		
		**Note:** This hook is predicted. This means that in singleplayer, it will not be called in the Client realm.
		
		**Bug:** BUG This is called twice for every holster clientside, one in prediction and one not. Issue Tracker: #2854
		
		**Bug:** BUG Before WEAPON:OnRemove is called, this function is only called serverside. Issue Tracker: #3133
		
		Name | Description
		--- | ---
		`weapon` | The weapon we are trying switch to.
		
		
		`**Returns:** Return true to allow weapon to holster
		
		___
		### Lua Examples
		#### Example 1
		Returns the weapon switched to when when the weapon is being holstered.
		
		```lua 
		function SWEP:Holster( wep )
		    if not IsFirstTimePredicted() then return end
		    LocalPlayer():ChatPrint("Switched to: "..(wep.PrintName or wep:GetClass()))
		end
		```
		**Output:**
		
		Switched to Toolgun Switched to weapon_crowbar
    **/
    
    @:hook
    function Holster(weapon:Entity):Bool {return null;}
    
    
    /**
        Sets the weapon deploy speed. This value needs to match on client and server.
		
		Name | Description
		--- | ---
		`speed` | The value to set deploy speed to. Negative will slow down playback.
		
		
		___
		### Lua Examples
		#### Example 1
		As defined in weapon_base
		
		```lua 
		function SWEP:SetDeploySpeed( speed )
		    self.m_WeaponDeploySpeed = tonumber( speed )
		end
		```
    **/
    
    @:hook
    function SetDeploySpeed(speed:Float):Void {}
    
    
    /**
        Called when the swep thinks. 
		
		This hook won't be called during the deploy animation and when using Weapon:DefaultReload.
		
		**Note:** Despite being a predicted hook, this hook is called clientside in single player, however it will not be recognized as a predicted hook to Player:GetCurrentCommand.
		
		**Note:** This hook will be called before Player movement is processed on the client, and after on the server.
		
		**Bug:** BUG This will not be run during deploy animations after a serverside-only deploy. This usually happens after picking up and dropping an object with +use. Issue Tracker: #2855
    **/
    
    @:hook
    function Think():Void {}
    
    
    /**
        Called before firing animation events, such as muzzle flashes or shell ejections. 
		
		This will only be called serverside for 3000-range events, and clientside for 5000-range and other events.
		
		Name | Description
		--- | ---
		`pos` | Position of the effect.
		`ang` | Angle of the effect.
		`event` | The event ID of happened even. See this page.
		`options` | Name or options of the event.
		
		
		`**Returns:** Return true to disable the effect.
		
		___
		### Lua Examples
		#### Example 1
		Disables muzzle flashes. Taken from tool gun source code.
		
		```lua 
		function SWEP:FireAnimationEvent( pos, ang, event, options )
		    
		    -- Disables animation based muzzle event
		    if ( event == 21 ) then return true end    
		
		    -- Disable thirdperson muzzle flash
		    if ( event == 5003 ) then return true end
		
		end
		```
		
		#### Example 2
		Counter-Strike: Source like muzzle flashes.
		
		```lua 
		function SWEP:FireAnimationEvent( pos, ang, event, options )
		
		    if ( !self.CSMuzzleFlashes ) then return end
		
		    -- CS Muzzle flashes
		    if ( event == 5001 or event == 5011 or event == 5021 or event == 5031 ) then
		    
		        local data = EffectData()
		        data:SetFlags( 0 )
		        data:SetEntity( self.Owner:GetViewModel() )
		        data:SetAttachment( math.floor( ( event - 4991 ) / 10 ) )
		        data:SetScale( 1 ) -- Change me
		
		        if ( self.CSMuzzleX ) then
		            util.Effect( "CS_MuzzleFlash_X", data )
		        else
		            util.Effect( "CS_MuzzleFlash", data )
		        end
		    
		        return true
		    end
		
		end
		```
    **/
    
    @:hook
    function FireAnimationEvent(pos:Vector, ang:Angle, event:Float, options:String):Bool {return null;}
    
    #if client
    /**
        Called when we are about to draw the world model.
		
		___
		### Lua Examples
		#### Example 1
		The default action - render the world model.
		
		```lua 
		function SWEP:DrawWorldModel()
		    self:DrawModel()
		end
		```
		
		#### Example 2
		Draw The World model when needed. Placing the SWEPs World model in the right hand of the Player.
		
		```lua 
		-- ...
		SWEP.HoldType = "pistol" -- You might need to do self:SetHoldType(self.HoldType) under the initialization hook for the SWEP.
		
		if CLIENT then
		    local WorldModel = ClientsideModel(SWEP.WorldModel)
		
		    -- Settings...
		    WorldModel:SetSkin(1)
		    WorldModel:SetNoDraw(true)
		
		    function SWEP:DrawWorldModel()
		        local _Owner = self:GetOwner()
		
		        if (IsValid(_Owner)) then
		            -- Specify a good position
		            local offsetVec = Vector(5, -2.7, -3.4)
		            local offsetAng = Angle(180, 90, 0)
		            
		            local boneid = _Owner:LookupBone("ValveBiped.Bip01_R_Hand") -- Right Hand
		            if !boneid then return end
		
		            local matrix = _Owner:GetBoneMatrix(boneid)
		            if !matrix then return end
		
		            local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())
		
		            WorldModel:SetPos(newPos)
		            WorldModel:SetAngles(newAng)
		
		            WorldModel:SetupBones()
		        else
		            WorldModel:SetPos(self:GetPos())
		            WorldModel:SetAngles(self:GetAngles())
		        end
		
		        WorldModel:DrawModel()
		    end
		end
		```
		**Output:**
		
		The World model is in the Players hand, with a skin applied. The World model when dropped.
    **/
    
    @:hook
    function DrawWorldModel():Void {}
    #end
    
    /**
        Called when the SWEP should set up its Data Tables.
		
		___
		### Lua Examples
		#### Example 1
		Sets up networked variables, adds functions SetDamage, GetDamage, SetMuzzlePos and GetMuzzlePos.
		
		```lua 
		function SWEP:SetupDataTables()
		    self:NetworkVar( "Float", 0, "Damage" )
		    self:NetworkVar( "Vector", 0, "MuzzlePos" )
		end
		```
    **/
    
    @:hook
    function SetupDataTables():Void {}
    
    
    /**
        Called when primary attack button ( +attack ) is pressed. 
		
		Since this is a predicted hook, as mentioned on the bottom of the page, it has some additional behaviour to it. This is the same with all predicted SWEP hooks. 
		
		 When in singleplayer, this function is only called in the server realm. When in multiplayer, the hook will be called on both the server and the client in order to allow for prediction. 
		
		 You can force the hook to always be called on client like this:
		
		___
		### Lua Examples
		#### Example 1
		This is how it is defined in weapon_base
		
		```lua 
		function SWEP:PrimaryAttack()
		
		    -- Make sure we can shoot first
		    if ( !self:CanPrimaryAttack() ) then return end
		
		    -- Play shoot sound
		    self.Weapon:EmitSound("Weapon_AR2.Single")
		    
		    -- Shoot 1 bullet, 150 damage, 0.01 aimcone
		    self:ShootBullet( 150, 1, 0.01 )
		    
		    -- Remove 1 bullet from our clip
		    self:TakePrimaryAmmo( 1 )
		    
		    -- Punch the player's view
		    self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
		
		end
		```
    **/
    
    @:hook
    function PrimaryAttack():Void {}
    
    #if client
    /**
        Called straight after the view model has been drawn. This is called before GM:PostDrawViewModel and WEAPON:PostDrawViewModel.
		
		Name | Description
		--- | ---
		`ViewModel` | Players view model
    **/
    
    @:hook
    function ViewModelDrawn(ViewModel:Entity):Void {}
    #end
    
    /**
        Returns how much of primary ammo the player has.
		
		`**Returns:** The amount of primary ammo player has
		
		___
		### Lua Examples
		#### Example 1
		As defined in weapon_base
		
		```lua 
		function SWEP:Ammo1()
		    return self.Owner:GetAmmoCount( self.Weapon:GetPrimaryAmmoType() )
		end
		```
    **/
    
    @:hook
    function Ammo1():Float {return null;}
    
    #if server
    /**
        Called when weapon is dropped by Player:DropWeapon. 
		
		See also WEAPON:OwnerChanged.
    **/
    
    @:hook
    function OnDrop():Void {}
    #end
    #if server
    /**
        Should this weapon be dropped when its owner dies? 
		
		This only works if the player has Player:ShouldDropWeapon set to true.
		
		`**Returns:** Return true to drop the weapon, false otherwise. Default ( if you don't return anything ) is false.
    **/
    
    @:hook
    function ShouldDropOnDie():Bool {return null;}
    #end
    #if client
    /**
        Called when the crosshair is about to get drawn, and allows you to override it.
		
		**Note:** This function will not be called if SWEP.DrawCrosshair set to false.
		
		**Note:** This function will not be called if player was affected by Player:CrosshairDisable.
		
		**Bug:** BUG The arguments passed to this function are not affected by SWEP.AccurateCrosshair. Issue Tracker: #2117
		
		Name | Description
		--- | ---
		`x` | X coordinate of the crosshair.
		`y` | Y coordinate of the crosshair.
		
		
		`**Returns:** Return true to override the default crosshair.
		
		___
		### Lua Examples
		#### Example 1
		Draws an outlined rectangle in place of the crosshair.
		
		```lua 
		function SWEP:DoDrawCrosshair( x, y )
		    surface.SetDrawColor( 0, 250, 255, 255 )
		    surface.DrawOutlinedRect( x - 32, y - 32, 64, 64 )
		    return true
		end
		```
    **/
    
    @:hook
    function DoDrawCrosshair(x:Float, y:Float):Bool {return null;}
    #end
    #if server
    /**
        Called when the weapon is used by NPCs to tell the NPC how to use this weapon. Controls how long the NPC can or should shoot continuously.
		
		Name | Description
		--- | ---
		`a` | Minimum amount of bullets per burst. Default is 1.
		`b` | Maximum amount of bullets per burst. Default is 1.
		`c` | Delay between each shot, aka firerate. Default is 1.
    **/
    
    @:hook
    function GetNPCBurstSettings():Dynamic {return null;}
    #end
    #if client
    /**
        Called to determine if the view model should be drawn or not.
		
		`**Returns:** Return true to draw the view model, false otherwise.
    **/
    
    @:hook
    function ShouldDrawViewModel():Bool {return null;}
    #end
    
    /**
        Called when the weapon entity is reloaded from a Source Engine save (not the Sandbox saves or dupes) or on a changelevel (for example Half-Life 2 campaign level transitions). 
		
		For the duplicator library callbacks, see ENTITY:OnDuplicated. 
		
		 See also saverestore library for relevant functions.
    **/
    
    @:hook
    function OnRestore():Void {}
    
    
    /**
        Called whenever the weapons Lua script is reloaded.
    **/
    
    @:hook
    function OnReloaded():Void {}
    
    #if client
    /**
        This hook allows you to freeze players screen.
		
		**Note:** Player will still be able to move or shoot
		
		`**Returns:** Return true to freeze moving the view
    **/
    
    @:hook
    function FreezeMovement():Bool {return null;}
    #end
    #if server
    /**
        Called when a player or NPC has picked the weapon up.
		
		Name | Description
		--- | ---
		`NewOwner` | The one who picked the weapon up. Can be Player or NPC.
    **/
    
    @:hook
    function Equip(NewOwner:Entity):Void {}
    #end
    
    /**
        Sets the hold type of the weapon. This must be called on both the server and the client to work properly. 
		
		NOTE: You should avoid calling this function and call Weapon:SetHoldType now.
		
		Name | Description
		--- | ---
		`name` | Name of the hold type. You can find all default hold types here
    **/
    
    @:hook
    function SetWeaponHoldType(name:String):Void {}
    
    #if client
    /**
        This hook allows you to draw on screen while this weapon is in use. This hook is called before WEAPON:DrawHUD and is equivalent of GM:HUDPaintBackground.
    **/
    
    @:hook
    function DrawHUDBackground():Void {}
    #end
    
}


@:multiReturn extern class SwepGetViewModelPositionReturn {
var a:Vector;
var b:Angle;

}
@:multiReturn extern class SwepGetNPCRestTimesReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class SwepGetNPCBurstSettingsReturn {
var a:Float;
var b:Float;
var c:Float;

}
@:multiReturn extern class SwepCalcViewModelViewReturn {
var a:Vector;
var b:Angle;

}
@:multiReturn extern class SwepCalcViewReturn {
var a:Vector;
var b:Angle;
var c:Float;

}

