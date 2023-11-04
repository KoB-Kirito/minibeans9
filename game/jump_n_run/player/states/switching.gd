class_name SwitchingState
extends State


@export var player: Player

var animation_state_machine: AnimationNodeStateMachinePlayback


func go_back(anim_name: String) -> void:
	if anim_name == "switch":
		animation_state_machine.travel("Move")
		state_machine.change_state(%Ground)


func _enter_state() -> void:
	if animation_state_machine == null:
		animation_state_machine = player.animation_tree["parameters/playback"]
	
	if player.transformed:
		player.transformed = false
		player.sprite.frame_coords.y = 0
	else:
		player.transformed = true
		player.sprite.frame_coords.y = 1
	
	player.animation_tree.animation_finished.connect(go_back)
	animation_state_machine.travel("switch")


func _exit_state() -> void:
	pass
