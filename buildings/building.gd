extends Node2D


@onready var floors: = $Floors


func enter_floor(floor_number: int) -> void:
    for i in floors.get_child_count():
        var _floor: Node2D = floors.get_child(i)
        _floor.get_node("ExternalWalls").toggle(i != floor_number)
        _floor.get_node("Roof").toggle(floor_number != floors.get_child_count() - 1)
        
        #if floor_number >= 0 and i - 1 == floor_number: _floor.modulate = Color(1, 1, 1, 0.2)
        #else: _floor.modulate = Color.WHITE
