extends Area2D


@export_enum("Up:1", "Down:-1") var direction: int
@export var floor_id: int = -1 # negative means exiting from the building
@export var root: Node


@onready var entrance_point: = $EntrancePoint


func enter(node: Node2D) -> void:
    owner.enter_floor(floor_id)
    node.global_position = entrance_point.global_position
