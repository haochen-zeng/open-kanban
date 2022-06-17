tool
class_name OTS

static func translate(value : String) -> String:
	var array_index : int = 0
	var dictionary : Dictionary = {
	"ADD_LIST" : ["+ Add list", "+ 添加列表", "+ リストに追加"],
	"ADD_CARD" : ["+ Add card", "+ 添加卡片", "+ カード追加"],
	"PAGE" : ["Page", "页面", "ページ"],
	"SEARCH" : ["Search", "搜索", "けんさく"],
	"FILTER" : ["Filter", "筛选", "スクリーニング"],
	"SORT" : ["Sort", "排列", "アレンジメント"],
	"SETTINGS" : ["Settings", "设置", "せってい"]
	}
	
	match "ja":
		"zh", "zh_CN", "zh_TW":
			array_index = 1
		"ja":
			array_index = 2
	
	if dictionary.has(value):
		return dictionary[value][array_index]
	else:
		return ""
