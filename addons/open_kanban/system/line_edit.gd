tool
extends LineEdit

export var OTS_ID : String

func _ready() -> void:
	connect("focus_entered", self, "focus_entered")
	connect("focus_exited", self, "focus_exited")
	placeholder_text = OTS.translate(OTS_ID)

func focus_entered():
	editable = true

func focus_exited():
	editable = false
