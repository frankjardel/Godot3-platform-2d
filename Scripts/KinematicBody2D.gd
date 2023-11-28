extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const JUMP_HEIGHT = -600
const RUN = 600
const WALK = 400
var speed = 400
var motion = Vector2()


func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("run"):
		speed = RUN
	else:
		speed = WALK
	
	if Input.is_action_pressed("left"):
		motion.x = -speed
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("right"):
		motion.x = speed
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = false
	else:
		motion.x = 0
		$AnimatedSprite.play("Idle")
		
	if $RayCast2D.is_colliding():
		if Input.is_action_just_pressed("jump"):
			motion.y = JUMP_HEIGHT -delta
	else:
		$AnimatedSprite.play("Jump")
			
	if is_on_wall():
		if Input.is_action_just_pressed("jump"):
			motion.y = JUMP_HEIGHT
			if $RayCast2DLeft.is_colliding():
				motion.x = -(JUMP_HEIGHT - speed)
			if $RayCast2DRight.is_colliding():
				motion.x = JUMP_HEIGHT + speed
		else:
			motion.y = 100
		
	motion = move_and_slide(motion, UP)


func _on_Area2D_body_entered(body):
	motion.y = JUMP_HEIGHT
	body.die()


func _on_Area2D2_body_entered(body):
	$AnimationPlayer.play("Damage")
	$TimerForReset.start()


func _on_TimerForReset_timeout():
	get_tree().reload_current_scene()
