extends TileMap


const EXTERNAL_WALLS_LAYER = 3
const ROOF_LAYER = 4
const TRANSPARENT_MODULATION = 0.15


func toggle_external_walls(on: bool) -> void: _toggle_layer(EXTERNAL_WALLS_LAYER, on)
func toggle_roof(on: bool) -> void: _toggle_layer(ROOF_LAYER, on)


func _toggle_layer(layer: int, on: bool) -> void:
    var modulation: = get_layer_modulate(layer)
    modulation.a = 1.0 if on else TRANSPARENT_MODULATION
    set_layer_modulate(layer, modulation)
