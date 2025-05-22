extends CanvasLayer

@onready var label_texto = $Text
@onready var label_press = $Press

func show_message(texto: String,param: String = "Aperte E para continuar") -> void:
	label_texto.text = texto
	label_press.text = param  # Limpa o texto do novo label ao exibir a mensagem

func hidden_message():
	label_texto.text = ""
	label_press.text = ""  # Limpa o texto do novo label
