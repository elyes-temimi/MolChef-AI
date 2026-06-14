extends Node2D

# ============================================================
# Level 2 - Organic Chemistry Laboratory
#
# Concepts:
# - Functional Groups
# - Organic Reactions
# - Spectroscopy
# - Reagents
#
# Objects:
# - Distillation Setup
# - Fume Hood
# - Spectrometer
# - Reagent Cabinet
# - Molecular Analyzer
# ============================================================

const LEVEL_NAME = "level2"
const CONCEPT = "organic"
var total_objects := 5

# ------------------------------------------------------------
# Colors
# ------------------------------------------------------------

const BG      = Color(0.05,0.07,0.12)
const FLOOR   = Color(0.08,0.12,0.20)
const WALL    = Color(0.06,0.09,0.16)

const TILE_A  = Color(0.09,0.15,0.26)
const TILE_B  = Color(0.07,0.11,0.19)

const CYAN    = Color(0.00,0.85,1.00)
const GREEN   = Color(0.00,1.00,0.55)
const ORANGE  = Color(1.00,0.60,0.15)
const RED     = Color(1.00,0.28,0.28)
const WHITE   = Color(0.90,0.95,1.00)
const GRAY    = Color(0.45,0.55,0.66)

# ------------------------------------------------------------
# Runtime
# ------------------------------------------------------------

var solved_objects := {}

const TOTAL_OBJECTS := 5

var current_object := ""

var _panel : CanvasLayer
var _player : CharacterBody2D
var _camera : Camera2D
var _hud : CanvasLayer

# ============================================================
# READY
# ============================================================

func _ready():

	randomize()

	GameState.current_level = 2

	# Register question database only once

	if !QuestionManager.databases.has(LEVEL_NAME):

		var db = preload("res://data/level2_questions.gd")

		QuestionManager.register_level(
			LEVEL_NAME,
			db.DATA
		)

	_setup_scene()

	_setup_hud()

	queue_redraw()

# ============================================================
# SCENE
# ============================================================

func _setup_scene():

	############################################################
	# PLAYER
	############################################################

	_player = _make_player(Vector2(640,600))

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
	# WALLS
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
	# INTERACTABLE OBJECTS
	############################################################

	_create_object(
		Vector2(220,180),
		"distillation",
		"Distillation Setup"
	)

	_create_object(
		Vector2(1050,180),
		"hood",
		"Fume Hood"
	)

	_create_object(
		Vector2(640,170),
		"spectrometer",
		"IR Spectrometer"
	)

	_create_object(
		Vector2(250,470),
		"cabinet",
		"Reagent Cabinet"
	)

	_create_object(
		Vector2(1030,470),
		"analyzer",
		"Molecular Analyzer"
	)

# ============================================================
# CREATE OBJECT
# ============================================================

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
func get_completed_objects() -> int:

	var total = 0

	for key in solved_objects:

		if solved_objects[key]:
			total += 1

	return total
	# ============================================================
# HUD
# ============================================================

func _setup_hud():

	_hud = CanvasLayer.new()
	_hud.layer = 5
	add_child(_hud)

	var bg = ColorRect.new()
	bg.color = Color(0.02,0.04,0.08,0.96)
	bg.size = Vector2(1280,52)
	_hud.add_child(bg)

	var line = ColorRect.new()
	line.position = Vector2(0,52)
	line.size = Vector2(1280,2)
	line.color = Color(CYAN,0.25)
	_hud.add_child(line)

	var title = Label.new()
	title.text = "🧬 Level 2 - Organic Chemistry Laboratory"
	title.position = Vector2(20,14)
	title.add_theme_font_size_override("font_size",18)
	title.add_theme_color_override("font_color",CYAN)
	_hud.add_child(title)

	var help = Label.new()
	help.text = "Move : WASD / Arrows     Interact : E"
	help.position = Vector2(420,16)
	help.add_theme_font_size_override("font_size",13)
	help.add_theme_color_override("font_color",GRAY)
	_hud.add_child(help)

	var score = Label.new()
	score.name = "ScoreLabel"
	score.position = Vector2(1030,15)
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

func _draw():

	_draw_floor()

	_draw_back_wall()

	_draw_lab_tables()

	_draw_distillation()

	_draw_fume_hood()

	_draw_spectrometer()

	_draw_reagent_cabinet()

	_draw_analyzer()

	_draw_exit()

