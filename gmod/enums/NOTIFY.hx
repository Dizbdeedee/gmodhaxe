package gmod.enums;
/**
    Enumerations used by notification.AddLegacy. Clientside only.
**/
@:native("_G")
extern enum abstract NOTIFY(Int) {
    /**
        [](https://wiki.garrysmod.com/page/File:NOTIFY_HINT_PREVIEW.png) Hint notification
    **/
    var NOTIFY_HINT;
    /**
        [](https://wiki.garrysmod.com/page/File:NOTIFY_UNDO_PREVIEW.png) Undo notification
    **/
    var NOTIFY_UNDO;
    /**
        [](https://wiki.garrysmod.com/page/File:NOTIFY_GENERIC_PREVIEW.png) Generic notification
    **/
    var NOTIFY_GENERIC;
    /**
        [](https://wiki.garrysmod.com/page/File:NOTIFY_CLEANUP_PREVIEW.png) Cleanup notification
    **/
    var NOTIFY_CLEANUP;
    /**
        [](https://wiki.garrysmod.com/page/File:NOTIFY_ERROR_PREVIEW.png) Error notification
    **/
    var NOTIFY_ERROR;
    
}