extends Control


func _ready() -> void:
    SpeedrunStopwatch.stop()
    PlayerData.save_and_reset_score()
    $Label.text %= [PlayerData.total_score(), PlayerData.deaths]
    if Game.current_gamemode == Game.Gamemodes.SPEEDRUN:
        $Stopwatch.visible = true
        $Stopwatch.text = SpeedrunStopwatch.get_time_formatted()
