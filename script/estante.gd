extends Area2D

var player_near = false
var firstInteraction = true
var dialog_index = 0
var is_vasculhando := false
var holding_time := 0.0
const HOLD_DURATION := 2.0  # segundos para vasculhar

var firstDialog = [
	"Desconhecida: Por favor... rápido!",
	"Desconhecido: Talvez no bolso da minha esposa...\ntenha um grampo, ou algo assim!",
	"Desconhecida: Oh não... minha querida... *choro*"
]

func _ready() -> void:
	$ScenePress/PressAnim.visible = false
	$ProgressBar.visible = false
	$ProgressBar.value = 0
	

func _process(delta: float) -> void:
	if player_near:
		Interact(delta)

func Interact(delta):
	if Input.is_action_just_pressed("action"):
		Press.play()
		# Iniciar a interação quando o jogador aperta o botão
		if Global.dialogEstante:
			if dialog_index < firstDialog.size():
				$Dialog.show_message(firstDialog[dialog_index])
				dialog_index += 1
				Global.InvestigCorpo = true
				if dialog_index >= firstDialog.size():
					Global.dialogEstante = false;
			else:
				$Dialog.show_message("EU: (Devo vasculhar a sala [estante])")
		else:
			if Global.actionPlayer:
				if Global.faca == 'quebrou':
					$Dialog.show_message("EU: (Devo Investigar a sala)")
				# Começar a vasculhar quando o jogador começa a pressionar o botão
				elif Input.is_action_pressed("action") and Global.faca == 'estante':
					$Dialog.show_message("Vasculhando Estante....", "Aperte e Segure E para Vasculhar")
					is_vasculhando = true
					$ProgressBar.visible = true  # Tornar a barra de progresso visível
					
				elif is_vasculhando and !Input.is_action_pressed("action"):
					# O botão foi solto antes de terminar o processo de vasculhamento
					is_vasculhando = false
					holding_time = 0
					$ProgressBar.visible = false
			else:
				if Global.grampo == "player":
					$Dialog.show_message("EU: (Devo tentar abrir a jaula com esse grampo)")
				else:
					$Dialog.show_message("EU: (Devo Investigar a sala)")

	# Lógica do processo de vasculhamento continua apenas se o botão for mantido pressionado
	if is_vasculhando:
		if Input.is_action_pressed("action"):
			# Continuar a aumentar o tempo de vasculhamento enquanto o botão for pressionado
			holding_time += delta
			$ProgressBar.value = holding_time / HOLD_DURATION * 100

			# Se o tempo de vasculhamento for suficiente, realizar a ação
			if holding_time >= HOLD_DURATION:
				vasculhar_estante()
				is_vasculhando = false
				holding_time = 0
				$ProgressBar.visible = false
		else:
			# Se o jogador soltou o botão, interrompe o processo
			is_vasculhando = false
			holding_time = 0
			$ProgressBar.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$ScenePress/PressAnim.visible = true
		player_near = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_near = false
		$Dialog.hidden_message()
		$ScenePress/PressAnim.visible = false

func vasculhar_estante():
	if Global.faca != "player":
		$Dialog.show_message("Eu: (Examinei tudo, apenas uma faca...)")
		Global.faca = "player"
	else:
		$Dialog.show_message("Eu: (Nada mais a encontrar.)")

	print("vasculhado")
