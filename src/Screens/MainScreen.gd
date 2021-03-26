extends Control


func _ready() -> void:
    Game.current_gamemode = Game.Gamemodes.NONE
    PlayerData.reset()
    SpeedrunStopwatch.reset()


func _on_PlayButton_button_up() -> void:
    Game.current_gamemode = Game.Gamemodes.DEFAULT


func _on_SpeedrunButton_button_up() -> void:
    Game.current_gamemode = Game.Gamemodes.SPEEDRUN
