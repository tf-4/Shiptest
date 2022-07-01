
//Current rate: 135000 research points in 90 minutes

//Base Nodes
/datum/research_node/base
	node_id = "base"
	starting_node = TRUE
	name = "Basic Research Technology"
	description = "NT default research technologies."
	designs = list(
		// Basic Parts
		"basic_matter_bin", "basic_cell", "basic_scanning", "basic_capacitor", "basic_micro_laser", "micro_mani",
		// Cargo Stuff
		"c-reader", "desttagger", "salestagger", "handlabel", "packagewrap",
		// Research Stuff
		"destructive_analyzer", "circuit_imprinter", "experimentor", "rdconsole", "bepis", "rdserver", "design_disk", "tech_disk", "mechfab",
		// Miscellaneous Stufff
		"paystand", "space_heater", "bucket", "plastic_knife", "plastic_fork", "plastic_spoon",
		// Security Stuff
		"sec_rshot", "sec_beanbag_slug", "sec_bshot", "sec_slug", "sec_Islug", "sec_dart", 	"sec_38", "buckshot_shell", "beanbag_slug", "rubber_shot",
		//Handgun Ammo (Security)
		"commanderammo", "stechkinammo", "m1911ammo", "m9cammo", "c9mm", "c10mm", "c45", "c556mmHITP", "rubbershot9mm", "rubbershot10mm", "rubbershot45", "rubbershot556mmHITP",
		// Construction Materials
		"rglass", "plasteel", "plastitanium", "plasmaglass", "plasmareinforcedglass", "titaniumglass", "plastitaniumglass",
	)

/datum/research_node/mmi
	node_id = "mmi"
	starting_node = TRUE
	name = "Man Machine Interface"
	description = "A slightly Frankensteinian device that allows human brains to interface natively with software APIs."
	designs = list("mmi")

/datum/research_node/cyborg
	node_id = "cyborg"
	starting_node = TRUE
	name = "Cyborg Construction"
	description = "Sapient robots with preloaded tool modules and programmable laws."
	designs = list("robocontrol", "sflash", "borg_suit", "borg_head", "borg_chest", "borg_r_arm", "borg_l_arm", "borg_r_leg", "borg_l_leg", "borgupload",
					"cyborgrecharger", "borg_upgrade_restart", "borg_upgrade_rename", "augmanipulator")

/datum/research_node/mech
	node_id = "mecha"
	starting_node = TRUE
	name = "Mechanical Exosuits"
	description = "Mechanized exosuits that are several magnitudes stronger and more powerful than the average human."
	designs = list("mecha_tracking", "mechacontrol", "mechapower", "mech_recharger", "ripley_chassis", "firefighter_chassis", "ripley_torso", "ripley_left_arm",
					"ripley_right_arm", "ripley_left_leg", "ripley_right_leg", "ripley_main", "ripley_peri", "ripleyupgrade", "mech_hydraulic_clamp")

/datum/research_node/mech_tools
	node_id = "mech_tools"
	starting_node = TRUE
	name = "Basic Exosuit Equipment"
	description = "Various tools fit for basic mech units"
	designs = list("mech_drill", "mech_mscanner", "mech_extinguisher", "mech_cable_layer") //WS Edit - Reverted Smartwire

/datum/research_node/basic_tools
	node_id = "basic_tools"
	starting_node = TRUE
	name = "Basic Tools"
	description = "Basic mechanical, electronic, surgical and botanical tools."
	designs = list("screwdriver", "wrench", "wirecutters", "crowbar", "multitool", "welding_tool", "tscanner", "analyzer", "cable_coil", "pipe_painter", "airlock_painter",
					"cultivator", "plant_analyzer", "shovel", "spade", "hatchet", "mop", "floor_painter", "decal_painter", "plunger", "spraycan") //WS Edit - Floor Painters

/datum/research_node/basic_medical
	node_id = "basic_medical"
	starting_node = TRUE
	name = "Basic Medical Equipment"
	description = "Basic medical tools and equipment."
	designs = list("cybernetic_liver", "cybernetic_heart", "cybernetic_lungs", "cybernetic_stomach", "scalpel", "circular_saw", "surgicaldrill", "retractor", "cautery", "hemostat",
					"syringe", "plumbing_rcd", "beaker", "large_beaker", "xlarge_beaker", "dropper", "defibmountdefault", "portable_chem_mixer")

/////////////////////////Biotech/////////////////////////
/datum/research_node/biotech
	node_id = "biotech"
	name = "Biological Technology"
	description = "What makes us tick."	//the MC, silly!
	requisite_nodes = list("base")
	designs = list("sleeper", "chem_heater", "chem_master", "chem_dispenser", "pandemic", "defibrillator", "defibmount", "operating", "soda_dispenser", "beer_dispenser", "healthanalyzer", "medigel","genescanner", "med_spray_bottle", "chem_pack", "blood_pack", "medical_kiosk", "crewpinpointerprox", "medipen_refiller")

/datum/research_node/adv_biotech
	node_id = "adv_biotech"
	name = "Advanced Biotechnology"
	description = "Advanced Biotechnology"
	requisite_nodes = list("biotech")
	designs = list("piercesyringe", "crewpinpointer", "smoke_machine", "plasmarefiller", "limbgrower", "meta_beaker", "healthanalyzer_advanced", "harvester", "holobarrier_med", "detective_scanner", "defibrillator_compact")

/datum/research_node/bio_process
	node_id = "bio_process"
	name = "Biological Processing"
	description = "From slimes to kitchens."
	requisite_nodes = list("biotech")
	designs = list("smartfridge", "gibber", "deepfryer", "monkey_recycler", "processor", "gibber", "microwave", "reagentgrinder", "dish_drive", "fat_sucker")

/////////////////////////Advanced Surgery/////////////////////////
/datum/research_node/imp_wt_surgery
	node_id = "imp_wt_surgery"
	name = "Improved Wound-Tending Surgery"
	description = "Who would have known being more gentle with a hemostat decreases patient pain?"
	requisite_nodes = list("biotech")
	designs = list("surgery_heal_brute_upgrade","surgery_heal_burn_upgrade")


/datum/research_node/adv_surgery
	node_id = "adv_surgery"
	name = "Advanced Surgery"
	description = "When simple medicine doesn't cut it."
	requisite_nodes = list("imp_wt_surgery")
	designs = list("surgery_lobotomy", "surgery_heal_brute_upgrade_femto", "surgery_heal_burn_upgrade_femto","surgery_heal_combo","surgery_adv_dissection")

