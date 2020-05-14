package gmod.enums;
/**
    Enumerations used by draw.SimpleText, draw.DrawText and in TextData structure.
**/
@:native("_G")
extern enum abstract TEXT_ALIGN(Int) {
    /**
        Align the text on the top
    **/
    var TEXT_ALIGN_TOP;
    /**
        Align the text on the left
    **/
    var TEXT_ALIGN_LEFT;
    /**
        Align the text on the bottom
    **/
    var TEXT_ALIGN_BOTTOM;
    /**
        Align the text on the right
    **/
    var TEXT_ALIGN_RIGHT;
    /**
        Align the text in center
    **/
    var TEXT_ALIGN_CENTER;
    
}