package gmod.gclass;


/**
    An object returned by util.Stack. 
	
	Like a Lua table, a Stack is a container. It follows the principle of LIFO (last in, first out). 
	
	 The Stack works like a stack of papers: the first page you put down (push) will be the last one you remove (pop). That also means that the last page you put down, will be the first to be removed.
**/
extern class Stack {
    
    /**
        Get the item at the top of the stack
		
		`**Returns:** The item at the top of the stack
    **/
    
    public function Top():Dynamic;
    
    
    /**
        Pop an item from the stack
		
		Name | Description
		--- | ---
		`amount` | Amount of items you want to pop.
    **/
    
    public function Pop(?amount:Float):Void;
    
    
    /**
        Push an item onto the stack
		
		Name | Description
		--- | ---
		`object` | The item you want to push
    **/
    
    public function Push(object:Dynamic):Void;
    
    
    /**
        Returns the size of the stack
		
		`**Returns:** The size of the stack
    **/
    
    public function Size():Float;
    
    
}



