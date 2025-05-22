extends Control



func start() -> void:
	Fundo.stop();
	# Trocar para a cena de introdução
	get_tree().change_scene_to_file("res://cenas/intro.tscn")

func credit() -> void:
	# Trocar para a cena de créditos
	get_tree().change_scene_to_file("res://cenas/creditos.tscn")

func quit() -> void:
	# Fechar o jogo
	get_tree().quit()
