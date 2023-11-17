extends Panel

func _gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		queue_free()
