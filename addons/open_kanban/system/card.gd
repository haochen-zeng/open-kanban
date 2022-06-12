tool
extends PanelContainer

onready var title = $title

func set_title(value : String) -> void:
	title.text = value
