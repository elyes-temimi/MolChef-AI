extends Node2D

const CONCEPT = "electricity"

const BG      = Color(0.05,0.07,0.12)
const FLOOR   = Color(0.08,0.11,0.18)
const WALL    = Color(0.10,0.13,0.22)
const ORANGE  = Color(1.0, 0.63, 0.16)

const CYAN    = Color(0,0.8,1)
const GREEN   = Color(0,1,0.5)
const RED     = Color(1,0.25,0.25)
const YELLOW  = Color(1,0.9,0.2)
const WHITE   = Color(0.92,0.94,1)

var player
var camera

var battery
var switch_box
var resistor
var lamp
var voltmeter

var wire1=false
var wire2=false
var wire3=false

var switch_on=false
var solved=false

var panel

func _ready():

	GameState.current_level = 3

	_create_player()

	_create_boundaries()

	_create_objects()

	_create_ui()

	queue_redraw()
	
func _create_world():

	camera.enabled=true
	add_child(camera)
	
func _create_player():

	player = _make_player(Vector2(640,360))
	add_child(player)

	camera = Camera2D.new()
	camera.enabled = true
	camera.position = Vector2.ZERO

	player.add_child(camera)
	camera.make_current()
func _create_objects():

	battery=_make_object(
		Vector2(160,320),
		"Battery",
		"battery")

	add_child(battery)

	switch_box=_make_object(
		Vector2(410,320),
		"Switch",
		"switch")

	add_child(switch_box)

	resistor=_make_object(
		Vector2(680,320),
		"Resistor",
		"resistor")

	add_child(resistor)

	lamp=_make_object(
		Vector2(980,320),
		"Lamp",
		"lamp")

	add_child(lamp)

	voltmeter=_make_object(
		Vector2(640,560),
		"Voltmeter",
		"meter")

	add_child(voltmeter)

	battery.interaction_started.connect(_on_object)
	switch_box.interaction_started.connect(_on_object)
	resistor.interaction_started.connect(_on_object)
	lamp.interaction_started.connect(_on_object)
	voltmeter.interaction_started.connect(_on_object)
func _create_ui():

	panel=CanvasLayer.new()

	add_child(panel)

	var lbl=Label.new()

	lbl.name="Status"

	lbl.position=Vector2(20,20)

	lbl.text="Repair the circuit"

	lbl.add_theme_font_size_override(
		"font_size",18)

	panel.add_child(lbl)
func _draw():

	draw_rect(Rect2(0,0,1280,720),BG)

	for x in range(0,1280,64):
		for y in range(0,720,64):

			var c=FLOOR

			if ((x+y)/64)%2==0:
				c=WALL

			draw_rect(
				Rect2(x,y,64,64),
				c)

	draw_string(
		ThemeDB.fallback_font,
		Vector2(420,70),
		"LEVEL 3 - CIRCUIT REPAIR LAB",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		28,
		CYAN
	)

	_draw_circuit()
	_draw_exit()
		# ==========================================================
# INTERACTION LOGIC
# ==========================================================

func _on_object(obj):
	print("INTERACTED WITH ", obj.object_type)
	match obj.object_type:

		"battery":
			_on_battery()

		"switch":
			_on_switch()

		"resistor":
			_on_resistor()

		"lamp":
			_on_lamp()

		"meter":
			_on_meter()

	update_status()

	queue_redraw()


# ==========================================================
# BATTERY
# ==========================================================

func _on_battery():

	if wire1:
		return

	wire1 = true

	update_status()

	queue_redraw()

	print("Battery connected")


# ==========================================================
# SWITCH
# ==========================================================

func _on_switch():

	if !wire1:
		ARIA.respond(
			"The switch isn't connected to a power source."
		)
		return

	if wire2:
		switch_on = !switch_on

		if switch_on:
			ARIA.respond("Switch closed.")
		else:
			ARIA.respond("Switch opened.")

		return

	wire2 = true

	ARIA.respond(
		"Switch connected successfully."
	)


# ==========================================================
# RESISTOR
# ==========================================================

