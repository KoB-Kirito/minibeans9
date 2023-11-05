class_name AttackingState
extends State


@export var player: Player

var animation_state_machine: AnimationNodeStateMachinePlayback

var enemies: Array[Enemy]


func go_back(_anim_name: String) -> void:
	player.animation_tree.animation_finished.disconnect(go_back)
	animation_state_machine.stop()
	
	for enemy: Enemy in enemies:
		enemy.hurt(player.stength)
	
	animation_state_machine.start("move", true)
	state_machine.change_state(%Ground)


func _enter_state() -> void:
	if animation_state_machine == null:
		animation_state_machine = player.animation_tree["parameters/playback"]
	
	animation_state_machine.stop()
	
	player.animation_tree.animation_finished.connect(go_back)
	animation_state_machine.start("attack", true)


func _exit_state() -> void:
	pass


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		enemies.append(body)


func _on_hitbox_body_exited(body: Node2D) -> void:
	if body is Enemy:
		enemies.erase(body)
