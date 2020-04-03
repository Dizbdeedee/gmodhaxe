package gmod.structs;
/**
    Table returned by [os](https://wiki.garrysmod.com/page/Category:os). [date](https://wiki.garrysmod.com/page/os/date) and used by [os](https://wiki.garrysmod.com/page/Category:os). [time](https://wiki.garrysmod.com/page/os/time).
**/
typedef DateData = {
    /**
        Year
    **/
    var year : Float;
    /**
        Day of the year
    **/
    var yday : Float;
    /**
        Daylight saving enabled
    **/
    var isdst : Bool;
    /**
        Minute
    **/
    var min : Float;
    /**
        Day of the month
    **/
    var day : Float;
    /**
        Second
    **/
    var sec : Float;
    /**
        Month January: 1, December: 12
    **/
    var month : Float;
    /**
        Hour
    **/
    var hour : Float;
    /**
        Day of the week Sunday: 1, Saturday: 7
    **/
    var wday : Float;
    
}
