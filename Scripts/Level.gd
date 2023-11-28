extends Area2D

export var scene: String = "res://Levels/Level02.tscn"


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene(scene)
