tool
extends Control

onready var kanban = $"../../.."

func _process(delta):
	if kanban.drag_component and Rect2(rect_global_position, rect_size).has_point(get_global_mouse_position()):
		if get_parent().name == "h":
			kanban.scroll.get_h_scrollbar().value += float(name) * 8
		else:
			kanban.scroll.get_v_scrollbar().value += float(name) * 8
