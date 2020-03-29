package gmod.libs;


/**
    The http library allows either the server or client to communicate with external websites via HTTP, both GET (http.Fetch) and POST (http.Post) are supported. A more powerful & advanced method can be used via the global HTTP function.
**/
@:native("_G.http")extern class HttpLib {
    
    /**
        Launches a GET request.
		
		Name | Description
		--- | ---
		`url` | The URL of the website to fetch.
		`onSuccess` | Function to be called on success. Arguments are string body string size - equal to string.len(body) table headers number code - The HTTP success code
		`onFailure` | Function to be called on failure. Arguments are string error - The error message
		`headers` | KeyValue table for headers
		
		
		___
		### Lua Examples
		#### Example 1
		Shows the typical usage to get the HTML of a webpage.
		
		```lua 
		local TheReturnedHTML = "" -- Blankness
		
		http.Fetch( "http://www.google.com",
		    function( body, len, headers, code )
		        -- The first argument is the HTML we asked for.
		        TheReturnedHTML = body
		    end,
		    function( error )
		        -- We failed. =(
		    end
		)
		```
		**Output:**
		
		If it successfully fetched the page, the variable 'TheReturnedHTML' should contain the returned HTML in plain text.
    **/
    
    public static function Fetch(url:String, ?onSuccess:Function, ?onFailure:Function, ?headers:AnyTable):Void;
    
    
    /**
        Sends an asynchronous POST request to a HTTP server. 
		
		HTTP requests returning a status code >= 400 are still considered a success and will call the onSuccess callback. 
		
		 The onFailure callback is usually only called on DNS or TCP errors (e.g. the website is unavailable or the domain does not exist)
		
		Name | Description
		--- | ---
		`url` | The url to of the website to fetch.
		`parameters` | The post parameters to be send to the server. Keys and values must be strings.
		`onSuccess` | The function called on success: function( string responseText, number contentLength, table responseHeaders, number statusCode )
		`onFailure` | The function called on failure: function( string errorMessage )
		`headers` | KeyValue table for headers
		
		
		___
		### Lua Examples
		#### Example 1
		Write a file in PHP, and invoke it from Lua. The output below is written in the file, not in the console.
		
		```lua 
		<?php
		    $p = $_POST["p"];
		    $a = $_POST["a"];
		
		    $f = fopen("write.html", "w");
		
		    fwrite($f, "This is a test. $p $a\n");
		
		    fclose($f);
		?>
		```
    **/
    
    public static function Post(url:String, parameters:AnyTable, ?onSuccess:Function, ?onFailure:Function, ?headers:AnyTable):Void;
    
    

}



