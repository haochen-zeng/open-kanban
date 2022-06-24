tool
extends ToolButton

export var OTS_ID : String

func _ready() -> void:
	add_to_group("tr")
	translate()

func translate() -> void:
	text = OTS.translate(OTS_ID)
