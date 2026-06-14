extends Node2D

# ============================================================
# Level1.gd
# Molecular Kitchen
#
# Every interactable has its own randomized question pool.
#
# Objects:
#   - Beaker
#   - Stove
#   - Sink
#   - Shelf
#   - Fridge
#
# All five must be completed to unlock the exit.
# ============================================================

const LEVEL_NAME = "level1"
const CONCEPT = "ph"

# ------------------------------------------------------------
# Colors
# ------------------------------------------------------------

const BG      = Color(0.06,0.09,0.16)
const FLOOR   = Color(0.09,0.13,0.22)
const WALL    = Color(0.07,0.10,0.18)

const TILE_A  = Color(0.10,0.15,0.26)
const TILE_B  = Color(0.08,0.12,0.20)

const CYAN    = Color(0.0,0.83,1.0)
const GREEN   = Color(0.0,1.0,0.53)
const ORANGE  = Color(1.0,0.63,0.16)
const RED     = Color(1.0,0.25,0.25)
const WHITE   = Color(0.90,0.93,1.0)
const GRAY    = Color(0.45,0.55,0.66)

# ------------------------------------------------------------
# Runtime
# ------------------------------------------------------------

var solved_objects = {}

var total_objects := 5

var current_object := ""

var _panel : CanvasLayer
var _player : CharacterBody2D
var _camera : Camera2D
var _hud : CanvasLayer

# ------------------------------------------------------------
# Ready
# ------------------------------------------------------------

func _ready():

	randomize()

	GameState.current_level = 1

	# Register Level 1 database once

	if !QuestionManager.databases.has(LEVEL_NAME):

		var db = preload("res://data/level1_questions.gd")

		QuestionManager.register_level(
			LEVEL_NAME,
			db.DATA
		)

	_setup_scene()

	_setup_hud()

	queue_redraw()

# ------------------------------------------------------------
# Scene
# ------------------------------------------------------------

func _setup_scene():

	############################################################
	# PLAYER
	############################################################

	_player = _make_player(Vector2(640,360))

	add_child(_player)

	############################################################
	# CAMERA
	############################################################

	_camera = Camera2D.new()

	_camera.enabled = true

	_camera.position = Vector2.ZERO

	_player.add_child(_camera)

	_camera.make_current()

	############################################################
	# WORLD WALLS
	############################################################

	_add_wall(Rect2(-20,-20,20,740))

	_add_wall(Rect2(1280,-20,20,740))

	_add_wall(Rect2(-20,-20,1300,20))

	_add_wall(Rect2(-20,720,1300,20))

	############################################################
	# CHALLENGE PANEL
	############################################################

	_panel = preload(
		"res://scenes/ChallengePanel.tscn"
	).instantiate()

	add_child(_panel)

	_panel.solved.connect(_on_challenge_solved)

	_panel.closed.connect(_on_panel_closed)

	############################################################
	# OBJECTS
	############################################################

	_create_object(
		Vector2(250,250),
		"beaker",
		"pH Beaker"
	)

	_create_object(
		Vector2(500,250),
		"stove",
		"Reaction Stove"
	)

	_create_object(
		Vector2(760,250),
		"sink",
		"Safety Sink"
	)

	_create_object(
		Vector2(1020,250),
		"shelf",
		"Chemical Shelf"
	)

	_create_object(
		Vector2(640,520),
		"fridge",
		"Cold Storage"
	)

# ------------------------------------------------------------
# Create object
# ------------------------------------------------------------

func _create_object(
	pos:Vector2,
	id:String,
	label:String
):

	var obj = _make_interactable(
		pos,
		label,
		CONCEPT,
		id,
		0
	)

	solved_objects[id] = false

	obj.interaction_started.connect(
		_on_interact
	)

	add_child(obj)
	# ============================================================
# HUD
# ============================================================

func _setup_hud():

	_hud = CanvasLayer.new()
	_hud.layer = 5
	add_child(_hud)

	var bg = ColorRect.new()
	bg.color = Color(0.03,0.05,0.10,0.95)
	bg.size = Vector2(1280,52)
	_hud.add_child(bg)

	var line = ColorRect.new()
	line.position = Vector2(0,52)
	line.size = Vector2(1280,1)
	line.color = Color(CYAN,0.25)
	_hud.add_child(line)

	var title = Label.new()
	title.text = "🧪 MolChef — Level 1 : Molecular Kitchen"
	title.position = Vector2(18,14)
	title.add_theme_font_size_override("font_size",18)
	title.add_theme_color_override("font_color",CYAN)
	_hud.add_child(title)

	var controls = Label.new()
	controls.position = Vector2(380,16)
	controls.text = "Move : WASD / Arrows    Interact : E"
	controls.add_theme_font_size_override("font_size",13)
	controls.add_theme_color_override("font_color",GRAY)
	_hud.add_child(controls)

	var score = Label.new()
	score.name = "ScoreLabel"
	score.position = Vector2(980,14)
	score.text = "0 / 5"
	score.add_theme_font_size_override("font_size",16)
	score.add_theme_color_override("font_color",WHITE)
	_hud.add_child(score)

