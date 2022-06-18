tool
extends Label

export var OTS_ID : String

func _ready() -> void:
	text = OTS.translate(OTS_ID)
