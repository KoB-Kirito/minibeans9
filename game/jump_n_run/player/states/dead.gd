class_name DeadState
extends State


@export var player: Player


func _physics_process(delta: float) -> void:
	# Gravity
	player.velocity.y += 300 * delta
	player.move_and_slide()


func _enter_state() -> void:
	Globals.paused = true
	Bgm.fade_out(0.0)
	player.animation_tree.active = false
	if player.transformed:
		player.animation_player.play("death_red")
	else:
		player.animation_player.play("death")
	
	await get_tree().create_timer(5.0).timeout
	
	Globals.player_dead = true


func _exit_state() -> void:
	pass
