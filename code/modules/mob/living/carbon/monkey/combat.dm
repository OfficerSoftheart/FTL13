
<<<<<<< HEAD
/mob/living/carbon/monkey
	var/aggressive=0 // set to 1 using VV for an angry monkey
	var/frustration=0
	var/pickupTimer=0
=======

/mob/living/carbon/monkey
	var/aggressive=0
	var/frustration=0
	var/pickupTimer=0
	var/vision_range = 9
>>>>>>> master
	var/list/enemies = list()
	var/mob/living/target
	var/obj/item/pickupTarget
	var/mode = MONKEY_IDLE
	var/list/myPath = list()
	var/list/blacklistItems = list()
	var/maxStepsTick = 6
	var/best_force = 0
	var/martial_art = new/datum/martial_art
	var/resisting = FALSE
	var/pickpocketing = FALSE
	var/disposing_body = FALSE
	var/obj/machinery/disposal/bodyDisposal = null
<<<<<<< HEAD
	var/next_battle_screech = 0
	var/battle_screech_cooldown = 50
=======

>>>>>>> master

/mob/living/carbon/monkey/proc/IsStandingStill()
	return resisting || pickpocketing || disposing_body

<<<<<<< HEAD
// blocks
=======
>>>>>>> master
// taken from /mob/living/carbon/human/interactive/
/mob/living/carbon/monkey/proc/walk2derpless(target)
	if(!target || IsStandingStill())
		return 0

	if(myPath.len <= 0)
		myPath = get_path_to(src, get_turf(target), /turf/proc/Distance, MAX_RANGE_FIND + 1, 250,1)

	if(myPath)
		if(myPath.len > 0)
			for(var/i = 0; i < maxStepsTick; ++i)
				if(!IsDeadOrIncap())
					if(myPath.len >= 1)
						walk_to(src,myPath[1],0,5)
						myPath -= myPath[1]
			return 1
<<<<<<< HEAD

	// failed to path correctly so just try to head straight for a bit
	walk_to(src,get_turf(target),0,5)
	sleep(1)
	walk_to(src,0)

=======
>>>>>>> master
	return 0

// taken from /mob/living/carbon/human/interactive/
/mob/living/carbon/monkey/proc/IsDeadOrIncap(checkDead = TRUE)
	if(!canmove)
		return 1
	if(health <= 0 && checkDead)
		return 1
<<<<<<< HEAD
=======
//	if(restrained())
//		return 1
>>>>>>> master
	if(paralysis)
		return 1
	if(stunned)
		return 1
	if(stat)
		return 1
	return 0

<<<<<<< HEAD
/mob/living/carbon/monkey/proc/battle_screech()
	if(next_battle_screech < world.time)
		emote(pick("roar","screech"))
		for(var/mob/living/carbon/monkey/M in view(7,src))
			M.next_battle_screech = world.time + battle_screech_cooldown

=======
>>>>>>> master
/mob/living/carbon/monkey/proc/equip_item(var/obj/item/I)

	if(I.loc == src)
		return TRUE

	if(I.anchored)
		blacklistItems[I] ++
		return FALSE

	// WEAPONS
	if(istype(I, /obj/item/weapon))
		var/obj/item/weapon/W = I
		if(W.force >= best_force)
			put_in_hands(W)
			best_force = W.force
			return TRUE

	// CLOTHING
	else if(istype(I,/obj/item/clothing))
		var/obj/item/clothing/C = I
		monkeyDrop(C)
<<<<<<< HEAD
		addtimer(CALLBACK(src, .proc/pickup_and_wear, C), 5)
=======
		spawn(5)
			if(!equip_to_appropriate_slot(C))
				unEquip(get_item_by_slot(C)) // remove the existing item if worn
				spawn(5)
					equip_to_appropriate_slot(C)
>>>>>>> master
		return TRUE

	// EVERYTHING ELSE
	else
<<<<<<< HEAD
		if(!get_item_for_held_index(1) || !get_item_for_held_index(2))
=======
		if(!locate(/obj/item) in held_items())
>>>>>>> master
			put_in_hands(I)
			return TRUE

	blacklistItems[I] ++
	return FALSE

