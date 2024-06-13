extends CharacterBody2D


@export var speed: = 50.0


var target: Node2D


func _physics_process(delta: float) -> void:
    update_animation()
    
    if not target:
        var collider = $VisionRay.get_collider()
        if collider: target = collider.owner
    
    if not target: return
    
    if abs(target.global_position.x - global_position.x) <= 70:
        velocity = Vector2.ZERO
        if $Body.animation != "hit": $Body.play("hit")
    else:
        velocity = Vector2(sign(target.global_position.x - global_position.x), 0.0) * speed
        move_and_slide()


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
