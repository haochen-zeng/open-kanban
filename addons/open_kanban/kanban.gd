tool
extends Control

const list = preload("res://addons/open_kanban/system/list.tscn")
onready var hbox = $panel/vbox/scroll/hbox
onready var scroll = $panel/vbox/scroll
var hscroll_max : float
var vscroll_max : float

func _ready() -> void:
	scroll.get_h_scrollbar().connect("changed", self, "push_hscroll")
	scroll.get_v_scrollbar().connect("changed", self, "push_vscroll")

func _on_add_pressed() -> void:
	var scene = list.instance()
	hbox.add_child(scene)
	hbox.move_child(scene, hbox.get_child_count() - 2)
	scene.title_edit()

func push_hscroll() -> void:
	if hscroll_max < scroll.get_h_scrollbar().max_value:
		scroll.scroll_horizontal = scroll.get_h_scrollbar().max_value
	hscroll_max = scroll.get_h_scrollbar().max_value

func push_vscroll() -> void:
	if vscroll_max < scroll.get_v_scrollbar().max_value:
		scroll.scroll_vertical = scroll.get_v_scrollbar().max_value
	vscroll_max = scroll.get_v_scrollbar().max_value
