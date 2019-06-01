extends Position2D
class_name Crosshair

export var debug : bool = true
export var rotate_sprite : bool = false
export var initial_line_length : float = 80.0
export var rotation_speed : float = 3.0

onready var viewport_width = get_viewport().size.x
onready var viewport_height = get_viewport().size.y
onready var line = $Line2D
onready var end_line = $Line2D/Position2D
onready var sprite = $Sprite
onready var radius = $CollisionShape2D.shape.radius

var rotation_angle : float = 0.0
var radius_x : float
var radius_y : float
const LINE_END_POINT_INDEX = 1

func _init() -> void:
	pause_mode = Node.PAUSE_MODE_STOP

func _ready() -> void:	
	
	set_process(GameManager.use_crosshair_as_pivot)
	set_process_input(GameManager.use_crosshair_as_pivot)
	set_process_unhandled_input(GameManager.use_crosshair_as_pivot)
	set_process_unhandled_key_input(GameManager.use_crosshair_as_pivot)
	
	if not GameManager.use_crosshair_as_pivot:
		hide()
		return
	
	end_line.scale = Vector2(1, initial_line_length)
	global_position.x = viewport_width / 2
	global_position.y = viewport_height / 2	
	end_line.position = line.get_point_position(LINE_END_POINT_INDEX)
	radius_x = radius * scale.x
	radius_y = radius * scale.y
	if not debug:
		line.hide()

func _process(delta : float) -> void:
	
	if GameManager.is_player_alive:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			rotation_angle += GameManager.player.get_rotation_speed()
		if Input.is_mouse_button_pressed(BUTTON_RIGHT):
			rotation_angle -= GameManager.player.get_rotation_speed()

func _physics_process(delta):
	
	global_rotation = rotation_angle * delta
	if not rotate_sprite:
		sprite.rotation = rotation_angle * delta * -1
	end_line.position = line.get_point_position(LINE_END_POINT_INDEX)

func _input(event):
	
	if GameManager.is_player_alive and event is InputEventMouseMotion:
		DebugManager.debug("event-mouse", event.relative, debug)
		global_position += event.relative
		global_position.x = clamp(global_position.x, radius_x, viewport_width - radius_x)
		global_position.y = clamp(global_position.y, radius_y, viewport_height - radius_y)

func get_line_end_position():	
	return $Line2D/Position2D
	
func on_Game_player_died() -> void:
	hide()
	
func on_Game_player_respawned(_position) -> void:
	if GameManager.use_crosshair_as_pivot:
		global_position = _position
		rotation_angle = 0.0
		show()
	
	
	
	
