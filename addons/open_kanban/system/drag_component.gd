tool
extends ToolButton
class_name DragComponent

onready var kanban = EditorPlugin.new().get_editor_interface().get_editor_viewport().get_node("kanban")
var type : String
var box : Object

func _ready() -> void:
	connect("button_down", self, "button_down")
	connect("button_up", self, "button_up")

func button_down():
	
	kanban.drag_component = self

func button_up():
	kanban.drag_component = null

func _input(event) -> void:
	if event is InputEventMouseMotion and kanban.drag_component and kanban.drag_component != self and Rect2(box.rect_global_position, box.rect_size).has_point(get_global_mouse_position()):
		if kanban.drag_component.box.get_parent() == box.get_parent():
			box.get_parent().move_child(kanban.drag_component.box, box.get_index())
		else:
			if type == "card" and kanban.drag_component.type == "card":
				kanban.drag_component.box.get_parent().remove_child(kanban.drag_component.box)
				box.get_parent().add_child(kanban.drag_component.box)
				box.get_parent().move_child(kanban.drag_component.box, box.get_index())
