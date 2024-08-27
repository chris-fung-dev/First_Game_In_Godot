extends Area2D

# Signal to detect collision
signal player_reached_flag
@onready var GameManager = %GameManager

func _ready():
	# Connect the signal to the function using Callable
	connect("body_entered", Callable(self, "_on_Flag_body_entered"))

func _on_Flag_body_entered(body):
	if body.name == "CharacterBody2D":  # Ensure the colliding body is the player
		if GameManager.money >= GameManager.required_coins:
			emit_signal("player_reached_flag")
			get_tree().change_scene_to_file("res://First_Godot_Game_Assets/Scenes/level_2.tscn")  # Change to your level 2 scene
