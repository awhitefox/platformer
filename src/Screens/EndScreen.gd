extends Control


func _ready() -> void:
    PlayerData.save_and_reset_score()
    $Label.text %= [PlayerData.total_score(), PlayerData.deaths]