func _on_resistor():

	if !wire2:
		ARIA.respond(
			"The resistor isn't connected yet."
		)
		return

	if wire3:
		return

	wire3 = true

	ARIA.respond(
		"Resistor added.\nCurrent is now limited safely."
	)


# ==========================================================
# LAMP
# ==========================================================

func _on_lamp():

	if !(wire1 and wire2 and wire3):

		ARIA.respond(
			"The lamp cannot receive current yet."
		)

		return

	if !switch_on:

		ARIA.respond(
			"Close the switch first."
		)

		return

	solved = true

	ARIA.respond(
		"Excellent!\nThe lamp lights up because the circuit is complete."
	)

	GameState.complete(3)

	await get_tree().create_timer(1.5).timeout

	get_tree().change_scene_to_file(
		"res://scenes/Level4.tscn"
	)


# ==========================================================
# VOLTMETER
# ==========================================================

func _on_meter():

	var voltage = 0

	if wire1:
		voltage = 9

	if wire1 and wire2:
		voltage = 9

	if wire1 and wire2 and wire3:
		voltage = 9

	if solved:
		voltage = 9

	ARIA.respond(
		"Measured voltage : " + str(voltage) + " V"
	)


# ==========================================================
# HUD
# ==========================================================

func update_status():

	var lbl = panel.get_node("Status")

	if solved:

		lbl.text = "Circuit repaired! Go to the exit."

		return

	if !wire1:

		lbl.text = "Step 1 : Connect the battery"

	elif !wire2:

		lbl.text = "Step 2 : Connect the switch"

	elif !wire3:

		lbl.text = "Step 3 : Install the resistor"

	elif !switch_on:

		lbl.text = "Step 4 : Turn ON the switch"

	else:

		lbl.text = "Step 5 : Test the lamp"
		# ==========================================================
# DRAW OBJECTS
# ==========================================================




# ==========================================================
# CIRCUIT
# ==========================================================

func _draw_circuit():

	var battery_pos = Vector2(160,320)
	var switch_pos  = Vector2(410,320)
	var resistor_pos= Vector2(680,320)
	var lamp_pos    = Vector2(980,320)

	# Battery
	draw_rect(Rect2(battery_pos-Vector2(22,32),Vector2(44,64)),Color(0.25,0.25,0.30))
	draw_rect(Rect2(battery_pos-Vector2(6,40),Vector2(12,80)),GREEN)

	draw_string(
		ThemeDB.fallback_font,
		battery_pos+Vector2(-28,60),
		"Battery",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		16,
		WHITE)

	# Switch
	draw_rect(Rect2(switch_pos-Vector2(30,20),Vector2(60,40)),Color(0.3,0.3,0.35))

	if switch_on:
		draw_line(
			switch_pos+Vector2(-18,0),
			switch_pos+Vector2(18,0),
			GREEN,
			4)
	else:
		draw_line(
			switch_pos+Vector2(-18,0),
			switch_pos+Vector2(12,-10),
			RED,
			4)

	draw_string(
		ThemeDB.fallback_font,
		switch_pos+Vector2(-25,55),
		"Switch",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		16,
		WHITE)

	# Resistor
	draw_rect(
		Rect2(resistor_pos-Vector2(35,12),Vector2(70,24)),
		ORANGE)

	draw_string(
		ThemeDB.fallback_font,
		resistor_pos+Vector2(-30,55),
		"Resistor",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		16,
		WHITE)

	# Lamp

	var lamp_color = Color(0.25,0.25,0.25)

	if solved:
		lamp_color = YELLOW

	draw_circle(
		lamp_pos,
		24,
		lamp_color)

	draw_circle(
		lamp_pos,
		24,
		WHITE,
		false,
		2)

	draw_string(
		ThemeDB.fallback_font,
		lamp_pos+Vector2(-18,60),
		"Lamp",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		16,
		WHITE)


	# ===========================
	# WIRES
	# ===========================

	if wire1:

		draw_line(
			battery_pos,
			switch_pos,
			GREEN,
			6)

	if wire2:

		draw_line(
			switch_pos,
			resistor_pos,
			GREEN,
			6)

	if wire3:

		draw_line(
			resistor_pos,
			lamp_pos,
			GREEN,
			6)
			# ==========================================================
