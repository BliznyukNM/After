extends CharacterBody2D


func kill() -> void:
    $Body.play("die")
    $CollisionShape2D.disabled = true
    $Body/HitBox/CollisionShape2D.disabled = true