# ============================================================
# PROCESS
# ============================================================

func _process(_delta):

	if _hud == null:
		return

	var completed = 0

	for k in solved_objects:

		if solved_objects[k]:
			completed += 1

	var lbl = _hud.get_node("ScoreLabel")

	lbl.text = str(completed) + " / " + str(total_objects)

# ============================================================
# DRAW
# ============================================================


# ============================================================
# FLOOR
# ============================================================

func _draw_floor():

	for x in range(0,1280,64):

		for y in range(52,720,64):

			var c = TILE_A

			if ((x+y)/64)%2==1:
				c = TILE_B

			draw_rect(
				Rect2(x,y,64,64),
				c
			)

			draw_rect(
				Rect2(x,y,64,64),
				Color(CYAN,0.03),
				false,
				1
			)

# ============================================================
# BACK WALL
# ============================================================

func _draw_back_wall():

	draw_rect(
		Rect2(0,52,1280,150),
		WALL
	)

	draw_rect(
		Rect2(0,198,1280,2),
		Color(CYAN,0.15)
	)

	for x in range(20,1280,120):

		draw_rect(
			Rect2(x,65,90,110),
			Color(CYAN,0.04)
		)

		draw_rect(
			Rect2(x,65,90,110),
			Color(CYAN,0.10),
			false,
			1
		)

# ============================================================
# COUNTER
# ============================================================

func _draw_counter():

	draw_rect(

		Rect2(
			40,
			200,
			1200,
			18
		),

		Color(0.16,0.24,0.40)

	)

	draw_rect(

		Rect2(
			40,
			218,
			1200,
			70
		),

		Color(0.11,0.16,0.27)

	)

	draw_rect(

		Rect2(
			40,
			200,
			1200,
			18
		),

		Color(CYAN,0.2),

		false,

		2

	)

# ============================================================
# CABINETS
# ============================================================

func _draw_cabinets():

	for x in range(70,1200,110):

		draw_rect(

			Rect2(

				x,

				226,

				90,

				56

			),

			Color(0.08,0.13,0.22)

		)

		draw_rect(

			Rect2(

				x,

				226,

				90,

				56

			),

			Color(CYAN,0.12),

			false,

			1

		)

		draw_circle(

			Vector2(

				x+74,

				254

			),

			3,

			Color(CYAN,0.45)

		)

# ============================================================
# TITLE
# ============================================================

func _draw_title():

	draw_string(

		ThemeDB.fallback_font,

		Vector2(430,130),

		"⚗ MOLECULAR KITCHEN",

		HORIZONTAL_ALIGNMENT_LEFT,

		-1,

		28,

		Color(CYAN)

	)

	draw_string(

		ThemeDB.fallback_font,

		Vector2(490,160),

		"Acids • Bases • Neutralization",

		HORIZONTAL_ALIGNMENT_LEFT,

		-1,

		16,

		Color(WHITE)

	)

# ============================================================
# EXIT
# ============================================================

func _draw_exit():

	var unlocked = true

	for k in solved_objects:

		if !solved_objects[k]:

			unlocked = false

	if unlocked:

		draw_rect(

			Rect2(590,52,100,130),

			Color(GREEN,0.18)

		)

		draw_rect(

			Rect2(590,52,100,130),

			GREEN,

			false,

			2

		)

		draw_string(

			ThemeDB.fallback_font,

			Vector2(608,98),

			"EXIT",

			HORIZONTAL_ALIGNMENT_LEFT,

			-1,

			22,

			GREEN

		)

		draw_string(

			ThemeDB.fallback_font,

			Vector2(598,122),

			"[E] Continue",

			HORIZONTAL_ALIGNMENT_LEFT,

			-1,

			14,

			WHITE

		)
		# ============================================================
# INTERACTION
# ============================================================

func _on_interact(obj) -> void:

	# Already solved
	if solved_objects[obj.object_type]:
		return

	current_object = obj.object_type

	_player.locked = true

	var challenge = QuestionManager.make_challenge(
		LEVEL_NAME,
		obj.object_type,
		"You inspect the " + obj.label + "."
	)

	_panel.open(
		challenge,
		CONCEPT
	)

# ============================================================
# CHALLENGE COMPLETED
# ============================================================

