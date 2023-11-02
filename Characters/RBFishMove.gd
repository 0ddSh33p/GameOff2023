extends RigidBody2D

var speed = 3.0;
var input;
var inWater = false;

func _physics_process(delta):
	var cur_speed = Vector2(0.0,0.0);
	input = Vector2(
		Input.get_action_raw_strength("ui_left") - Input.get_action_raw_strength("ui_right"),
		Input.get_action_raw_strength("ui_up") - Input.get_action_raw_strength("ui_down")).normalized();
	
	#if(abs(linear_velocity.x) < speed):
	cur_speed.x = speed * input.x;
		
	#if(abs(linear_velocity.y) < speed && inWater):
	cur_speed.y = speed * input.y;

	apply_central_impulse(cur_speed);
