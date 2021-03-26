extends Node2D


export var reward: int


func pick_up():
    PlayerData.score += reward
    $AnimationPlayer.play("fade_out")


func _on_body_entered(_body: PhysicsBody2D) -> void:
    pick_up()
