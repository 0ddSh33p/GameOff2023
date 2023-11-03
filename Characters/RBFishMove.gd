extends RigidBody2D

var speed = 360
var ramp = 15
var input = Vector2(0,0)
var inWater = false
var size
var nSize
var grounded = false
var fGrounded = false

var ray
var flopHeight = -35
var jumpHeight = -120


func _process(_delta):
	size = abs(get_node("FishYGator").scale.x)
	nSize = abs(get_node("FishYGator").scale.x) * -1
	
	if(linear_velocity.x < -1):
		get_node("FishYGator").scale.x = size
	elif(linear_velocity.x > 1):
		get_node("FishYGator").scale.x = nSize
	
	if(fGrounded && !inWater):
		apply_central_impulse(Vector2(0,flopHeight * randf_range(0.8,1.8)))
		fGrounded = false


func _physics_process(_delta):
	ray = get_node("RayCast2D")
	if(ray.get_collider() != null):
		grounded = true
		fGrounded = true
	else:
		fGrounded=false
	
	
	
	input = Vector2(
		Input.get_action_raw_strength("ui_right") - Input.get_action_raw_strength("ui_left"),
		Input.get_action_raw_strength("ui_up") - Input.get_action_raw_strength("ui_down")).normalized()
	
	if(abs(linear_velocity.x) < speed):
		linear_velocity.x += ramp * input.x
		
	if(grounded && input.y > 0.5):
		apply_central_impulse(Vector2(0,jumpHeight))
		grounded = false;
	
	if(inWater):
		gravity_scale = 0.0;
	else:
		gravity_scale = 1.0;



