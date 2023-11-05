extends Node
# global data


### pause while dialog is shown

var paused: bool = false

func _ready() -> void:
	Dialogic.timeline_started.connect(dialog_started)
	Dialogic.timeline_ended.connect(dialog_ended)

func dialog_started() -> void:
	paused = true

func dialog_ended() -> void:
	paused = false
