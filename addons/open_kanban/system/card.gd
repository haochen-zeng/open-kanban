tool
extends PanelContainer

onready var title = $panel/title
onready var title_line_edit = $panel/card_title
onready var drag_button = $drag
onready var rect = $rect

func _ready() -> void:
	drag_button.box = $"."
	drag_button.type = "card"

func title_edit() -> void:
	if !drag_button.drag:
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
