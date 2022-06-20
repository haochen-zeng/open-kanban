tool
extends ToolButton
class_name DragComponent

onready var kanban = EditorPlugin.new().get_editor_interface().get_editor_viewport().get_node("kanban")
var type : String
var box : Object
var drag : bool = false setget set_drag

func _ready() -> void:
	connect("button_down", self, "button_down")
	connect("button_up", self, "button_up")

func button_down():
	if type == "card":
		shortcut = load("res://addons/open_kanban/res/others/card.tres")
	kanban.drag_component = self

func button_up():
	if type == "card":
		shortcut = null
		kanban.set_drag_view(null)
		drag = false
		box.modulate.a = 1
	kanban.drag_component = null

func _input(event) -> void:
	if event is InputEventMouseMotion and kanban.drag_component and kanban.drag_component != self:
		if type == "card" and Rect2(box.rect.rect_global_position, box.rect.rect_size).has_point(get_global_mouse_position()) or type == "list" and Rect2(box.rect_global_position, box.rect_size).has_point(get_global_mouse_position()):
			if !kanban.drag_component.drag and kanban.drag_component.type == "card":
				kanban.set_drag_view(kanban.drag_component)
				kanban.drag_component.drag = true
			
			if kanban.drag_component.box.get_parent() == box.get_parent():
				box.get_parent().move_child(kanban.drag_component.box, box.get_index())
			else:
				if type == "card" and kanban.drag_component.type == "card":
					kanban.drag_component.box.get_parent().remove_child(kanban.drag_component.box)
					box.get_parent().add_child(kanban.drag_component.box)
					box.get_parent().move_child(kanban.drag_component.box, box.get_index())

func set_drag(value : bool) -> void:
	if value:
		box.modulate.a = 0
	drag = value
