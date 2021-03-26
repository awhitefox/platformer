extends KinematicBody2D 
class_name Actor


export var speed: Vector2
export var gravity: float


var velocity := Vector2.ZERO


func _physics_process(delta: float) -> void:
    velocity.y += gravity * delta
