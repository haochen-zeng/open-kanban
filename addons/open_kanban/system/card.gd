tool
extends PanelContainer

onready var kanban = EditorPlugin.new().get_editor_interface().get_editor_viewport().get_node("kanban")
onready var title = $panel/title
onready var title_line_edit = $panel/card_title
onready var drag_button = $drag
onready var rect = $rect

func _ready() -> void:
	drag_button.box = $"."
	drag_button.type = "card"

func title_edit(context_menu : bool = false) -> void:
	if context_menu or !drag_button.drag and Rect2(rect_global_position, rect_size).has_point(get_global_mouse_position()):
		title_line_edit.grab_focus()
		title_line_edit.text = title.text
		title_line_edit.set_cursor_position(title_line_edit.text.length())
		title_line_edit.show()
		title.hide()

func _on_card_title_text_entered(new_text : String = title_line_edit.text):
	title.text = new_text
	title_line_edit.hide()
	title.show()

func set_title(value : String) -> void:
	title.text = value

func get_title() -> String:
	return title.text

func _input(event):
	if event.is_action_pressed("ok_right") and Rect2(rect_global_position, rect_size).has_point(get_global_mouse_position()):
		kanban.show_context_menu(self)
