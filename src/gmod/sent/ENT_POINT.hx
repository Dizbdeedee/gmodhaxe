package gmod.sent;
@:gclass("base_point")
@:TYPE("point")
extern class ENT_POINT extends gmod.sent.ENT {
	public static inline final gclass:EntityClass<ENT_POINT> = "base_point";

    /**
        Called whenever the transmit state should be updated. 
		
		
		**Returns:** Transmit state to set, see TRANSMIT_ Enums.
		
		___
		### Lua Examples
		#### Example 1
		Entity pickup example, stops the entity from being networked after it's been picked up, and restores it once it "respawns".
		
		```lua 
		function ENT:Touch( other )
		    if ( self.NextRespawn > CurTime() ) then return end
		    
		    self.NextRespawn = CurTime() + 5
		    self:AddEFlags( EFL_FORCE_CHECK_TRANSMIT )
		end
		
		function ENT:UpdateTransmitState()
		    if ( self.NextRespawn > CurTime() ) then
		        return TRANSMIT_NEVER
		    end
		    
		    return TRANSMIT_PVS
		end
		
		function ENT:Think()
		    if ( self.NextRespawn != -1 && self.NextRespawn < CurTime() ) then
		        self.NextRespawn = -1
		        self:AddEFlags( EFL_FORCE_CHECK_TRANSMIT )
		    end
		end
		```
		
		
    **/
    
    @:hook
    function UpdateTransmitState():Float;
}
