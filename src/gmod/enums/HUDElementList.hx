package gmod.enums;

#if client
enum abstract HUDElementList(String) from String to String {
	/**
		Primary ammo counter.
	**/
	var CHudAmmo;
	/**
		The armor meter. This is only called if players armor is above 0.
	**/
	var CHudBattery;
	/**
		The default chat box. Hiding this element will cause players view angles to snap to a random angle when they try to open the chat.
	**/
	var CHudChat;
	/**
		The default SWEP and HL2 weapon crosshair.
	**/
	var CHudCrosshair;
	/**
		Close captions
	**/
	var CHudCloseCaption;
	/**
 		The damage indicator from Half-Life 2, active only when visible.
	**/
	var CHudDamageIndicator;
	/**
        The death notice panel.

		This will not do anything in Garry's Mod because the kill feed is painted in Lua.
	**/
	var CHudDeathNotice;

	/**
		Geiger counter from Half-Life 2. Only active when the sound plays. Hiding this stops the sound.
	**/
	var CHudGeiger;
	/**
 		The GetHUDPanel. Hiding this will hide anything rendered with GM:HUDPaint, GM:HUDPaintBackground and GM:HUDDrawScoreBoard
	**/
	var CHudGMod;

	/**
		The health meter.
	**/
	var CHudHealth;
	/**
 		The key hint display? Disabled in Garry's Mod by default
	**/
	var CHudHintDisplay;
	/**
		The main menu.

		Hiding this will cause the player to not be able to open their main menu or console.
	**/
	var CHudMenu;
	/**

	**/
	var CHudMessage;
	/**
		The "Neurotoxin Detected" HUD above Health when you get hit by a poison headcrab.
	**/
	var CHudPoisonDamageIndicator;
	/**
		Secondary ammo counter ( SMG1 grenades, AR2 energy balls )
	**/
	var CHudSecondaryAmmo;
	/**
		Citizen Squad status HUD from Half-Life 2. Only called if citizens follow you.
	**/
	var CHudSquadStatus;
	/**
		Possibly the controls HUD for controllable func_tracktrain.
	**/
	var CHudTrain;
	/**
		Crosshair for jeep and airboat when gun is mounted.
	**/
	var CHudVehicle;
	/**

	**/
	var CHudWeapon;
	/**
		The weapon selection panel.

		Hiding this will also disable capability to switch weapons for the client.
	**/
	var CHudWeaponSelection;

	/**
		Suit zoom from Half-Life 2.

		Only called if visible ( +zoom bind ). Hiding this does not prevent zooming.
	**/
	var CHudZoom;

	/**
		The netgraph. Only works if net_graph convar is above 0
	**/
	var NetGraph;
	/**
		Health and ammo near crosshair. Only works if hud_quickinfo convar is above 0
	**/
	var CHUDQuickInfo;
	/**
		HEV Suit power.
	**/
	var CHudSuitPower;
}
#end
