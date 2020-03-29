package gmod.enums;
/**
    Encompasses the range of KEY_ Enums, MOUSE_ Enums and JOYSTICK_ Enums, all of which can be used by:
**/
@:native("_G")
extern enum abstract BUTTON_CODE(Int) {
    /**
        
    **/
    var KEY_ESCAPE;
    /**
        
    **/
    var KEY_XBUTTON_Y;
    /**
        
    **/
    var KEY_F11;
    /**
        
    **/
    var KEY_RCONTROL;
    /**
        Joystick POV buttons are in this range, but don't have individual enum names.
    **/
    var JOYSTICK_FIRST_POV_BUTTON;
    /**
        
    **/
    var KEY_F12;
    /**
        Mouse 4 button ( Sometimes, mouse wheel tilt left )
    **/
    var MOUSE_4;
    /**
        
    **/
    var KEY_COUNT;
    /**
        
    **/
    var KEY_CAPSLOCK;
    /**
        
    **/
    var KEY_I;
    /**
        
    **/
    var BUTTON_CODE_NONE;
    /**
        
    **/
    var KEY_XBUTTON_START;
    /**
        
    **/
    var JOYSTICK_FIRST;
    /**
        Mouse 5 button ( Sometimes, mouse wheel tilt right )
    **/
    var MOUSE_5;
    /**
        
    **/
    var KEY_G;
    /**
        
    **/
    var KEY_XBUTTON_RTRIGGER;
    /**
        Normal number 8 key
    **/
    var KEY_8;
    /**
        The right Windows key or the Command key on Mac OSX
    **/
    var KEY_RWIN;
    /**
        Keypad dot key (.)
    **/
    var KEY_PAD_DECIMAL;
    /**
        
    **/
    var KEY_F10;
    /**
        
    **/
    var KEY_J;
    /**
        
    **/
    var KEY_BACKQUOTE;
    /**
        The left Windows key or the Command key on Mac OSX
    **/
    var KEY_LWIN;
    /**
        
    **/
    var KEY_XBUTTON_RIGHT;
    /**
        
    **/
    var JOYSTICK_LAST_BUTTON;
    /**
        
    **/
    var KEY_XBUTTON_BACK;
    /**
        
    **/
    var KEY_END;
    /**
        
    **/
    var KEY_FIRST;
    /**
        
    **/
    var KEY_F;
    /**
        
    **/
    var KEY_SCROLLLOCK;
    /**
        
    **/
    var KEY_U;
    /**
        
    **/
    var BUTTON_CODE_COUNT;
    /**
        Normal number 3 key
    **/
    var KEY_3;
    /**
        
    **/
    var KEY_SPACE;
    /**
        Keypad division/slash key (/)
    **/
    var KEY_PAD_DIVIDE;
    /**
        
    **/
    var KEY_XSTICK1_DOWN;
    /**
        
    **/
    var KEY_RBRACKET;
    /**
        Normal number 7 key
    **/
    var KEY_7;
    /**
        
    **/
    var KEY_ENTER;
    /**
        
    **/
    var KEY_PERIOD;
    /**
        
    **/
    var KEY_Z;
    /**
        
    **/
    var KEY_XSTICK1_RIGHT;
    /**
        
    **/
    var BUTTON_CODE_LAST;
    /**
        
    **/
    var KEY_XBUTTON_B;
    /**
        
    **/
    var KEY_XSTICK1_UP;
    /**
        
    **/
    var KEY_NUMLOCK;
    /**
        
    **/
    var KEY_LEFT;
    /**
        
    **/
    var KEY_XSTICK1_LEFT;
    /**
        Keypad number 6 key
    **/
    var KEY_PAD_6;
    /**
        
    **/
    var KEY_BACKSPACE;
    /**
        
    **/
    var KEY_DELETE;
    /**
        Joystick axis buttons are in this range, but don't have individual enum names.
    **/
    var JOYSTICK_FIRST_AXIS_BUTTON;
    /**
        
    **/
    var KEY_Y;
    /**
        Normal number 1 key
    **/
    var KEY_1;
    /**
        
    **/
    var KEY_XBUTTON_LEFT;
    /**
        
    **/
    var KEY_XSTICK2_RIGHT;
    /**
        Normal number 6 key
    **/
    var KEY_6;
    /**
        
    **/
    var KEY_SLASH;
    /**
        
    **/
    var KEY_F5;
    /**
        
    **/
    var KEY_XBUTTON_A;
    /**
        
    **/
    var KEY_L;
    /**
        
    **/
    var KEY_SEMICOLON;
    /**
        
    **/
    var KEY_R;
    /**
        
    **/
    var KEY_LCONTROL;
    /**
        Mouse button count
    **/
    var MOUSE_COUNT;
    /**
        
    **/
    var KEY_P;
    /**
        Normal number 5 key
    **/
    var KEY_5;
    /**
        
    **/
    var KEY_XSTICK2_DOWN;
    /**
        
    **/
    var KEY_TAB;
    /**
        
    **/
    var KEY_C;
    /**
        
    **/
    var KEY_RIGHT;
    /**
        
    **/
    var KEY_UP;
    /**
        
    **/
    var KEY_XBUTTON_X;
    /**
        
    **/
    var KEY_F2;
    /**
        
    **/
    var KEY_HOME;
    /**
        
    **/
    var KEY_E;
    /**
        
    **/
    var KEY_MINUS;
    /**
        
    **/
    var KEY_D;
    /**
        
    **/
    var KEY_LAST;
    /**
        Keypad number 9 key
    **/
    var KEY_PAD_9;
    /**
        
    **/
    var KEY_O;
    /**
        The left Shift key, has been seen to be triggered by Right Shift in [PANEL](https://wiki.garrysmod.com/page/Category:PANEL_Hooks):[OnKeyCodePressed](https://wiki.garrysmod.com/page/PANEL/OnKeyCodePressed)
    **/
    var KEY_LSHIFT;
    /**
        
    **/
    var KEY_RALT;
    /**
        Keypad number 8 key
    **/
    var KEY_PAD_8;
    /**
        
    **/
    var KEY_M;
    /**
        
    **/
    var JOYSTICK_LAST;
    /**
        Keypad minus key
    **/
    var KEY_PAD_MINUS;
    /**
        
    **/
    var KEY_F9;
    /**
        
    **/
    var KEY_XBUTTON_STICK2;
    /**
        
    **/
    var KEY_V;
    /**
        
    **/
    var KEY_F7;
    /**
        Normal number 0 key
    **/
    var KEY_0;
    /**
        
    **/
    var KEY_DOWN;
    /**
        
    **/
    var KEY_XBUTTON_LTRIGGER;
    /**
        
    **/
    var KEY_K;
    /**
        
    **/
    var KEY_APOSTROPHE;
    /**
        Keypad number 3 key
    **/
    var KEY_PAD_3;
    /**
        Mouse wheel scroll down
    **/
    var MOUSE_WHEEL_DOWN;
    /**
        
    **/
    var KEY_F8;
    /**
        First mouse button
    **/
    var MOUSE_FIRST;
    /**
        Keypad number 7 key
    **/
    var KEY_PAD_7;
    /**
        
    **/
    var KEY_PAGEDOWN;
    /**
        Normal number 9 key
    **/
    var KEY_9;
    /**
        
    **/
    var KEY_BACKSLASH;
    /**
        Middle mouse button, aka the wheel press
    **/
    var MOUSE_MIDDLE;
    /**
        Left mouse button
    **/
    var MOUSE_LEFT;
    /**
        
    **/
    var KEY_H;
    /**
        
    **/
    var KEY_XBUTTON_STICK1;
    /**
        
    **/
    var KEY_NONE;
    /**
        Normal number 2 key
    **/
    var KEY_2;
    /**
        Keypad plus key
    **/
    var KEY_PAD_PLUS;
    /**
        
    **/
    var KEY_SCROLLLOCKTOGGLE;
    /**
        
    **/
    var JOYSTICK_LAST_POV_BUTTON;
    /**
        Last mouse button
    **/
    var MOUSE_LAST;
    /**
        
    **/
    var KEY_B;
    /**
        
    **/
    var KEY_APP;
    /**
        Keypad number 2 key
    **/
    var KEY_PAD_2;
    /**
        
    **/
    var KEY_XBUTTON_DOWN;
    /**
        
    **/
    var KEY_A;
    /**
        Keypad enter key
    **/
    var KEY_PAD_ENTER;
    /**
        
    **/
    var KEY_XSTICK2_LEFT;
    /**
        Keypad number 1 key
    **/
    var KEY_PAD_1;
    /**
        
    **/
    var BUTTON_CODE_INVALID;
    /**
        Keypad number 0 key
    **/
    var KEY_PAD_0;
    /**
        
    **/
    var KEY_T;
    /**
        Right mouse button
    **/
    var MOUSE_RIGHT;
    /**
        Keypad asterisk key (*)
    **/
    var KEY_PAD_MULTIPLY;
    /**
        
    **/
    var KEY_X;
    /**
        Mouse wheel scroll up
    **/
    var MOUSE_WHEEL_UP;
    /**
        
    **/
    var KEY_PAGEUP;
    /**
        
    **/
    var KEY_LBRACKET;
    /**
        
    **/
    var KEY_EQUAL;
    /**
        Joystick buttons are in this range, but don't have individual enum names.
    **/
    var JOYSTICK_FIRST_BUTTON;
    /**
        
    **/
    var KEY_INSERT;
    /**
        
    **/
    var KEY_XSTICK2_UP;
    /**
        
    **/
    var KEY_XBUTTON_UP;
    /**
        
    **/
    var KEY_COMMA;
    /**
        
    **/
    var KEY_RSHIFT;
    /**
        
    **/
    var KEY_Q;
    /**
        Keypad number 5 key
    **/
    var KEY_PAD_5;
    /**
        
    **/
    var JOYSTICK_LAST_AXIS_BUTTON;
    /**
        
    **/
    var KEY_CAPSLOCKTOGGLE;
    /**
        
    **/
    var KEY_F6;
    /**
        
    **/
    var KEY_BREAK;
    /**
        
    **/
    var KEY_F3;
    /**
        
    **/
    var KEY_XBUTTON_RIGHT_SHOULDER;
    /**
        Normal number 4 key
    **/
    var KEY_4;
    /**
        
    **/
    var KEY_LALT;
    /**
        
    **/
    var KEY_NUMLOCKTOGGLE;
    /**
        Keypad number 4 key
    **/
    var KEY_PAD_4;
    /**
        
    **/
    var KEY_F4;
    /**
        
    **/
    var KEY_S;
    /**
        
    **/
    var KEY_F1;
    /**
        
    **/
    var KEY_N;
    /**
        
    **/
    var KEY_W;
    /**
        
    **/
    var KEY_XBUTTON_LEFT_SHOULDER;
    
}