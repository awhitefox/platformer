extends TileMap


func _ready() -> void:
    var rect := get_used_rect()
    rect.position *= cell_size
    rect.size *= cell_size
    var camera: Camera2D = get_tree().get_nodes_in_group("cameras")[0]
    camera.limit_left = int(rect.position.x)
    camera.limit_top = int(rect.position.y)
    camera.limit_right = int(rect.end.x)
    camera.limit_bottom = int(rect.end.y)
