extends CharacterBody2D

var speed = 250



func _ready() -> void:
	var canvas = $Items;
	canvas.get_node("Faca").visible = false
	canvas.get_node("ChaveFenda").visible = false
	canvas.get_node("grampo").visible = false;
	
	
func _physics_process(delta: float) -> void:
	var canvas = $Items;
	if Global.grampo == "player":
		canvas.get_node("grampo").visible = true;
	if Global.faca == "player":
		canvas.get_node("Faca").visible = true;
	if Global.chaveFenda == "player":
		canvas.get_node("ChaveFenda").visible = true;
	move_player()
	move_and_slide()
	limit_to_screen()

func move_player():
	if Input.is_action_pressed("left"):
		if not $Andando.playing:
			$Andando.play()
		$AnimatedPlayer.play("walk")
		$AnimatedPlayer.flip_h = true
		velocity.x = -speed
	elif Input.is_action_pressed("right"):
		if not $Andando.playing:
			$Andando.play()
		$AnimatedPlayer.play("walk")
		$AnimatedPlayer.flip_h = false
		velocity.x = speed
	else:
		if $Andando.playing:
			$Andando.stop()
		velocity.x = 0
		$AnimatedPlayer.play("idle")

func limit_to_screen():
	var screen_rect = get_viewport_rect()
	var pos = global_position

	# Ajuste os valores abaixo conforme o tamanho do seu personagem
	var margin_left = 0
	var margin_right = screen_rect.size.x
	var margin_top = 0
	var margin_bottom = screen_rect.size.y

	# Limita a posição X
	pos.x = clamp(pos.x, margin_left, margin_right)
	# Se quiser limitar vertical também (opcional)
	pos.y = clamp(pos.y, margin_top, margin_bottom)

	global_position = pos
