extends Area2D

var firstInteractionPrision = true
var player_near = false

var dialog_index := 0

var firstInteractionPrison = [
	"Desconhecido: Por favor... me ajuda... me tira daqui!",
	"Desconhecido: Eles... eles mataram minha esposa..\nnós somos os próximos!",
	"Desconhecido: Eles iam fazer o mesmo contigo...\nmas alguém ligou... e eles pararam.",
	"Desconhecido: *Choro abafado* Por favor...",
	"Desconhecido: Temos... uns 2 minutos, no máximo, antes que eles voltem!"
]


func _ready() -> void:
	$ScenePress/PressAnim.visible = false;
	
	
	
func _physics_process(delta: float) -> void:
	$AnimatedSpritePrision.play("idle")
	if player_near:
		interact()

func interact():
	if Input.is_action_just_pressed("action"):
		Press.play()
		if firstInteractionPrision:
			if dialog_index < firstInteractionPrison.size():
				$Dialog.show_message(firstInteractionPrison[dialog_index])
				dialog_index += 1
			else:
				firstInteractionPrision = false  # Aqui a variável 'firstInteractionPrision' é alterada corretamente
				Global.firstInteractionCorpo = false;
				Global.dialogEstante = true;
		else:
			if Global.chaveFenda == "player" and !Global.actionPlayer:
				$Dialog.show_message("Soltando...")
				Global.prision = false;
				get_tree().change_scene_to_file("res://cenas/final_1.tscn")
			elif !Global.actionPlayer and Global.grampo == "player" or Global.faca == "player" or Global.chaveFenda == "estante":
				var lock_scene = preload("res://cenas/game.tscn").instantiate()
				get_tree().current_scene.add_child(lock_scene)
				lock_scene.visible = true
			else:
				$Dialog.show_message("Eu: (Devo investigar a sala...)")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$ScenePress/PressAnim.visible = true
		$ScenePress/PressAnim.play("default")
		player_near = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Dialog.hidden_message()
		$ScenePress/PressAnim.visible = false
		player_near = false