# ============================================================
# FLOOR
# ============================================================

func _draw_floor():

	for x in range(0,1280,64):

		for y in range(52,720,64):

			var col = TILE_A

			if ((x+y)/64)%2==1:
				col = TILE_B

			draw_rect(Rect2(x,y,64,64),col)

			draw_rect(
				Rect2(x,y,64,64),
				Color(CYAN,0.04),
				false,
				1
			)

# ============================================================
# BACK WALL
# ============================================================

func _draw_back_wall():

	draw_rect(
		Rect2(0,52,1280,160),
		WALL
	)

	draw_rect(
		Rect2(0,205,1280,2),
		Color(CYAN,0.15)
	)

	draw_string(

		ThemeDB.fallback_font,

		Vector2(380,120),

		"ORGANIC CHEMISTRY LAB",

		HORIZONTAL_ALIGNMENT_LEFT,

		-1,

		30,

		CYAN

	)

	draw_string(

		ThemeDB.fallback_font,

		Vector2(455,155),

		"Functional Groups • Spectroscopy • Reagents",

		HORIZONTAL_ALIGNMENT_LEFT,

		-1,

		15,

		WHITE

	)

# ============================================================
# LAB TABLES
# ============================================================

func _draw_lab_tables():

	draw_rect(

		Rect2(

			80,

			220,

			1120,

			18

		),

		Color(0.18,0.24,0.42)

	)

	draw_rect(

		Rect2(

			80,

			238,

			1120,

			80

		),

		Color(0.12,0.17,0.30)

	)

	draw_rect(

		Rect2(

			80,

			220,

			1120,

			18

		),

		Color(CYAN,0.25),

		false,

		2

	)

# ============================================================
# DISTILLATION APPARATUS
# ============================================================


# ============================================================
# FUME HOOD
# ============================================================
# ============================================================
# SPECTROMETER
# ============================================================
# ============================================================
# REAGENT CABINET
# ============================================================

# ============================================================
# MOLECULAR ANALYZER
# ============================================================
# ============================================================
# EXIT
# ============================================================
		# ============================================================
# INTERACTION
# ============================================================

