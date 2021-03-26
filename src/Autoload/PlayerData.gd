extends Node


signal score_updated
signal deaths_updated


var score := 0 setget set_score
var deaths := 0 setget set_deaths
var _total_score := 0


func set_score(value: int) -> void:
    score = value
    emit_signal("score_updated")


func set_deaths(value: int) -> void:
    deaths = value
    emit_signal("deaths_updated")


func total_score() -> int:
    return _total_score


func save_and_reset_score() -> void:
    _total_score += score
    self.score = 0


func reset() -> void:
    _total_score = 0
    self.score = 0
    self.deaths = 0