<<<<<<< HEAD
/mob/living/carbon/monkey/proc/pickup_and_wear(var/obj/item/clothing/C)
	if(!equip_to_appropriate_slot(C))
		monkeyDrop(get_item_by_slot(C)) // remove the existing item if worn
		sleep(5)
		equip_to_appropriate_slot(C)

=======
>>>>>>> master
/mob/living/carbon/monkey/resist_restraints()
	var/obj/item/I = null
	if(handcuffed)
		I = handcuffed
	else if(legcuffed)
		I = legcuffed
	if(I)
		changeNext_move(CLICK_CD_BREAKOUT)
		last_special = world.time + CLICK_CD_BREAKOUT
<<<<<<< HEAD
		cuff_resist(I)

/mob/living/carbon/monkey/proc/should_target(var/mob/living/L)

	if(L == src)
		return 0

	if(enemies[L])
		return 1

	// target non-monkey mobs when aggressive, with a small probability of monkey v monkey
	if(aggressive && (!istype(L, /mob/living/carbon/monkey/) || prob(MONKEY_AGGRESSIVE_MVM_PROB)))
		return 1

	return 0

/mob/living/carbon/monkey/proc/handle_combat()
	// Don't do any AI if inside another mob (devoured)
	if (ismob(loc))
		// Really no idea what needs to be returned but everything else is TRUE
		return TRUE

	if(on_fire || buckled || restrained())
		if(!resisting && prob(MONKEY_RESIST_PROB))
=======
		cuff_resist(I, 900)

/mob/living/carbon/monkey/proc/handle_combat()

	if(on_fire || buckled || restrained())
		if(!resisting && prob(50))
>>>>>>> master
			resisting = TRUE
			walk_to(src,0)
			resist()
	else
		resisting = FALSE


	if(IsDeadOrIncap())
		return TRUE

	// have we been disarmed
<<<<<<< HEAD
	if(!locate(/obj/item/weapon) in held_items)
		best_force = 0

	if(restrained() || blacklistItems[pickupTarget] || (pickupTarget && (pickupTarget.flags & NODROP)))
=======
	if(!locate(/obj/item/weapon) in held_items())
		best_force = 0

	if(restrained() || blacklistItems[pickupTarget])
>>>>>>> master
		pickupTarget = null

	if(!resisting && pickupTarget)
		pickupTimer++

		// next to target
		if(Adjacent(pickupTarget) || Adjacent(pickupTarget.loc))
<<<<<<< HEAD
			INVOKE_ASYNC(src, .proc/walk2derpless, pickupTarget.loc)

			// who cares about these items, i want that one!
			drop_all_held_items()
=======
			walk2derpless(pickupTarget.loc)

			// who cares about these items, i want that one!
			for(var/obj/item/I in held_items())
				if(I)
					monkeyDrop(I)
>>>>>>> master

			// on floor
			if(isturf(pickupTarget.loc))
				equip_item(pickupTarget)
				pickupTarget = null
				pickupTimer = 0

			// in someones hand
			else if(ismob(pickupTarget.loc))
				var/mob/M = pickupTarget.loc
				if(!pickpocketing)
					pickpocketing = TRUE
					M.visible_message("[src] starts trying to take [pickupTarget] from [M]", "[src] tries to take [pickupTarget]!")
<<<<<<< HEAD
					INVOKE_ASYNC(src, .proc/pickpocket, M)
=======
					spawn(5)
						if(do_mob(src, M, 20) && pickupTarget)
							for(var/obj/item/I in M.held_items())
								if(I == pickupTarget)
									M.visible_message("<span class='danger'>[src] snatches [pickupTarget] from [M].</span>", "<span class='userdanger'>[src] snatched [pickupTarget]!</span>")
									M.unEquip(pickupTarget)
									equip_item(pickupTarget)
						pickpocketing = FALSE
						pickupTarget = null
						pickupTimer = 0
>>>>>>> master

		else
			if(pickupTimer >= 8)
				blacklistItems[pickupTarget] ++
				pickupTarget = null
				pickupTimer = 0
			else
