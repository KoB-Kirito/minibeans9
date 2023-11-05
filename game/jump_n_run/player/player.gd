class_name Player
extends CharacterBody2D


@export var health: int = 100
@export var stength: int = 10
@export var double_jumps: int = 1

var current_jumps: int = 0
var transformed: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree


func _ready() -> void:
	animation_tree.active = true


func _physics_process(_delta: float) -> void:
	update_animation()
	update_facing_direction()


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
