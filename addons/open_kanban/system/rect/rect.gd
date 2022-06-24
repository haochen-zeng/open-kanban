extends PanelContainer
class_name Rect

var target : Object
var type : String
var kanban = EditorPlugin.new().get_editor_interface().get_editor_viewport().get_node("kanban")

func set_rect(target_input : Object, type_input : String) -> void:
	rect_global_position = target_input.rect_global_position
	match type_input:
		"list":
			rect_global_position.x += target_input.rect_size.x + 12
		"card":
			rect_global_position.x += target_input.rect_size.x + 24
			rect_global_position.y -= 12
		"tab_panel":
			rect_global_position.y += 60
	rect_global_position.x = clamp(rect_global_position.x, kanban.rect_global_position.x + 12, kanban.rect_global_position.x + kanban.rect_size.x - rect_size.x - 12)
	rect_global_position.y = clamp(rect_global_position.y, kanban.rect_global_position.y + 12, kanban.rect_global_position.y + kanban.rect_size.y - rect_size.y - 12)
	target = target_input
	type = type_input

func exit() -> void:
	queue_free()
