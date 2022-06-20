tool
extends VBoxContainer

onready var kanban = EditorPlugin.new().get_editor_interface().get_editor_viewport().get_node("kanban")
onready var tab = $tab
onready var drag_button = $tab/drag
onready var add = $container/vbox/add
onready var title_line_edit = $tab/title/list_title
onready var label = $tab/title/label
onready var button = $tab/title/button
onready var num = $tab/num
onready var container = $container/vbox
onready var card_line_edit = $container/vbox/add/card_title
onready var parent = $"../../../../.."
const card = preload("res://addons/open_kanban/system/card.tscn")

func _ready() -> void:
	drag_button.box = $"."
	drag_button.type = "list"

func title_edit() -> void:
	title_line_edit.grab_focus()
	title_line_edit.text = label.text
	title_line_edit.set_cursor_position(title_line_edit.text.length())
	title_line_edit.show()
	label.hide()
	button.hide()

func _on_list_title_text_entered(new_text : String = title_line_edit.text):
	label.text = new_text
	title_line_edit.hide()
	label.show()
	button.show()
	card_line_edit.grab_focus()

func _on_vbox_sort_children():
	num.text = str(container.get_child_count() - 1)

func add_card(title : String = "", index : int = container.get_child_count() - 1):
	var scene = card.instance()
	container.add_child(scene)
	container.move_child(scene, index)
	if title:
		scene.set_title(title)
		card_line_edit.text = ""
	else:
		scene.title_edit(true)
	kanban.push_vscroll()

func _input(event) -> void:
	if event.is_action_pressed("ok_right") and Rect2(tab.rect_global_position, tab.rect_size).has_point(get_global_mouse_position()):
		kanban.show_context_menu(self)
	if event is InputEventMouseMotion and container.get_child_count() == 1 and kanban.drag_component and kanban.drag_component.type == "card" and Rect2(add.rect_global_position, add.rect_size).has_point(get_global_mouse_position()):
			kanban.drag_component.box.get_parent().remove_child(kanban.drag_component.box)
			container.add_child(kanban.drag_component.box)
			container.move_child(kanban.drag_component.box, container.get_child_count() - 2)

func set_title(value : String) -> void:
	label.text = value

func get_title() -> String:
	return label.text
