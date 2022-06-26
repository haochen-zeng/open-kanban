tool
class_name OFS

static func load_kanban() -> Dictionary:
	var file = File.new()
	if file.open("user://open-kanban/data.json", File.READ) == OK:
		var value = parse_json(file.get_as_text())
		file.close()
		return value
	else:
		return {
			"version" : 0.1, 
			"lists" : {
				"0": {
					"name": "Introduction",
					"cards": {
						"0": {"name": "Welcome to Open Kanban"},
						"1": {"name": "Press the left mouse button to drag cards or lists"},
						"2": {"name": "Press the right mouse button to show the context menu"},
						"3": {"name": "Click on the card to edit its name"},
						"4": {"name": "Press the setting button to change the language used in Open Kanban"},
						"5": {"name": "づ￣ 3￣)づ"}
					}
				},
				"1": {
					"name": "ToDo",
					"cards": {}
				},
				"2": {
					"name": "Development",
					"cards": {}
				},
				"3": {
					"name": "Testing",
					"cards": {}
				},
				"4": {
					"name": "Done",
					"cards": {}
				}
			},
			"settings" : {
				"lang" : "en"
			}
		}

static func save_kanban(value : Dictionary) -> void:
	var file = File.new()
	var dir = Directory.new()
	
	if dir.open("user://open-kanban/") != OK:
		dir.make_dir_recursive("user://open-kanban/")
	
	if file.open("user://open-kanban/data.json", File.WRITE) == OK:
		file.store_string(JSON.print(value, "\t"))
		file.close()
