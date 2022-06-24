tool
extends Rect

onready var lang_option = $vbox/lang/option
var lang : Dictionary = {
	"en" : "English",
	"zh" : "中文",
	"ja" : "にほんこ°"
}
var exit : bool = true

func _ready() -> void:
	lang_option.clear()
	for i in lang.values():
		lang_option.add_item(i)
	lang_option.select(lang.keys().find(kanban.data["settings"]["lang"]))

func _on_option_item_selected(index):
	kanban.data["settings"]["lang"] = lang.keys()[index]
	get_tree().call_group("tr", "translate")
	exit()

func _on_option_toggled(button_pressed):
	exit = !button_pressed

func _input(event) -> void:
	if exit and (event.is_action_pressed("ok_left") or event.is_action_pressed("ok_right")) and !Rect2(rect_global_position, rect_size).has_point(get_global_mouse_position()):
		exit()
