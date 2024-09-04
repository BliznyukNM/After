extends Area2D


@onready var view: AnimatedSprite2D = get_parent()


func hit(hit_pos: Vector2, _rid: RID) -> bool:
	var current_frame_texture: = view.sprite_frames.get_frame_texture(view.animation, view.frame)
	var current_frame_image: = current_frame_texture.get_image()
	var half_size: = current_frame_image.get_size() / 2
	var pixel_hit_pos: = Vector2i((hit_pos - global_position) / view.scale) + half_size
	var pixel: = current_frame_image.get_pixelv(pixel_hit_pos)
	var is_hit: = pixel.a > 0
	if is_hit: owner.kill() #TODO fix this
	return is_hit