/datum/research_node/exp_surgery
	node_id = "exp_surgery"
	name = "Experimental Surgery"
	description = "When evolution isn't fast enough."
	requisite_nodes = list("adv_surgery")
	designs = list("surgery_pacify","surgery_vein_thread","surgery_muscled_veins","surgery_nerve_splice","surgery_nerve_ground","surgery_ligament_hook","surgery_ligament_reinforcement","surgery_viral_bond", "surgery_heal_combo_upgrade", "surgery_exp_dissection", "surgery_cortex_imprint","surgery_cortex_folding")

/datum/research_node/alien_surgery
	node_id = "alien_surgery"
	name = "Alien Surgery"
	description = "Abductors did nothing wrong."
	requisite_nodes = list("exp_surgery", "alientech")
	designs = list("surgery_brainwashing","surgery_zombie","surgery_heal_combo_upgrade_femto", "surgery_ext_dissection")

/////////////////////////data theory tech/////////////////////////
/datum/research_node/datatheory //Computer science
	node_id = "datatheory"
	name = "Data Theory"
	description = "Big Data, in space!"
	requisite_nodes = list("base")
	designs = list(
		"survey-handheld-advanced",
		"design_disk_adv"
	)


/////////////////////////engineering tech/////////////////////////
/datum/research_node/engineering
	node_id = "engineering"
	name = "Industrial Engineering"
	description = "A refresher course on modern engineering technology."
	requisite_nodes = list("base")
	designs = list("solarcontrol", "solarassembly", "recharger", "powermonitor", "rped", "pacman", "adv_capacitor", "adv_scanning", "emitter", "high_cell", "adv_matter_bin", "scanner_gate",
	"atmosalerts", "atmos_control", "recycler", "autolathe", "high_micro_laser", "nano_mani", "mesons", "welding_goggles", "thermomachine", "rad_collector", "tesla_coil", "grounding_rod",
	"apc_control", "cell_charger", "power control", "airlock_board", "firelock_board", "aac_electronics", "airalarm_electronics", "firealarm_electronics", "cell_charger", "stack_console", "stack_machine",
	"oxygen_tank", "plasma_tank", "emergency_oxygen", "emergency_oxygen_engi", "plasmaman_tank_belt", "pneumatic_seal", "shieldwallgen", "shieldwallgen_atmos") //WS edit, solar assemblies from lathe

/datum/research_node/adv_engi
	node_id = "adv_engi"
	name = "Advanced Engineering"
	description = "Pushing the boundaries of physics, one chainsaw-fist at a time."
	requisite_nodes = list("engineering", "emp_basic")
	designs = list("engine_goggles", "magboots", "forcefield_projector", "weldingmask", "rcd_loaded", "rpd_loaded", "sheetifier")

/datum/research_node/anomaly
	node_id = "anomaly_research"
	name = "Anomaly Research"
	description = "Unlock the potential of the mysterious anomalies that appear throughout the sector."
	requisite_nodes = list("adv_engi", "practical_bluespace")
	designs = list("reactive_armour", "anomaly_neutralizer")

/datum/research_node/high_efficiency
	node_id = "high_efficiency"
	name = "High Efficiency Parts"
	description = "Finely-tooled manufacturing techniques allowing for picometer-perfect precision levels."
	requisite_nodes = list("engineering", "datatheory")
	designs = list("pico_mani", "super_matter_bin")

/datum/research_node/adv_power
	node_id = "adv_power"
	name = "Advanced Power Manipulation"
	description = "How to get more zap."
	requisite_nodes = list("engineering")
	designs = list("smes", "super_cell", "hyper_cell", "super_capacitor", "superpacman", "mrspacman", "power_turbine", "power_turbine_console", "power_compressor", "circulator", "teg")

/////////////////////////Bluespace tech/////////////////////////
/datum/research_node/bluespace_basic //Bluespace-memery
	node_id = "bluespace_basic"
	name = "Basic Bluespace Theory"
	description = "Basic studies into the mysterious alternate dimension known as bluespace."
	requisite_nodes = list("base")
	designs = list("beacon", "xenobioconsole", "telesci_gps", "bluespace_crystal")

/datum/research_node/bluespace_travel
	node_id = "bluespace_travel"
	name = "Bluespace Travel"
	description = "Application of Bluespace for static teleportation technology."
	requisite_nodes = list("practical_bluespace")
	designs = list("tele_station", "tele_hub", "teleconsole", "quantumpad", "launchpad", "launchpad_console", "bluespace_pod")

/datum/research_node/micro_bluespace
	node_id = "micro_bluespace"
	name = "Miniaturized Bluespace Research"
	description = "Extreme reduction in space required for bluespace engines, leading to portable bluespace technology."
	requisite_nodes = list("bluespace_travel", "practical_bluespace", "high_efficiency")
	designs = list("bluespace_matter_bin", "femto_mani", "bluespacebodybag", "triphasic_scanning", "quantum_keycard", "wormholeprojector", "swapper")

/datum/research_node/advanced_bluespace
	node_id = "bluespace_storage"
	name = "Advanced Bluespace Storage"
	description = "With the use of bluespace we can create even more advanced storage devices than we could have ever done"
	requisite_nodes = list("micro_bluespace", "janitor")
	designs = list("bag_holding")

/datum/research_node/practical_bluespace
	node_id = "practical_bluespace"
	name = "Applied Bluespace Research"
	description = "Using bluespace to make things faster and better."
	requisite_nodes = list("bluespace_basic", "engineering")
	designs = list("bs_rped","minerbag_holding", "bluespacebeaker", "bluespacesyringe", "phasic_scanning", "roastingstick", "ore_silo")

/datum/research_node/bluespace_power
	node_id = "bluespace_power"
	name = "Bluespace Power Technology"
	description = "Even more powerful.. power!"
	requisite_nodes = list("adv_power", "practical_bluespace")
	designs = list("bluespace_cell", "quadratic_capacitor")

/datum/research_node/regulated_bluespace
	node_id = "regulated_bluespace"
	name = "Regulated Bluespace Research"
	description = "Bluespace technology using stable and balanced procedures. Required by galactic convention for public use."
	requisite_nodes = list("base")
	designs = list()

/datum/research_node/unregulated_bluespace
	node_id = "unregulated_bluespace"
	name = "Unregulated Bluespace Research"
	description = "Bluespace technology using unstable or unbalanced procedures, prone to damaging the fabric of bluespace. Outlawed by galactic conventions."
	requisite_nodes = list("bluespace_travel", "syndicate_basic")
	designs = list("desynchronizer")


