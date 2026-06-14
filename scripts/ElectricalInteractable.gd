extends Area2D

signal interaction_started(obj)

@export var label : String = ""
@export var object_type : String = ""

var player_near := false
const RED  = Color(1.0,0.25,0.25)
const WHITE = Color.WHITE
const CYAN = Color(0.0,0.8,1.0)
const GREEN = Color(0.0,1.0,0.5)
const YELLOW = Color(1.0,0.9,0.2)

func _ready():
	body_entered.connect(_on_enter)
	body_exited.connect(_on_exit)

	input_pickable = true

	queue_redraw()


func _on_enter(body):
	if body.name == "Player":
		player_near = true
		queue_redraw()


func _on_exit(body):
	if body.name == "Player":
		player_near = false
		queue_redraw()


func _process(_delta):
	if player_near and Input.is_action_just_pressed("interact"):
		interaction_started.emit(self)


func _draw():

	match object_type:

		"battery":
			_draw_battery()

		"switch":
			_draw_switch()

		"resistor":
			_draw_resistor()

		"lamp":
			_draw_lamp()

		"meter":
			_draw_meter()

		_:
			draw_circle(Vector2.ZERO,20,CYAN)

	if player_near:
		_draw_prompt()


func _draw_prompt():

	draw_rect(
		Rect2(-40,-70,80,24),
		Color(0,0,0,0.7),
		true
	)

	draw_rect(
		Rect2(-40,-70,80,24),
		YELLOW,
		false,
		2
	)

	draw_string(
		ThemeDB.fallback_font,
		Vector2(-30,-53),
		"[E]",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		14,
		YELLOW
	)


func _draw_battery():

	draw_rect(Rect2(-18,-28,36,56),Color(0.25,0.25,0.25))
	draw_rect(Rect2(-18,-28,36,56),GREEN,false,2)

	draw_rect(Rect2(-5,-36,10,8),GREEN)

	draw_string(
		ThemeDB.fallback_font,
		Vector2(-25,45),
		label,
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		14,
		WHITE
	)


func _draw_switch():

	draw_rect(Rect2(-24,-18,48,36),Color(0.2,0.2,0.2))
	draw_rect(Rect2(-24,-18,48,36),CYAN,false,2)

	draw_line(
		Vector2(-12,8),
		Vector2(12,-8),
		CYAN,
		3
	)

	draw_string(
		ThemeDB.fallback_font,
		Vector2(-22,40),
		label,
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		14,
		WHITE
	)


func _draw_resistor():

	draw_line(Vector2(-30,0),Vector2(-18,0),WHITE,2)

	draw_rect(
		Rect2(-18,-8,36,16),
		Color(0.7,0.5,0.2)
	)

	draw_rect(
		Rect2(-18,-8,36,16),
		WHITE,
		false,
		2
	)

	draw_line(Vector2(18,0),Vector2(30,0),WHITE,2)

	draw_string(
		ThemeDB.fallback_font,
		Vector2(-28,36),
		label,
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		14,
		WHITE
	)


func _draw_lamp():

	draw_circle(
		Vector2(0,-5),
		16,
		Color(1,1,0,0.25)
	)

	draw_circle(
		Vector2(0,-5),
		14,
		YELLOW
	)

	draw_line(
		Vector2(-8,12),
		Vector2(8,12),
		WHITE,
		2
	)

	draw_string(
		ThemeDB.fallback_font,
		Vector2(-18,40),
		label,
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		14,
		WHITE
	)


func _draw_meter():

	draw_circle(Vector2.ZERO,20,Color(0.1,0.2,0.3))
	draw_circle(Vector2.ZERO,20,CYAN,false,2)

	draw_line(
		Vector2.ZERO,
		Vector2(8,-10),
		RED,
		2
	)

	draw_string(
		ThemeDB.fallback_font,
		Vector2(-30,40),
		label,
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		14,
		WHITE
	)
