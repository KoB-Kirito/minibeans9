class_name SwitchingState
extends State


@export var player: Player

var animation_state_machine: AnimationNodeStateMachinePlayback


func go_back(_anim_name: String) -> void:
	player.animation_tree.animation_finished.disconnect(go_back)
	animation_state_machine.travel("Move")
	state_machine.change_state(%Ground)


func _enter_state() -> void:
	if animation_state_machine == null:
		animation_state_machine = player.animation_tree["parameters/playback"]
	
	animation_state_machine.stop()
	
	if player.transformed:
		player.transformed = false
		player.animation_tree.set("parameters/Move/blend_position:y", 0)
		player.animation_tree.set("parameters/switch/blend_position", 0)
	else:
		player.transformed = true
		player.animation_tree.set("parameters/Move/blend_position:y", 1)
		player.animation_tree.set("parameters/switch/blend_position", 1)
	
	player.animation_tree.animation_finished.connect(go_back)
	animation_state_machine.start("switch", true)


func _exit_state() -> void:
	pass
