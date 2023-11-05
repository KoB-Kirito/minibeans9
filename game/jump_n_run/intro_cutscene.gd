extends Node


func _ready() -> void:
	Globals.paused = true
	
	Bgm.fade_out(0.5)
	
	await get_tree().create_timer(1).timeout
