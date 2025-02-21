extends Node2D


@onready var floors: = $Floors


const OUTSIDE: = -1


func _ready() -> void: enter_room(OUTSIDE, OUTSIDE)


func enter_room(floor_id: int, room_id: int) -> void:
	for floor_index in floors.get_child_count():
		var floor: Node2D = floors.get_child(floor_index)
		
		for room_index in floor.get_child_count():
			var exact_room: = floor_id == floor_index and room_id == room_index
			var room: Node2D = floor.get_child(room_index)
			var interior: BackBufferCopy = room.get_node("Interior")
			interior.copy_mode = BackBufferCopy.CopyMode.COPY_MODE_DISABLED if not exact_room else BackBufferCopy.CopyMode.COPY_MODE_VIEWPORT
			interior.get_node("Floor").z_index = 0 if floor_id >= 0 and not exact_room else -1
			room.get_node("InteriorMask").visible = exact_room
			room.get_node("ExternalWalls").collision_enabled = floor_id != floor_index
			room.z_index = 0 if exact_room else -2
		#_floor.get_node("Roof").toggle(floor_number != floors.get_child_count() - 1)
		
		#if floor_number >= 0 and i - 1 == floor_number: _floor.modulate = Color(1, 1, 1, 0.2)
		#else: _floor.modulate = Color.WHITE
