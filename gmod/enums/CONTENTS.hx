package gmod.enums;
/**
    Enumerations used by util.PointContents and as tracer masks.
**/
@:native("_G")
extern enum abstract CONTENTS(Int) {
    /**
        Hitbox
    **/
    var CONTENTS_HITBOX;
    /**
        
    **/
    var CONTENTS_MONSTERCLIP;
    /**
        Last visible contents enumeration
    **/
    var LAST_VISIBLE_CONTENTS;
    /**
        
    **/
    var CONTENTS_CURRENT_DOWN;
    /**
        Glass
    **/
    var CONTENTS_WINDOW;
    /**
        
    **/
    var CONTENTS_TEAM4;
    /**
        Things that block light
    **/
    var CONTENTS_OPAQUE;
    /**
        Hits world but not skybox
    **/
    var CONTENTS_TRANSLUCENT;
    /**
        
    **/
    var CONTENTS_TEAM3;
    /**
        
    **/
    var CONTENTS_ORIGIN;
    /**
        
    **/
    var CONTENTS_TESTFOGVOLUME;
    /**
        
    **/
    var CONTENTS_SLIME;
    /**
        
    **/
    var CONTENTS_AUX;
    /**
        Hits world but not skybox
    **/
    var CONTENTS_WATER;
    /**
        
    **/
    var CONTENTS_IGNORE_NODRAW_OPAQUE;
    /**
        
    **/
    var CONTENTS_MOVEABLE;
    /**
        
    **/
    var CONTENTS_AREAPORTAL;
    /**
        Sum of all the visible contents enumerations
    **/
    var ALL_VISIBLE_CONTENTS;
    /**
        Things that are not solid
    **/
    var CONTENTS_EMPTY;
    /**
        Bullets go through, solids don't
    **/
    var CONTENTS_GRATE;
    /**
        NPCs
    **/
    var CONTENTS_MONSTER;
    /**
        Things that are solid
    **/
    var CONTENTS_SOLID;
    /**
        Things that block line of sight
    **/
    var CONTENTS_BLOCKLOS;
    /**
        
    **/
    var CONTENTS_CURRENT_90;
    /**
        
    **/
    var CONTENTS_TEAM1;
    /**
        Ladder
    **/
    var CONTENTS_LADDER;
    /**
        
    **/
    var CONTENTS_TEAM2;
    /**
        
    **/
    var CONTENTS_CURRENT_0;
    /**
        
    **/
    var CONTENTS_DETAIL;
    /**
        
    **/
    var CONTENTS_CURRENT_UP;
    /**
        
    **/
    var CONTENTS_CURRENT_180;
    /**
        
    **/
    var CONTENTS_DEBRIS;
    /**
        
    **/
    var CONTENTS_CURRENT_270;
    /**
        
    **/
    var CONTENTS_PLAYERCLIP;
    
}