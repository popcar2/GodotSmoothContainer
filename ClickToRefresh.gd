extends Node

func _ready():
	get_parent().gui_input.connect(_parent_gui_input)

func _parent_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed():
		get_parent().update_positions()
