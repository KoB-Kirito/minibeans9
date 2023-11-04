extends ParallaxBackground


@export var distance: float = 0.1

@onready var parallax_layer_1: ParallaxLayer = $ParallaxLayer1
@onready var parallax_layer_2: ParallaxLayer = $ParallaxLayer2
@onready var parallax_layer_3: ParallaxLayer = $ParallaxLayer3
@onready var parallax_layer_4: ParallaxLayer = $ParallaxLayer4
@onready var parallax_layer_5: ParallaxLayer = $ParallaxLayer5

func _ready() -> void:
	parallax_layer_1.motion_scale = Vector2.ONE * distance
	parallax_layer_2.motion_scale = Vector2.ONE * distance * 2
	parallax_layer_3.motion_scale = Vector2.ONE * distance * 3
	parallax_layer_4.motion_scale = Vector2.ONE * distance * 4
	parallax_layer_5.motion_scale = Vector2.ONE * distance * 5
