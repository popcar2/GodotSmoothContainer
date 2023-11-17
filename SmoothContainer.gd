extends Control
class_name SmoothContainer

@export_enum("Horizontal", "Vertical") var direction: String = "Horizontal"

@export_group("Spacing")
@export var horizontal_spacing: int = 10
@export var vertical_spacing: int = 10

@export_group("Margins")
@export var left_margin: int
@export var up_margin: int
@export var right_margin: int
@export var down_margin: int

var tween: Tween
var just_updated: bool
var next_position: Vector2

func _gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		update_positions()

func _ready():
	get_window().size_changed.connect(update_positions)
	update_positions(false)

func update_positions(update_again: bool = true):
	if just_updated:
		return
	
	if update_again:
		cooldown_update()
	
	next_position = Vector2(left_margin, up_margin)
	if tween: tween.kill()
	
	if direction == "Horizontal":
		update_horizontal_direction()
	elif direction == "Vertical":
		update_vertical_direction()

func update_horizontal_direction():
	var tallest_child: int = 0
	for child: Node in get_children():
		if !(child is Control):
			continue
		
		if next_position.x + right_margin + child.size.x > size.x:
			next_position.x = left_margin
			next_position.y += tallest_child + vertical_spacing
			tallest_child = 0
		
		if child.position != next_position:
			if tween == null or !tween.is_running():
				restore_tween()
			tween.tween_property(child, "position", next_position, 0.5)
		
		if child.size.y > tallest_child:
			tallest_child = child.size.y
		
		next_position.x += child.size.x + horizontal_spacing

func update_vertical_direction():
	var longest_child: int = 0
	for child: Node in get_children():
		if !(child is Control):
			continue
		
		if next_position.y + down_margin + child.size.y > size.y:
			next_position.y = up_margin
			next_position.x += longest_child + horizontal_spacing
			longest_child = 0
		
		if child.position != next_position:
			if tween == null or !tween.is_running():
				restore_tween()
			tween.tween_property(child, "position", next_position, 0.5)
		
		if child.size.x > longest_child:
			longest_child = child.size.x
		
		next_position.y += child.size.y + vertical_spacing

## Creates a polling rate of x seconds rather than using the function every single frame.
## Plays the function again after polling rate ends to readjust positions.
func cooldown_update():
	just_updated = true
	await get_tree().create_timer(0.1).timeout
	just_updated = false
	update_positions(false)

func restore_tween():
	tween = create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
