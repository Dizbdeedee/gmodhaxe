package gmod.sent;
#if server
class ENT_POINT extends gmod.sent.ENT {
    var self(default,never):gmod.gclass.Entity;
	public final TYPE = "point";
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
    private function UpdateTransmitState():Float {return null;}
}
#end