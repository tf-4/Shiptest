/datum/research_node/medical
	name = "Medical Node"
	abstract = /datum/research_node/medical

/datum/research_node/medical/surgery
	name = "Surgery Node"
	abstract = /datum/research_node/medical/surgery
	/// id of the surgery to unlock
	var/surgery_id = "default"

/datum/research_node/medical/surgery/handle_completion()
	. = ..()
	parent.unlocked_surgeries |= surgery_id
