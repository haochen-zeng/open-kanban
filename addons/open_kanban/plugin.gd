tool
extends EditorPlugin

var kanban
var export_plugin

func _ready():
	if Engine.editor_hint:
		get_editor_interface().get_resource_filesystem().scan()

func _enter_tree():
	add_kanban()
	get_editor_interface().get_editor_viewport().add_child(kanban)
	make_visible(false)

func _exit_tree():
	remove_kanban()

func get_plugin_name():
	return "Open Kanban"

func has_main_screen():
	return true

func get_plugin_icon():
	var scale = get_editor_interface().get_editor_scale()
	var theme = "dark"
	if get_editor_interface().get_editor_settings().get_setting("interface/theme/base_color").v > 0.5:
		theme = "light"
	return load("res://addons/open_kanban/res/images/editor_icon/%s%s.svg" % [theme, str(scale)])

func make_visible(visible):
	if kanban:
		kanban.visible = visible

func add_kanban():
	kanban = load("res://addons/open_kanban/kanban.tscn").instance()

func remove_kanban():
	if kanban:
		remove_control_from_bottom_panel(kanban)
		kanban.queue_free()
