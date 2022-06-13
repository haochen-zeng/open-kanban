tool
extends ToolButton
class_name DragComponent

var type : String
var box : Object
var kanban : Object

func _ready() -> void:
	connect("button_down", self, "button_down")
	connect("button_up", self, "button_up")
	kanban = EditorPlugin.new().get_editor_interface().get_editor_viewport().get_node("kanban")

func button_down():
	print("button_down")
	kanban.drag_component = self

func button_up():
	print("button_up")
	kanban.drag_component = null

func _input(event) -> void:
	if Rect2(box.rect_global_position, box.rect_size).has_point(get_global_mouse_position()) and kanban.drag_component != self and kanban.drag_component:
		if kanban.drag_component.box.get_parent() == box.get_parent():
			box.get_parent().move_child(kanban.drag_component.box, box.get_index())
		else:
			if type == "card" and kanban.drag_component.type == "card":
				kanban.drag_component.box.get_parent().remove_child(kanban.drag_component.box)
				box.get_parent().add_child(kanban.drag_component.box)
				box.get_parent().move_child(kanban.drag_component.box, box.get_index())
