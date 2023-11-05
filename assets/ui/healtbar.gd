extends Control

func healthchanged(health):
	$TextureProgressBar.value = health 

func _ready():
	Events.healthchanged.connect(healthchanged)