func _on_challenge_solved(_concept:String) -> void:

	solved_objects[current_object] = true

	# Mark only the current object as solved
	for child in get_children():

		if child is Area2D:

			if child.object_type == current_object:
				
				child.solved = true

				child.queue_redraw()
			
				GameState.add_points(15)

	_player.locked = false
	GameState.remove_points(15)
	queue_redraw()

	_check_level_complete()

# ============================================================
# PANEL CLOSED
# ============================================================

func _on_panel_closed() -> void:

	if _player != null:
		_player.locked = false

# ============================================================
# CHECK LEVEL COMPLETE
# ============================================================

func _check_level_complete():

	for key in solved_objects:

		if !solved_objects[key]:
			return

	GameState.complete(1)

	print("LEVEL 1 COMPLETE")

	queue_redraw()

# ============================================================
# INPUT
# ============================================================

func _input(event):

	var unlocked = true

	for key in solved_objects:

		if !solved_objects[key]:

			unlocked = false

	if !unlocked:
		return

	if event is InputEventKey:

		if event.pressed:

			if event.keycode == KEY_E:

				if _player_near_exit():

					_load_next_level()

# ============================================================
# EXIT CHECK
# ============================================================

func _player_near_exit() -> bool:

	if _player == null:
		return false

	return _player.global_position.distance_to(
		Vector2(640,120)
	) < 90

# ============================================================
# NEXT LEVEL
# ============================================================

func _load_next_level():

	if _player != null:

		_player.locked = true

	var fade = ColorRect.new()

	fade.color = Color.BLACK

	fade.size = Vector2(1280,720)

	fade.modulate.a = 0.0

	var canvas = CanvasLayer.new()

	canvas.layer = 100

	canvas.add_child(fade)

	add_child(canvas)

	var tween = create_tween()

	tween.tween_property(
		fade,
		"modulate:a",
		1.0,
		0.8
	)

	await tween.finished

	get_tree().change_scene_to_file(
		"res://scenes/Level2.tscn"
	)

# ============================================================
# OBJECT PROGRESS
# ============================================================

func get_completed_objects() -> int:

	var total = 0

	for key in solved_objects:

		if solved_objects[key]:
			total += 1

	return total

# ============================================================
# LEVEL FINISHED?
# ============================================================

func is_level_complete() -> bool:

	return get_completed_objects() == total_objects

# ============================================================
# DEBUG
# ============================================================

func _unhandled_key_input(event):

	if OS.is_debug_build():

		if event is InputEventKey:

			if event.pressed:

				if event.keycode == KEY_F8:

					for k in solved_objects:

						solved_objects[k] = true

					queue_redraw()

					print("DEBUG : Level Completed")
					# ============================================================
# PLAYER
# ============================================================

func _make_player(pos:Vector2) -> CharacterBody2D:

	var p = CharacterBody2D.new()

	p.name = "Player"

	p.position = pos

	p.set_script(
		load("res://scripts/Player.gd")
	)

	var col = CollisionShape2D.new()

	var shape = CapsuleShape2D.new()

	shape.radius = 14
	shape.height = 36

	col.shape = shape

	p.add_child(col)

	return p

# ============================================================
# INTERACTABLE
# ============================================================

func _make_interactable(
	pos:Vector2,
	lbl:String,
	concept:String,
	obj_type:String,
	challenge_id:int
):

	var obj = Area2D.new()

	obj.position = pos

	obj.set_script(
		load("res://scripts/Interactable.gd")
	)

	obj.label = lbl
	obj.concept = concept
	obj.object_type = obj_type
	obj.challenge_id = challenge_id

	var col = CollisionShape2D.new()

	var shape = RectangleShape2D.new()

	shape.size = Vector2(64,64)

	col.shape = shape

	obj.add_child(col)

	return obj

# ============================================================
# WALL
# ============================================================

func _add_wall(rect:Rect2):

	var body = StaticBody2D.new()

	body.position = rect.position

	var col = CollisionShape2D.new()

	var shape = RectangleShape2D.new()

	shape.size = rect.size

	col.shape = shape

	col.position = rect.size / 2.0

	body.add_child(col)

	add_child(body)

# ============================================================
# OBJECT LOOKUP
# ============================================================

func get_object_by_type(type:String):

	for child in get_children():

		if child is Area2D:

			if child.object_type == type:

				return child

	return null

# ============================================================
# OBJECT STATUS
# ============================================================

func object_completed(type:String) -> bool:

	if !solved_objects.has(type):
		return false

	return solved_objects[type]

# ============================================================
# LEVEL PROGRESS %
# ============================================================

func get_completion_percent() -> float:

	var complete = get_completed_objects()

	return float(complete) / float(total_objects) * 100.0

# ============================================================
# LEVEL NAME
# ============================================================

func get_level_name() -> String:

	return "Molecular Kitchen"