<<<<<<< HEAD
				INVOKE_ASYNC(src, .proc/walk2derpless, pickupTarget.loc)
=======
				walk2derpless(pickupTarget.loc)
>>>>>>> master

		return TRUE

	// nuh uh you don't pull me!
<<<<<<< HEAD
	if(pulledby && (mode != MONKEY_IDLE || prob(MONKEY_PULL_AGGRO_PROB)))
		if(Adjacent(pulledby))
			a_intent = INTENT_DISARM
			monkey_attack(pulledby)
			retaliate(pulledby)
			return TRUE

=======
	if(pulledby && (mode != MONKEY_IDLE || prob(5)))
		if(Adjacent(pulledby))
			a_intent = INTENT_DISARM
			pulledby.attack_paw(src)
			retaliate(pulledby)
			return TRUE

	// nrrr, RARRRGH
//	if(buckled)
//		resist_buckle()

>>>>>>> master
	switch(mode)

		if(MONKEY_IDLE)		// idle

<<<<<<< HEAD
			var/list/around = view(src, MONKEY_ENEMY_VISION)
=======
			var/list/around = view(src, vision_range)
>>>>>>> master
			bodyDisposal = locate(/obj/machinery/disposal/) in around

			// scan for enemies
			for(var/mob/living/L in around)
<<<<<<< HEAD
				if( should_target(L) )
					if(L.stat == CONSCIOUS)
						battle_screech()
=======
				if(enemies[L])
					if(L.stat == CONSCIOUS)
						emote(pick("roar","screech"))
>>>>>>> master
						retaliate(L)
						return TRUE
					else if(bodyDisposal)
						target = L
						mode = MONKEY_DISPOSE
						return TRUE

			// pickup any nearby objects
<<<<<<< HEAD
			if(!pickupTarget && prob(MONKEY_PICKUP_PROB))
=======
			if(!pickupTarget && prob(5))
>>>>>>> master
				var/obj/item/I = locate(/obj/item/) in oview(5,src)
				if(I && !blacklistItems[I])
					pickupTarget = I

			// I WANNA STEAL
<<<<<<< HEAD
			if(!pickupTarget && prob(MONKEY_STEAL_PROB))
				var/mob/living/carbon/human/H = locate(/mob/living/carbon/human/) in oview(5,src)
				if(H)
					pickupTarget = pick(H.held_items)
=======
			if(!pickupTarget && prob(5))
				var/mob/living/carbon/human/H = locate(/mob/living/carbon/human/) in oview(5,src)
				if(H)
					pickupTarget = pick(H.held_items())
>>>>>>> master

			// clear any combat walking
			if(!resisting)
				walk_to(src,0)

			return IsStandingStill()

		if(MONKEY_HUNT)		// hunting for attacker
<<<<<<< HEAD
			if(health < MONKEY_FLEE_HEALTH)
=======
			if(health < 50)
>>>>>>> master
				mode = MONKEY_FLEE
				return TRUE

			if(target != null)
<<<<<<< HEAD
				INVOKE_ASYNC(src, .proc/walk2derpless, target)

			// pickup any nearby weapon
			if(!pickupTarget && prob(MONKEY_WEAPON_PROB))
=======
				walk2derpless(target)

			// pickup any nearby weapon
			if(!pickupTarget && prob(20))
>>>>>>> master
				var/obj/item/weapon/W = locate(/obj/item/weapon/) in oview(2,src)
				if(W && !blacklistItems[W] && W.force > best_force)
					pickupTarget = W

			// recruit other monkies
<<<<<<< HEAD
			var/list/around = view(src, MONKEY_ENEMY_VISION)
			for(var/mob/living/carbon/monkey/M in around)
				if(M.mode == MONKEY_IDLE && prob(MONKEY_RECRUIT_PROB))
					M.battle_screech()
=======
			var/list/around = view(src, vision_range)
			for(var/mob/living/carbon/monkey/M in around)
				if(M.mode == MONKEY_IDLE && prob(25))
					M.emote(pick("roar","screech"))
>>>>>>> master
					M.target = target
					M.mode = MONKEY_HUNT

			// switch targets
			for(var/mob/living/L in around)