func _on_interact(obj) -> void:

	if solved_objects[obj.object_type]:
		return

	current_object = obj.object_type

	_player.locked = true

	var intro = "You approach the " + obj.label + "."

	var challenge = QuestionManager.make_challenge(
		LEVEL_NAME,
		obj.object_type,
		intro
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

	for child in get_children():

		if child is Area2D:

			if child.object_type == current_object:

				child.solved = true
				GameState.add_points(15)
				child.queue_redraw()

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

	GameState.complete(2)

	print("Organic Chemistry Completed")

	queue_redraw()

# ============================================================
# INPUT
# ============================================================

func _input(event):

	var unlocked := true

	for key in solved_objects:

		if !solved_objects[key]:

			unlocked = false

	if !unlocked:
		return

	if event is InputEventKey:

		if event.pressed:

			if event.keycode == KEY_E:

				if _player_near_exit():

					_next_level()

# ============================================================
# EXIT
# ============================================================

func _player_near_exit() -> bool:

	if _player == null:
		return false

	return _player.global_position.distance_to(
		Vector2(640,120)
	) < 90

# ============================================================
# LOAD LEVEL 3
# ============================================================

func _next_level():

	_player.locked = true

	var fade_layer = CanvasLayer.new()
	fade_layer.layer = 100

	var fade = ColorRect.new()

	fade.color = Color.BLACK
	fade.size = Vector2(1280,720)
	fade.modulate.a = 0.0

	fade_layer.add_child(fade)

	add_child(fade_layer)

	var tween = create_tween()

	tween.tween_property(
		fade,
		"modulate:a",
		1.0,
		0.8
	)

	await tween.finished

	get_tree().change_scene_to_file(
		"res://scenes/Level3.tscn"
	)

func get_completion_percent() -> float:

	var complete = get_completed_objects()

	return float(complete) / float(total_objects) * 100.0
	
func is_level_complete() -> bool:

	return get_completed_objects() == total_objects
# ============================================================
# UTILITIES
# ============================================================

func is_completed() -> bool:

	return get_completed_objects() == TOTAL_OBJECTS

func get_progress_percent() -> float:

	return float(get_completed_objects()) / float(TOTAL_OBJECTS) * 100.0

# ============================================================
# DEBUG
# ============================================================

func _unhandled_key_input(event):

	if !OS.is_debug_build():
		return

	if event is InputEventKey:

		if event.pressed:

			match event.keycode:

				KEY_F8:

					for key in solved_objects:

						solved_objects[key] = true

					queue_redraw()

					print("Level 2 Completed (Debug)")

				KEY_F9:

					print("----------------")

					print("Progress")

					print(get_completed_objects())

					print(get_progress_percent())

					print("----------------")
					# ============================================================
# PLAYER
# ============================================================

func _make_player(pos: Vector2) -> CharacterBody2D:

	var p := CharacterBody2D.new()

	p.name = "Player"

	p.position = pos

	p.set_script(
		load("res://scripts/Player.gd")
	)

	var collision := CollisionShape2D.new()

	var shape := CapsuleShape2D.new()

	shape.radius = 14
	shape.height = 36

	collision.shape = shape

	p.add_child(collision)

	return p

# ============================================================
# INTERACTABLE
# ============================================================

func _make_interactable(
	pos: Vector2,
	lbl: String,
	concept: String,
	obj_type: String,
	challenge_id: int
) -> Area2D:

	var obj := Area2D.new()

	obj.position = pos

	obj.set_script(
		load("res://scripts/Interactable.gd")
	)

	obj.label = lbl
	obj.concept = concept
	obj.object_type = obj_type
	obj.challenge_id = challenge_id

	var collision := CollisionShape2D.new()

	var shape := RectangleShape2D.new()

	shape.size = Vector2(70,70)

	collision.shape = shape

	obj.add_child(collision)

	return obj

# ============================================================
# WALLS
# ============================================================

func _add_wall(rect: Rect2):

	var body := StaticBody2D.new()

	body.position = rect.position

	var collision := CollisionShape2D.new()

	var shape := RectangleShape2D.new()

	shape.size = rect.size

	collision.shape = shape

	collision.position = rect.size / 2.0

	body.add_child(collision)

	add_child(body)

# ============================================================
# LOOKUP
# ============================================================

func get_station(id:String):

	for child in get_children():

		if child is Area2D:

			if child.object_type == id:

				return child

	return null

# ============================================================
# STATION NAME
# ============================================================

func get_station_name(id:String)->String:

	match id:

		"distillation":
			return "Distillation Setup"

		"hood":
			return "Fume Hood"

		"spectrometer":
			return "IR Spectrometer"

		"cabinet":
			return "Reagent Cabinet"

		"analyzer":
			return "Molecular Analyzer"

	return id

# ============================================================
# LEVEL INFO
# ============================================================

func get_level_name()->String:

	return "Organic Chemistry Laboratory"

func get_level_number()->int:

	return 2

func get_level_topic()->String:

	return "Organic Chemistry"

func get_level_description()->String:

	return "Learn functional groups, spectroscopy and organic reactions."

# ============================================================
# SAVE
# ============================================================

func get_save_data()->Dictionary:

	return {

		"level":2,

		"stations":solved_objects.duplicate(true)

	}

# ============================================================
# LOAD
# ============================================================

func load_save_data(data:Dictionary):

	if data.has("stations"):

		solved_objects = data["stations"]

	queue_redraw()

# ============================================================
# RESET
# ============================================================

func reset_level():

	for key in solved_objects:

		solved_objects[key] = false

	queue_redraw()

# ============================================================
# RELOAD
# ============================================================

func restart():

	get_tree().reload_current_scene()

# ============================================================
# DEBUG
# ============================================================

func print_progress():

	print("====================")

	print(get_level_name())

	print("====================")

	for key in solved_objects:

		print(

			get_station_name(key),

			" -> ",

			solved_objects[key]

		)

	print(

		"Completion : ",

		get_progress_percent(),

		"%"

	)

	print("====================")
	# ============================================================
# VISUAL EFFECTS
# ============================================================

var _anim_time := 0.0
# ============================================================
# GLOWING STATIONS
# ============================================================

func _draw_glow():

	for child in get_children():

		if !(child is Area2D):
			continue

		var col = CYAN

		if child.solved:
			col = GREEN

		var pulse = 6 * sin(_anim_time * 2.5)

		draw_circle(
			child.global_position,
			34 + pulse,
			Color(col,0.08)
		)

		draw_circle(
			child.global_position,
			22,
			Color(col,0.18)
		)

# ============================================================
# LABELS
# ============================================================

func _draw_labels():

	for child in get_children():

		if !(child is Area2D):
			continue

		var color = CYAN

		if child.solved:
			color = GREEN

		var text = child.label

		if child.solved:

			text += " ✓"

		draw_string(

			ThemeDB.fallback_font,

			child.global_position + Vector2(-45,-48),

			text,

			HORIZONTAL_ALIGNMENT_LEFT,

			-1,

			14,

			color

		)

# ============================================================
# FLOATING MOLECULES
# ============================================================

func _draw_molecules():

	for i in range(12):

		var x = 70 + i * 95

		var y = 90 + sin(_anim_time * 1.5 + i) * 6

		draw_circle(
			Vector2(x,y),
			5,
			Color(CYAN,0.35)
		)

		draw_circle(
			Vector2(x+16,y+10),
			4,
			Color(WHITE,0.25)
		)

		draw_line(
			Vector2(x,y),
			Vector2(x+16,y+10),
			Color(CYAN,0.25),
			2
		)

# ============================================================
# DISTILLATION ANIMATION
# ============================================================

func _draw_distillation():

	var p = Vector2(220,180)

	draw_circle(p,18,Color(0.55,0.90,1))

	draw_line(
		p+Vector2(0,-18),
		p+Vector2(45,-45),
		WHITE,
		3
	)

	draw_circle(
		p+Vector2(52,-52),
		10,
		Color(0.45,0.9,1)
	)

	for i in range(3):

		var yy = sin(_anim_time*2+i)*8

		draw_circle(
			p+Vector2(0,-8-yy),
			2,
			Color(WHITE,0.6)
		)

# ============================================================
# FUME HOOD GAS
# ============================================================

func _draw_fume_hood():

	var p = Vector2(1050,180)

	draw_rect(
		Rect2(
			p.x-35,
			p.y-35,
			70,
			70
		),
		Color(0.16,0.20,0.30)
	)

	for i in range(5):

		var off = sin(_anim_time*2+i)

		draw_circle(
			p+Vector2(off*8,-10-i*8),
			5,
			Color(0.3,1,0.4,0.15)
		)

# ============================================================
# COMPUTER SCREEN
# ============================================================

func _draw_spectrometer():

	var p = Vector2(640,170)

	draw_rect(
		Rect2(
			p.x-32,
			p.y-20,
			64,
			40
		),
		Color(0.18,0.20,0.28)
	)

	var intensity = abs(sin(_anim_time*4))

	draw_rect(

		Rect2(
			p.x-22,
			p.y-10,
			44,
			20
		),

		Color(
			0.1,
			0.8,
			1,
			0.25+intensity*0.4
		)

	)

# ============================================================
# CABINET
# ============================================================

func _draw_reagent_cabinet():

	var p = Vector2(250,470)

	draw_rect(
		Rect2(
			p.x-25,
			p.y-45,
			50,
			90
		),
		Color(0.42,0.28,0.12)
	)

	draw_line(
		Vector2(p.x,p.y-45),
		Vector2(p.x,p.y+45),
		Color.BLACK,
		2
	)

# ============================================================
# ANALYZER
# ============================================================

func _draw_analyzer():

	var p = Vector2(1030,470)

	draw_circle(
		p,
		24,
		Color(0.25,0.9,1)
	)

	draw_circle(
		p,
		10+abs(sin(_anim_time*5))*3,
		Color(0.05,0.15,0.20)
	)

# ============================================================
# EXIT
# ============================================================

func _draw_exit():

	if !is_completed():
		return

	var pulse = abs(sin(_anim_time*3))

	draw_rect(

		Rect2(
			590,
			52,
			100,
			130
		),

		Color(
			0,
			1,
			0.5,
			0.18+pulse*0.12
		)

	)

	draw_rect(

		Rect2(
			590,
			52,
			100,
			130
		),

		GREEN,

		false,

		2

	)

	draw_string(

		ThemeDB.fallback_font,

		Vector2(610,96),

		"LEVEL 3",

		HORIZONTAL_ALIGNMENT_LEFT,

		-1,

		18,

		GREEN

	)

	draw_string(

		ThemeDB.fallback_font,

		Vector2(602,118),

		"[E] Continue",

		HORIZONTAL_ALIGNMENT_LEFT,

		-1,

		14,

		WHITE

	)
