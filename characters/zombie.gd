extends CharacterBody2D


@export var speed: = 50.0


var target: Node2D


func _physics_process(delta: float) -> void:
	update_animation()


func update_animation() -> void:
	if abs(velocity.x) > 0.0:
		$Body.play("run")
		$Body.flip_h = velocity.x > 0
		$VisionRay.target_position = abs($VisionRay.target_position) * sign(velocity.x)
	else: $Body.play("idle")
	


func kill() -> void:
	set_physics_process(false)
	$Body.play("die")
	$CollisionShape2D.disabled = true
	$Body/HitBox/CollisionShape2D.disabled = true
