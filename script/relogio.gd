extends CanvasLayer

@onready var timer = $Timer
@onready var label_timer = $TextEdit

var total_seconds := 2 * 60  # 2 minutos em segundos

func _ready():
	update_timer_label()
	timer.start()

func _on_timer_timeout():
	if !Global.firstInteractionCorpo:
		total_seconds -= 1
		update_timer_label()

	if total_seconds <= 0:
		timer.stop()
		label_timer.text = "00:00"
		get_tree().change_scene_to_file("res://cenas/fim.tscn")# <- ajuste o caminho da cena aqui

func update_timer_label():
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60
	label_timer.text = "%02d:%02d" % [minutes, seconds]
