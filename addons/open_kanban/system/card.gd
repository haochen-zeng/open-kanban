tool
extends PanelContainer

onready var title = $panel/title
onready var drag_button = $drag

func _ready() -> void:
	drag_button.box = $"."
	drag_button.type = "card"

func set_title(value : String) -> void:
	title.text = value

func get_title() -> void:
	return title.text
