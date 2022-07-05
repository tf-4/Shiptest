/datum/research_node/medical/biotech
	node_id = "biotech"
	name = "Biological Technology"
	description = "What makes us tick."	//the MC, silly!
	requisite_nodes = list("base")
	designs = list(
		"sleeper",
		"chem_heater",
		"chem_master",
		"chem_dispenser",
		"pandemic",
		"defibrillator",
		"defibmount",
		"operating",
		"healthanalyzer",
		"medigel",
		"genescanner",
		"med_spray_bottle",
		"chem_pack",
		"blood_pack",
		"medical_kiosk",
		"crewpinpointerprox",
		"medipen_refiller",
		// some of these things are not like the others
		"soda_dispenser",
		"beer_dispenser",
	)

/datum/research_node/medical/adv_biotech
	node_id = "adv_biotech"
	name = "Advanced Biotechnology"
	description = "Advanced Biotechnology"
	requisite_nodes = list("biotech")
	designs = list(
		"piercesyringe",
		"crewpinpointer",
		"smoke_machine",
		"plasmarefiller",
		"limbgrower",
		"meta_beaker",
		"healthanalyzer_advanced",
		"holobarrier_med",
		"defibrillator_compact",
		// why are these in here
		"harvester",
		"detective_scanner",
	)

/datum/research_node/medical/bio_process
	node_id = "bio_process"
	name = "Biological Processing"
	description = "From slimes to kitchens."
	requisite_nodes = list("biotech")
	
	// shouldnt this be in a fucking service node?
	designs = list(
		"smartfridge",
		"gibber",
		"deepfryer",
		"monkey_recycler",
		"processor",
		"gibber",
		"microwave",
		"reagentgrinder",
		"dish_drive",
		"fat_sucker",
	)
