extends Node2D
# Ganz schreckliches Gemauschel wegen Zeit und so


@export var player: Player
@export var boss: Enemy


func _ready() -> void:
	boss.died.connect(end)
	Globals.player_dead = false


func end() -> void:
	Dialogic.timeline_ended.connect(end2)
	Dialogic.start("end")


func end2() -> void:
	get_tree().change_scene_to_file("res://game/menu/credits.tscn")


func _physics_process(_delta: float) -> void:
	if Globals.player_dead or player.position.y > 5000:
		print("game over")
		get_tree().change_scene_to_file("res://game/jump_n_run/level1.tscn")
		return
