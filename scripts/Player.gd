extends CharacterBody2D
# ─── Player.gd — attach to CharacterBody2D node named "Player" ──────────────

const SPEED = 160.0

# Direction the player faces: 0=down 1=up 2=left 3=right
var facing: int = 0
var walk_frame: int = 0
var walk_timer: float = 0.0
var locked: bool = false   # true when interaction panel is open

# Colors for drawn character
const SKIN   = Color(0.96, 0.80, 0.65)
const HAIR   = Color(0.20, 0.12, 0.05)
const COAT   = Color(0.95, 0.95, 0.95)
const PANTS  = Color(0.20, 0.30, 0.60)
const SHOES  = Color(0.15, 0.10, 0.08)
const ACCENT = Color(0.10, 0.70, 1.00)   # lab coat accent / collar

func _physics_process(delta: float) -> void:
	if locked:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var dir = Vector2.ZERO
	if Input.is_action_pressed("ui_right"): dir.x += 1; facing = 3
	if Input.is_action_pressed("ui_left"):  dir.x -= 1; facing = 2
	if Input.is_action_pressed("ui_down"):  dir.y += 1; facing = 0
	if Input.is_action_pressed("ui_up"):    dir.y -= 1; facing = 1

	if dir != Vector2.ZERO:
		dir = dir.normalized()
		walk_timer += delta
		if walk_timer > 0.18:
			walk_timer = 0.0
			walk_frame = (walk_frame + 1) % 4
	else:
		walk_frame = 0
		walk_timer = 0.0

	velocity = dir * SPEED
	move_and_slide()
	queue_redraw()

func _draw() -> void:
	_draw_character(Vector2.ZERO, facing, walk_frame)

func _draw_character(pos: Vector2, dir: int, frame: int) -> void:
	var flip = (dir == 2)   # mirror when facing left
	var f    = -1 if flip else 1

	# Leg animation offsets
	var leg_offsets = [[0,0],[3,0],[-3,0],[0,0]]
	var lo = leg_offsets[frame]

	# Shadow
	draw_ellipse_approx(pos + Vector2(0, 20), Vector2(14, 5), Color(0,0,0,0.25))

	# Shoes
	draw_rect(Rect2(pos + Vector2(f * lo[0] - 9, 12),  Vector2(10, 6)), SHOES)
	draw_rect(Rect2(pos + Vector2(f * lo[1] + 1,  12), Vector2(10, 6)), SHOES)

	# Pants / legs
	draw_rect(Rect2(pos + Vector2(f * lo[0] - 8, 2),  Vector2(9, 12)), PANTS)
	draw_rect(Rect2(pos + Vector2(f * lo[1] + 1,  2), Vector2(9, 12)), PANTS)

	# Lab coat body
	draw_rect(Rect2(pos + Vector2(-12, -16), Vector2(24, 20)), COAT)
	# Coat lapels
	draw_rect(Rect2(pos + Vector2(-3, -16), Vector2(6, 14)), ACCENT)

	# Arms (swing when walking)
	var arm_swing = [0, 4, 0, -4][frame]
	draw_rect(Rect2(pos + Vector2(-18, -14 + arm_swing * f), Vector2(7, 14)), COAT)
	draw_rect(Rect2(pos + Vector2(11,  -14 - arm_swing * f), Vector2(7, 14)), COAT)

	# Hands
	draw_circle(pos + Vector2(-14, -14 + arm_swing * f + 14), 4, SKIN)
	draw_circle(pos + Vector2(14,  -14 - arm_swing * f + 14), 4, SKIN)

	# Head
	draw_rect(Rect2(pos + Vector2(-10, -32), Vector2(20, 20)), SKIN)

	# Hair
	draw_rect(Rect2(pos + Vector2(-10, -32), Vector2(20, 8)), HAIR)

	# Eyes (direction-dependent)
	if dir == 0:   # facing down
		draw_circle(pos + Vector2(-4, -22), 2, Color(0.1,0.1,0.1))
		draw_circle(pos + Vector2(4,  -22), 2, Color(0.1,0.1,0.1))
	elif dir == 1: # facing up
		pass  # just show hair
	else:          # left / right
		draw_circle(pos + Vector2(f * 5, -22), 2, Color(0.1,0.1,0.1))

	# Name tag on coat
	draw_rect(Rect2(pos + Vector2(-8, -10), Vector2(16, 7)), Color(0.8,0.9,1.0))

func draw_ellipse_approx(center: Vector2, radii: Vector2, color: Color) -> void:
	var points = PackedVector2Array()
	for i in 16:
		var a = i * TAU / 16
		points.append(center + Vector2(cos(a) * radii.x, sin(a) * radii.y))
	draw_colored_polygon(points, color)
