<<<<<<< HEAD
/datum/emote/slime
	mob_type_allowed_typecache = /mob/living/simple_animal/slime
	mob_type_blacklist_typecache = list()

/datum/emote/slime/bounce
	key = "bounce"
	key_third_person = "bounces"
	message = "bounces in place."

/datum/emote/slime/jiggle
	key = "jiggle"
	key_third_person = "jiggles"
	message = "jiggles!"

/datum/emote/slime/light
	key = "light"
	key_third_person = "lights"
	message = "lights up for a bit, then stops."

/datum/emote/slime/vibrate
	key = "vibrate"
	key_third_person = "vibrates"
	message = "vibrates!"

/datum/emote/slime/mood
	key = "moodnone"
	var/mood = null

/datum/emote/slime/mood/run_emote(mob/user, params)
	. = ..()
	var/mob/living/simple_animal/slime/S = user
	S.mood = mood
	S.regenerate_icons()

/datum/emote/slime/mood/sneaky
	key = "moodsneaky"
	mood = "mischevous"

/datum/emote/slime/mood/smile
	key = "moodsmile"
	mood = ":3"

/datum/emote/slime/mood/cat
	key = "moodcat"
	mood = ":33"

/datum/emote/slime/mood/pout
	key = "moodpout"
	mood = "pout"

/datum/emote/slime/mood/sad
	key = "moodsad"
	mood = "sad"

/datum/emote/slime/mood/angry
	key = "moodangry"
	mood = "angry"
=======
/mob/living/simple_animal/slime/emote(act)
	if(stat)
		return

	if (findtext(act, "-", 1, null))
		var/t1 = findtext(act, "-", 1, null)
		//param = copytext(act, t1 + 1, length(act) + 1)
		act = copytext(act, 1, t1)


	var/m_type = 1
	var/regenerate_icons
	var/message

	switch(act) //Alphabetical please
		if("bounce","bounces")
			message = "<B>The [src.name]</B> bounces in place."
			m_type = 1

		if("jiggle","jiggles")
			message = "<B>The [src.name]</B> jiggles!"
			m_type = 1

		if("light","lights")
			message = "<B>The [src.name]</B> lights up for a bit, then stops."
			m_type = 1

		if("moan","moans")
			message = "<B>The [src.name]</B> moans."
			m_type = 2

		if("shiver","shivers")
			message = "<B>The [src.name]</B> shivers."
			m_type = 2

		if("sway","sways")
			message = "<B>The [src.name]</B> sways around dizzily."
			m_type = 1

		if("twitch","twitches")
			message = "<B>The [src.name]</B> twitches."
			m_type = 1

		if("vibrate","vibrates")
			message = "<B>The [src.name]</B> vibrates!"
			m_type = 1

		if("noface") //mfw I have no face
			mood = null
			regenerate_icons = 1

		if("smile","smiles")
			mood = "mischevous"
			regenerate_icons = 1

		if(":3")
			mood = ":33"
			regenerate_icons = 1

		if("pout","pouts")
			mood = "pout"
			regenerate_icons = 1

		if("frown","frowns")
			mood = "sad"
			regenerate_icons = 1

		if("scowl","scowls")
			mood = "angry"
			regenerate_icons = 1

		if ("help") //This is an exception
			to_chat(src, "Help for slime emotes. You can use these emotes with say \"*emote\":\n\nbounce, jiggle, light, moan, shiver, sway, twitch, vibrate. \n\nYou may also change your face with: \n\nsmile, :3, pout, frown, scowl, noface")

		else
			to_chat(src, "<span class='notice'>Unusable emote '[act]'. Say *help for a list.</span>")

	if ((message && stat == CONSCIOUS))
		if(client)
			log_emote("[name]/[key] : [message]")
		if (m_type & 1)
			visible_message(message)
		else
			audible_message(message)

	if (regenerate_icons)
		regenerate_icons()

	return
>>>>>>> master
