extends Area2D


@export_enum("Up:1", "Down:-1") var direction: int
@export var room: Node


@onready var entrance_point: = $EntrancePoint


func enter(node: Node2D) -> void:
	var room_id: = &"" if not room else room.name
	var floor_id: = &"" if not room else room.get_parent().name
	var root: = owner.get_parent() if not room else room.get_node("Interior/Spawn")
	
	owner.enter_room(floor_id, room_id)
	node.get_parent().remove_child(node)
	root.add_child(node)
	node.global_position = entrance_point.global_position
