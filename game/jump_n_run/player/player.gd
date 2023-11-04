class_name Player
extends CharacterBody2D


@export var double_jumps: int = 1

var current_jumps: int = 0
var transformed: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree


func _physics_process(_delta: float) -> void:
	update_animation()
	update_facing_direction()


func update_animation() -> void:
	animation_tree.set("parameters/Move/blend_position:x", velocity.x)


func update_facing_direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
