extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	get_tree().change_scene_to_file("res://game/jump_n_run/level1.tscn") 


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://game/menu/settings.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://game/menu/credits.tscn")
