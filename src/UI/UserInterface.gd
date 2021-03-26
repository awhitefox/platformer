extends Control


onready var _default_label_text = $Label.text


var paused := false setget set_paused


func _ready() -> void:
    # warning-ignore:return_value_discarded
    PlayerData.connect("score_updated", self, "update_ui")
    update_ui()


func update_ui() -> void:
    $Label.text = _default_label_text % PlayerData.score


func set_paused(value: bool) -> void:
    paused = value
    get_tree().paused = value
    $PauseOverlay.visible = value


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("pause"):
        self.paused = !self.paused
        get_tree().set_input_as_handled()


func _on_ResumeButton_button_up() -> void:
    self.paused = false


func _on_BackButton_button_up() -> void:
    self.paused = false
