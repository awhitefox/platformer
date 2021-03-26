tool
extends Area2D


export var next_scene: PackedScene


func teleport() -> void:
    $AnimationPlayer.play("fade_to_black")
    yield($AnimationPlayer, "animation_finished")
    # warning-ignore:return_value_discarded
    get_tree().change_scene_to(next_scene)


func _get_configuration_warning() -> String:
    if not next_scene:
        return "next_scene must have a value"
    return ""


func _on_body_entered(_body: PhysicsBody2D) -> void:
    teleport()
