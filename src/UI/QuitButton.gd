extends Button


func _ready() -> void:
    if OS.get_name() == "HTML5":
        disabled = true
    # warning-ignore:return_value_discarded
    connect("button_up", self, "quit")


func quit() -> void:
    get_tree().quit()
