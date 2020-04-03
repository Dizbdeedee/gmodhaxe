package gmod.enums;
/**
    Enumerations used by NPC:Classify.
**/
@:native("_G")
extern enum abstract CLASS(Int) {
    /**
        HL2 flares - env_flare.
    **/
    var CLASS_FLARE;
    /**
        HL2 metro police - npc_metropolice and npc_vehicledriver.
    **/
    var CLASS_METROPOLICE;
    /**
        HL2 bullseyes - npc_bullseye.
    **/
    var CLASS_BULLSEYE;
    /**
        HL:S turrets - monster_turret, monster_miniturret, monster_sentry.
    **/
    var CLASS_MACHINE;
    /**
        HL:S friendly humans - monster_scientist.
    **/
    var CLASS_HUMAN_PASSIVE;
    /**
        HL:S insects - montser_roach and monster_leech.
    **/
    var CLASS_INSECT;
    /**
        HL2 manhacks - hostile npc_manhack not held by the gravity gun.
    **/
    var CLASS_MANHACK;
    /**
        HL2 player allies - monster_barney, npc_citizen, hacked npc_manhack, and friendly npc_turret_floor.
    **/
    var CLASS_PLAYER_ALLY;
    /**
        HL:S human military - monster_human_grunt and monster_apache.
    **/
    var CLASS_HUMAN_MILITARY;
    /**
        HL2 snipers - npc_sniper and proto_sniper.
    **/
    var CLASS_PROTOSNIPER;
    /**
        HL:S alien military - monster_alien_controller, monster_vortigaunt, monster_alien_grunt, monster_nihilanth, and monster_snark if it has an enemy of class CLASS_PLAYER, CLASS_HUMAN_PASSIVE, or CLASS_HUMAN_MILITARY.
    **/
    var CLASS_ALIEN_MILITARY;
    /**
        HL2 vital player allies - npc_magnusson, npc_gman, npc_fisherman, npc_eli, npc_barney, npc_kleiner, npc_mossman, npc_alyx, npc_monk, npc_dog, and npc_vortigaunt at the end of EP2 (controlled by "MakeGameEndAlly" input).
    **/
    var CLASS_PLAYER_ALLY_VITAL;
    /**
        HL:S enemy bioweapons - hornet fired by anyone but a player, or monster_snark with no enemy or an enemy without the class CLASS_PLAYER, CLASS_HUMAN_PASSIVE, or CLASS_HUMAN_MILITARY.
    **/
    var CLASS_ALIEN_BIOWEAPON;
    /**
        None - default class for entities.
    **/
    var CLASS_NONE;
    /**
        HL2 antlions - npc_antlion, npc_antlionguard, and npc_ichthyosaur.
    **/
    var CLASS_ANTLION;
    /**
        HL2 headcrabs - visible npc_headcrab.
    **/
    var CLASS_HEADCRAB;
    /**
        HL2 vortigaunts - npc_vortigaunt before the end of EP2 (controlled by "MakeGameEndAlly" input).
    **/
    var CLASS_VORTIGAUNT;
    /**
        HL:S headcrabs - monster_headcrab.
    **/
    var CLASS_ALIEN_PREY;
    /**
        HL2 barnacles - npc_barnacle.
    **/
    var CLASS_BARNACLE;
    /**
        HL2 unused.
    **/
    var CLASS_CITIZEN_REBEL;
    /**
        HL2 combine scanners - npc_cscanner and npc_clawscanner.
    **/
    var CLASS_SCANNER;
    /**
        HL2 friendly rollermines - hacked npc_rollermine.
    **/
    var CLASS_HACKED_ROLLERMINE;
    /**
        HL:S monsters - monster_tentacle, monster_barnacle, monster_zombie, monster_gargantua, monster_houndeye, monster_ichthyosaur, and monster_bigmomma.
    **/
    var CLASS_ALIEN_MONSTER;
    /**
        HL2 stalkers - npc_stalker.
    **/
    var CLASS_STALKER;
    /**
        HL2 animals - npc_crow, npc_seagull, and npc_pigeon.
    **/
    var CLASS_EARTH_FAUNA;
    /**
        HL2 missiles - rpg_missile, apc_missile, and grenade_pathfollower.
    **/
    var CLASS_MISSILE;
    /**
        HL2 passive/non-rebel citizens - npc_citizen in the beginning of HL2.
    **/
    var CLASS_CITIZEN_PASSIVE;
    /**
        HL:S alien predators - monster_bullsquid, xen_tree, and xen_hull.
    **/
    var CLASS_ALIEN_PREDATOR;
    /**
        HL2 zombies - unslumped npc_zombie, npc_poisonzombie, npc_fastzombie, npc_fastzombie_torso, and npc_zombine.
    **/
    var CLASS_ZOMBIE;
    /**
        Players.
    **/
    var CLASS_PLAYER;
    /**
        HL2 hunters - npc_hunter.
    **/
    var CLASS_COMBINE_HUNTER;
    /**
        HL2 combine military objects - func_guntarget, npc_spotlight, and active npc_combine_camera.
    **/
    var CLASS_MILITARY;
    /**
        HL2 unused.
    **/
    var CLASS_CONSCRIPT;
    /**
        HL2 combine troops - npc_combine, npc_advisor, apc_missile, npc_apcdriver, hostile npc_turret_floor, hostile npc_rollermine, npc_turret_ground when active, npc_turret_ceiling when active, and npc_strider when active (not being carried by the gunship).
    **/
    var CLASS_COMBINE;
    /**
        HL:S player bioweapons - hornet fired by a player.
    **/
    var CLASS_PLAYER_BIOWEAPON;
    /**
        HL2 combine aircrafts - npc_combinegunship, npc_combinedropship, and npc_helicopter.
    **/
    var CLASS_COMBINE_GUNSHIP;
    
}