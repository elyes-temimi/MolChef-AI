extends Node
# ─── GameState.gd — Global Singleton (add to Autoload as "GameState") ───────

var player_name: String = "Chef"
var start_time: float = 0.0
var current_level: int = 1
var hints_used: int = 0
var total_score := 100
var levels_complete: Dictionary = {1: false, 2: false, 3: false}

var scores: Dictionary = {
	"ph":            0.0,
	"emulsion":      0.0,
	"gelification":  0.0,
}

var attempts: Dictionary = {
	"ph":            {"correct": 0, "total": 0},
	"emulsion":      {"correct": 0, "total": 0},
	"gelification":  {"correct": 0, "total": 0},
}

var consecutive_wrong: Dictionary = {
	"ph": 0, "emulsion": 0, "gelification": 0
}
func add_points(points:int):
	total_score += points
	if total_score > 100:
		total_score = 100

func remove_points(points:int):
	total_score -= points
	if total_score < 0:
		total_score = 0

func get_total_score():
	return total_score

func record(concept:String, correct:bool) -> void:

	if !attempts.has(concept):
		attempts[concept] = {
			"correct":0,
			"total":0
		}

	if !consecutive_wrong.has(concept):
		consecutive_wrong[concept] = 0

	attempts[concept]["total"] += 1

	if correct:
		attempts[concept]["correct"] += 1
		consecutive_wrong[concept] = 0
	else:
		consecutive_wrong[concept] += 1

	_recalc(concept)

func _recalc(concept: String) -> void:
	var t = attempts[concept]["total"]
	var c = attempts[concept]["correct"]
	scores[concept] = round(float(c) / float(t) * 100.0) if t > 0 else 0.0

func get_score(concept: String) -> float:
	return scores.get(concept, 0.0)

func get_consecutive(concept: String) -> int:
	return consecutive_wrong.get(concept, 0)

func needs_help(concept: String) -> bool:
	return consecutive_wrong.get(concept, 0) >= 2

func overall() -> float:
	var s = 0.0
	for k in scores: s += scores[k]
	return round(s / scores.size())

func weakest() -> String:
	var w = "ph"
	var low = 999.0
	for k in scores:
		if scores[k] < low:
			low = scores[k]; w = k
	return w

func elapsed_minutes() -> float:
	return (Time.get_ticks_msec() / 1000.0 - start_time) / 60.0

func complete(level: int) -> void:
	levels_complete[level] = true

func reset() -> void:
	player_name = "Chef"; start_time = 0.0; current_level = 1; hints_used = 0
	levels_complete = {1: false, 2: false, 3: false}
	scores = {"ph": 0.0, "emulsion": 0.0, "gelification": 0.0}
	attempts = {
		"ph": {"correct":0,"total":0},
		"emulsion": {"correct":0,"total":0},
		"gelification": {"correct":0,"total":0}
	}
	consecutive_wrong = {"ph":0,"emulsion":0,"gelification":0}
