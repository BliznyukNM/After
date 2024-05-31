extends CharacterBody2D


@export var speed: = 100.0


func _process(_delta: float) -> void:
    var input: = Input.get_axis("character.left", "character.right")
    velocity = Vector2.RIGHT * input * speed
    move_and_slide()
    
    if absf(input) > 0.0:
        $Visual/Body.play("walk")
        $Visual.scale = Vector2(sign(input), 1.0)
    else:
        $Visual/Body.play("idle")
    
    var entrance = $EntranceDetector.entrance
    if entrance:
        if entrance.direction > 0 and Input.is_action_just_pressed("character.up") or \
                entrance.direction < 0 and Input.is_action_just_pressed("character.down"):
            entrance.enter(self)
    
