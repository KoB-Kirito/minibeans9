extends Control

func healthchanged(health):
	$TextureProgressBar.value = health 

func _ready():
	Events.healthchanged.connect(healthchanged)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
