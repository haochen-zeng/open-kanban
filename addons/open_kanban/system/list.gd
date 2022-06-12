tool
extends VBoxContainer

onready var tab = $tab
onready var title_line_edit = $tab/title/line_edit
onready var label = $tab/title/label
onready var button = $tab/title/button
onready var num = $tab/num
onready var container = $container/vbox
onready var card_line_edit = $container/vbox/add/card_title
const card = preload("res://addons/open_kanban/system/card.tscn")
var drag : bool

func title_edit() -> void:
	title_line_edit.grab_focus()
	title_line_edit.set_cursor_position(title_line_edit.text.length())
	title_line_edit.show()
	label.hide()
	button.hide()

func _on_line_edit_text_entered(new_text) -> void:
	label.text = new_text
	title_line_edit.hide()
	label.show()
	button.show()

func _on_vbox_sort_children():
	num.text = str(container.get_child_count() - 1)

func _on_card_title_text_entered(new_text):
	if new_text:
		var scene = card.instance()
		container.add_child(scene)
		scene.set_title(new_text)
		container.move_child(scene, container.get_child_count() - 2)
		card_line_edit.text = ""

func _on_drag_button_down():
	drag = true

func _on_drag_button_up():
	drag = false

func _input(event) -> void:
	if event is InputEventMouseMotion:
		for i in get_parent().get_children():
			if i.get("drag") and i != self and Rect2(rect_global_position, rect_size).has_point(get_global_mouse_position()):
				var x = i.get_index()
				get_parent().move_child(i, get_index())
				get_parent().move_child(self, x)
