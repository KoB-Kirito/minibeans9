extends Node
# global data

@onready var player: AudioStreamPlayer = $player


func _ready() -> void:
	player.stream = load("res://assets/sounds/bittersweet-eerie-horror-vocals-the-siren.ogg")
	player.play()


func fade_out(duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(player, "volume_db", -30.0, duration)
	tween.tween_callback(func(): player.stop())

func fade_in(stream: AudioStream, duration: float) -> void:
	player.stream = stream
	player.volume_db = -30
	player.play()
	var tween = create_tween()
	tween.tween_property(player, "volume_db", 0.0, duration)
