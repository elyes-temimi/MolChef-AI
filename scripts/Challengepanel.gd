extends CanvasLayer
# ─── ChallengePanel.gd — Sliding challenge UI overlay ───────────────────────
# Add as CanvasLayer child of each Level scene
# Call open(challenge_data, concept) to show, emits solved/closed signals

signal solved(concept: String)
signal closed()

const CYAN   = Color(0.0,  0.83, 1.0)
const GREEN  = Color(0.0,  1.0,  0.53)
const RED    = Color(1.0,  0.31, 0.31)
const ORANGE = Color(1.0,  0.63, 0.16)
const WHITE  = Color(0.86, 0.92, 1.0)
const GRAY   = Color(0.31, 0.43, 0.55)
const BG     = Color(0.04, 0.07, 0.14, 0.96)

var _concept: String = ""
var _challenge: Dictionary = {}
var _visible: bool = false
var _step: int = 0
var _total_steps: int = 0
var _answered: bool = false

# UI refs
var _panel:        Panel
var _title_lbl:    Label
var _desc_lbl:     RichTextLabel
var _aria_lbl:     RichTextLabel
var _aria_header:  Label
var _feedback_lbl: Label
var _hint_btn:     Button
var _close_btn:    Button
var _next_btn:     Button
var _opt_btns:     Array = []

func _ready() -> void:
	layer = 10
	_build()
	hide()
	ARIA.responded.connect(_on_aria)
	ARIA.errored.connect(_on_aria)

func open(challenge: Dictionary, concept: String) -> void:
	_concept  = concept
	_challenge = challenge
	_step     = 0
	_total_steps = challenge.steps.size()
	_visible  = true
	show()
	_load_step()
	ARIA.intro(GameState.current_level, challenge.get("intro_ctx", "A new challenge begins!"))
	_aria_lbl.text = "⟳  ARIA is briefing you..."

func _load_step() -> void:
	var step = _challenge.steps[_step]
	_title_lbl.text = "  %s" % step.title
	_desc_lbl.text  = step.desc
	_answered = false
	_feedback_lbl.text = ""
	_next_btn.hide()

	# Rebuild option buttons
	for b in _opt_btns: b.queue_free()
	_opt_btns.clear()

	var opts: Array = step.options
	var cols = 2
	var bw = 460; var bh = 54; var gap = 10
	var start_x = 40; var start_y = 390
	for i in opts.size():
		var col = i % cols
		var row = i / cols
		var btn = _btn(
			opts[i].text,
			Vector2(start_x + col * (bw + gap), start_y + row * (bh + gap)),
			Vector2(bw, bh), WHITE
		)
		btn.pressed.connect(_on_answer.bind(i))
		_panel.add_child(btn)
		_opt_btns.append(btn)

func _on_answer(idx: int) -> void:
	if _answered: return
	_answered = true
	for b in _opt_btns: b.disabled = true

	var step = _challenge.steps[_step]
	var opt  = step.options[idx]
	var ok   = opt.get("correct", false)

	GameState.record(_concept, ok)

	if ok:
		_set_feedback("✓  " + opt.get("learns", "Correct!"), GREEN)
		_next_btn.show()
		ARIA.celebrate(_concept, opt.get("learns", ""))
		_aria_lbl.text = "⟳  ARIA is responding..."
	else:
		_set_feedback("✗  " + opt.get("wrong_hint", "Think again — check your reasoning."), RED)
		var streak = GameState.get_consecutive(_concept)
		ARIA.hint(_concept, opt.text, streak)
		_aria_lbl.text = "⟳  ARIA is thinking..."
		await get_tree().create_timer(0.6).timeout
		for b in _opt_btns: b.disabled = false
		_answered = false

func _on_hint_pressed() -> void:
	GameState.hints_used += 1
	ARIA.hint(_concept, "(hint requested)", 0)
	_aria_lbl.text = "⟳  ARIA is thinking..."

func _on_next_pressed() -> void:
	_step += 1
	if _step >= _total_steps:
		hide()
		solved.emit(_concept)
	else:
		_load_step()
		_aria_lbl.text = "⟳  ARIA is watching..."

func _on_close_pressed() -> void:
	hide()
	closed.emit()

func _on_aria(msg: String) -> void:
	_aria_lbl.text = msg

func _set_feedback(text: String, color: Color) -> void:
	_feedback_lbl.text = text
	_feedback_lbl.add_theme_color_override("font_color", color)

# ─── Build UI ────────────────────────────────────────────────────────────────

