extends Node2D

@onready var medical_report: Control = $UI/HistoryPanel

func _ready() -> void:
	# Start hidden and fully transparent
	medical_report.visible = false
	medical_report.modulate.a = 0.0 

func _on_history_button_pressed() -> void:
	# Create a new tween animation
	var tween = create_tween().set_parallel(false)
	
	# EASE_OUT makes it start fast and slow down at the end
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	if not medical_report.visible:
		# 1. Show the node so it can be seen
		medical_report.visible = true
		# 2. Fade alpha property to 1.0 (fully visible) over 0.3 seconds
		tween.tween_property(medical_report, "modulate:a", 1.0, 0.3)
	else:
		# 1. Fade alpha property to 0.0 (transparent) over 0.2 seconds
		tween.tween_property(medical_report, "modulate:a", 0.0, 0.2)
		# 2. Automatically turn off visibility completely once the animation finishes
		tween.tween_callback(func(): medical_report.visible = false)

@onready var timer_label = $UI/TopContainer/Control/Timer/TimerLabel

var time_left := 601.0

func _process(delta: float) -> void:

	time_left -= delta
	time_left = max(time_left, 0.0)

	var total_seconds: int = int(time_left)
	var minutes: int = int(total_seconds / 60.0) 
	var seconds: int = total_seconds % 60

	timer_label.text = "Time: " + "%d:%02d" % [minutes, seconds]
	if time_left <= 120.0:

		timer_label.add_theme_color_override("font_color", Color.RED)


func _on_exam_button_pressed() -> void:
	print("Exam pressed")


func _on_diagnostics_button_pressed() -> void:
	print("Diagnostics pressed")


func _on_treatment_button_pressed() -> void:
	print("Treatment pressed")
