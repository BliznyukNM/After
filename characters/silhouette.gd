extends AnimatedSprite2D


@onready var target: AnimatedSprite2D = get_parent()


func _ready() -> void:
    assert(target)
    target.property_list_changed.connect(_on_target_properties_changed)
    sprite_frames = target.sprite_frames


func _on_target_properties_changed() -> void:
    animation = target.animation
    frame = target.frame
    speed_scale = target.speed_scale
