extends Node2D

const BG = Color(0.05,0.08,0.12)
const CYAN = Color(0,0.85,1)
const GREEN = Color(0,1,0.45)
const RED = Color(1,0.3,0.3)
const WHITE = Color.WHITE

var score

func _ready():

	score = GameState.get_total_score()

	queue_redraw()

func _draw():

	draw_rect(Rect2(0,0,1280,720),BG)

	draw_string(
		ThemeDB.fallback_font,
		Vector2(390,90),
		"MOLECHEF TRAINING COMPLETE",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		36,
		CYAN
	)

	draw_string(
		ThemeDB.fallback_font,
		Vector2(520,180),
		"Final Score",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		28,
		WHITE
	)

	var color = GREEN

	if score < 60:
		color = RED

	draw_string(
		ThemeDB.fallback_font,
		Vector2(570,260),
		str(score) + " / 100",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		42,
		color
	)

	var grade = ""

	if score >= 90:
		grade = "Master Molecular Chef"

	elif score >= 75:
		grade = "Excellent Scientist"

	elif score >= 60:
		grade = "Good Lab Assistant"

	else:
		grade = "Needs More Practice"

	draw_string(
		ThemeDB.fallback_font,
		Vector2(450,340),
		grade,
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		28,
		CYAN
	)

	draw_string(
		ThemeDB.fallback_font,
		Vector2(250,430),
		"What you learned:",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		26,
		WHITE
	)

	draw_string(
		ThemeDB.fallback_font,
		Vector2(250,470),
		"• Acids and Bases",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		22,
		WHITE
	)

	draw_string(
		ThemeDB.fallback_font,
		Vector2(250,510),
		"• Organic Chemistry",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		22,
		WHITE
	)

	draw_string(
		ThemeDB.fallback_font,
		Vector2(250,550),
		"• Electric Circuits",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		22,
		WHITE
	)

	draw_string(
		ThemeDB.fallback_font,
		Vector2(350,650),
		"Press ENTER to return to Main Menu",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		22,
		GREEN
	)

func _input(event):

	if event is InputEventKey and event.pressed:

		if event.keycode == KEY_ENTER:

			GameState.total_score = 100

			get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