<<<<<<< HEAD
				if(L != target && should_target(L) && L.stat == CONSCIOUS && prob(MONKEY_SWITCH_TARGET_PROB))
=======
				if(L != target && enemies[L] && L.stat == CONSCIOUS && prob(25))
>>>>>>> master
					target = L
					return TRUE

			// if can't reach target for long enough, go idle
<<<<<<< HEAD
			if(frustration >= MONKEY_HUNT_FRUSTRATION_LIMIT)
=======
			if(frustration >= 8)
>>>>>>> master
				back_to_idle()
				return TRUE

			if(target && target.stat == CONSCIOUS)		// make sure target exists
				if(Adjacent(target) && isturf(target.loc))	// if right next to perp
<<<<<<< HEAD

					// check if target has a weapon
					var/obj/item/weapon/W = locate(/obj/item/weapon) in target.held_items

					// if the target has a weapon, chance to disarm them
					if(W && prob(MONKEY_ATTACK_DISARM_PROB))
						pickupTarget = W
						a_intent = INTENT_DISARM
						monkey_attack(target)

					else
						a_intent = INTENT_HARM
						monkey_attack(target)

=======
					var/obj/item/weapon/Weapon = locate(/obj/item/weapon) in held_items()

					// attack with weapon if we have one
					if(Weapon)

						// if the target has a weapon, 50% change to disarm them
						if((locate(/obj/item/weapon) in target.held_items()) && prob(50))

							pickupTarget = locate(/obj/item/weapon) in target.held_items()

							a_intent = INTENT_DISARM
							target.attackby(Weapon, src)
							attacked(target)

						else
							a_intent = INTENT_HARM
							target.attackby(Weapon, src)
							attacked(target)
					else

						// if the target has a weapon, 50% change to disarm them
						if((locate(/obj/item/weapon) in target.held_items()) && prob(50))

							pickupTarget = locate(/obj/item/weapon) in target.held_items()

							a_intent = INTENT_DISARM
							target.attack_paw(src)
							attacked(target)

						else
							a_intent = INTENT_HARM
							target.attack_paw(src)
							attacked(target)
>>>>>>> master
					return TRUE

				else								// not next to perp
					var/turf/olddist = get_dist(src, target)
					if((get_dist(src, target)) >= (olddist))
						frustration++
					else
						frustration = 0
			else
				back_to_idle()

		if(MONKEY_FLEE)
<<<<<<< HEAD
			var/list/around = view(src, MONKEY_FLEE_VISION)
			target = null

			// flee from anyone who attacked us and we didn't beat down
			for(var/mob/living/L in around)
				if( enemies[L] && L.stat == CONSCIOUS )
					target = L

			if(target != null)
				walk_away(src, target, MONKEY_ENEMY_VISION, 5)
			else
				back_to_idle()
=======
			var/list/around = view(src, vision_range)
			target = null
			for(var/mob/living/carbon/C in around)
				if(enemies[C] && C.stat == CONSCIOUS)
					target = C

			if(target != null)
				walk_away(src, target, vision_range, 5)
			else
				mode = MONKEY_IDLE
>>>>>>> master

			return TRUE

		if(MONKEY_DISPOSE)

			// if can't dispose of body go back to idle
<<<<<<< HEAD
			if(!target || !bodyDisposal || frustration >= MONKEY_DISPOSE_FRUSTRATION_LIMIT)
=======
			if(!target || !bodyDisposal || frustration >= 16)
>>>>>>> master
				back_to_idle()
				return TRUE

			if(target.pulledby != src && !istype(target.pulledby, /mob/living/carbon/monkey/))

<<<<<<< HEAD
				INVOKE_ASYNC(src, .proc/walk2derpless, target.loc)
=======
				walk2derpless(target.loc)
>>>>>>> master

				if(Adjacent(target) && isturf(target.loc))
					a_intent = INTENT_GRAB
					target.grabbedby(src)
				else
					var/turf/olddist = get_dist(src, target)
					if((get_dist(src, target)) >= (olddist))
						frustration++
					else
						frustration = 0

			else if(!disposing_body)
