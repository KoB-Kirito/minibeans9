extends Node


@onready var camera: Camera2D = $"../Player/Camera"


func _on_area_2d_body_entered(body: Node2D) -> void:
	# pause
	Globals.paused = true
	
	Bgm.fade_out(0.5)
	
	# move camera
	camera.reparent(self)
	var tween = camera.create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(camera, "position", Vector2(12480, 250), 4.0)
	tween.tween_callback(camera_moved)


func camera_moved() -> void:
	Globals.paused = false
	Bgm.fade_in(load("res://assets/sounds/Spiritwatcher.ogg"), 1.0)