/////////////////////////plasma tech/////////////////////////
/datum/research_node/basic_plasma
	node_id = "basic_plasma"
	name = "Basic Plasma Research"
	description = "Research into the mysterious and dangerous substance, plasma."
	requisite_nodes = list("engineering")
	designs = list("mech_generator")

/datum/research_node/adv_plasma
	node_id = "adv_plasma"
	name = "Advanced Plasma Research"
	description = "Research on how to fully exploit the power of plasma."
	requisite_nodes = list("basic_plasma")
	designs = list("mech_plasma_cutter")

/////////////////////////robotics tech/////////////////////////
/datum/research_node/robotics
	node_id = "robotics"
	name = "Basic Robotics Research"
	description = "Programmable machines that make our lives lazier."
	requisite_nodes = list("base")
	designs = list("paicard")

/datum/research_node/adv_robotics
	node_id = "adv_robotics"
	name = "Advanced Robotics Research"
	description = "Machines using actual neural networks to simulate human lives."
	requisite_nodes = list("neural_programming", "robotics")
	designs = list("mmi_posi")

/datum/research_node/neural_programming
	node_id = "neural_programming"
	name = "Neural Programming"
	description = "Study into networks of processing units that mimic our brains."
	requisite_nodes = list("biotech", "datatheory")

/datum/research_node/cyborg_upg_util
	node_id = "cyborg_upg_util"
	name = "Cyborg Upgrades: Utility"
	description = "Utility upgrades for cyborgs."
	requisite_nodes = list("adv_robotics")
	designs = list("borg_upgrade_thrusters", "borg_upgrade_selfrepair", "borg_upgrade_expand", "borg_upgrade_disablercooler", "borg_upgrade_trashofholding", "borg_upgrade_advancedmop")

/datum/research_node/cyborg_upg_engiminer
	node_id = "cyborg_upg_engiminer"
	name = "Cyborg Upgrades: Engineering & Mining"
	description = "Engineering and Mining upgrades for cyborgs."
	requisite_nodes = list("adv_engi", "basic_mining")
	designs = list("borg_upgrade_rped", "borg_upgrade_circuitapp", "borg_upgrade_diamonddrill", "borg_upgrade_lavaproof", "borg_upgrade_holding")

/datum/research_node/cyborg_upg_med
	node_id = "cyborg_upg_med"
	name = "Cyborg Upgrades: Medical"
	description = "Medical upgrades for cyborgs."
	requisite_nodes = list("adv_biotech")
	designs = list("borg_upgrade_defibrillator", "borg_upgrade_piercinghypospray", "borg_upgrade_expandedsynthesiser", "borg_upgrade_pinpointer", "borg_upgrade_surgicalprocessor", "borg_upgrade_beakerapp")

/datum/research_node/ai
	node_id = "ai"
	name = "Artificial Intelligence"
	description = "AI unit research."
	requisite_nodes = list("adv_robotics")
	designs = list("aifixer", "aicore", "safeguard_module", "onehuman_module", "protectstation_module", "quarantine_module", "oxygen_module", "freeform_module",
	"reset_module", "purge_module", "remove_module", "freeformcore_module", "asimov_module", "paladin_module", "tyrant_module", "overlord_module", "corporate_module",
	"default_module", "borg_ai_control", "mecha_tracking_ai_control", "aiupload", "intellicard")

/////////////////////////EMP tech/////////////////////////
/datum/research_node/emp_basic //EMP tech for some reason
	node_id = "emp_basic"
	name = "Electromagnetic Theory"
	description = "Study into usage of frequencies in the electromagnetic spectrum."
	requisite_nodes = list("base")
	designs = list("holosign", "holosignsec", "holosignengi", "holosignatmos", "inducer", "tray_goggles", "holopad")

/datum/research_node/emp_adv
	node_id = "emp_adv"
	name = "Advanced Electromagnetic Theory"
	description = "Determining whether reversing the polarity will actually help in a given situation."
	requisite_nodes = list("emp_basic")
	designs = list("ultra_micro_laser")

/datum/research_node/emp_super
	node_id = "emp_super"
	name = "Quantum Electromagnetic Technology"	//bs
	description = "Even better electromagnetic technology."
	requisite_nodes = list("emp_adv")
	designs = list("quadultra_micro_laser")

/////////////////////////Clown tech/////////////////////////
/datum/research_node/clown
	node_id = "clown"
	name = "Clown Technology"
	description = "Honk?!"
	requisite_nodes = list("base")
	designs = list("air_horn", "honker_main", "honker_peri", "honker_targ", "honk_chassis", "honk_head", "honk_torso", "honk_left_arm", "honk_right_arm",
	"honk_left_leg", "honk_right_leg", "mech_banana_mortar", "mech_mousetrap_mortar", "mech_honker", "mech_punching_face", "implant_trombone", "borg_transform_clown")

////////////////////////Computer tech////////////////////////
/datum/research_node/comptech
	node_id = "comptech"
	name = "Computer Consoles"
	description = "Computers and how they work."
	requisite_nodes = list("datatheory")
	designs = list(
		"comconsole",
		"crewconsole",
		"idcard",
		"idcardconsole",
		"libraryconsole",
		"mining",
		"rdcamera",
		"seccamera",
		"survey-handheld-elite",
		"design_disk_super",
	)

/datum/research_node/computer_hardware_basic				//Modular computers are shitty and nearly useless so until someone makes them actually useful this can be easy to get.
	node_id = "computer_hardware_basic"
	name = "Computer Hardware"
	description = "How computer hardware are made."
	requisite_nodes = list("comptech")
	designs = list("hdd_basic", "hdd_advanced", "hdd_super", "hdd_cluster", "ssd_small", "ssd_micro", "netcard_basic", "netcard_advanced", "netcard_wired",
	"portadrive_basic", "portadrive_advanced", "portadrive_super", "cardslot", "aislot", "miniprinter", "APClink", "bat_control", "bat_normal", "bat_advanced",
	"bat_super", "bat_micro", "bat_nano", "cpu_normal", "pcpu_normal", "cpu_small", "pcpu_small")

/datum/research_node/computer_board_gaming
	node_id = "computer_board_gaming"
	name = "Arcade Games"
	description = "For the slackers on the station."
	requisite_nodes = list("comptech")
	designs = list("arcade_battle", "arcade_orion", "slotmachine")

/datum/research_node/comp_recordkeeping
	node_id = "comp_recordkeeping"
	name = "Computerized Recordkeeping"
	description = "Organized record databases and how they're used."
	requisite_nodes = list("comptech")
	designs = list("secdata", "med_data", "prisonmanage", "vendor", "automated_announcement", "design_disk_elite")

