tool
extends Button


export(String, FILE) var next_scene_path := ""


func _ready() -> void:
    # warning-ignore:return_value_discarded
    connect("button_up", self, "change_scene")


func change_scene() -> void:
    # warning-ignore:return_value_discarded
    get_tree().change_scene(next_scene_path)


func _get_configuration_warning() -> String:
    if next_scene_path == "":
        return "next_scene_path must have value"
    return ""