func _build() -> void:
	_panel = Panel.new()
	_panel.position = Vector2(200, 60)
	_panel.size     = Vector2(980, 600)
	var sty = StyleBoxFlat.new()
	sty.bg_color = BG
	sty.border_color = CYAN
	sty.set_border_width_all(2)
	sty.set_corner_radius_all(10)
	_panel.add_theme_stylebox_override("panel", sty)
	add_child(_panel)

	# Dim overlay behind panel
	var dim = ColorRect.new()
	dim.color = Color(0, 0, 0, 0.55)
	dim.size  = Vector2(1280, 720)
	dim.z_index = -1
	add_child(dim)
	dim.mouse_filter = Control.MOUSE_FILTER_IGNORE

	# Header bar
	var hdr = ColorRect.new()
	hdr.color    = Color(0.0, 0.83, 1.0, 0.08)
	hdr.position = Vector2(0, 0)
	hdr.size     = Vector2(980, 50)
	_panel.add_child(hdr)

	_title_lbl = _lbl("", Vector2(0, 14), 18, CYAN)
	_panel.add_child(_title_lbl)

	# Step indicator
	var step_lbl = _lbl("", Vector2(800, 16), 14, GRAY)
	step_lbl.name = "StepLbl"
	_panel.add_child(step_lbl)

	# Close button
	_close_btn = _btn("✕", Vector2(940, 8), Vector2(34, 34), RED)
	_close_btn.pressed.connect(_on_close_pressed)
	_panel.add_child(_close_btn)

	# Divider
	var div = ColorRect.new()
	div.color    = Color(CYAN, 0.2)
	div.position = Vector2(0, 50)
	div.size     = Vector2(980, 1)
	_panel.add_child(div)

	# Description
	_desc_lbl = RichTextLabel.new()
	_desc_lbl.position = Vector2(30, 60)
	_desc_lbl.size     = Vector2(560, 130)
	_desc_lbl.bbcode_enabled  = true
	_desc_lbl.scroll_active   = false
	_desc_lbl.add_theme_color_override("default_color", WHITE)
	_desc_lbl.add_theme_font_size_override("normal_font_size", 16)
	_panel.add_child(_desc_lbl)

	# ARIA panel
	var aria_bg = Panel.new()
	aria_bg.position = Vector2(610, 58)
	aria_bg.size     = Vector2(350, 210)
	var asty = StyleBoxFlat.new()
	asty.bg_color     = Color(0.03, 0.08, 0.18)
	asty.border_color = Color(CYAN, 0.5)
	asty.set_border_width_all(1)
	asty.set_corner_radius_all(6)
	aria_bg.add_theme_stylebox_override("panel", asty)
	_panel.add_child(aria_bg)

	_aria_header = _lbl("◈  ARIA — Chef AI Mentor", Vector2(624, 68), 13, CYAN)
	_panel.add_child(_aria_header)

	var adiv = ColorRect.new()
	adiv.color    = Color(CYAN, 0.15)
	adiv.position = Vector2(610, 86)
	adiv.size     = Vector2(350, 1)
	_panel.add_child(adiv)

	_aria_lbl = RichTextLabel.new()
	_aria_lbl.position = Vector2(616, 92)
	_aria_lbl.size     = Vector2(336, 170)
	_aria_lbl.bbcode_enabled  = true
	_aria_lbl.scroll_active   = false
	_aria_lbl.add_theme_color_override("default_color", Color(0.75, 0.90, 1.0))
	_aria_lbl.add_theme_font_size_override("normal_font_size", 14)
	_panel.add_child(_aria_lbl)

	# Divider above options
	var div2 = ColorRect.new()
	div2.color    = Color(CYAN, 0.12)
	div2.position = Vector2(0, 375)
	div2.size     = Vector2(980, 1)
	_panel.add_child(div2)

	# Feedback label
	_feedback_lbl = _lbl("", Vector2(30, 345), 15, GREEN)
	_feedback_lbl.size = Vector2(560, 30)
	_panel.add_child(_feedback_lbl)

	# Hint button
	_hint_btn = _btn("💡  Ask ARIA for a hint", Vector2(610, 280), Vector2(350, 42), CYAN)
	_hint_btn.pressed.connect(_on_hint_pressed)
	_panel.add_child(_hint_btn)

	# Next button
	_next_btn = _btn("▶  Next Challenge", Vector2(30, 545), Vector2(220, 44), GREEN)
	_next_btn.pressed.connect(_on_next_pressed)
	_next_btn.hide()
	_panel.add_child(_next_btn)

func _lbl(text: String, pos: Vector2, size: int, color: Color) -> Label:
	var l = Label.new()
	l.text = text; l.position = pos
	l.add_theme_font_size_override("font_size", size)
	l.add_theme_color_override("font_color", color)
	return l

func _btn(text: String, pos: Vector2, sz: Vector2, color: Color) -> Button:
	var b = Button.new()
	b.text = text; b.position = pos; b.size = sz
	var s = StyleBoxFlat.new()
	s.bg_color = Color(color.r, color.g, color.b, 0.08)
	s.border_color = Color(color, 0.5)
	s.set_border_width_all(1); s.set_corner_radius_all(5)
	b.add_theme_stylebox_override("normal", s)
	var h = s.duplicate(); h.bg_color = Color(color.r,color.g,color.b,0.18); h.border_color = color
	b.add_theme_stylebox_override("hover", h)
	b.add_theme_color_override("font_color", color)
	b.add_theme_font_size_override("font_size", 14)
	return b
