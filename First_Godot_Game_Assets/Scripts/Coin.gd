extends Area2D 

@onready var GameManager = %GameManager

func _on_body_entered(body):
	print("Collided with: ", body.name)
	GameManager.add_coin()
	queue_free()
