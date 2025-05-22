extends CanvasLayer

const ZONA_VERDE_MIN := 0.45  # Valor mínimo da zona verde
const ZONA_VERDE_MAX := 0.55  # Valor máximo da zona verde

var hold_value := 0.0  # Valor atual da barra
var holding := false  # Se o jogador está segurando o botão
var game_active := true  # Se o jogo está ativo
@onready var progress_bar = $VBoxContainer/LockBar1  # Barra de progresso
@onready var label = $Label  # Label de mensagens

func _process(delta):
	if !game_active:
		return

	# Se o jogador pressionar o botão
	if Input.is_action_pressed("action"):
		holding = true
		hold_value += delta * 0.5  # A barra carrega mais rápido com o tempo
		hold_value = clamp(hold_value, 0, 1)  # Garantir que o valor não ultrapasse 1
	else:
		if holding:
			if Global.grampo == "player":
				if hold_value >= ZONA_VERDE_MIN and hold_value <= ZONA_VERDE_MAX:
					# Sucesso: dentro da zona verde
					progress_bar.value = hold_value * 100
					label.text = "Grampo quebrou"
					game_won()
				else:
					# Falha: fora da zona verde
					progress_bar.value = hold_value * 100
					label.text = "Grampo quebrou"
					game_over()
				holding = false  # Para o carregamento da barra
				Global.grampo = 'quebrou'
				Global.actionPlayer = true;
			if Global.faca == "player":
				if hold_value >= ZONA_VERDE_MIN and hold_value <= ZONA_VERDE_MAX:
					# Sucesso: dentro da zona verde
					progress_bar.value = hold_value * 100
					label.text = "Faca quebrou"
					game_won()
				else:
					# Falha: fora da zona verde
					progress_bar.value = hold_value * 100
					label.text = "Faca quebrou"
					game_over()
				holding = false  # Para o carregamento da barra
				Global.faca = 'quebrou'
				Global.actionPlayer = true;
				
			if Global.chaveFenda == "player":
				if hold_value >= ZONA_VERDE_MIN and hold_value <= ZONA_VERDE_MAX:
					# Sucesso: dentro da zona verde
					progress_bar.value = hold_value * 100
					label.text = "Abriu"
					game_won()
				else:
					# Falha: fora da zona verde
					progress_bar.value = hold_value * 100
					label.text = "Abriu"
					game_over()
				holding = false  # Para o carregamento da barra
				Global.chaveFenda = 'quebrou'
				Global.actionPlayer = true;

	# Atualiza a barra de progresso visualmente enquanto o jogador segura o botão
	if holding and game_active:
		progress_bar.value = hold_value * 100

# Função que é chamada quando o jogo termina com falha
func game_over():
	game_active = false
	await get_tree().create_timer(1.5).timeout
	label.text = "Fim de Jogo!"
	self.visible = false  # Torna o jogo invisível (pode ser substituído por um reset)

# Função que é chamada quando o jogador vence
func game_won():
	game_active = false
	await get_tree().create_timer(1.5).timeout
	label.text = "Parabéns, você abriu a chave!"
	self.visible = false  # Torna o jogo invisível (pode ser substituído por um reset)