/datum/research_node/telecomms
	node_id = "telecomms"
	name = "Telecommunications Technology"
	description = "Subspace transmission technology for near-instant communications devices."
	requisite_nodes = list("comptech", "bluespace_basic")
	designs = list("s-receiver", "s-bus", "s-broadcaster", "s-processor", "s-hub", "s-server", "s-relay", "comm_monitor", "comm_server",
	"s-ansible", "s-filter", "s-amplifier", "ntnet_relay", "s-treatment", "s-analyzer", "s-crystal", "s-transmitter", "s-messaging")

/datum/research_node/integrated_HUDs
	node_id = "integrated_HUDs"
	name = "Integrated HUDs"
	description = "The usefulness of computerized records, projected straight onto your eyepiece!"
	requisite_nodes = list("comp_recordkeeping", "emp_basic")
	designs = list("health_hud", "security_hud", "diagnostic_hud", "scigoggles")

/datum/research_node/NVGtech
	node_id = "NVGtech"
	name = "Night Vision Technology"
	description = "Allows seeing in the dark without actual light!"
	requisite_nodes = list("integrated_HUDs", "adv_engi", "emp_adv")
	designs = list("health_hud_night", "security_hud_night", "diagnostic_hud_night", "night_visision_goggles", "nvgmesons")

////////////////////////Medical////////////////////////
/datum/research_node/genetics
	node_id = "genetics"
	name = "Genetic Engineering"
	description = "We have the technology to change him."
	requisite_nodes = list("biotech")
	designs = list("dnascanner", "scan_console", "dna_disk", "clonepod", "cloning")

/datum/research_node/cryotech
	node_id = "cryotech"
	name = "Cryostasis Technology"
	description = "Smart freezing of objects to preserve them!"
	requisite_nodes = list("adv_engi", "biotech")
	designs = list("splitbeaker", "cryotube", "cryo_Grenade", "stasis")

/datum/research_node/subdermal_implants
	node_id = "subdermal_implants"
	name = "Subdermal Implants"
	description = "Electronic implants buried beneath the skin."
	requisite_nodes = list("biotech")
	designs = list("implanter", "implantcase", "implant_chem", "implant_tracking", "locator", "c38_trac")

/datum/research_node/cyber_organs
	node_id = "cyber_organs"
	name = "Cybernetic Organs"
	description = "We have the technology to rebuild him."
	requisite_nodes = list("biotech")
	designs = list("cybernetic_ears", "cybernetic_heart_tier2", "cybernetic_liver_tier2", "cybernetic_lungs_tier2", "cybernetic_stomach_tier2")

/datum/research_node/cyber_organs_upgraded
	node_id = "cyber_organs_upgraded"
	name = "Upgraded Cybernetic Organs"
	description = "We have the technology to upgrade him."
	requisite_nodes = list("adv_biotech", "cyber_organs")
	designs = list("cybernetic_ears_u", "cybernetic_heart_tier3", "cybernetic_liver_tier3", "cybernetic_lungs_tier3", "cybernetic_stomach_tier3")

/datum/research_node/cyber_implants
	node_id = "cyber_implants"
	name = "Cybernetic Implants"
	description = "Electronic implants that improve humans."
	requisite_nodes = list("adv_biotech", "datatheory")
	designs = list("ci-nutriment", "ci-breather", "ci-gloweyes", "ci-welding", "ci-medhud", "ci-sechud", "ci-diaghud")

/datum/research_node/adv_cyber_implants
	node_id = "adv_cyber_implants"
	name = "Advanced Cybernetic Implants"
	description = "Upgraded and more powerful cybernetic implants."
	requisite_nodes = list("neural_programming", "cyber_implants","integrated_HUDs")
	designs = list("ci-toolset", "ci-surgery", "ci-reviver", "ci-nutrimentplus")

/datum/research_node/combat_cyber_implants
	node_id = "combat_cyber_implants"
	name = "Combat Cybernetic Implants"
	description = "Military grade combat implants to improve performance."
	requisite_nodes = list("adv_cyber_implants","weaponry","NVGtech","high_efficiency")
	designs = list("ci-xray", "ci-thermals", "ci-antidrop", "ci-antistun", "ci-thrusters")

////////////////////////Tools////////////////////////

/datum/research_node/basic_mining
	node_id = "basic_mining"
	name = "Mining Technology"
	description = "Better than Efficiency V."
	requisite_nodes = list("engineering", "basic_plasma")
	designs = list("drill", "superresonator", "triggermod", "damagemod", "cooldownmod", "rangemod", "ore_redemption", "mining_equipment_vendor", "cargoexpress", "plasmacutter")//e a r l y    g a  m e)

/datum/research_node/adv_mining
	node_id = "adv_mining"
	name = "Advanced Mining Technology"
	description = "Efficiency Level 127"	//dumb mc references
	requisite_nodes = list("basic_mining", "adv_engi", "adv_power", "adv_plasma")
	designs = list("drill_diamond", "jackhammer", "hypermod", "plasmacutter_adv")
// WS Edit Start - Yeet The BSM
// /datum/research_node/bluespace_mining
// 	node_id = "bluespace_mining"
// 	name = "Bluespace Mining Technology"
// 	description = "Harness the power of bluespace to make materials out of nothing. Slowly."
// 	requisite_nodes = list("practical_bluespace", "adv_mining")
// 	designs = list("bluespace_miner")
//  WS Edit End - Yeet The BSM
/datum/research_node/janitor
	node_id = "janitor"
	name = "Advanced Sanitation Technology"
	description = "Clean things better, faster, stronger, and harder!"
	requisite_nodes = list("adv_engi")
	designs = list("holobarrier_jani", "advmop", "buffer", "blutrash", "light_replacer", "spraybottle", "beartrap")

/datum/research_node/botany
	node_id = "botany"
	name = "Botanical Engineering"
	description = "Botanical tools"
	requisite_nodes = list("adv_engi", "biotech")
	designs = list("diskplantgene", "portaseeder", "flora_gun", "hydro_tray", "biogenerator", "seed_extractor")

/datum/research_node/exp_tools
	node_id = "exp_tools"
	name = "Experimental Tools"
	description = "Highly advanced tools."
	designs = list("exwelder", "jawsoflife", "handdrill", "laserscalpel", "mechanicalpinches", "searingtool")
	requisite_nodes = list("adv_engi")

