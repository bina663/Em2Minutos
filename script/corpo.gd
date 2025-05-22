extends Area2D

var player_near = false
var is_vasculhando := false
var holding_time := 0.0
const HOLD_DURATION := 2.0  # segundos para vasculhar

func _ready() -> void:
	$ScenePress/PressAnim.visible = false
	$ProgressBar.visible = false
	$ProgressBar.value = 0

func _process(delta: float) -> void:
	if player_near:
		if Input.is_action_just_pressed("action"):
			Press.play()

			if Global.grampo == "player":
				# Se já foi vasculhado, só mostra isso
				$Dialog.show_message("Eu: (Nada mais a encontrar.)")
				return

			if Global.firstInteractionCorpo:
				$Dialog.show_message("Eu: (Meu Deus... ela está morta. Mas o que diabos aconteceu aqui?)")
			else:
				if !Global.InvestigCorpo:
					$Dialog.show_message("Eu: (Por que fizeram isso com ela? O que esse casal tem a ver com tudo isso?)\n(E o que estou fazendo aqui?)")
				elif Global.grampo == "corpo" and Global.chaveFenda == "estante":
					$Dialog.show_message("Segure para vasculhar o corpo...")
				elif Global.chaveFenda == "player":
					$Dialog.show_message("Eu: (Tenho 2 chaves, ajuda-lo ou Sair da sala?)")
				

		# Segurando botão para vasculhar
		if Global.InvestigCorpo and Input.is_action_pressed("action") and Global.grampo == "corpo":
			$Dialog.show_message("Vasculhando corpo....", "Aperte e Segure E para Vasculhar")
			is_vasculhando = true
			holding_time += delta
			$ProgressBar.visible = true
			$ProgressBar.value = holding_time / HOLD_DURATION * 100

			if holding_time >= HOLD_DURATION:
				vasculhar_corpo()
				is_vasculhando = false
				holding_time = 0
				$ProgressBar.visible = false

		elif is_vasculhando and !Input.is_action_pressed("action"):
			is_vasculhando = false
			holding_time = 0
			$ProgressBar.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$ScenePress/PressAnim.visible = true
		$ScenePress/PressAnim.play("default")
		player_near = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$ScenePress/PressAnim.visible = false
		$Dialog.hidden_message()
		$ProgressBar.visible = false
		player_near = false
		is_vasculhando = false
		holding_time = 0

func vasculhar_corpo():
	if Global.grampo == "corpo":
		$Dialog.show_message("Eu: (Examinei tudo, apenas um grampo no bolso...)")
		Global.grampo = "player"
		Global.actionPlayer = false
	if Global.grampo == "player":
		$Dialog.show_message("Eu: (Já peguei o grampo. Nada mais a encontra[corpo].)")
	elif Global.grampo == "quebrado" and Global.chaveFenda == 'estante':
		$Dialog.show_message("Eu: (O grampo se quebrou... nada mais a encontrar[corpo].)")
	
	print("vasculhado")
