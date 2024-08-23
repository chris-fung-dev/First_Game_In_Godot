extends CharacterBody2D

var Can_dash = false
const Dash_Speed = 600
var is_Dashing = false
const SPEED = 100.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var Dash_Length = $Dash_Length
@onready var Dash_Effect_Timer = $Dash_Effect_Timer
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite_2d.play("Junp")

	# Initiate dash if the player can dash.
	if Input.is_action_just_pressed("Dash") and Can_dash:
		is_Dashing = true
		$Dash_Length.start()
		$Dash_Effect_Timer.start()  # Start the Dash Effect Timer here.

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle movement.
	var direction = Input.get_axis("Move_Left", "Move_Right")
	if is_on_floor():
		if direction > 0:
			animated_sprite_2d.flip_h = false
			animated_sprite_2d.play("Run")
		elif direction < 0:
			animated_sprite_2d.flip_h = true
			animated_sprite_2d.play("Run")
		elif direction == 0:
			animated_sprite_2d.play("Idle")
	else:
		animated_sprite_2d.play("Junp")

	if direction:
		if is_Dashing:
			velocity.x = direction * Dash_Speed
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_dash_length_timeout():
	is_Dashing = false
	Can_dash = false
	Dash_Effect_Timer.stop()

func die() -> void:
	get_tree().reload_current_scene()

func create_dash_effect():
	var playerCopyNode = $AnimatedSprite2D.duplicate()
	get_parent().add_child(playerCopyNode)
	playerCopyNode.global_position = global_position
	
	var animationTime = Dash_Length.wait_time / 3
	await get_tree().create_timer(animationTime).timeout
	playerCopyNode.modulate.a = 0.4
	await get_tree().create_timer(animationTime).timeout
	playerCopyNode.modulate.a = 0.2
	await get_tree().create_timer(animationTime).timeout
	playerCopyNode.queue_free()

func _on_dash_effect_timer_timeout():
	create_dash_effect()
func _on_animated_sprite_2d_animation_changed():
	pass # Replace with function body.
