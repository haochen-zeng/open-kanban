tool
extends Control

const list = preload("res://addons/open_kanban/system/list.tscn")
onready var hbox = $panel/vbox/scroll/hbox
onready var scroll = $panel/vbox/scroll
onready var drag_view = $drag_view
var hscroll_max : float
var vscroll_max : float
var drag_component : Object setget set_drag_component

func _ready() -> void:
	print(rect_size)
	scroll.get_h_scrollbar().connect("changed", self, "push_hscroll")
	scroll.get_v_scrollbar().connect("changed", self, "push_vscroll")

func _on_add_pressed() -> void:
	var scene = list.instance()
	hbox.add_child(scene)
	hbox.move_child(scene, hbox.get_child_count() - 2)
	scene.title_edit()

func push_hscroll() -> void:
	if hscroll_max < scroll.get_h_scrollbar().max_value and !drag_component:
		scroll.scroll_horizontal = scroll.get_h_scrollbar().max_value
	hscroll_max = scroll.get_h_scrollbar().max_value

func push_vscroll() -> void:
	if vscroll_max < scroll.get_v_scrollbar().max_value and !drag_component:
		scroll.scroll_vertical = scroll.get_v_scrollbar().max_value
	vscroll_max = scroll.get_v_scrollbar().max_value

func _input(event) -> void:
	if !Input.is_mouse_button_pressed(BUTTON_LEFT) and drag_component:
		drag_component.button_down()
	if event is InputEventMouseMotion:
		drag_view.rect_rotation += event.relative.x
		drag_view.rect_rotation = clamp(drag_view.rect_rotation, -45, 45)

func _process(_delta) -> void:
	if drag_view:
		drag_view.rect_global_position = get_global_mouse_position()
		drag_view.rect_rotation = lerp(drag_view.rect_rotation, 0, 0.2)

func set_drag_component(value : Object) -> void:
	if value and value.type == "card":
		set_process(true)
		drag_view.rect_rotation = 0
		drag_view.get_child(0).rect_size = drag_view.get_child(0).rect_min_size
		drag_view.get_child(0).set_title(value.box.get_title())
		drag_view.show()
	else:
		set_process(false)
		drag_view.hide()
	drag_component = value
