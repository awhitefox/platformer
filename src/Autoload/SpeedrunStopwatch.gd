extends Node


var _start_ms := 0
var _stop_ms := 0
var _running := false


func start() -> void:
    if _running:
        return
    _start_ms = OS.get_ticks_msec()
    _running = true


func stop() -> void:
    if !_running:
        return
    _stop_ms = OS.get_ticks_msec()
    _running = false


func reset() -> void:
    _start_ms = 0
    _stop_ms = 0
    _running = false


func get_ms() -> int:
    if _running:
        return OS.get_ticks_msec() - _start_ms
    else:
        return _stop_ms - _start_ms


func get_time_formatted() -> String:
    var time = get_ms()
    var mins = time / 1000 / 60
    var secs = time / 1000 % 60
    var ms = time / 10 % 100
    return "%02d:%02d.%02d" % [mins, secs, ms]
        
