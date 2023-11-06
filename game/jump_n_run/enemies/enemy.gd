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
var player_in_attack_range: bool = false

@onready var ancor: Node2D = $Ancor
@onready var sprite: AnimatedSprite2D = $Ancor/AnimatedSprite2D
@onready var attack_cooldown: Timer = $AttackCooldown
@onready var area_2d: Area2D = $Ancor/Area2D
@onready var ray_cast_2d: RayCast2D = $Ancor/RayCast2D
@onready var snd_attack: AudioStreamPlayer2D = $snd_attack
@onready var attack_sound_timer: Timer = $AttackSound


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	area_2d.body_entered.connect(on_area_2d_body_entered)
	area_2d.body_exited.connect(on_area_2d_body_exited)
	attack_sound_timer.timeout.connect(play_attack_sound)


func _physics_process(delta: float) -> void:
	if Globals.paused:
		return
	
	# pause enemy if far away
	var distance_to_player := position.distance_squared_to(player.position)
	if distance_to_player > 1000000:
		#print(position.distance_squared_to(player.position))
		return
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	match state:
		WALK:
			# attack
			if distance_to_player < 4000 and attack_cooldown.time_left == 0:
				attack()
				return
			
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
	
	# dont walk off edges
	if not ray_cast_2d.is_colliding():
		velocity.x = 0
	
	move_and_slide()


func attack() -> void:
	attack_cooldown.start()
	state = ATTACK
	
	velocity = Vector2.ZERO
	
	sprite.stop()
	sprite.animation_finished.connect(back_to_walk)
	sprite.play("attack")
	
	attack_sound_timer.start()


func back_to_walk() -> void:
	sprite.animation_finished.disconnect(back_to_walk)
	
	if state == DEAD:
		return
	
	state = WALK
	
	if player_in_attack_range:
		player.hurt(damage)


func play_attack_sound() -> void:
	snd_attack.play()


func hurt(amount: int) -> void:
	if state == DEAD:
		return
	
	print_debug("enemy was hurt for ", amount)
	
	health -= amount
	if health <= 0:
		state = DEAD
		velocity.x = 0
		sprite.stop()
		sprite.animation_finished.connect(remove)
		sprite.play("death")
	
	sprite.modulate = Color(1.0, 0.0, 0.0)
	
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(1.0, 1.0, 1.0), 0.5)


func remove() -> void:
	died.emit()
	queue_free()


func on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_attack_range = true


func on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_attack_range = false
