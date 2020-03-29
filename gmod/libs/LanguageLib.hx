package gmod.libs;
#if client

/**
    The language library is used for translation.
**/
@:native("_G.language")extern class LanguageLib {
    
    /**
        Adds a language item. Language placeholders preceded with "#" are replaced with full text in Garry's Mod once registered with this function.
		
		Name | Description
		--- | ---
		`placeholder` | The key for this phrase, without the preceding "#".
		`fulltext` | The phrase that should be displayed whenever this key is used.
		
		
		___
		### Lua Examples
		#### Example 1
		Small excerpt from a STOOL named cooltool. It has been registered as cooltool.
		
		```lua 
		language.Add("Tool_cooltool_name", "The really cool tool")
		language.Add("Tool_cooltool_desc", "Do some random cool stuff.")
		language.Add("Tool_cooltool_0", "Left-click: Cool Stuff. Right-click: Nothing.")
		language.Add("Undone_cooltool", "Cool stuff has been undone.")
		```
		**Output:**
		
		When the player presses undo, "Cool stuff has been undone" will be shown. The cooltool's name will be "The really cool tool". Below that, where the description is shown, "Do some random cool stuff." will be shown. Below that, where the instructions or additional notes for the tool are shown, it will display "Left-click: Cool Stuff. Right-click: Nothing.".
    **/
    
    public static function Add(placeholder:String, fulltext:String):Void;
    
    
    /**
        Retrieves the translated version of inputted string. Useful for concentrating multiple translated strings.
		
		Name | Description
		--- | ---
		`phrase` | The phrase to translate
		
		
		`**Returns:** The translated phrase, or the input string if no translation was found
		
		___
		### Lua Examples
		#### Example 1
		An example on usage of this function.
		
		```lua 
		print( "Our phrase is: " .. language.GetPhrase( "limit_physgun" ) )
		```
		**Output:**
		
		Our phrase is: Limited Physgun
    **/
    
    public static function GetPhrase(phrase:String):String;
    
    

}



#end