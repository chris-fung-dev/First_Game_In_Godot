extends Node

var money: int = 0
var required_coins: int = 1 # Change this value to set the required amount of coins
var label: Label = null

func _ready():
	# Assuming the label is a child node of the GameManager
	label = $CoinLabel
	update_label()



func add_coin():
	money += 1
	update_label()

func update_label():
	if label:
		label.text = str(money)


func _input(event):
	# Check if the Escape key is pressed
	if event.is_action_pressed("ui_cancel"):
		# Change to a different scene
		get_tree().change_scene_to_file("res://scenes/pause_menu.tscn")