# EXIT DOOR
# ==========================================================

func _draw_exit():

	var door = Rect2(1140,180,80,130)

	if solved:

		draw_rect(
			door,
			Color(0,0.7,0.2))

		draw_rect(
			door,
			WHITE,
			false,
			2)

		draw_string(
			ThemeDB.fallback_font,
			Vector2(1155,245),
			"EXIT",
			HORIZONTAL_ALIGNMENT_LEFT,
			-1,
			18,
			WHITE)

		draw_string(
			ThemeDB.fallback_font,
			Vector2(1138,270),
			"[E]",
			HORIZONTAL_ALIGNMENT_LEFT,
			-1,
			16,
			YELLOW)

	else:

		draw_rect(
			door,
			Color(0.2,0.05,0.05))

		draw_rect(
			door,
			RED,
			false,
			2)
			# ==========================================================
# EXIT
# ==========================================================

func _input(event):

	if !solved:
		return

	if event is InputEventKey \
	and event.pressed \
	and event.keycode==KEY_E:

		if player.position.distance_to(Vector2(1180,250))<90:

			get_tree().change_scene_to_file(
				"res://scenes/Level4.tscn")
				# ==========================================================
# PROCESS
# ==========================================================

func _process(delta):

	queue_redraw()
	# ==========================================================
# PLAYER
# ==========================================================

func _make_player(pos: Vector2) -> CharacterBody2D:

	var p = CharacterBody2D.new()

	p.position = pos
	p.name = "Player"

	p.set_script(load("res://scripts/Player.gd"))

	var col = CollisionShape2D.new()

	var shape = CapsuleShape2D.new()

	shape.radius = 14
	shape.height = 34

	col.shape = shape

	p.add_child(col)

	return p


# ==========================================================
# INTERACTABLE OBJECT
# ==========================================================

func _make_object(pos: Vector2, lbl: String, obj_type: String) -> Area2D:

	var obj = Area2D.new()

	obj.position = pos

	obj.set_script(load("res://scripts/ElectricalInteractable.gd"))

	obj.label = lbl
	obj.object_type = obj_type

	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = Vector2(70,70)
	collision.shape = shape
	obj.add_child(collision)

	return obj
	# ==========================================================
# ROOM
# ==========================================================

func _draw_room():

	draw_rect(
		Rect2(0,0,1280,720),
		BG)

	for x in range(0,1280,64):
		for y in range(0,720,64):

			var c=FLOOR

			if ((x+y)/64)%2==0:
				c=WALL

			draw_rect(
				Rect2(x,y,64,64),
				c)

	# Title

	draw_string(
		ThemeDB.fallback_font,
		Vector2(360,60),
		"LEVEL 3 - ELECTRIC CIRCUIT LAB",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		30,
		CYAN)

	# Instructions

	draw_string(
		ThemeDB.fallback_font,
		Vector2(320,95),
		"Repair the electrical circuit to restore power.",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		18,
		WHITE)
		# ==========================================================
# WALLS
# ==========================================================

func _add_wall(rect:Rect2):

	var body=StaticBody2D.new()

	body.position=rect.position

	var col=CollisionShape2D.new()

	var shape=RectangleShape2D.new()

	shape.size=rect.size

	col.shape=shape

	col.position=rect.size/2

	body.add_child(col)

	add_child(body)
	# ==========================================================
# CREATE BOUNDARIES
# ==========================================================

func _create_boundaries():

	_add_wall(Rect2(-20,-20,20,760))

	_add_wall(Rect2(1280,-20,20,760))

	_add_wall(Rect2(-20,-20,1320,20))

	_add_wall(Rect2(-20,720,1320,20))
# ==========================================================
# READY MESSAGE
# ==========================================================

func _notification(what):

	if what==NOTIFICATION_READY:

		ARIA.respond(
			"Welcome to the Circuit Repair Lab!\n\nRestore power by assembling a working electrical circuit. Remember: electricity only flows in a complete closed circuit."
		)
	
