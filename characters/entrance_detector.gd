extends Area2D


var entrance


func _on_entrance_detected(area: Area2D) -> void:
    entrance = area


func _on_entrance_lost(area: Area2D) -> void:
    if entrance == area: entrance = null