/datum/research_node/sec_basic
	node_id = "sec_basic"
	name = "Basic Security Equipment"
	description = "Standard equipment used by security."
	designs = list("seclite", "pepperspray", "bola_energy", "zipties", "evidencebag")
	requisite_nodes = list("base")

/datum/research_node/rcd_upgrade
	node_id = "rcd_upgrade"
	name = "RCD designs upgrade"
	description = "Unlocks new RCD designs."
	designs = list("rcd_upgrade_frames", "rcd_upgrade_simple_circuits")
	requisite_nodes = list("adv_engi")

/datum/research_node/adv_rcd_upgrade
	node_id = "adv_rcd_upgrade"
	name = "Advanced RCD designs upgrade"
	description = "Unlocks new RCD designs."
	designs = list("rcd_upgrade_silo_link")
	requisite_nodes = list("rcd_upgrade", "bluespace_travel")

/////////////////////////weaponry tech/////////////////////////
/datum/research_node/weaponry
	node_id = "weaponry"
	name = "Weapon Development Technology"
	description = "Our researchers have found new ways to weaponize just about everything now."
	requisite_nodes = list("engineering")
	designs = list("pin_testing", "tele_shield","gun_cell")

/datum/research_node/adv_weaponry
	node_id = "adv_weaponry"
	name = "Advanced Weapon Development Technology"
	description = "Our weapons are breaking the rules of reality by now."
	requisite_nodes = list("adv_engi", "weaponry")
	designs = list("pin_loyalty","gun_cell_upgraded", "gun_cell_large")

/datum/research_node/electric_weapons
	node_id = "electronic_weapons"
	name = "Electric Weapons"
	description = "Weapons using electric technology"
	requisite_nodes = list("weaponry", "adv_power"  , "emp_basic")
	designs = list("stunrevolver", "ioncarbine")

/datum/research_node/radioactive_weapons
	node_id = "radioactive_weapons"
	name = "Radioactive Weaponry"
	description = "Weapons using radioactive technology."
	requisite_nodes = list("adv_engi", "adv_weaponry")
	designs = list("nuclear_gun")

/datum/research_node/medical_weapons
	node_id = "medical_weapons"
	name = "Medical Weaponry"
	description = "Weapons using medical technology."
	requisite_nodes = list("adv_biotech", "weaponry")
	designs = list("rapidsyringe", "shotgun_dart")

/datum/research_node/beam_weapons
	node_id = "beam_weapons"
	name = "Beam Weaponry"
	description = "Various basic beam weapons"
	requisite_nodes = list("adv_weaponry")
	designs = list("temp_gun", "xray_laser")

/datum/research_node/adv_beam_weapons
	node_id = "adv_beam_weapons"
	name = "Advanced Beam Weaponry"
	description = "Various advanced beam weapons"
	requisite_nodes = list("beam_weapons")
	designs = list("beamrifle")

/datum/research_node/explosive_weapons
	node_id = "explosive_weapons"
	name = "Explosive & Pyrotechnical Weaponry"
	description = "If the light stuff just won't do it."
	requisite_nodes = list("adv_weaponry")
	designs = list("large_Grenade", "pyro_Grenade", "adv_Grenade")

/datum/research_node/ballistic_weapons
	node_id = "ballistic_weapons"
	name = "Ballistic Weaponry"
	description = "This isn't research.. This is reverse-engineering!"
	requisite_nodes = list("weaponry")
	designs = list("mag_oldsmg", "mag_oldsmg_ap", "mag_oldsmg_ic", "shotgun_slug")

/datum/research_node/adv_ballistics
	node_id = "adv_ballistics"
	name = "Advanced Ballistics"
	description = "Refined ballistic ammunition for extra combat trauma."
	requisite_nodes = list("ballistic_weapons", "adv_engi")
	designs = list("ap9mm", "ap10mm", "ap45", "hp9mm", "hp10mm", "hp45", "ap556mmHITP", "hp556mmHITP")

/datum/research_node/exotic_ammo
	node_id = "exotic_ammo"
	name = "Exotic Ammunition"
	description = "They won't know what hit em."
	requisite_nodes = list("adv_weaponry", "medical_weapons")
	designs = list("techshotshell", "c38_hotshot", "c38_iceblox", "inc9mm", "inc10mm", "inc45", "incendiary_slug")

/datum/research_node/gravity_gun
	node_id = "gravity_gun"
	name = "One-point Bluespace-gravitational Manipulator"
	description = "Fancy wording for gravity gun."
	requisite_nodes = list("adv_weaponry", "bluespace_travel")
	designs = list("gravitygun", "mech_gravcatapult")

////////////////////////mech technology////////////////////////
/datum/research_node/adv_mecha
	node_id = "adv_mecha"
	name = "Advanced Exosuits"
	description = "For when you just aren't Gundam enough."
	requisite_nodes = list("adv_robotics")
	designs = list("mech_repair_droid")

/datum/research_node/odysseus
	node_id = "mecha_odysseus"
	name = "EXOSUIT: Odysseus"
	description = "Odysseus exosuit designs"
	requisite_nodes = list("base")
	designs = list("odysseus_chassis", "odysseus_torso", "odysseus_head", "odysseus_left_arm", "odysseus_right_arm" ,"odysseus_left_leg", "odysseus_right_leg",
	"odysseus_main", "odysseus_peri")

/datum/research_node/gygax
	node_id = "mech_gygax"
	name = "EXOSUIT: Gygax"
	description = "Gygax exosuit designs"
	requisite_nodes = list("adv_mecha", "weaponry")
	designs = list("gygax_chassis", "gygax_torso", "gygax_head", "gygax_left_arm", "gygax_right_arm", "gygax_left_leg", "gygax_right_leg", "gygax_main",
	"gygax_peri", "gygax_targ", "gygax_armor")

/datum/research_node/durand
	node_id = "mech_durand"
	name = "EXOSUIT: Durand"
	description = "Durand exosuit designs"
	requisite_nodes = list("adv_mecha", "adv_weaponry")
	designs = list("durand_chassis", "durand_torso", "durand_head", "durand_left_arm", "durand_right_arm", "durand_left_leg", "durand_right_leg", "durand_main",
	"durand_peri", "durand_targ", "durand_armor")

/datum/research_node/phazon
	node_id = "mecha_phazon"
	name = "EXOSUIT: Phazon"
	description = "Phazon exosuit designs"
	requisite_nodes = list("adv_mecha", "weaponry" , "micro_bluespace")
	designs = list("phazon_chassis", "phazon_torso", "phazon_head", "phazon_left_arm", "phazon_right_arm", "phazon_left_leg", "phazon_right_leg", "phazon_main",
	"phazon_peri", "phazon_targ", "phazon_armor")