<<<<<<< HEAD
				INVOKE_ASYNC(src, .proc/walk2derpless, bodyDisposal.loc)

				if(Adjacent(bodyDisposal))
					disposing_body = TRUE
					addtimer(CALLBACK(src, .proc/stuff_mob_in), 5)
=======
				walk2derpless(bodyDisposal.loc)

				if(Adjacent(bodyDisposal))
					disposing_body = TRUE
					spawn(5)
						bodyDisposal.stuff_mob_in(target, src)
						disposing_body = FALSE
>>>>>>> master

				else
					var/turf/olddist = get_dist(src, bodyDisposal)
					if((get_dist(src, bodyDisposal)) >= (olddist))
						frustration++
					else
						frustration = 0

			return TRUE



	return IsStandingStill()

<<<<<<< HEAD
/mob/living/carbon/monkey/proc/pickpocket(var/mob/M)
	if(do_mob(src, M, MONKEY_ITEM_SNATCH_DELAY) && pickupTarget)
		for(var/obj/item/I in M.held_items)
			if(I == pickupTarget)
				M.visible_message("<span class='danger'>[src] snatches [pickupTarget] from [M].</span>", "<span class='userdanger'>[src] snatched [pickupTarget]!</span>")
				if(M.temporarilyRemoveItemFromInventory(pickupTarget) && !QDELETED(pickupTarget))
					equip_item(pickupTarget)
				else
					M.visible_message("<span class='danger'>[src] tried to snatch [pickupTarget] from [M], but failed!</span>", "<span class='userdanger'>[src] tried to grab [pickupTarget]!</span>")
	pickpocketing = FALSE
	pickupTarget = null
	pickupTimer = 0

/mob/living/carbon/monkey/proc/stuff_mob_in()
	if(bodyDisposal && target && Adjacent(bodyDisposal))
		bodyDisposal.stuff_mob_in(target, src)
	disposing_body = FALSE
	back_to_idle()

/mob/living/carbon/monkey/proc/back_to_idle()

	if(pulling)
		stop_pulling()

=======
/mob/living/carbon/monkey/proc/back_to_idle()
>>>>>>> master
	mode = MONKEY_IDLE
	target = null
	a_intent = INTENT_HELP
	frustration = 0
<<<<<<< HEAD
	walk_to(src,0)

// attack using a held weapon otherwise bite the enemy, then if we are angry there is a chance we might calm down a little
/mob/living/carbon/monkey/proc/monkey_attack(mob/living/L)
	var/obj/item/weapon/Weapon = locate(/obj/item/weapon) in held_items

	// attack with weapon if we have one
	if(Weapon)
		L.attackby(Weapon, src)
	else
		L.attack_paw(src)

	// no de-aggro
	if(aggressive)
		return

	// if we arn't enemies, we were likely recruited to attack this target, jobs done if we calm down so go back to idle
	if(!enemies[L])
		if( target == L && prob(MONKEY_HATRED_REDUCTION_PROB) )
			back_to_idle()
		return // already de-aggroed

	if(prob(MONKEY_HATRED_REDUCTION_PROB))
		enemies[L] --

	// if we are not angry at our target, go back to idle
	if(enemies[L] <= 0)
		enemies.Remove(L)
		if( target == L )
			back_to_idle()

// get angry are a mob
/mob/living/carbon/monkey/proc/retaliate(mob/living/L)
	mode = MONKEY_HUNT
	target = L
	enemies[L] += MONKEY_HATRED_AMOUNT

	if(a_intent != INTENT_HARM)
		battle_screech()
		a_intent = INTENT_HARM

/mob/living/carbon/monkey/attack_hand(mob/living/L)
	if(L.a_intent == INTENT_HARM && prob(MONKEY_RETALIATE_HARM_PROB))
		retaliate(L)
	else if(L.a_intent == INTENT_DISARM && prob(MONKEY_RETALIATE_DISARM_PROB))
=======

// handle de-aggro
/mob/living/carbon/monkey/proc/attacked(mob/living/carbon/H)
	if(!enemies[H])
		return

	if(prob(25))
		enemies[H] --

	if(enemies[H] <= 0)
		enemies.Remove(H)
		if( target == H )
			back_to_idle()

