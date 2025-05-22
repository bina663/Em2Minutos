extends Area2D

var player_near = false;
func _ready() -> void:
	$ScenePress/PressAnim.visible = false;
	
func _physics_process(delta: float) -> void:
	if player_near:
		interact()
func interact():
	if Input.is_action_just_pressed("action"):
		Press.play()

		if Global.chaveFenda == "player":
			$Dialog.show_message("Abrindo...");
			get_tree().change_scene_to_file("res://cenas/final_2.tscn");
		else:
			$Press.play();
			$Dialog.show_message("Está trancada! Eu ouço passos... do lado de fora.");


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$ScenePress/PressAnim.visible = true;
		player_near = true;


func _on_body_exited(body: Node2D) -> void:
	$Dialog.hidden_message()
	player_near = false
	$ScenePress/PressAnim.visible = false;