/datum/research_node/adv_mecha_tools
	node_id = "adv_mecha_tools"
	name = "Advanced Exosuit Equipment"
	description = "Tools for high level mech suits"
	requisite_nodes = list("adv_mecha")
	designs = list("mech_rcd", "mech_thrusters")

/datum/research_node/med_mech_tools
	node_id = "med_mech_tools"
	name = "Medical Exosuit Equipment"
	description = "Tools for high level mech suits"
	requisite_nodes = list("adv_biotech")
	designs = list("mech_sleeper", "mech_syringe_gun", "mech_medi_beam")

/datum/research_node/mech_modules
	node_id = "adv_mecha_modules"
	name = "Simple Exosuit Modules"
	description = "An advanced piece of mech weaponry"
	requisite_nodes = list("adv_mecha", "bluespace_power")
	designs = list("mech_energy_relay", "mech_ccw_armor", "mech_proj_armor", "mech_generator_nuclear")

/datum/research_node/mech_scattershot
	node_id = "mecha_tools"
	name = "Exosuit Weapon (LBX AC 10 \"Scattershot\")"
	description = "An advanced piece of mech weaponry"
	requisite_nodes = list("ballistic_weapons")
	designs = list("mech_scattershot", "mech_scattershot_ammo")

/datum/research_node/mech_carbine
	node_id = "mech_carbine"
	name = "Exosuit Weapon (FNX-99 \"Hades\" Carbine)"
	description = "An advanced piece of mech weaponry"
	requisite_nodes = list("ballistic_weapons")
	designs = list("mech_carbine", "mech_carbine_ammo")

/datum/research_node/mech_ion
	node_id = "mmech_ion"
	name = "Exosuit Weapon (MKIV Ion Heavy Cannon)"
	description = "An advanced piece of mech weaponry"
	requisite_nodes = list("electronic_weapons", "emp_adv")
	designs = list("mech_ion")

/datum/research_node/mech_tesla
	node_id = "mech_tesla"
	name = "Exosuit Weapon (MKI Tesla Cannon)"
	description = "An advanced piece of mech weaponry"
	requisite_nodes = list("electronic_weapons", "adv_power")
	designs = list("mech_tesla")

/datum/research_node/mech_laser
	node_id = "mech_laser"
	name = "Exosuit Weapon (CH-PS \"Immolator\" Laser)"
	description = "A basic piece of mech weaponry"
	requisite_nodes = list("beam_weapons")
	designs = list("mech_laser")

/datum/research_node/mech_laser_heavy
	node_id = "mech_laser_heavy"
	name = "Exosuit Weapon (CH-LC \"Solaris\" Laser Cannon)"
	description = "An advanced piece of mech weaponry"
	requisite_nodes = list("adv_beam_weapons")
	designs = list("mech_laser_heavy")

/datum/research_node/mech_disabler
	node_id = "mech_disabler"
	name =  "Exosuit Weapon (CH-DS \"Peacemaker\" Mounted Disabler)"
	description = "A basic piece of mech weaponry"
	requisite_nodes = list("beam_weapons")
	designs = list("mech_disabler")

/datum/research_node/mech_grenade_launcher
	node_id = "mech_grenade_launcher"
	name = "Exosuit Weapon (SGL-6 Grenade Launcher)"
	description = "An advanced piece of mech weaponry"
	requisite_nodes = list("explosive_weapons")
	designs = list("mech_grenade_launcher", "mech_grenade_launcher_ammo")

/datum/research_node/mech_missile_rack
	node_id = "mech_missile_rack"
	name = "Exosuit Weapon (BRM-6 Missile Rack)"
	description = "An advanced piece of mech weaponry"
	requisite_nodes = list("explosive_weapons")
	designs = list("mech_missile_rack", "mech_missile_rack_ammo")

/datum/research_node/clusterbang_launcher
	node_id = "clusterbang_launcher"
	name = "Exosuit Module (SOB-3 Clusterbang Launcher)"
	description = "An advanced piece of mech weaponry"
	requisite_nodes = list("explosive_weapons")
	designs = list("clusterbang_launcher", "clusterbang_launcher_ammo")

/datum/research_node/mech_teleporter
	node_id = "mech_teleporter"
	name = "Exosuit Module (Teleporter Module)"
	description = "An advanced piece of mech Equipment"
	requisite_nodes = list("micro_bluespace")
	designs = list("mech_teleporter")

/datum/research_node/mech_wormhole_gen
	node_id = "mech_wormhole_gen"
	name = "Exosuit Module (Localized Wormhole Generator)"
	description = "An advanced piece of mech weaponry"
	requisite_nodes = list("bluespace_travel")
	designs = list("mech_wormhole_gen")

/datum/research_node/mech_lmg
	node_id = "mech_lmg"
	name = "Exosuit Weapon (\"Ultra AC 2\" LMG)"
	description = "An advanced piece of mech weaponry"
	requisite_nodes = list("ballistic_weapons")
	designs = list("mech_lmg", "mech_lmg_ammo")

/datum/research_node/mech_diamond_drill
	node_id = "mech_diamond_drill"
	name =  "Exosuit Diamond Drill"
	description = "A diamond drill fit for a large exosuit"
	requisite_nodes = list("adv_mining")
	designs = list("mech_diamond_drill")

/////////////////////////Nanites/////////////////////////
/datum/research_node/nanite_base
	node_id = "nanite_base"
	name = "Basic Nanite Programming"
	description = "The basics of nanite construction and programming."
	requisite_nodes = list("datatheory")
	designs = list("nanite_disk","nanite_remote","nanite_comm_remote","nanite_scanner",\
						"nanite_chamber","public_nanite_chamber","nanite_chamber_control","nanite_programmer","nanite_program_hub","nanite_cloud_control",\
						"relay_nanites", "monitoring_nanites", "research_nanites" ,"researchplus_nanites", "access_nanites", "repairing_nanites","sensor_nanite_volume", "repeater_nanites", "relay_repeater_nanites","red_diag_nanites")

/datum/research_node/nanite_smart
	node_id = "nanite_smart"
	name = "Smart Nanite Programming"
	description = "Nanite programs that require nanites to perform complex actions, act independently, roam or seek targets."
	requisite_nodes = list("nanite_base","robotics")
	designs = list("purging_nanites", "metabolic_nanites", "stealth_nanites", "memleak_nanites","sensor_voice_nanites", "voice_nanites")

