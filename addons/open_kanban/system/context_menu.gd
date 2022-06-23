tool
extends Rect

func _on_edit_pressed():
	if type == "list":
		target.title_edit()
	else:
		target.title_edit(true)

func _on_insert_before_pressed():
	target.get_node(target.parent).call("add_" + type, "", target.get_index())

func _on_insert_after_pressed():
	target.get_node(target.parent).call("add_" + type, "", target.get_index() + 1)

func _on_duplicate_pressed():
	var i = target.duplicate(7)
	target.get_parent().add_child(i)
	target.get_parent().move_child(i, target.get_index() + 1)

func _on_delete_pressed():
	target.queue_free()
