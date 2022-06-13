tool
extends DragComponent

onready var title = $panel/title

func _ready() -> void:
	box = $"."
	type = "card"

func set_title(value : String) -> void:
	title.text = value