/datum/research_node/nanite_mesh
	node_id = "nanite_mesh"
	name = "Mesh Nanite Programming"
	description = "Nanite programs that require static structures and membranes."
	requisite_nodes = list("nanite_base","engineering")
	designs = list("hardening_nanites", "dermal_button_nanites", "refractive_nanites", "cryo_nanites", "conductive_nanites", "shock_nanites", "emp_nanites", "temperature_nanites")

/datum/research_node/nanite_bio
	node_id = "nanite_bio"
	name = "Biological Nanite Programming"
	description = "Nanite programs that require complex biological interaction."
	requisite_nodes = list("nanite_base","biotech")
	designs = list("regenerative_nanites", "bloodheal_nanites", "coagulating_nanites","poison_nanites","flesheating_nanites",\
					"sensor_crit_nanites","sensor_death_nanites", "sensor_health_nanites", "sensor_damage_nanites", "sensor_species_nanites")

/datum/research_node/nanite_neural
	node_id = "nanite_neural"
	name = "Neural Nanite Programming"
	description = "Nanite programs affecting nerves and brain matter."
	requisite_nodes = list("nanite_bio")
	designs = list("nervous_nanites", "brainheal_nanites", "paralyzing_nanites", "stun_nanites", "selfscan_nanites","good_mood_nanites","bad_mood_nanites")

/datum/research_node/nanite_synaptic
	node_id = "nanite_synaptic"
	name = "Synaptic Nanite Programming"
	description = "Nanite programs affecting mind and thoughts."
	requisite_nodes = list("nanite_neural","neural_programming")
	designs = list("mindshield_nanites", "pacifying_nanites", "blinding_nanites", "sleep_nanites", "mute_nanites", "speech_nanites","hallucination_nanites")

/datum/research_node/nanite_harmonic
	node_id = "nanite_harmonic"
	name = "Harmonic Nanite Programming"
	description = "Nanite programs that require seamless integration between nanites and biology."
	requisite_nodes = list("nanite_bio","nanite_smart","nanite_mesh")
	designs = list("fakedeath_nanites","aggressive_nanites","defib_nanites","regenerative_plus_nanites","brainheal_plus_nanites","purging_plus_nanites","adrenaline_nanites")

/datum/research_node/nanite_combat
	node_id = "nanite_military"
	name = "Military Nanite Programming"
	description = "Nanite programs that perform military-grade functions."
	requisite_nodes = list("nanite_harmonic", "syndicate_basic")
	designs = list("explosive_nanites","pyro_nanites","meltdown_nanites","viral_nanites","nanite_sting_nanites")

/datum/research_node/nanite_hazard
	node_id = "nanite_hazard"
	name = "Hazard Nanite Programs"
	description = "Extremely advanced Nanite programs with the potential of being extremely dangerous."
	requisite_nodes = list("nanite_harmonic", "alientech")
	designs = list("spreading_nanites","mindcontrol_nanites","mitosis_nanites")

/datum/research_node/nanite_replication_protocols
	node_id = "nanite_replication_protocols"
	name = "Nanite Replication Protocols"
	description = "Advanced behaviours that allow nanites to exploit certain circumstances to replicate faster."
	requisite_nodes = list("nanite_smart")
	designs = list("kickstart_nanites","factory_nanites","tinker_nanites","offline_nanites")
	node_hidden = TRUE
	node_experimental = TRUE

////////////////////////Alien technology////////////////////////
/datum/research_node/alientech //AYYYYYYYYLMAOO tech
	node_id = "alientech"
	name = "Alien Technology"
	description = "Things used by the greys."
	requisite_nodes = list("biotech","engineering")
	node_hidden = TRUE
	designs = list("alienalloy")

/datum/research_node/alien_bio
	node_id = "alien_bio"
	name = "Alien Biological Tools"
	description = "Advanced biological tools."
	requisite_nodes = list("alientech", "adv_biotech")
	designs = list("alien_scalpel", "alien_hemostat", "alien_retractor", "alien_saw", "alien_drill", "alien_cautery")
	node_hidden = TRUE

/datum/research_node/alien_engi
	node_id = "alien_engi"
	name = "Alien Engineering"
	description = "Alien engineering tools"
	requisite_nodes = list("alientech", "adv_engi")
	designs = list("alien_wrench", "alien_wirecutters", "alien_screwdriver", "alien_crowbar", "alien_welder", "alien_multitool")
	node_hidden = TRUE

/datum/research_node/syndicate_basic
	node_id = "syndicate_basic"
	name = "Illegal Technology"
	description = "Dangerous research used to create dangerous objects."
	requisite_nodes = list("adv_engi", "adv_weaponry", "explosive_weapons")
	designs = list("decloner", "borg_syndicate_module", "ai_cam_upgrade", "suppressor", "largecrossbow", "donksofttoyvendor", "donksoft_refill", "advanced_camera")
	node_hidden = TRUE

/////////////////////////spacepod tech/////////////////////////
/datum/research_node/spacepod_basic
	node_id = "spacepod_basic"
	name = "Spacepod Construction"
	description = "Basic stuff to construct Spacepods. Don't crash your first spacepod into the sun, especially while going more than 10 m/s."
	requisite_nodes = list("base")
	designs = list("podcore", "podarmor_civ", "podarmor_dark", "spacepod_main")

/datum/research_node/spacepod_lock
	node_id = "spacepod_lock"
	name = "Spacepod Security"
	description = "Keeps greytiders out of your spacepods."
	requisite_nodes = list("spacepod_basic", "engineering")
	designs = list("podlock_keyed", "podkey", "podmisc_tracker")

/datum/research_node/spacepod_disabler
	node_id = "spacepod_disabler"
	name = "Spacepod Weaponry"
	description = "For a bit of pew pew space battles"
	requisite_nodes = list("spacepod_basic", "weaponry")
	designs = list("podgun_disabler")

/datum/research_node/spacepod_lasers
	node_id = "spacepod_lasers"
	name = "Advanced Spacepod Weaponry"
	description = "For a lot of pew pew space battles. PEW PEW PEW!! Shit, I missed. I need better aim. Whatever."
	requisite_nodes = list("spacepod_disabler", "electronic_weapons")
	designs = list("podgun_laser", "podgun_bdisabler")

/datum/research_node/spacepod_ka
	node_id = "spacepod_ka"
	name = "Spacepod Mining Tech"
	description = "Cutting up asteroids using your spacepods"
	requisite_nodes = list("basic_mining", "spacepod_disabler")
	designs = list("pod_ka_basic")

