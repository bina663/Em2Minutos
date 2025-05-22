extends CanvasLayer

@onready var text_box = $RichTextLabel
var tween: Tween

var dialog_lines = [
	"Você: ...Ugh... minha cabeça...",
	"Você: Onde eu tô?",
	"*Barulho de alguém chorando*",
	"Você: Tem alguém aí?",
	"*Pessoa chorando, murmurando: 'Por favor, me deixe sair... por favor, minha esposa... alguém me ajuda...'*",
	"*O choro fica mais forte, vindo de algum lugar à frente*"
]





var current_line = 0
var fading = false
var typing = false
var type_timer := 0.03  # tempo entre letras
var full_text := ""
var typed_text := ""
var char_index := 0

func _ready():
	text_box.modulate.a = 0.0
	show_next_line()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		$Digitando.play();
		if typing:
			# Mostrar texto completo se apertar no meio da digitação
			text_box.text = full_text
			typing = false
		elif not fading:
			fade_out_and_next()

func fade_out_and_next():
	fading = true
	tween = create_tween()
	tween.tween_property(text_box, "modulate:a", 0.0, 0.3)
	tween.tween_callback(func():
		show_next_line()
	)

func show_next_line():
	if current_line < dialog_lines.size():
		full_text = dialog_lines[current_line]
		
		# Verifica se a linha tem "choro" ou "chorando" e toca o som
		if full_text.to_lower().find("choro") != -1 or full_text.to_lower().find("chorando") != -1:
			$Choro.play()
		
		current_line += 1
		char_index = 0
		typed_text = ""
		text_box.text = ""
		typing = true

		# Fade-in
		tween = create_tween()
		tween.tween_property(text_box, "modulate:a", 1.0, 0.3)
		tween.tween_callback(func():
			start_typing()
			fading = false
		)
	else:
		get_tree().change_scene_to_file("res://cenas/sala.tscn")

func start_typing():
	# Inicia o efeito de digitação
	typing = true
	typed_text = ""
	char_index = 0
	text_box.text = ""
	set_process(true)

func _process(delta):
	if typing:
		if char_index < full_text.length():
			type_timer -= delta
			if type_timer <= 0:
				type_timer = 0.03  # reinicia timer
				typed_text += full_text[char_index]
				text_box.text = typed_text
				char_index += 1
		else:
			typing = false
			set_process(false)

			# Verifica se acabou o diálogo
			if current_line >= dialog_lines.size():
				await get_tree().create_timer(5.0).timeout
				get_tree().change_scene_to_file("res://cenas/sala.tscn")
