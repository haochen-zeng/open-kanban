tool
extends Control

const list_scene = preload("res://addons/open_kanban/system/list.tscn")
const card_scene = preload("res://addons/open_kanban/system/card.tscn")
onready var hbox = $panel/vbox/scroll/hbox
onready var scroll = $panel/vbox/scroll
onready var drag_view = $drag_view
onready var drag_view_label = $drag_view/panel/title
var hscroll_max : float
var vscroll_max : float
var drag_component : Object setget set_drag_component
var data : Dictionary = {"lists" : {}, "settings" : {}} setget set_data

func _ready() -> void:
	print(OTS.translate("WELCOME"))
	scroll.get_h_scrollbar().connect("changed", self, "push_hscroll")
	scroll.get_v_scrollbar().connect("changed", self, "push_vscroll")
	self.data = OFS.load_kanban()

func _on_add_pressed() -> void:
	var scene = list_scene.instance()
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
		drag_view_label.text = value.box.get_title()
		drag_view.show()
	else:
		set_process(false)
		drag_view.hide()
	drag_component = value

func _exit_tree() -> void:
	for list in hbox.get_children():
		var list_index = list.get_index()
		if list.name != "add":
			var cards : Dictionary
			for card in list.container.get_children():
				var card_index = card.get_index()
				if card.name != "add":
					cards[card_index] = {"name" : card.get_title()}
			data["lists"][list_index] = {"name" : list.get_title(), "cards" : cards}
	OFS.save_kanban(data)

func set_data(value : Dictionary) -> void:
	for list in value["lists"].keys():
		var list_instance = list_scene.instance()
		hbox.add_child(list_instance)
		list_instance.set_title(value["lists"][list]["name"])
		hbox.move_child(list_instance, int(list))
		for card in value["lists"][list]["cards"].keys():
			list_instance.add_card(value["lists"][list]["cards"][card]["name"])
	value = data
