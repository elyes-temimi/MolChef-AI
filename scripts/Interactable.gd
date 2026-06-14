extends Area2D
# ─── Interactable.gd — Base class for all interactive kitchen objects ────────
# Subclass or configure via exported vars in the editor

signal interaction_started(interactable)

@export var label: String = "Object"
@export var concept: String = "ph"
@export var object_type: String = "beaker"   # beaker | stove | fridge | sink | shelf
@export var challenge_id: int = 0            # which question set to load

var solved: bool = false
var player_nearby: bool = false
var prompt_node: Node2D = null

const CYAN   = Color(0.0, 0.83, 1.0)
const GREEN  = Color(0.0, 1.0, 0.53)
const YELLOW = Color(1.0, 0.86, 0.16)
const WHITE  = Color(0.86, 0.92, 1.0)

func _ready() -> void:
	body_entered.connect(_on_enter)
	body_exited.connect(_on_exit)

func _on_enter(body: Node) -> void:
	if body.name == "Player":
		player_nearby = true
		queue_redraw()

func _on_exit(body: Node) -> void:
	if body.name == "Player":
		player_nearby = false
		queue_redraw()

func _input(event: InputEvent) -> void:
	if player_nearby and not solved:
		if event is InputEventKey and event.pressed and event.keycode == KEY_E:
			interaction_started.emit(self)

func _draw() -> void:
	_draw_object()
	
	if player_nearby and not solved:
		_draw_prompt()
	if solved:
		_draw_solved_glow()

func _draw_object() -> void:
	match object_type:
		"beaker":   _draw_beaker()
		"stove":    _draw_stove()
		"fridge":   _draw_fridge()
		"sink":     _draw_sink()
		"shelf":    _draw_shelf()
		_:          _draw_beaker()

func _draw_beaker() -> void:
	var col = Color(0.2, 0.6, 1.0) if not solved else Color(0.1, 1.0, 0.4)
	# Glass body
	var pts = PackedVector2Array([
		Vector2(-18, -40), Vector2(-22, 20),
		Vector2(22, 20),   Vector2(18, -40)
	])
	draw_colored_polygon(pts, Color(col, 0.25))
	draw_polyline(pts, Color(col, 0.9), 2)
	draw_line(pts[0], pts[3], Color(col, 0.9), 2)
	# Liquid
	var liq = PackedVector2Array([
		Vector2(-20, -5), Vector2(-21, 18),
		Vector2(21, 18),  Vector2(20, -5)
	])
	draw_colored_polygon(liq, Color(col, 0.5))
	# Bubbles
	if not solved:
		for i in 3:
			draw_circle(Vector2(-8 + i * 8, -10), 3, Color(col, 0.6))
	# Label
	draw_string(ThemeDB.fallback_font, Vector2(-20, 35), label, HORIZONTAL_ALIGNMENT_LEFT, -1, 12, WHITE)

func _draw_stove() -> void:
	var col = Color(0.8, 0.3, 0.1) if not solved else Color(0.1, 1.0, 0.4)
	draw_rect(Rect2(-28, -20, 56, 44), Color(0.15, 0.15, 0.20))
	draw_rect(Rect2(-28, -20, 56, 44), Color(col, 0.7), false, 2)
	# Burners
	for bx in [-12, 12]:
		draw_circle(Vector2(bx, -5), 10, Color(col if not solved else GREEN, 0.4))
		draw_circle(Vector2(bx, -5), 10, Color(col, 0.8), false, 2)
	# Pot
	draw_rect(Rect2(-14, -22, 28, 14), Color(0.3, 0.3, 0.4))
	draw_rect(Rect2(-14, -22, 28, 14), WHITE, false, 1)
	draw_string(ThemeDB.fallback_font, Vector2(-24, 36), label, HORIZONTAL_ALIGNMENT_LEFT, -1, 12, WHITE)

func _draw_fridge() -> void:
	var col = Color(0.4, 0.7, 1.0) if not solved else Color(0.1, 1.0, 0.4)
	draw_rect(Rect2(-24, -50, 48, 74), Color(0.10, 0.14, 0.22))
	draw_rect(Rect2(-24, -50, 48, 74), Color(col, 0.8), false, 2)
	draw_line(Vector2(-24, 0), Vector2(24, 0), Color(col, 0.5), 1)
	draw_circle(Vector2(18, -24), 4, Color(col, 0.6))
	draw_circle(Vector2(18, 14),  4, Color(col, 0.6))
	draw_string(ThemeDB.fallback_font, Vector2(-22, 36), label, HORIZONTAL_ALIGNMENT_LEFT, -1, 12, WHITE)

func _draw_sink() -> void:
	var col = Color(0.5, 0.8, 1.0) if not solved else Color(0.1, 1.0, 0.4)
	draw_rect(Rect2(-26, -18, 52, 38), Color(0.12, 0.18, 0.28))
	draw_rect(Rect2(-26, -18, 52, 38), Color(col, 0.7), false, 2)
	draw_rect(Rect2(-20, -12, 40, 22), Color(0.05, 0.08, 0.15))
	draw_circle(Vector2(0, -22), 4, Color(0.7, 0.7, 0.8))
	draw_string(ThemeDB.fallback_font, Vector2(-24, 28), label, HORIZONTAL_ALIGNMENT_LEFT, -1, 12, WHITE)

func _draw_shelf() -> void:
	var col = Color(0.8, 0.6, 0.3) if not solved else Color(0.1, 1.0, 0.4)
	for sy in [-30, 0, 30]:
		draw_rect(Rect2(-30, sy - 2, 60, 4), Color(col, 0.8))
	for bx in [-20, -5, 10]:
		draw_rect(Rect2(bx, -28, 10, 26), Color(0.2, 0.5, 0.8, 0.6))
	draw_string(ThemeDB.fallback_font, Vector2(-28, 50), label, HORIZONTAL_ALIGNMENT_LEFT, -1, 12, WHITE)

func _draw_prompt() -> void:
	# "E — Interact" floating prompt
	var t = Time.get_ticks_msec() / 1000.0
	var bob = sin(t * 3.0) * 4.0
	var prompt_pos = Vector2(-30, -70 + bob)
	draw_rect(Rect2(prompt_pos, Vector2(60, 22)), Color(0,0,0,0.7), true)
	draw_rect(Rect2(prompt_pos, Vector2(60, 22)), YELLOW, false, 1)
	draw_string(ThemeDB.fallback_font, prompt_pos + Vector2(4, 16), "[E] Interact", HORIZONTAL_ALIGNMENT_LEFT, -1, 12, YELLOW)
	queue_redraw()   # keep animating bob

func _draw_solved_glow() -> void:
	# Green glow overlay when solved
	var s = PackedVector2Array([
		Vector2(-30, -55), Vector2(30, -55),
		Vector2(30, 40),   Vector2(-30, 40)
	])
	draw_colored_polygon(s, Color(0, 1, 0.4, 0.08))
	draw_string(ThemeDB.fallback_font, Vector2(-12, -62), "✓ DONE", HORIZONTAL_ALIGNMENT_LEFT, -1, 13, GREEN)
