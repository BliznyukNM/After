extends Sprite2D


var _last_mouse_position: Vector2

# TODO: think about abstract fatigue mechanism
var _mouse_movement_fatigue: float
var _character_movement_fatigue: float
var _distance_fatigue: float


func _ready() -> void:
    _last_mouse_position = get_global_mouse_position()


func _process(delta: float) -> void:
    var target_position: = get_global_mouse_position()
    var delta_position: = (target_position - _last_mouse_position)
    
    if delta_position.length_squared() > 1: _mouse_movement_fatigue = min(2, _mouse_movement_fatigue + 10 * delta)
    else: _mouse_movement_fatigue = max(0.0, _mouse_movement_fatigue - delta)
    
    var character: CharacterBody2D = get_parent()
    if character.velocity.length_squared() > 0.0: _character_movement_fatigue = min(1, _character_movement_fatigue + 10 * delta)
    else: _character_movement_fatigue = max(0.0, _character_movement_fatigue - 3 * delta)
    
    var scope_distance: = (character.global_position - global_position).length()
    _distance_fatigue = scope_distance * 0.005
    
    var fatigue = _mouse_movement_fatigue + _character_movement_fatigue + _distance_fatigue
    var ticks: = Time.get_ticks_msec() * 0.001
    var offset = Vector2(9.21 * sin(ticks * 4.93), 8.3 * cos(ticks * 4.5)) * fatigue
    global_position = lerp(global_position, target_position + offset, delta * 10)
    _last_mouse_position = get_global_mouse_position()
