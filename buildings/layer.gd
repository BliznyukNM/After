extends TileMapLayer


func hit(hit_pos: Vector2, rid: RID) -> bool:
    # This abomination is basically calculating mouse position relative to atlas texture
    
    # 1. As we have RID after collision we can have exact coordinates of tile we are colliding with
    # + we can gather all the necessary data
    var tile_coords: = get_coords_for_body_rid(rid) # coordinates in tile layer
    var source_id: = get_cell_source_id(tile_coords) # id of atlas in tile set
    var tile_data: = get_cell_tile_data(tile_coords) # tile data (we will need texture origin offset)
    var atlas_coords: = get_cell_atlas_coords(tile_coords) # coordinates in tile set atlas
    var tile_source: TileSetAtlasSource = tile_set.get_source(source_id)
    var tile_atlas_size: = tile_source.get_tile_size_in_atlas(atlas_coords)
    var atlas_image: = tile_source.texture.get_image()
    
    # 2. In tile set we have each tile origin in exact centre of area in covers. Additionaly
    # we setup texture offset to draw the tile from left bottom corner. So to revert that
    # first we remove this origin offset and then move the origin half size left and up.
    # After all manipulations we are half cell left and up, so we compencate that.
    var left_corner_offset: = tile_data.texture_origin + tile_atlas_size * tile_set.tile_size / 2 - tile_set.tile_size / 2
    
    # 3. Substracting global mouse click position from tile layer global position give us relative mouse
    # position. After that we substract tile layer coordinate (basically [i * width, j * height]) to get
    # position relative to the tile itself. By adding left corner offset we will get mouse position
    # relative to tile's left top corner.
    var local_hit_pos: = Vector2i(hit_pos - global_position) - tile_coords * tile_set.tile_size + left_corner_offset
    
    # 4. Last step is to move calculated relative mouse position to appropriate texture position.
    # For that we just take atlas coordinate and multiply it by tile size.
    var pixel_hit_pos: = local_hit_pos + tile_set.tile_size * atlas_coords
    
    return atlas_image.get_pixelv(pixel_hit_pos).a > 0