/mob/living/carbon/monkey/proc/retaliate(mob/living/L)
	mode = MONKEY_HUNT
	target = L
	enemies[L] += 4

	if(a_intent != INTENT_HARM)
		emote(pick("roar","screech"))
		a_intent = INTENT_HARM

/mob/living/carbon/monkey/attack_hand(mob/living/L)
	if(L.a_intent == INTENT_HARM && prob(95))
		retaliate(L)
	else if(L.a_intent == INTENT_DISARM && prob(20))
>>>>>>> master
		retaliate(L)
	return ..()

/mob/living/carbon/monkey/attack_paw(mob/living/L)
<<<<<<< HEAD
	if(L.a_intent == INTENT_HARM && prob(MONKEY_RETALIATE_HARM_PROB))
		retaliate(L)
	else if(L.a_intent == INTENT_DISARM && prob(MONKEY_RETALIATE_DISARM_PROB))
=======
	if(L.a_intent == INTENT_HARM && prob(95))
		retaliate(L)
	else if(L.a_intent == INTENT_DISARM && prob(20))
>>>>>>> master
		retaliate(L)
	return ..()

/mob/living/carbon/monkey/attackby(obj/item/weapon/W, mob/user, params)
	..()
	if((W.force) && (!target) && (W.damtype != STAMINA) )
		retaliate(user)

/mob/living/carbon/monkey/bullet_act(obj/item/projectile/Proj)
	if(istype(Proj ,/obj/item/projectile/beam)||istype(Proj,/obj/item/projectile/bullet))
		if((Proj.damage_type == BURN) || (Proj.damage_type == BRUTE))
			if(!Proj.nodamage && Proj.damage < src.health)
				retaliate(Proj.firer)
	..()

/mob/living/carbon/monkey/hitby(atom/movable/AM, skipcatch = 0, hitpush = 1, blocked = 0)
	if(istype(AM, /obj/item))
		var/obj/item/I = AM
		if(I.throwforce < src.health && I.thrownby && ishuman(I.thrownby))
			var/mob/living/carbon/human/H = I.thrownby
			retaliate(H)
	..()

/mob/living/carbon/monkey/Crossed(atom/movable/AM)
	if(!IsDeadOrIncap() && ismob(AM) && target)
		var/mob/living/carbon/monkey/M = AM
<<<<<<< HEAD
		if(!istype(M) || !M)
			return
		knockOver(M)
		return
	..()

/mob/living/carbon/monkey/proc/monkeyDrop(var/obj/item/A)
	if(A)
		dropItemToGround(A, TRUE)
		update_icons()
=======
		if(!istype(M) || !M || in_range(src, target))
			return
		M.visible_message("<span class='warning'>[pick( \
						  "[M] dives out of [src]'s way!", \
						  "[M] stumbles over [src]!", \
						  "[M] jumps out of [src]'s path!", \
						  "[M] trips over [src] and falls!", \
						  "[M] topples over [src]!", \
						  "[M] leaps out of [src]'s way!")]</span>")
		M.Weaken(2)
		return
	..()

/mob/living/carbon/monkey/proc/take_to_slot(obj/item/G)
	var/list/slots = list ("left hand" = slot_l_hand,"right hand" = slot_r_hand)
	G.loc = src
	if(G.force && G.force > best_force)
		best_force = G.force
	equip_in_one_of_slots(G, slots)
	// update_hands = 1

/mob/living/carbon/monkey/proc/equip_in_one_of_slots(obj/item/I, list/slots, qdel_on_fail = 0)
	for(var/slot in slots)
		if(equip_to_slot_if_possible(I, slots[slot], qdel_on_fail = 0, disable_warning = TRUE))
			return slot
	if(qdel_on_fail)
		qdel(I)
	return null

/mob/living/carbon/monkey/proc/monkeyDrop(var/obj/item/A)
	if(A)
		unEquip(A)
		A.loc = get_turf(src) // drop item works inconsistently
		update_icons()
>>>>>>> master
