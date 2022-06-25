tool
extends Control

const list_scene = preload("res://addons/open_kanban/system/list.tscn")
const card_scene = preload("res://addons/open_kanban/system/card.tscn")
const context_menu = preload("res://addons/open_kanban/system/rect/context_menu.tscn")
const settings_menu = preload("res://addons/open_kanban/system/rect/settings_menu.tscn")
onready var highlight = $highlight
onready var hbox = $panel/vbox/scroll/hbox
onready var scroll = $panel/vbox/scroll
onready var drag_view = $drag_view
onready var drag_view_label = $drag_view/panel/title
onready var settings_button = $panel/vbox/tab/settings
var drag_component : Object
var drag_move_h : float
var drag_move_v : float

var data : Dictionary = {"version" : 0.1, "lists" : {}, "settings" : {"lang" : "en"}}

func _ready() -> void:
	print(OTS.translate("WELCOME"))
	initiate(OFS.load_kanban())
	if !InputMap.has_action("ok_left"):
		InputMap.add_action("ok_left")
		var ev = InputEventMouseButton.new()
		ev.button_index = BUTTON_LEFT
		InputMap.action_add_event("ok_left", ev)
		ProjectSettings.save()
	if !InputMap.has_action("ok_right"):
		InputMap.add_action("ok_right")
		var ev = InputEventMouseButton.new()
		ev.button_index = BUTTON_RIGHT
		InputMap.action_add_event("ok_right", ev)
		ProjectSettings.save()

func add_list(title : String = "", index : int = hbox.get_child_count() - 1) -> void:
	var scene = list_scene.instance()
	hbox.add_child(scene)
	hbox.move_child(scene, index)
	if title:
		scene.set_title(title)
	else:
		scene.title_edit()
	push_hscroll()

func push_hscroll() -> void:
	yield(scroll.get_h_scrollbar(), "changed")
	scroll.scroll_horizontal = scroll.get_h_scrollbar().max_value

func push_vscroll() -> void:
	yield(scroll.get_v_scrollbar(), "changed")
	scroll.scroll_vertical = scroll.get_v_scrollbar().max_value

func _input(event) -> void:
	if event.is_action_released("ok_right") and drag_component:
		drag_component.button_down()
	if event is InputEventMouseMotion:
		drag_view.rect_rotation += event.relative.x
		drag_view.rect_rotation = clamp(drag_view.rect_rotation, -45, 45)

func _process(_delta) -> void:
	if drag_view:
		drag_view.rect_global_position = get_global_mouse_position()
		drag_view.rect_rotation = lerp(drag_view.rect_rotation, 0, 0.2)
	
	if drag_component:
		if drag_move_h:
			scroll.get_h_scrollbar().value += drag_move_h * 8
		if drag_move_v:
			scroll.get_v_scrollbar().value += drag_move_v * 8

func set_drag_view(value : Object) -> void:
	if value:
		set_process(true)
		drag_view.rect_rotation = 0
		drag_view.get_child(0).rect_size = drag_view.get_child(0).rect_min_size
		drag_view_label.text = value.box.get_title()
		drag_view.show()
	else:
		set_process(false)
		drag_view.hide()

func _exit_tree() -> void:
	data["lists"] = {}
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

func initiate(value : Dictionary) -> void:
	for list in value["lists"].keys():
		var list_instance = list_scene.instance()
		hbox.add_child(list_instance)
		list_instance.set_title(value["lists"][list]["name"])
		hbox.move_child(list_instance, int(list))
		for card in value["lists"][list]["cards"].keys():
			list_instance.add_card(value["lists"][list]["cards"][card]["name"], int(card))
	data = value
	get_tree().call_group("tr", "translate")

func show_context_menu(target : Object, type : String) -> void:
	var scene = context_menu.instance()
	add_child(scene)
	scene.set_rect(target, type)

func _on_settings_pressed():
	var scene = settings_menu.instance()
	add_child(scene)
	scene.set_rect(settings_button, "tab_panel")

func highlight(value : Object) -> void:
	highlight.rect_global_position = value.rect_global_position
	highlight.rect_size = value.rect_size
	highlight.show()

func scroll_include(value : Object) -> void:
	scroll.ensure_control_visible(value)
