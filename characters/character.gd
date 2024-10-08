extends CharacterBody2D


@export var speed: = 100.0
@export var back_speed: = 70.0


@onready var weapon_root: = $Visual/WeaponRoot


var carry_weapon: bool:
	set(value):
		carry_weapon = value
		weapon_root.visible = value
		Cursor.mode = Cursor.Mode.GUN if value else Cursor.Mode.PICK


func _ready() -> void:
	carry_weapon = false
	Cursor.character = self


func _process(_delta: float) -> void:
	var look_dir: = _get_look_direction()
	if abs(look_dir.x) > 0: $Visual.scale = Vector2(1 if look_dir.x > 0 else -1, 1)
	
	var input: = Input.get_axis("character.left", "character.right")
	
	if absf(input) > 0.0:
		$Visual/Body.play("walk", sign(input * look_dir.x))
	else:
		$Visual/Body.play("idle")
	
	var is_going_forward = input >= 0 and look_dir.x >= 0 or input < 0 and look_dir.x < 0
	velocity = Vector2.RIGHT * input * (speed if is_going_forward else back_speed)
	move_and_slide()
	
	var entrance = $EntranceDetector.entrance
	if entrance and "direction" in entrance:
		if entrance.direction > 0 and Input.is_action_just_pressed("character.up") or \
				entrance.direction < 0 and Input.is_action_just_pressed("character.down"):
			entrance.enter(self)
	
	if Input.is_action_just_pressed("character.weapon.toggle"):
		carry_weapon = !carry_weapon
	
	if carry_weapon and Input.is_action_just_pressed("character.shoot"):
		#$Visual/Arms/BackArm.play("shoot")
		#$Visual/Arms/FrontArm.play("shoot")
		
		var flare: Node2D = load("res://assets/crosshairs/flare.tscn").instantiate()
		flare.global_position = Cursor.crosshair.global_position
		owner.add_child(flare)
		
		shoot(Cursor.crosshair.global_position)


func _get_look_direction() -> Vector2:
	return get_viewport().get_camera_2d().get_global_mouse_position() - global_position \
		if carry_weapon else velocity
		

func shoot(mouse_position: Vector2) -> void:
	var space_state: = get_world_2d().direct_space_state
	var query: = PhysicsPointQueryParameters2D.new()
	query.position = mouse_position
	query.collide_with_areas = true
	query.collide_with_bodies = true
	var result: = space_state.intersect_point(query)
	
	if result.is_empty(): return
	
	result.sort_custom(sort_ascending)
	
	for target in result:
		if not target.collider.has_method("hit"): continue
		if target.collider.hit(query.position, target.rid): break


func sort_ascending(a, b): return a.collider.owner.position.y > b.collider.owner.position.y