/datum/research_node/spacepod_advmining
	node_id = "spacepod_aka"
	name = "Advanced Spacepod Mining Tech"
	description = "Cutting up asteroids using your spacepods.... faster!"
	requisite_nodes = list("spacepod_ka", "adv_mining")
	designs = list("pod_ka", "pod_plasma_cutter")

/datum/research_node/spacepod_advplasmacutter
	node_id = "spacepod_apc"
	name = "Advanced Spacepod Plasma Cutter"
	description = "Cutting up asteroids using your spacepods........... FASTERRRRRR!!!!!! Oh shit, that was gibtonite."
	requisite_nodes = list("spacepod_aka", "adv_plasma")
	designs = list("pod_adv_plasma_cutter")

/datum/research_node/spacepod_pseat
	node_id = "spacepod_pseat"
	name = "Spacepod Passenger Seat"
	description = "For bringing along victims as you fly off into the far reaches of space"
	requisite_nodes = list("spacepod_basic", "adv_engi")
	designs = list("podcargo_seat")

/datum/research_node/spacepod_storage
	node_id = "spacepod_storage"
	name = "Spacepod Storage"
	description = "For storing the stuff you find in the far reaches of space"
	requisite_nodes = list("spacepod_pseat", "high_efficiency")
	designs = list("podcargo_crate", "podcargo_ore")

/datum/research_node/spacepod_lockbuster
	node_id = "spacepod_lockbuster"
	name = "Spacepod Lock Buster"
	description = "For when someone's being really naughty with a spacepod"
	requisite_nodes = list("spacepod_lasers", "high_efficiency", "adv_mining")
	designs = list("pod_lockbuster")

/datum/research_node/spacepod_iarmor
	node_id = "spacepod_iarmor"
	name = "Advanced Spacepod Armor"
	description = "Better protection for your precious ride. You'll need it if you plan on engaging in spacepod battles."
	requisite_nodes = list("spacepod_storage", "high_efficiency")
	designs = list("podarmor_industiral", "podarmor_sec", "podarmor_gold")

/datum/research_node/dex_robotics
	node_id = "dex_robotics"
	name = "Dexterous Robotics Research"
	description = "The fine art of opposable thumbs."
	requisite_nodes = list("adv_engi", "adv_robotics", "biotech")
	designs = list("maint_drone")

/////////////////////////shuttle tech/////////////////////////
/datum/research_node/basic_shuttle_tech
	node_id = "basic_shuttle"
	name = "Basic Shuttle Research"
	description = "Research the technology required to create and use basic shuttles."
	requisite_nodes = list("bluespace_travel", "adv_engi")
	designs = list("engine_plasma", "engine_ion", "engine_heater", "engine_smes", "shuttle_helm", "rapid_shuttle_designator")

/datum/research_node/exp_shuttle_tech
	node_id = "exp_shuttle"
	name = "Experimental Shuttle Research"
	description = "A bunch of engines and related shuttle parts that are likely not really that useful, but could be in strange situations."
	requisite_nodes = list("basic_shuttle")
	designs = list("engine_expulsion")


////////////////////// Deepcore ///////////////////////

/datum/research_node/deepcore
	node_id = "deepcore"
	name = "Deepcore Mining"
	description = "Mining, but automated."
	requisite_nodes = list("basic_mining")
	designs = list("deepcore_drill", "deepcore_hopper", "deepcore_hub")

////////////////////// IPC Parts ///////////////////////
/datum/research_node/ipc_organs
	node_id = "ipc_organs"
	name = "IPC Parts"
	description = "We have the technology to replace him."
	requisite_nodes = list("cyber_organs","robotics")
	designs = list("robotic_liver", "robotic_eyes", "robotic_tongue", "robotic_stomach", "robotic_ears", "power_cord")

////////////////////////B.E.P.I.S. Locked Techs////////////////////////
/datum/research_node/light_apps
	node_id = "light_apps"
	name = "Illumination Applications"
	description = "Applications of lighting and vision technology not originally thought to be commercially viable."
	requisite_nodes = list("base")
	designs = list("bright_helmet", "rld_mini")
	node_hidden = TRUE
	node_experimental = TRUE

/datum/research_node/rolling_table
	node_id = "rolling_table"
	name = "Advanced Wheel Applications"
	description = "Adding wheels to things can lead to extremely beneficial outcomes."
	requisite_nodes = list("base")
	designs = list("rolling_table")
	node_hidden = TRUE
	node_experimental = TRUE

/datum/research_node/Mauna_Mug
	node_id = "mauna_mug"
	name = "Mauna Mug"
	description = "A bored scientist was thinking to himself for very long...and then realized his coffee got cold! He made this invention to solve this extreme problem."
	requisite_nodes = list("base")
	designs = list("mauna_mug")
	node_hidden = TRUE
	node_experimental = TRUE

/datum/research_node/spec_eng
	node_id = "spec_eng"
	name = "Specialized Engineering"
	description = "Conventional wisdom has deemed these engineering products 'technically' safe, but far too dangerous to traditionally condone."
	requisite_nodes = list("base")
	designs = list("lava_rods", "eng_gloves")
	node_hidden = TRUE
	node_experimental = TRUE

/datum/research_node/aus_security
	node_id = "aus_security"
	name = "Australicus Security Protocols"
	description = "It is said that security in the Australicus sector is tight, so we took some pointers from their equipment. Thankfully, our sector lacks any signs of these, 'dropbears'."
	requisite_nodes = list("base")
	designs = list("stun_boomerang")

	node_hidden = TRUE
	node_experimental = TRUE

/datum/research_node/interrogation
	node_id = "interrogation"
	name = "Enhanced Interrogation Technology"
	description = "By cross-referencing several declassified documents from past dictatorial regimes, we were able to develop an incredibly effective interrogation device. \
	Ethical concerns about loss of free will do not apply to criminals, according to galactic law."
	requisite_nodes = list("base")
	designs = list("hypnochair")

	node_hidden = TRUE
	node_experimental = TRUE

/datum/research_node/sticky_advanced
	node_id = "sticky_advanced"
	name = "Advanced Tapenology"
	description = "The absolute pinnacle of engineering!"
	designs = list("electric_tape", "super_tape")

	node_hidden = TRUE
	node_experimental = TRUE

/datum/research_node/tackle_advanced
	node_id = "tackle_advanced"
	name = "Advanced Grapple Technology"
	description = "Nanotrasen would like to remind its researching staff that it is never acceptable to \"glomp\" your coworkers, and further \"scientific trials\" on the subject \
	will no longer be accepted in its academic journals."
	designs = list("tackle_dolphin", "tackle_rocket")

	node_hidden = TRUE
	node_experimental = TRUE