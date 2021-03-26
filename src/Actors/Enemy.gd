extends Actor
class_name Enemy


export var reward: int


func _ready() -> void:
    set_physics_process(false)
    velocity.x = -speed.x


func _physics_process(_delta: float) -> void:
    velocity.y += gravity * _delta
    if is_on_wall():
        velocity *= -1.0
    velocity.y = move_and_slide(velocity, Vector2.UP).y    


func stomp_height_global() -> float:
    return $StompMarker.global_position.y


func die():
    PlayerData.score += reward
    queue_free()
