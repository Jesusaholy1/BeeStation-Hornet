// Cold
/datum/disease/advance/cold
	copy_type = /datum/disease/advance

/datum/disease/advance/cold/New()
	name = "Cold"
	symptoms = list(new/datum/symptom/sneeze)
	..()

// Flu
/datum/disease/advance/flu
	copy_type = /datum/disease/advance

/datum/disease/advance/flu/New()
	name = "Flu"
	symptoms = list(new/datum/symptom/cough)
	..()

//Randomly generated Disease, for virus crates and events
/datum/disease/advance/random
	name = "Experimental Disease"
	copy_type = /datum/disease/advance
	var/randomname = TRUE
	var/datum/symptom/specialsymptom = null

/datum/disease/advance/random/New(max_symptoms, max_level = 9)
	if(!max_symptoms)
		max_symptoms = (2 + rand(1, (VIRUS_SYMPTOM_LIMIT-2)))
	if(specialsymptom)
		max_symptoms -= 1
	var/list/datum/symptom/possible_symptoms = list()
	for(var/symptom in subtypesof(/datum/symptom))
		var/datum/symptom/S = symptom
		if(S == specialsymptom)
			continue
		if(initial(S.level) > max_level)
			continue
		if(initial(S.level) <= 0) //unobtainable symptoms
			continue
		possible_symptoms += S
	for(var/i in 1 to max_symptoms)
		var/datum/symptom/chosen_symptom = pick_n_take(possible_symptoms)
		if(chosen_symptom)
			var/datum/symptom/S = new chosen_symptom
			symptoms += S
	var/datum/symptom/special = new specialsymptom
	symptoms += special
	Refresh()
	if(randomname)
		name = "Sample #[rand(1,10000)]"

/datum/disease/advance/random/macrophage
	name = "Unknown Disease"
	specialsymptom = /datum/symptom/macrophage


/datum/disease/advance/random/necropolis
	name = "Necropolis Seed"
	specialsymptom = /datum/symptom/necroseed
	randomname = FALSE
