package gmod.stringtypes;
/**
    Represents an entity class
**/
enum abstract EntityClass<T:Entity>(Dynamic) from String to String {
    public inline function new(name:String) {
        this = name;
    }
}

/**
   A not comprehensive list of entities found in the base gamemode
   Using EntsLib.Create with these will give you the correct class of entity
**/
enum abstract BaseEntities<T:Entity>(EntityClass<T>) to String to EntityClass<T> {
    var npc_zombie:BaseEntities<NPC>;
    var combine_mine:BaseEntities<NPC>;
    var npc_alyx:BaseEntities<NPC>;
    var npc_antlion:BaseEntities<NPC>;
    var npc_antlion_template_maker:BaseEntities<NPC>;
    var npc_antlionguard:BaseEntities<NPC>;
    var npc_barnacle:BaseEntities<NPC>;
    var npc_barney:BaseEntities<NPC>;
    var npc_breen:BaseEntities<NPC>;
    var npc_citizen:BaseEntities<NPC>;
    var npc_combine_camera:BaseEntities<NPC>;
    var npc_combine_s:BaseEntities<NPC>;
    var npc_combinedropship:BaseEntities<NPC>;
    var npc_combinegunship:BaseEntities<NPC>;
    var npc_crabsynth:BaseEntities<NPC>;
    var npc_cranedriver:BaseEntities<NPC>;
    var npc_crow:BaseEntities<NPC>;
    var npc_cscanner:BaseEntities<NPC>;
    var npc_dog:BaseEntities<NPC>;
    var npc_eli:BaseEntities<NPC>;
    var npc_fastzombie:BaseEntities<NPC>;
    var npc_fisherman:BaseEntities<NPC>;
    var npc_gman:BaseEntities<NPC>;
    var npc_headcrab:BaseEntities<NPC>;
    var npc_headcrab_black:BaseEntities<NPC>;
    var npc_headcrab_fast:BaseEntities<NPC>;
    var npc_helicopter:BaseEntities<NPC>;
    var npc_ichthyosaur:BaseEntities<NPC>;
    var npc_kleiner:BaseEntities<NPC>;
    var npc_manhack:BaseEntities<NPC>;
    var npc_metropolice:BaseEntities<NPC>;
    var npc_monk:BaseEntities<NPC>;
    var npc_mortarsynth:BaseEntities<NPC>;
    var npc_mossman:BaseEntities<NPC>;
    var npc_pigeon:BaseEntities<NPC>;
    var npc_poisonzombie:BaseEntities<NPC>;
    var npc_rollermine:BaseEntities<NPC>;
    var npc_seagull:BaseEntities<NPC>;
    var npc_sniper:BaseEntities<NPC>;
    var npc_stalker:BaseEntities<NPC>;
    var npc_strider:BaseEntities<NPC>;
    var npc_turret_ceiling:BaseEntities<NPC>;
    var npc_turret_floor:BaseEntities<NPC>;
    var npc_turret_ground:BaseEntities<NPC>;
    var npc_vortigaunt:BaseEntities<NPC>;
    var npc_zombie_torso:BaseEntities<NPC>;
    var phys_ballsocket:BaseEntities<Entity>;
    var phys_constraint:BaseEntities<Entity>;
    var phys_constraintsystem:BaseEntities<Entity>;
    var phys_convert:BaseEntities<Entity>;
    var phys_hinge:BaseEntities<Entity>;
    var phys_keepupright:BaseEntities<Entity>;
    var phys_lengthconstraint:BaseEntities<Entity>;
    var phys_magnet:BaseEntities<Entity>;
    var phys_motor:BaseEntities<Entity>;
    var phys_pulleyconstraint:BaseEntities<Entity>;
    var phys_ragdollconstraint:BaseEntities<Entity>;
    var phys_ragdollmagnet:BaseEntities<Entity>;
    var phys_slideconstraint:BaseEntities<Entity>;
    var phys_spring:BaseEntities<Entity>;
    var phys_thruster:BaseEntities<Entity>;
    var phys_torque:BaseEntities<Entity>;
    var physics_cannister:BaseEntities<Entity>;
    var weapon_357:BaseEntities<Weapon>;
    var weapon_alyxgun:BaseEntities<Weapon>;
    var weapon_annabelle:BaseEntities<Weapon>;
    var weapon_ar2:BaseEntities<Weapon>;
    var weapon_brickbat:BaseEntities<Weapon>;
    var weapon_bugbait:BaseEntities<Weapon>;
    var weapon_citizenpackage:BaseEntities<Weapon>;
    var weapon_citizensuitcase:BaseEntities<Weapon>;
    var weapon_crossbow:BaseEntities<Weapon>;
    var weapon_crowbar:BaseEntities<Weapon>;
    var weapon_extinguisher:BaseEntities<Weapon>;
    var weapon_frag:BaseEntities<Weapon>;
    var weapon_physcannon:BaseEntities<Weapon>;
    var weapon_physgun:BaseEntities<Weapon>;
    var weapon_pistol:BaseEntities<Weapon>;
    var weapon_rpg:BaseEntities<Weapon>;
    var weapon_shotgun:BaseEntities<Weapon>;
    var weapon_smg1:BaseEntities<Weapon>;
    var weapon_stunstick:BaseEntities<Weapon>;
    var ai_ally_manager:BaseEntities<Entity>;
    var ai_battle_line:BaseEntities<Entity>;
    var ai_changehintgroup:BaseEntities<Entity>;
    var ai_changetarget:BaseEntities<Entity>;
    var ai_citizen_response_system:BaseEntities<Entity>;
    var ai_goal_actbusy:BaseEntities<Entity>;
    var ai_goal_assault:BaseEntities<Entity>;
    var ai_goal_follow:BaseEntities<Entity>;
    var ai_goal_lead:BaseEntities<Entity>;
    var ai_goal_police:BaseEntities<Entity>;
    var ai_goal_standoff:BaseEntities<Entity>;
    var ai_relationship:BaseEntities<Entity>;
    var ai_script_conditions:BaseEntities<Entity>;
    var ai_sound:BaseEntities<Entity>;
    var ai_speechfilter:BaseEntities<Entity>;
    var aiscripted_schedule:BaseEntities<Entity>;
    var assault_assaultpoint:BaseEntities<Entity>;
    var assault_rallypoint:BaseEntities<Entity>;
    var info_apc_missile_hint:BaseEntities<Entity>;
    var info_node:BaseEntities<Entity>;
    var info_node_air:BaseEntities<Entity>;
    var info_node_climb:BaseEntities<Entity>;
    var info_node_hint:BaseEntities<Entity>;
    var info_node_link:BaseEntities<Entity>;
    var info_node_link_controller:BaseEntities<Entity>;
    var info_npc:BaseEntities<Entity>;
    var spawn_destination:BaseEntities<Entity>;
    var info_snipertarget:BaseEntities<Entity>;
    var logic_choreographed_scene:BaseEntities<Entity>;
    var path_corner:BaseEntities<Entity>;
    var path_corner_crash:BaseEntities<Entity>;
    var path_track:BaseEntities<Entity>;
    var scripted_scene:BaseEntities<Entity>;
    var scripted_sentence:BaseEntities<Entity>;
    var scripted_sequence:BaseEntities<Entity>;
    var scripted_target:BaseEntities<Entity>;
    var tanktrain_aitarget:BaseEntities<Entity>;
    var tanktrain_ai:BaseEntities<Entity>;
}
