extends CanvasLayer

# Referência ao TextureRect (por exemplo, uma imagem de "fim")
@onready var texture_rect = $TextureRect
var fade_duration = 2.0  # segundos

func _ready():
	fade_out_texture()
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://cenas/menu.tscn")
	reset_global_variables()

func fade_out_texture():
	var tween = create_tween()
	tween.tween_property(texture_rect, "modulate:a", 0.0, fade_duration)


func reset_global_variables():
	Global.firstInteractionCorpo = true;
	Global.InvestigCorpo = false;
	Global.grampo = "corpo";
	Global.faca = "estante";
	Global.chaveFenda = "armario";
	Global.actionPlayer = false;
	Global.firstInteractionPrision = true;
	Global.dialogEstante = false;
	Global.firstInteractionEstante = true;
	Global.actionPrision = 0;
	Global.prision = true;
