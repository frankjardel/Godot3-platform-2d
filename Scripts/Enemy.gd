extends StaticBody2D

var flip: bool = true
var start_position: float
var final_position: float
export var distance: float = 500
var is_die: bool


func _ready():
	$AnimatedSprite.play("Walk")
	start_position = $".".position.x
	final_position = start_position + distance


func _process(delta):
	if !is_die:
		if (start_position <= final_position and flip):
			$".".position.x += 0.3
			$AnimatedSprite.flip_h = false
			if ($".".position.x >= final_position):
				flip = false
		if ($".".position.x >= start_position and !flip):
			$".".position.x -= 0.3
			$AnimatedSprite.flip_h = true
			if ($".".position.x <= start_position):
				flip = true
	else:
		$CollisionShape2D.disabled = true


func die():
	is_die = true
	$AnimatedSprite.play("Dead")
	$AnimationPlayer.play("Damage")
