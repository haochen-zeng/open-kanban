tool
extends LineEdit

export var OTS_ID : String

func _ready() -> void:
	connect("focus_entered", self, "focus_entered")
	connect("focus_exited", self, "focus_exited")
	add_to_group("tr")
	translate()

func focus_entered():
	editable = true

func focus_exited():
	editable = false

func translate() -> void:
	placeholder_text = OTS.translate(OTS_ID)
