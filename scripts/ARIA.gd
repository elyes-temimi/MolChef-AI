extends Node
# ─── ARIA.gd — AI Mentor Autoload (add to Autoload as "ARIA") ───────────────

signal responded(msg: String)
signal errored(msg: String)

const URL   = "http://localhost:11434/api/generate"
const MODEL = "llama3.1"
const SYS   = """You are ARIA, an AI molecular cuisine mentor inside MolChef, an educational game.
You are a brilliant, warm, slightly dramatic chef-scientist.
RULES: Never give the direct answer. Max 2 sentences. End with a question or clue.
Mix cooking and chemistry naturally. Simple language for ages 16-25. Always encouraging."""

var _http: HTTPRequest

func _ready() -> void:
	_http = HTTPRequest.new()
	add_child(_http)
	_http.request_completed.connect(_on_done)

func hint(concept: String, wrong: String, streak: int) -> void:
	var tone = "Very gentle, near-direct clue." if streak >= 3 \
		else ("More direct, address misconception." if streak == 2 \
		else "Light Socratic nudge.")
	_call("%s\nConcept: %s\nWrong answer: %s\nGive a brief cooking-chemistry hint." % [tone, concept, wrong])

func celebrate(concept: String, learned: String) -> void:
	_call("Student got it right!\nConcept: %s\nThey learned: %s\nOne excited sentence + one science-cooking insight." % [concept, learned])

func intro(level: int, ctx: String) -> void:
	_call("Level %d starting. Context: %s\n2 dramatic sentences briefing the player as Chef-Scientist ARIA." % [level, ctx])

func passport(pname: String, ph: float, em: float, gel: float, weak: String, mins: float) -> void:
	var sys2 = "You are ARIA writing an official MolChef Science Passport. Warm, scientific, specific. Emoji headers. Max 180 words."
	_call("Passport for Chef: %s\npH: %.0f%%  Emulsion: %.0f%%  Gélification: %.0f%%\nWeakest: %s  Time: %.0f min\nInclude: certification, score interpretation, next study recommendation, closing." % [pname, ph, em, gel, weak, mins], sys2)

func _call(prompt: String, sys: String = SYS) -> void:
	var body = JSON.stringify({"model": MODEL, "prompt": prompt, "system": sys, "stream": false, "options": {"temperature": 0.7, "num_predict": 120}})
	var err = _http.request(URL, ["Content-Type: application/json"], HTTPClient.METHOD_POST, body)
	if err != OK:
		errored.emit("⚠ ARIA offline — run: ollama serve")

func _on_done(result: int, _code: int, _h: PackedStringArray, body: PackedByteArray) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		errored.emit("⚠ Cannot reach ARIA. Is ollama running?")
		return
	var j = JSON.new()
	if j.parse(body.get_string_from_utf8()) == OK:
		responded.emit(j.get_data().get("response", "").strip_edges())
	else:
		errored.emit("⚠ ARIA parse error.")

func respond(message:String) -> void:
	responded.emit(message)
