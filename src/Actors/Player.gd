extends Actor
class_name Player


export var stomp_impulse: float
export var bracking_speed: float

var can_move := true
var _jump_queued := false


func _ready() -> void:
    PlayerData.save_and_reset_score()


func _physics_process(_delta: float) -> void:
    velocity = move_and_slide(velocity, Vector2.UP)
    
    if !_jump_queued:
        _jump_queued = Input.is_action_just_pressed("jump") and can_enqueue_jump()
        if _jump_queued:
            print("jump enqueued")
    
    var direction := get_direction()
    var is_jump_interrupted := Input.is_action_just_released("jump") and velocity.y < 0.0
    velocity = calculate_move_velocity(velocity, direction, is_jump_interrupted)
    

func get_direction() -> Vector2:
    if !can_move:
        return Vector2.ZERO
    return Vector2(
        Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
        -1.0 if try_dequeue_jump() else 1.0
    )


func can_enqueue_jump() -> bool:
    for node in $GroundRayCasts.get_children():
        var raycast: RayCast2D = node as RayCast2D
        if raycast.is_colliding():
            return true
    return false


func try_dequeue_jump() -> bool:
    if (_jump_queued or Input.is_action_just_pressed("jump")) and is_on_floor():
        _jump_queued = false
        if Input.is_action_pressed("jump"):
            print("jump dequeued")
        return Input.is_action_pressed("jump")
    return false



func calculate_move_velocity(
        linear_velocity: Vector2, 
        direction: Vector2, 
        is_jump_interrupted: bool
        ) -> Vector2:
    var new_velocity = linear_velocity
    
    if direction.x != 0.0:
        new_velocity.x = speed.x * direction.x
    elif new_velocity.x != 0.0:
        new_velocity.x = max(0, (abs(linear_velocity.x) - bracking_speed)) * sign(linear_velocity.x)
    
    if direction.y < 0.0:
        new_velocity.y = speed.y * direction.y
    else:
        new_velocity.y += gravity * get_physics_process_delta_time()
        
    if is_jump_interrupted:
        new_velocity.y = 0
        
    return new_velocity
    

func restart_level() -> void:
    PlayerData.score = 0
    PlayerData.deaths += 1
    # warning-ignore:return_value_discarded
    get_tree().reload_current_scene()


func _on_EnemyDetectionArea_body_entered(body: Node) -> void:
    if $AnimationPlayer.current_animation == "die":
        return
            
    var enemy: Enemy = (body as Enemy)
    print(global_position.y, "\t", enemy.stomp_height_global())
    if global_position.y < enemy.stomp_height_global():
        velocity.y = -stomp_impulse
        enemy.die()
    else:
        can_move = false
        $AnimationPlayer.play("die")
