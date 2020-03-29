package gmod.structs;
/**
    Table is one element from [team](https://wiki.garrysmod.com/page/Category:team). [GetAllTeams](https://wiki.garrysmod.com/page/team/GetAllTeams).
**/
typedef TeamData = {
    /**
        Color of the team
    **/
    var Color : Color;
    /**
        Whether the team is joinable or not.
    **/
    var Joinable : Bool;
    /**
        Score of the team
    **/
    var Score : Float;
    /**
        Name of the team
    **/
    var Name : String;
    
}
