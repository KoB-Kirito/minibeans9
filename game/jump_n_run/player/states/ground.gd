class_name GroundState
extends State


@export var player: Player

@export var speed: float = 300.0
@export var jump_strength: float = 400.0


func _physics_process(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.change_state(%Jumping)
		return
	
	if Input.is_action_just_pressed("switch"):
		state_machine.change_state(%Switching)
		return
	
	if Input.is_action_just_pressed("attack"):
		state_machine.change_state(%Attacking)
		return
	
	# Jump
	if Input.is_action_just_pressed("jump"):
		player.velocity.y = -jump_strength
	
	# Movement
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
	
	player.move_and_slide()


func _enter_state() -> void:
	# reset double jumps
	player.current_jumps = 0
	
	if player.animation_tree != null:
		player.animation_tree.set("parameters/conditions/grounded", true)


func _exit_state() -> void:
	player.animation_tree.set("parameters/conditions/grounded", false)
