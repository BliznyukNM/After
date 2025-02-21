extends Node2D


@onready var floors: = $Floors


const OUTSIDE: = "OUTSIDE"


func _ready() -> void: enter_room(OUTSIDE, OUTSIDE)


func enter_room(floor_id: String, room_id: String) -> void:
	for floor_index in floors.get_child_count():
		var floor: Node2D = floors.get_child(floor_index)
		var exact_floor: = floor_id == floor.name
		
		for room_index in floor.get_child_count():
			var room: Node2D = floor.get_child(room_index)
			var exact_room: = exact_floor and room_id == room.name
			var interior: BackBufferCopy = room.get_node("Interior")
			interior.copy_mode = BackBufferCopy.CopyMode.COPY_MODE_DISABLED if not exact_room else BackBufferCopy.CopyMode.COPY_MODE_VIEWPORT
			interior.get_node("Floor").z_index = 0 if floor_index >= 0 and not exact_room else -1
			room.get_node("InteriorMask").visible = exact_room
			room.get_node("ExternalWalls").collision_enabled = not exact_floor
			#room.z_index = 0 if exact_room else -2
		#_floor.get_node("Roof").toggle(floor_number != floors.get_child_count() - 1)
		
		#if floor_number >= 0 and i - 1 == floor_number: _floor.modulate = Color(1, 1, 1, 0.2)
		#else: _floor.modulate = Color.WHITE
