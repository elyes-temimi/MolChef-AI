extends Node

# ============================================================
# QuestionManager.gd
# Random challenge manager for MolChef
# ============================================================

# Dictionary containing every level's question pools.
# Each object (beaker, stove...) has its own list.

var databases = {}

func _ready():
	randomize()

# ------------------------------------------------------------
# Register a level database
# ------------------------------------------------------------
func register_level(level_name:String, data:Dictionary) -> void:
	databases[level_name] = data


# ------------------------------------------------------------
# Returns N random questions for one object
# ------------------------------------------------------------
func get_questions(level_name:String, object_name:String, amount:int=3) -> Array:

	if !databases.has(level_name):
		push_error("Unknown level: " + level_name)
		return []

	var level = databases[level_name]

	if !level.has(object_name):
		push_error("Unknown object: " + object_name)
		return []

	var pool:Array = level[object_name].duplicate(true)

	pool.shuffle()

	if amount > pool.size():
		amount = pool.size()

	return pool.slice(0, amount)


# ------------------------------------------------------------
# Returns challenge dictionary compatible with ChallengePanel
# ------------------------------------------------------------
func make_challenge(level_name:String,
		object_name:String,
		intro:String="") -> Dictionary:

	var questions = get_questions(level_name, object_name, 3)

	return {
		"intro_ctx": intro,
		"steps": questions
	}


# ------------------------------------------------------------
# Get every object in a level
# ------------------------------------------------------------
func get_objects(level_name:String) -> Array:

	if !databases.has(level_name):
		return []

	return databases[level_name].keys()


# ------------------------------------------------------------
# Number of questions available
# ------------------------------------------------------------
func question_count(level_name:String,
		object_name:String) -> int:

	if !databases.has(level_name):
		return 0

	if !databases[level_name].has(object_name):
		return 0

	return databases[level_name][object_name].size()
