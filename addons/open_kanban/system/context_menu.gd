tool
extends PanelContainer

var target : Object setget set_target
var type : String

func set_target(value : Object) -> void:
	rect_global_position = value.rect_global_position
	rect_global_position.x += value.rect_size.x
	type = value.drag_button.type
	if type == "list":
		$vbox/duplicate.hide()
		rect_global_position.x += 12
	else:
		rect_global_position.y -= 12
		rect_global_position.x += 24
	var i = $vbox.get_child_count()
	rect_size.y = 48 * i + (i - 1) * 6 + 12 * 2
	show()
	target = value

func _input(event) -> void:
	if (event.is_action_pressed("ok_left") or event.is_action_pressed("ok_right")) and !Rect2(rect_global_position, rect_size).has_point(get_global_mouse_position()):
		exit()

func _on_edit_pressed():
	if type == "list":
		target.title_edit()
	else:
		target.title_edit(true)

func _on_insert_before_pressed():
	pass # Replace with function body.

func _on_insert_after_pressed():
	pass # Replace with function body.

func _on_duplicate_pressed():
	pass # Replace with function body.

func _on_delete_pressed():
	target.queue_free()

func exit() -> void:
	queue_free()
