extends Control

@onready var start_button = $StartButton  # Seletor do botão na interface

# Função chamada quando o botão é pressionado
func start() -> void:
	# Troca para a nova cena
	get_tree().change_scene("res://caminho/para/a/nova/scena_de_jogo.tscn")
	
# Conectar o evento de pressionamento do botão
func _ready():
	start_button.connect("pressed", self, "start")
