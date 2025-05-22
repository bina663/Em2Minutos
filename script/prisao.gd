extends Area2D



func _ready() -> void:
	$AnimatedSprite2D.play("trancado")


func _process(delta: float) -> void:
	if !Global.prision:
		$AnimatedSprite2D.play("aberto")
