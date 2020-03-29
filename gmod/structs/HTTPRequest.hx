package gmod.structs;
/**
    Table used by [HTTP](https://wiki.garrysmod.com/page/Global/HTTP) function.
**/
typedef HTTPRequest = {
    /**
        KeyValue table for parameters. This is only applicable to the following request methods:
    **/
    var parameters : AnyTable;
    /**
        Function to be called on failure. Arguments are
    **/
    var failed : Function;
    /**
        Function to be called on success. Arguments are
    **/
    var success : Function;
    /**
        The target url
    **/
    var url : String;
    /**
        Request method, case insensitive. Possible values are:
    **/
    var method : String;
    /**
        KeyValue table for headers
    **/
    var headers : AnyTable;
    /**
        Body string for POST data. If set, will override parameters
    **/
    var body : String;
    /**
        Content type for body. 
		
		Default: "text/plain; charset=utf-8"
    **/
    var ?type : String;
    
}
