extends Control


onready var _default_score_text = $Inner/Score.text


var paused := false setget set_paused


func _ready() -> void:
    $Inner/Stopwatch.visible = Game.current_gamemode == Game.Gamemodes.SPEEDRUN
    # warning-ignore:return_value_discarded
    PlayerData.connect("score_updated", self, "update_ui")
    update_ui()


func _process(delta: float) -> void:
    if Game.current_gamemode == Game.Gamemodes.SPEEDRUN:
        $Inner/Stopwatch.text = SpeedrunStopwatch.get_time_formatted()


func update_ui() -> void:
    $Inner/Score.text = _default_score_text % PlayerData.score


func set_paused(value: bool) -> void:
    if Game.current_gamemode == Game.Gamemodes.SPEEDRUN:
        $PauseOverlay/VBoxContainer/BackButton.change_scene()
        return
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
