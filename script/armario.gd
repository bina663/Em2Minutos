extends Area2D

var player_near = false
var is_vasculhando := false
var holding_time := 0.0
const HOLD_DURATION := 2.0  # segundos para vasculhar

var dialog = ["Eu: (2 Chaves indicando ser da jaula e uma da porta...)",
			"Posso ajudar ele ou simplesmente sair daqui"
]

func _ready() -> void:
	$ScenePress/PressAnim.visible = false
	$ProgressBar.visible = false
	$ProgressBar.value = 0

func _process(delta: float) -> void:
	if player_near:
		interact(delta)
	
func interact(delta):
	
	if Global.dialogEstante == false:
		# Segurando botão para vasculhar
		if Input.is_action_pressed("action") and Global.grampo == "quebrou" and Global.faca == "quebrou" and Global.chaveFenda == "armario":
			$Dialog.show_message("Vasculhando Armário....", "Aperte e Segure E para Vasculhar")
			is_vasculhando = true
			holding_time += delta
			$ProgressBar.visible = true
			$ProgressBar.value = holding_time / HOLD_DURATION * 100

			if holding_time >= HOLD_DURATION:
				vasculhar_armario()
				is_vasculhando = false
				holding_time = 0
				$ProgressBar.visible = false

		elif is_vasculhando and !Input.is_action_pressed("action"):
			Press.play()
			is_vasculhando = false
			holding_time = 0
			$ProgressBar.visible = false
		else:
			if Input.is_action_just_pressed("action") :
				Press.play()
				$Dialog.show_message("Desconhecido: Por favor me ajude!!!")
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$ScenePress/PressAnim.visible = true
		$ScenePress/PressAnim.play("default")
		player_near = true

func _on_body_exited(body: Node2D) -> void:
	$ScenePress/PressAnim.visible = false
	$Dialog.hidden_message()
	player_near = false

func vasculhar_armario():
	if Global.grampo == "quebrou" and Global.faca == "quebrou" and Global.chaveFenda == "armario":
		$Dialog.show_message("Eu: (2 Chaves, indicando ser uma da porta e outra da jaula)\nPosso solta-lo ou simplesmente fugir vivo daqui)")
		Global.chaveFenda = "player"
		Global.actionPlayer = false
	elif Global.chaveFenda == "player":
		$Dialog.show_message("Eu: (Nada mais a encontrar.)")
	print("vasculhado")
	
