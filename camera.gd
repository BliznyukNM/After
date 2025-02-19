extends Camera2D


@export var target: Node2D


func _process(delta: float) -> void:
	var middle_pos: = target.position + get_local_mouse_position()
	position.x = lerp(position.x, middle_pos.x, delta * 10)
	position.y = lerp(position.y, middle_pos.y, delta * 5)