# ============================================================
# LEVEL DESCRIPTION
# ============================================================

func get_level_description() -> String:

	return "Learn pH, acids, bases and neutralization."

# ============================================================
# OBJECT DISPLAY NAME
# ============================================================

func get_display_name(id:String) -> String:

	match id:

		"beaker":
			return "pH Beaker"

		"stove":
			return "Reaction Stove"

		"sink":
			return "Safety Sink"

		"shelf":
			return "Chemical Shelf"

		"fridge":
			return "Cold Storage"

	return id

# ============================================================
# SAVE DATA
# ============================================================

func get_save_data() -> Dictionary:

	return {
		"level":1,
		"solved":solved_objects.duplicate(true)
	}

# ============================================================
# LOAD DATA
# ============================================================

func load_save_data(data:Dictionary):

	if data.has("solved"):

		solved_objects = data["solved"]

	queue_redraw()

# ============================================================
# RESTART LEVEL
# ============================================================

func restart_level():

	get_tree().reload_current_scene()

# ============================================================
# DEBUG OBJECTS
# ============================================================

func print_progress():

	print("------ LEVEL 1 ------")

	for key in solved_objects:

		print(
			key,
			" => ",
			solved_objects[key]
		)

	print(
		"Completion: ",
		get_completion_percent(),
		"%"
	)
	# ============================================================
# LEVEL VISUAL POLISH
# ============================================================

func _notification(what):

	if what == NOTIFICATION_WM_WINDOW_FOCUS_IN:

		queue_redraw()

# ============================================================
# SCIENTIFIC DECORATIONS
# ============================================================

func _draw_science_decorations():

	# Decorative molecules

	for i in range(8):

		var x = 120 + i * 130

		var y = 90

		draw_circle(
			Vector2(x, y),
			8,
			Color(CYAN, 0.18)
		)

		draw_circle(
			Vector2(x + 22, y + 16),
			6,
			Color(WHITE, 0.15)
		)

		draw_line(
			Vector2(x, y),
			Vector2(x + 22, y + 16),
			Color(CYAN, 0.20),
			2
		)

# ============================================================
# OBJECT LABELS
# ============================================================

func _draw_object_labels():

	for child in get_children():

		if !(child is Area2D):
			continue

		var pos = child.global_position + Vector2(-40, -55)

		var text = child.label

		if child.solved:

			text += "  ✓"

			draw_string(
				ThemeDB.fallback_font,
				pos,
				text,
				HORIZONTAL_ALIGNMENT_LEFT,
				-1,
				14,
				GREEN
			)

		else:

			draw_string(
				ThemeDB.fallback_font,
				pos,
				text,
				HORIZONTAL_ALIGNMENT_LEFT,
				-1,
				14,
				CYAN
			)

# ============================================================
# OBJECT GLOW
# ============================================================

func _draw_object_glow():

	for child in get_children():

		if !(child is Area2D):
			continue

		var color = CYAN

		if child.solved:
			color = GREEN

		draw_circle(
			child.global_position,
			42,
			Color(color, 0.08)
		)

		draw_circle(
			child.global_position,
			34,
			Color(color, 0.15)
		)

# ============================================================
# OBJECT ICONS
# ============================================================

func _draw_icons():

	for child in get_children():

		if !(child is Area2D):
			continue

		var p = child.global_position

		match child.object_type:

			"beaker":

				draw_circle(
					p,
					18,
					Color(0.40,0.80,1.0)
				)

				draw_rect(
					Rect2(
						p.x-8,
						p.y-24,
						16,
						8
					),
					Color.WHITE
				)

			"stove":

				draw_rect(
					Rect2(
						p.x-20,
						p.y-20,
						40,
						40
					),
					Color(0.25,0.25,0.30)
				)

				draw_circle(
					p,
					10,
					ORANGE
				)

			"sink":

				draw_rect(
					Rect2(
						p.x-18,
						p.y-14,
						36,
						24
					),
					Color(0.60,0.70,0.80)
				)

			"shelf":

				draw_rect(
					Rect2(
						p.x-20,
						p.y-24,
						40,
						48
					),
					Color(0.45,0.30,0.15)
				)

			"fridge":

				draw_rect(
					Rect2(
						p.x-18,
						p.y-30,
						36,
						60
					),
					Color(0.80,0.90,1.0)
				)

# ============================================================
# OVERRIDE DRAW
# ============================================================

func _draw():

	_draw_floor()

	_draw_back_wall()

	_draw_counter()

	_draw_cabinets()

	_draw_title()

	_draw_exit()

	_draw_science_decorations()

	_draw_object_glow()

	_draw_icons()

	_draw_object_labels()

# ============================================================
# DEBUG
# ============================================================

func _exit_tree():

	print("Leaving Level 1")
		
