extends Node2D


@onready var floors: = $Floors


func _ready() -> void: enter_floor(-1)


func enter_floor(floor_number: int) -> void:
	for i in floors.get_child_count():
		var _floor: Node2D = floors.get_child(i)
		var interior: BackBufferCopy = _floor.get_node("Interior")
		interior.copy_mode = BackBufferCopy.CopyMode.COPY_MODE_DISABLED if i != floor_number else BackBufferCopy.CopyMode.COPY_MODE_VIEWPORT
		interior.get_node("Floor").z_index = 0 if floor_number >= 0 and i != floor_number else -1
		_floor.get_node("InteriorMask").visible = i == floor_number
		_floor.get_node("ExternalWalls").collision_enabled = i != floor_number
		#_floor.get_node("Roof").toggle(floor_number != floors.get_child_count() - 1)
		
		#if floor_number >= 0 and i - 1 == floor_number: _floor.modulate = Color(1, 1, 1, 0.2)
		#else: _floor.modulate = Color.WHITE
