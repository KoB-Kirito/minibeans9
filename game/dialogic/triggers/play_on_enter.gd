extends Area2D
# plays a dialog if entered by player


@export var dialog_name: String
@export var one_shot: bool = true


func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	
	Dialogic.start(dialog_name)
	
	if one_shot:
		queue_free()
