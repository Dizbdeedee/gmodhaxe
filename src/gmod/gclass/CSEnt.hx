package gmod.gclass;
#if client

/**
    CSEnt is a client-side only entity which can be created with ClientsideModel, ClientsideRagdoll, ClientsideScene, and ents.CreateClientProp. 
	
	Its base class is Entity so it inherits all of the Client and Shared functions used by Entity.
**/
extern class CSEnt extends Entity {
    
    /**
        Removes the clientside entity
    **/
    
    function Remove():Void;
    
    
}



#end