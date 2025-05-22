extends Area2D
var player_near = false;


func _ready() -> void:
	$ScenePress/PressAnim.visible = false;

func _process(delta: float) -> void:
	if player_near:
		if Input.is_action_just_pressed("action"):
			Press.play()
			$Dialog.show_message("Eu: (Um quadro com gotas de sague...)")
			

func _on_body_entered(body: Node2D) -> void:
	
	$ScenePress/PressAnim.visible = true;
	player_near= true;


func _on_body_exited(body: Node2D) -> void:
	
	$ScenePress/PressAnim.visible = false;
	player_near = false;
	$Dialog.hidden_message();
