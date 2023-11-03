extends RigidBody2D

var speed = 360
var ramp = 25
var input = Vector2(0,0)
var inWater = false
var size
var grounded = false


func _process(_delta):
	size = abs(get_node("FishYGator").scale.x)
	if(linear_velocity.x < -0.8):
		get_node("FishYGator").scale.x = size
	elif(linear_velocity.x > 0.8):
		get_node("FishYGator").scale.x = size*-1
		
func _physics_process(_delta):
	var space_state = get_world_2d().direct_space_state
	input = Vector2(
		Input.get_action_raw_strength("ui_right") - Input.get_action_raw_strength("ui_left"),
		Input.get_action_raw_strength("ui_down") - Input.get_action_raw_strength("ui_up")).normalized()
	
	if(abs(linear_velocity.x) < speed):
		linear_velocity.x += ramp * input.x
	
	if(inWater):
		gravity_scale = 0.0;
	else:
		gravity_scale = 1.0;
