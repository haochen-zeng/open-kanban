tool
extends LineEdit

func _ready() -> void:
	connect("focus_entered", self, "focus_entered")
	connect("focus_exited", self, "focus_exited")

func focus_entered():
	editable = true

func focus_exited():
	editable = false
