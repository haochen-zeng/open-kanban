tool
extends Control

onready var kanban = $"../../.."

func _input(event):
	if event is InputEventMouseMotion and Rect2(rect_global_position, rect_size).has_point(get_global_mouse_position()):
		kanban.set("drag_move_%s" % get_parent().name, float(name))
