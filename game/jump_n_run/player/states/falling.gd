class_name FallingState
extends State


@export var player: Player

@export var speed: float = 300.0
@export var jump_strength: float = 400.0
@export var gravity: int = 960


func _physics_process(delta: float) -> void:
	if player.is_on_floor():
		state_machine.change_state(%Ground)
		return
	
	if player.velocity.y < 0:
		state_machine.change_state(%Jumping)
		return
	
	# Gravity
	player.velocity.y += gravity * delta
	
	# Double Jump
	if player.current_jumps < player.double_jumps and Input.is_action_just_pressed("jump"):
		player.current_jumps += 1
		player.velocity.y = -jump_strength
	
	# Movement
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
	
	player.move_and_slide()


func _enter_state() -> void:
	player.animation_tree.set("parameters/conditions/falling", true)


func _exit_state() -> void:
	player.animation_tree.set("parameters/conditions/falling", false)
