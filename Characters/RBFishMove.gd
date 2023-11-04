extends RigidBody2D

var speed = 360
var ramp = 15
var input = Vector2(0,0)
var wallhop = Vector2(400,-380)
var inWater = true
var size = 1
var startScale
var grounded = false
var fGrounded = false
var WallBounce = false

var ray
var flopHeight = -35
var jumpHeight = -380


func _process(_delta):
	startScale = abs(get_node("FishYGator").scale.x)
	
	if(linear_velocity.x < -1):
		size = 1
	elif(linear_velocity.x > 1):
		size = -1
		
	get_node("FishYGator").scale.x = startScale * size
		



func _physics_process(_delta):
	ray = get_node("Jhop")
	if(ray.get_collision_count () != 0):
		grounded = true
		fGrounded = true
	else:
		fGrounded=false	
		
	ray = get_node("FishYGator/FaceCast")
	if(ray.get_collider() != null):
		WallBounce = true
	else:
		WallBounce = false
	
	
	input = Vector2(
		Input.get_action_raw_strength("ui_right") - Input.get_action_raw_strength("ui_left"),
		Input.get_action_raw_strength("ui_down") - Input.get_action_raw_strength("ui_up")).normalized()
	

	if(abs(linear_velocity.x) < speed):
		linear_velocity.x += ramp * input.x
	
	
	if(inWater):
		gravity_scale = 0.0;
		if(abs(linear_velocity.y) < speed):
			linear_velocity.y += ramp * input.y
			
		if(abs(input.x) < 0.33):
			linear_velocity.x /= 1.015
		if(abs(input.y) < 0.33):
			linear_velocity.y /= 1.015
	else:
		if(Input.is_action_just_pressed("ui_up")):
			input.y = 1
		else:
			input.y = 0
		gravity_scale = 1.0;
		
		if(grounded && input.y > 0.5):
			var plus = 0
			if(linear_velocity.y > 0):
				plus += linear_velocity.y
			linear_velocity.y = jumpHeight + plus;
			grounded = false;
			
		if(WallBounce && input.y > 0.5 && !grounded):
			linear_velocity.y = wallhop.y
			linear_velocity.x = wallhop.x * size + linear_velocity.x
			
		if(fGrounded):
			apply_central_impulse(Vector2(0,flopHeight * randf_range(0.8,1.8)))
			fGrounded = false


