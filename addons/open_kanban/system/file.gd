tool
class_name OFS

static func load_kanban() -> Dictionary:
	var file = File.new()
	if file.open("user://open-kanban/data.json", File.READ) == OK:
		var value = parse_json(file.get_as_text())
		file.close()
		return value
	else:
		return {}

static func save_kanban(value : Dictionary) -> void:
	var file = File.new()
	var dir = Directory.new()
	
	if dir.open("user://open-kanban/") != OK:
		dir.make_dir_recursive("user://open-kanban/")
	
	if file.open("user://open-kanban/data.json", File.WRITE) == OK:
		file.store_string(JSON.print(value, "\t"))
		file.close()
