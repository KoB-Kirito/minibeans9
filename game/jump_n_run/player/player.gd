class_name Player
extends CharacterBody2D


@export var health: int = 100
@export var stength: int = 10
@export var double_jumps: int = 1

var current_jumps: int = 0
var transformed: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_tree.active = true


func _physics_process(_delta: float) -> void:
	update_animation()
	update_facing_direction()
	
	if Input.is_action_just_pressed("reset"):
		print("reset")
		animation_tree.active = true
		animation_tree["parameters/playback"].start("move", true)
		$StateMachine.change_state(%Ground)


func update_animation() -> void:
	if transformed:
		animation_tree.set("parameters/move/blend_position", Vector2(velocity.x, 1))
		animation_tree.set("parameters/switch/blend_position", 1)
		animation_tree.set("parameters/jump/blend_position", 1)
		animation_tree.set("parameters/fall/blend_position", 1)
	else:
		animation_tree.set("parameters/move/blend_position", Vector2(velocity.x, 0))
		animation_tree.set("parameters/switch/blend_position", 0)
		animation_tree.set("parameters/jump/blend_position", 0)
		animation_tree.set("parameters/fall/blend_position", 0)


func update_facing_direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true


func hurt(amount: int) -> void:
	if health <= 0:
		return
	
	print("player hurt for ", amount)
	
	health -= amount
	Events.healthchanged.emit(health)
	
	%snd_hit.play()
	
	if health <= 0:
		$StateMachine.change_state(%Dead)
		return
	
	# simple red flash animation
	sprite.modulate = Color(1.0, 0.0, 0.0)
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(1.0, 1.0, 1.0), 0.5)
	
	# buggy, replaced with red flash for now
	#animation_tree.active = false
	#animation_player.play("hurt", transformed)
	#animation_player.animation_finished.connect(func(name): animation_tree.active = true, CONNECT_ONE_SHOT)


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		hurt(body.damage)
