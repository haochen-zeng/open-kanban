tool
class_name OTS

static func translate(value : String) -> String:
	var array_index : int = 0
	var dictionary : Dictionary = {
	"OPEN_KANBAN" : ["Open Kanban", "开源看板", "かんばん"],
	"WELCOME" : ["Open Kanban initiated...", "欢迎使用开源看板...", "カンバンプラグインがロードされる..."],
	"HELP" : ["", "", ""],
	"ADD_LIST" : ["+ Add list", "+ 添加列表", "+ リストに追加"],
	"ADD_CARD" : ["+ Add card", "+ 添加卡片", "+ カード追加"],
	"PAGE" : ["Page", "页面", "ページ"],
	"SEARCH" : ["Search", "搜索", "けんさく"],
	"FILTER" : ["Filter", "筛选", "スクリーニング"],
	"SORT" : ["Sort", "排列", "アレンジメント"],
	"SETTINGS" : ["Settings", "设置", "せってい"],
	"EDIT" : ["Edit", "编辑", "エディット"],
	"DELETE" : ["Delete", "删除", "デリート"],
	"DUPLICATE" : ["Duplicate", "复制", "コピー"],
	"INSERT_BEFORE" : ["Insert before", "在前插入", "まえにインサート"],
	"INSERT_AFTER" : ["Insert after", "在后插入", "のちにインサート"]
	}
	
	match EditorSettings.new().get_setting("interface/editor/editor_language"):
		"zh", "zh_CN", "zh_TW":
			array_index = 1
		"ja":
			array_index = 2
	
	if dictionary.has(value):
		return dictionary[value][array_index]
	else:
		return value
