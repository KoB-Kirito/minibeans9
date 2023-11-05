extends Node2D


@export var player: Player
@export var boss: Enemy


func _ready() -> void:
	boss.died.connect(end)


func end() -> void:
	Dialogic.timeline_ended.connect(end2)
	Dialogic.start("end")


func end2() -> void:
	get_tree().change_scene_to_file("res://game/menu/credits.tscn")


func _physics_process(delta: float) -> void:
	if player.health <= 0 or player.position.y > 800:
		print("game over")
		get_tree().change_scene_to_file("res://game/jump_n_run/level1.tscn")
		return
