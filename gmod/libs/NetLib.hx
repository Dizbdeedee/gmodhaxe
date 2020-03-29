package gmod.libs;


/**
    The net library is one of a number of ways to send data between the client and server. 
	
	The major advantages of the net library are the large size limit (64kb/message) and the ability to send data backwards - from the client to the server. 
	
	 Refer to Net Library Usage for a short introduction.
**/
@:native("_G.net")extern class NetLib {
    
    /**
        Reads an integer from the received net message.
		
		**Warning:** You must read information in same order as you write it.
		
		Name | Description
		--- | ---
		`bitCount` | The amount of bits to be read. This must be set to what you set to net. WriteInt. Read more information at net. WriteInt.
		
		
		`**Returns:** The read integer number, or 0 if no integer could be read.
    **/
    
    public static function ReadInt(bitCount:Int):Int;
    
    
    /**
        Reads a double-precision number from the received net message.
		
		**Warning:** You must read information in same order as you write it.
		
		`**Returns:** The double-precision number, or 0 if no number could be read.
    **/
    
    public static function ReadDouble():Float;
    
    
    /**
        Appends a float (number with decimals) to the current net message.
		
		Name | Description
		--- | ---
		`float` | The float to be sent.
    **/
    
    public static function WriteFloat(float:Float):Void;
    
    
    /**
        Reads a vector from the received net message. Vectors sent by this function are compressed, which may result in precision loss. See net.WriteVector for more information.
		
		**Warning:** You must read information in same order as you write it.
		
		`**Returns:** The read vector, or Vector(0,0,0) if no vector could be read.
    **/
    
    public static function ReadVector():Vector;
    
    
    /**
        ***INTERNAL** You may be looking for net. Receive.
		
		Function called by the engine to tell the lua state a message arrived.
		
		Name | Description
		--- | ---
		`length` | The message length, in bits.
		`client` | The player that sent the message. This will be nil in the client state.
    **/
    @:deprecated("INTERNAL: You may be looking for net. Receive.")
    public static function Incoming(length:Float, client:Player):Void;
    
    
    /**
        Returns the size of the current message in bytes.
		
		**Note:** This will include 3 extra bytes used by the engine internally to send the data over the network.
		
		Name | Description
		--- | ---
		`a` | The amount of bytes written to the current net message. Returns nil if no net message has been started.
		`b` | The amount of bits written to the current net message. Returns nil if no net message has been started.
    **/
    
    public static function BytesWritten():NetLibBytesWrittenReturn;
    
    
    /**
        Appends an unsigned integer with the specified number of bits to the current net message.
		
		Name | Description
		--- | ---
		`unsignedInteger` | The unsigned integer to be sent.
		`numberOfBits` | The size of the integer to be sent, in bits. Acceptable values range from any number 1 to 32 inclusive. For reference, 1 = bit, 4 = nibble, 8 = byte, 16 = short, 32 = long.
    **/
    
    public static function WriteUInt(unsignedInteger:Float, numberOfBits:Float):Void;
    
    
    /**
        Reads an entity from the received net message. You should always check if the specified entity exists as it may have been removed and therefor NULL if it is outside of the players PVS or was already removed.
		
		**Warning:** You must read information in same order as you write it.
		
		`**Returns:** The entity, or Entity(0) if no entity could be read.
    **/
    
    public static function ReadEntity():Entity;
    
    
    /**
        Reads pure binary data from the message.
		
		**Warning:** You must read information in same order as you write it.
		
		Name | Description
		--- | ---
		`length` | The length of the data to be read, in bytes.
		
		
		`**Returns:** The binary data read, or a string containing one character with a byte of 0 if no data could be read.
    **/
    
    public static function ReadData(length:Float):String;
    
    
    /**
        Reads a VMatrix from the received net message.
		
		**Warning:** You must read information in same order as you write it.
		
		`**Returns:** The matrix, or an empty matrix if no matrix could be read.
    **/
    
    public static function ReadMatrix():VMatrix;
    
    
    /**
        Writes a normalized/direction vector ( Vector with length of 1 ) to the net message. 
		
		This function uses less bandwidth compared to net.WriteVector and will not send vectors with length of > 1 properly.
		
		Name | Description
		--- | ---
		`normal` | The normalized/direction vector to be send.
		
		
		___
		### Lua Examples
		#### Example 1
		Showcases the difference between this function and net.WriteVector.
		
		```lua 
		if ( SERVER ) then
		    util.AddNetworkString( "test1" )
		    util.AddNetworkString( "test2" )
		    
		    timer.Simple( 1, function()
		        net.Start( "test1" )
		            net.WriteVector( Vector( 1.23456789, 2.3456789, 3.456789 ) )
		        net.Broadcast()
		    
		        net.Start( "test2" )
		            net.WriteNormal( Vector( 1.23456789, 2.3456789, 3.456789 ) )
		        net.Broadcast()
		
		        net.Start( "test2" )
		            net.WriteNormal( Vector( 1.23456789, 2.3456789, 3.456789 ):GetNormalized() )
		        net.Broadcast()
		    
		        net.Start( "test2" )
		            net.WriteNormal( Vector( 0.5, -0.5, 0.23 ) )
		        net.Broadcast()
		    end )
		else
		    net.Receive( "test1", function( ... )
		        print( ... ) 
		        print( net.ReadVector() ) 
		    end )
		    
		    net.Receive( "test2", function( ... )
		        print( ... ) 
		        print( net.ReadNormal() ) 
		    end )
		end
		```
		**Output:**
		
		69 nil 1.218750 2.343750 3.437500 27 nil 1.000000 1.000000 0.000000 27 nil 0.283341 0.538349 0.793661 27 nil 0.499756 -0.499756 0.707452
    **/
    
    public static function WriteNormal(normal:Vector):Void;
    
    
    /**
        Reads a null terminated string from the net stream. The size of the string is 8 bits plus 8 bits for every ASCII character in the string.
		
		**Warning:** You must read information in same order as you write it.
		
		`**Returns:** The read string, or a string with 0 length if no string could be read.
    **/
    
    public static function ReadString():String;
    
    
    /**
        Appends a table to the current net message. Adds 16 extra bits per key/value pair so you're better off writing each individual key/value as the exact type if possible.
		
		**Warning:** All net messages have a 64kb buffer. This function will not check or error when that buffer is overflown. You might want to consider using util.TableToJSON and util.Compress and send the resulting string in 60kb chunks, doing the opposite on the receiving end.
		
		**Warning:** If the table contains a nil key the table may not be read correctly. Not all objects can be sent over the network. Things like functions, IMaterials, etc will cause errors when reading the table from a net message.
		
		Name | Description
		--- | ---
		`table` | The table to be sent. WARNING If the table contains a nil key the table may not be read correctly. Not all objects can be sent over the network. Things like functions, IMaterials, etc will cause errors when reading the table from a net message.
    **/
    
    public static function WriteTable(table:AnyTable):Void;
    
    
    /**
        Writes a chunk of binary data to the message.
		
		Name | Description
		--- | ---
		`binaryData` | The binary data to be sent.
		`length` | The length of the binary data to be sent, in bytes.
    **/
    
    public static function WriteData(binaryData:String, length:Float):Void;
    
    
    /**
        Reads a normal vector from the net message.
		
		**Warning:** You must read information in same order as you write it.
		
		`**Returns:** The normalized vector ( length = 1 ), or Vector(0,0,1) if no normal could be read.
    **/
    
    public static function ReadNormal():Vector;
    
    
    /**
        Appends a string to the current net message. The size of the string is 8 bits plus 8 bits for every ASCII character in the string. The maximum allowed length of a single written string is 65533 characters.
		
		Name | Description
		--- | ---
		`string` | The string to be sent.
    **/
    
    public static function WriteString(string:String):Void;
    
    
    /**
        Writes a VMatrix to the current net message.
		
		Name | Description
		--- | ---
		`matrix` | The matrix to be sent.
    **/
    
    public static function WriteMatrix(matrix:VMatrix):Void;
    
    
    /**
        Returns the amount of data left to read in the current message in bytes. Does nothing when sending data.
		
		Name | Description
		--- | ---
		`a` | The amount of data left to read in the current net message in bytes. Returns nil if no net message has been started.
		`b` | The amount of data left to read in the current net message in bits. Returns nil if no net message has been started.
    **/
    
    public static function BytesLeft():NetLibBytesLeftReturn;
    
    
    /**
        Reads an angle from the received net message.
		
		**Warning:** You must read information in same order as you write it.
		
		`**Returns:** The read angle, or Angle(0,0,0) if no angle could be read
    **/
    
    public static function ReadAngle():Angle;
    
    #if client
    /**
        Sends the current message to the server.
		
		___
		### Lua Examples
		#### Example 1
		Sends a simple "hello_world" message with the string "Hi" to the server
		
		```lua 
		net.Start( "hello_world" )
		    net.WriteString( "Hi" )
		net.SendToServer()
		```
		**Output:**
		
		The netmessage "hello_world" is sent to the server. The server can handle this with net.Receive. Remember that any client has the potential to send any net message at any time. On your server-side net.Receive, make sure to verify the message sender's permissions whenever you can and prevent expensive functions from being run too often.
    **/
    
    public static function SendToServer():Void;
    #end
    
    /**
        Reads a table from the received net message.
		
		**Warning:** You must read information in same order as you write it.
		
		**Note:** Sometimes when sending a table through the net library, the order of the keys may be switched. So be cautious when comparing (See Example 1).
		
		`**Returns:** Table recieved via the net message, or a blank table if no table could be read.
		
		___
		### Lua Examples
		#### Example 1
		This is an example of how the keys order may be switched:
		
		```lua 
		--Client:
		function SendTable()
		     local Table = {}
		     Table.Type = "Dining"
		     Table.Legs = 4
		     Table.Material = "Wood"
		     net.Start("TableSend")
		      net.WriteTable(Table)
		     net.SendToServer()
		     PrintTable(Table) -- Prints the order client side
		end
		
		--Server:
		function GotTable(len, Player)
		     PrintTable(net.ReadTable()) -- Prints the order server side
		end
		net.Receive("TableSend", GotTable)
		```
		**Output:**
		
		Client: Type = "Dining" Legs = 4 Material = "Wood" Server: Legs = 4 Material = "Wood" Type = "Dining"
    **/
    
    public static function ReadTable():AnyTable;
    
    
    /**
        Reads a bit from the received net message.
		
		**Warning:** You must read information in same order as you write it.
		
		`**Returns:** 0 or 1, or 0 if the bit could not be read.
    **/
    
    public static function ReadBit():Float;
    
    
    /**
        Writes an angle to the current net message.
		
		Name | Description
		--- | ---
		`angle` | The angle to be sent.
    **/
    
    public static function WriteAngle(angle:Angle):Void;
    
    
    /**
        Appends a boolean (as 1 or 0) to the current net message. 
		
		Please note that the bit is written here from a boolean (true/false) but net.ReadBit returns a number.
		
		Name | Description
		--- | ---
		`boolean` | Bit status (false = 0, true = 1)
    **/
    
    public static function WriteBit(boolean:Bool):Void;
    
    
    /**
        Appends a boolean to the current net message. Alias of net.WriteBit
		
		Name | Description
		--- | ---
		`boolean` | Boolean value to write
    **/
    
    public static function WriteBool(boolean:Bool):Void;
    
    
    /**
        Begins a new net message. If another net message is already started and hasn't been sent yet, it will be discarded.
		
		**Warning:** Each net message has a length limit of 64KB!
		
		**Warning:** The message name must be pooled with util.AddNetworkString beforehand!
		
		Name | Description
		--- | ---
		`messageName` | The name of the message to send
		`unreliable` | If set to true, the message is not guaranteed to reach its destination
		
		
		`**Returns:** True if the message has been started.
    **/
    
    public static function Start(messageName:String, ?unreliable:Bool):Bool;
    
    
    /**
        Reads a Color structure from the current net message.
		
		**Warning:** You must read information in same order as you write it.
		
		`**Returns:** The Color structure read from the current net message, or Color(0,0,0,0) if the color could not be read.
    **/
    
    public static function ReadColor():Color;
    
    
    /**
        Reads a floating point number from the received net message.
		
		**Warning:** You must read information in same order as you write it.
		
		`**Returns:** The floating point number, or 0 if no number could be read.
    **/
    
    public static function ReadFloat():Float;
    
    
    /**
        Appends a vector to the current net message. Vectors sent by this function are compressed, which may result in precision loss. XYZ components greater than 16384 or less than -16384 are irrecoverably altered (most significant bits are trimmed) and precision after the decimal point is low.
		
		Name | Description
		--- | ---
		`vector` | The vector to be sent.
		
		
		___
		### Lua Examples
		#### Example 1
		Create a serverside command to send a vector to all clients, and a function to receive the vector on the clientside. This example displays the vector compression discussed above.
		
		```lua 
		if SERVER then
		
		    util.AddNetworkString("testingvecs")
		    function testvecs_sv()
		        net.Start("testingvecs")
		        net.WriteVector(Vector(10000, 20000, -20000.123456789))
		        net.Broadcast()
		    end
		    concommand.Add("dovectest", testvecs_sv)
		
		elseif CLIENT then
		
		    function testvecs_cl(len)
		        print("RECV: vec = " .. tostring(net.ReadVector()) .. "\n")
		    end
		    net.Receive("testingvecs", testvecs_cl)
		
		end
		```
		**Output:**
		
		RECV: vec = 10000.000000 3616.000000 -3616.093750
    **/
    
    public static function WriteVector(vector:Vector):Void;
    
    
    /**
        Reads a boolean from the received net message.
		
		**Warning:** You must read information in same order as you write it.
		
		`**Returns:** true or false, or false if the bool could not be read.
    **/
    
    public static function ReadBool():Bool;
    
    #if server
    /**
        Sends the message to all players the position is in the PVS of or, more simply said, sends the message to players that can potentially see this position.
		
		Name | Description
		--- | ---
		`position` | Position that must be in players' visibility set.
    **/
    
    public static function SendPVS(position:Vector):Void;
    #end
    #if server
    /**
        Sends the message to all players that are in the same potentially audible set(PAS) as the position, or simply said, it adds all players that can potentially hear sounds from this position.
		
		Name | Description
		--- | ---
		`position` | PAS position.
    **/
    
    public static function SendPAS(position:Vector):Void;
    #end
    
    /**
        ***INTERNAL** 
		
		Reads a word, basically unsigned short. This is used internally to read the "header" of the message which is an unsigned short which can be converted to the corresponding message name via util.NetworkIDToString.
		
		`**Returns:** The header number
    **/
    @:deprecated("INTERNAL")
    public static function ReadHeader():Float;
    
    
    /**
        Reads an unsigned integer with the specified number of bits from the received net message.
		
		**Warning:** You must read information in same order as you write it.
		
		Name | Description
		--- | ---
		`numberOfBits` | The size of the integer to be read, in bits.
		
		
		`**Returns:** The unsigned integer read, or 0 if the integer could not be read.
    **/
    
    public static function ReadUInt(numberOfBits:Float):Float;
    
    
    /**
        ***INTERNAL** Used internally by net. ReadTable.
		
		Reads a value from the net message with the specified type, written by net.WriteType.
		
		**Warning:** You must read information in same order as you write it.
		
		Name | Description
		--- | ---
		`typeID` | The type of value to be read, using TYPE_ Enums.
		
		
		`**Returns:** The value, or the respective blank value based on the type you're reading if the value could not be read.
    **/
    @:deprecated("INTERNAL: Used internally by net. ReadTable.")
    public static function ReadType(?typeID:TYPE):Dynamic;
    
    
    /**
        ***INTERNAL** Used internally by net. WriteTable.
		
		Appends any type of value to the current net message.
		
		**Note:** An additional 8-bit unsigned integer indicating the type will automatically be written to the packet before the value, in order to facilitate reading with net.ReadType. If you know the data type you are writing, use a function meant for that specific data type to reduce amount of data sent.
		
		Name | Description
		--- | ---
		`Data` | The data to be sent
    **/
    @:deprecated("INTERNAL: Used internally by net. WriteTable.")
    public static function WriteType(Data:Dynamic):Void;
    
    
    /**
        Appends an integer - a whole number - to the current net message. Can be read back with net.ReadInt on the receiving end. 
		
		Use net.WriteUInt to send an unsigned number (that you know will never be negative). Use net.WriteFloat for a non-whole number (e.g. 2.25).
		
		Name | Description
		--- | ---
		`integer` | The integer to be sent.
		`bitCount` | The amount of bits the number consists of. This must be 32 or less. If you are unsure what to set, just set it to 32. Consult the table below to determine the bit count you need. Bit Count Minimum value Maximum value 2 -2 1 3 -4 3 4 -8 7 5 -16 15 6 -32 31 7 -64 63 8 -128 127 9 -256 255 10 -512 511 11 -1024 1023 12 -2048 2047 13 -4096 4095 14 -8192 8191 15 -16384 16383 16 -32768 32767 17 -65536 65535 18 -131072 131071 19 -262144 262143 20 -524288 524287 21 -1048576 1048575 22 -2097152 2097151 23 -4194304 4194303 24 -8388608 8388607 25 -16777216 16777215 26 -33554432 33554431 27 -67108864 67108863 28 -134217728 134217727 29 -268435456 268435455 30 -536870912 536870911 31 -1073741824 1073741823 32 -2147483648 2147483647
		
		
		___
		### Lua Examples
		#### Example 1
		Sends the server the client's age.
		
		```lua 
		--Client
		function SendAge()
		     net.Start("SendAge")
		     net.WriteInt(3, 3)  -- Only 2 bits are needed to store the number '3', but we add one because of the rule.
		     net.SendToServer()
		end
		
		--Server
		util.AddNetworkString("SendAge")
		
		local function GetAge(len, ply)
		     local age = net.ReadInt(3) -- use the same number of bits that were written
		     print("Player " .. ply:Nick() .. " is " .. age .. " years old."
		end
		net.Receive("SendAge", GetAge)
		```
		**Output:**
		
		Player <name> is 3 years old.
    **/
    
    public static function WriteInt(integer:Float, bitCount:Float):Void;
    
    #if server
    /**
        Sends the current message to all except the specified, or to all except all players in the table.
		
		Name | Description
		--- | ---
		`ply` | The player(s) to NOT send the message to. Can be a table of players
    **/
    
    public static function SendOmit(ply:Player):Void;
    #end
    
    /**
        Appends a double-precision number to the current net message.
		
		Name | Description
		--- | ---
		`double` | The double to be sent
    **/
    
    public static function WriteDouble(double:Float):Void;
    
    
    /**
        Appends an entity to the current net message.
		
		Name | Description
		--- | ---
		`entity` | The entity to be sent.
    **/
    
    public static function WriteEntity(entity:Entity):Void;
    
    
    /**
        Appends a Color structure to the current net message.
		
		Name | Description
		--- | ---
		`Color` | The Color structure you want to append to the net message.
    **/
    
    public static function WriteColor(Color:Color):Void;
    
    
    /**
        Adds a net message handler. Only one receiver can be used to receive the net message.
		
		**Warning:** You must put this function outside of any other function or hook for it to work properly unless you know what you are doing!
		
		**Warning:** You must read information in the same order as you write it.
		
		**Warning:** Each net message has a length limit of 64KB!
		
		**Note:** The message-name is converted to lower-case so the message-names "BigBlue" and "bigblue" would be equal.
		
		Name | Description
		--- | ---
		`messageName` | The message name to hook to.
		`callback` | The function to be called if the specified message was received. Arguments are: number len - Length of the message, in bits Player ply - The player that sent the message, works only serverside
		
		
		___
		### Lua Examples
		#### Example 1
		A simple callback
		
		```lua 
		net.Receive( "my_message", function( len, pl )
		    if ( IsValid( pl ) and pl:IsPlayer() ) then
		        print( "Message from " .. pl:Nick() .. " received. Its length is " .. len .. "." )
		    else
		        print( "Message from server received. Its length is " .. len .. "." )
		    end
		end )
		```
		**Output:**
		
		When run server-side: Message from John received. Its length is 4. And client-side: Message from server received. Its length is 4.
    **/
    
    public static function Receive(messageName:String, callback:Function):Void;
    
    #if server
    /**
        Sends the currently built net message to all connected players. More information can be found in Net Library Usage.
		
		___
		### Lua Examples
		#### Example 1
		Sends a packet to all players.
		
		```lua 
		net.Start("NETHOOK")
		    net.WriteString("some text")
		net.Broadcast()
		```
    **/
    
    public static function Broadcast():Void;
    #end
    #if server
    /**
        Sends the current message to the specified player, or to all players listed in the table.
		
		Name | Description
		--- | ---
		`ply` | The player(s) to send the message to. Can be a table of players or a CRecipientFilter.
    **/
    
    public static function Send(ply:Player):Void;
    #end
    

}


@:multiReturn extern class NetLibBytesWrittenReturn {
var a:Float;
var b:Float;

}
@:multiReturn extern class NetLibBytesLeftReturn {
var a:Float;
var b:Float;

}

