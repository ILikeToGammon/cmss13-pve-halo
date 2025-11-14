/mob/living/simple_animal/hostile/flood/combat_form/human ///mob/living/simple_animal/hostile/flood_combat_form_human
	var/caste_type = FLOOD_CASTE_COMBAT_FORM_HUMAN
	name = FLOOD_CASTE_COMBAT_FORM_HUMAN
	desc = "A grotesque amalgamation of flesh and bone, reanimated and twisted by the Flood parasite."
	icon = 'icons/mob/flood/flood_combat_human.dmi'
	icon_state = "marine_infested"
	icon_living = "marine_infested"
	icon_dead = "marine_dead"
	min_oxy = 0
	max_oxy = 0
	min_n2 = 0
	max_n2 = 0
	min_co2 = 0
	max_co2 = 0
	min_tox = 0
	max_tox = 0
	turns_per_move = 5
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	see_in_dark = 50
	speed = -0.2
	maxHealth = 300
	health = 300
	var/armor_deflection = 15
	harm_intent_damage = 5
	melee_damage_lower = 15
	melee_damage_upper = 25
	attacktext = "slashes"
	a_intent = INTENT_HARM
	attack_sound = 'sound/weapons/flood/melee.melee1.ogg'

	unsuitable_atoms_damage = 15
	wall_smash = 1
	minbodytemp = 0
	heat_damage_per_tick = 20
	stop_automated_movement_when_pulled = TRUE
	break_stuff_probability = 90
	mob_size = 2

	COOLDOWN_DECLARE(swipe_cooldown)
	COOLDOWN_DECLARE(pain_cooldown)

/mob/living/simple_animal/hostile/flood/combat_form/human/FindTarget()
	. = ..()
	if(.)
		emote("swipe")

/mob/living/simple_animal/hostile/flood/combat_form/human/bullet_act(obj/projectile/projectile)
	. = ..()
	if(projectile.damage)
		handle_blood_splatter(get_dir(projectile.starting, src))
		add_splatter_floor(loc, FALSE)
		emote("hurt")
		COOLDOWN_START(src, pain_cooldown, rand(5,10) SECONDS)

/mob/living/simple_animal/hostile/flood/combat_form/human/handle_blood_splatter(splatter_dir)
	var/obj/effect/temp_visual/dir_setting/bloodsplatter/human/bloodsplatter = new(loc, splatter_dir)
	bloodsplatter.pixel_y = 0
