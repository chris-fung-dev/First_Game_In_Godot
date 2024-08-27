extends Area2D




func _on_body_entered(body):
	body.Can_dash = true
	queue_free()

