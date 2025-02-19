extends Sprite2D


@onready var target: AnimatedSprite2D = get_parent()


func _ready() -> void:
	assert(target)


func _process(delta: float) -> void:
	var animation: = target.animation
	var frame: = target.frame
	texture = target.sprite_frames.get_frame_texture(animation, frame)
