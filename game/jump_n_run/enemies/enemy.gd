class_name Enemy
extends CharacterBody2D

signal died


enum {WALK, ATTACK, DEAD}
var state = WALK

@export var health: int = 20
@export var speed = 20.0
@export var gravity: int = 960
@export var damage: int = 10

var player: Player

@onready var ancor: Node2D = $Ancor
@onready var sprite: AnimatedSprite2D = $Ancor/AnimatedSprite2D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	if Globals.paused:
		return
	
	# pause enemy if far away
	if position.distance_squared_to(player.position) > 12000000:
		#print(position.distance_squared_to(player.position))
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	match state:
		WALK:
			if velocity.x == 0:
				sprite.stop()
			else:
				sprite.play("walk")
			
			if player.position.x < position.x - 20:
				velocity.x = -speed
				ancor.scale.x = 1
			elif player.position.x > position.x + 20:
				velocity.x = speed
				ancor.scale.x = -1
	
	move_and_slide()


func hurt(amount: int) -> void:
	if state == DEAD:
		return
	
	print_debug("enemy was hurt for ", amount)
	
	health -= amount
	if health <= 0:
		state = DEAD
		sprite.stop()
		sprite.animation_finished.connect(remove)
		sprite.play("death")
		return
	
	sprite.modulate = Color(1.0, 0.0, 0.0)
	
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(1.0, 1.0, 1.0), 0.5)


func remove() -> void:
	died.emit()
	queue_free()
