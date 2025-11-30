extends Panel
class_name PanelLevelUp

@export var card_prefab = preload("res://scenes/level_up_card.tscn")
@export var card_container: HBoxContainer

var tween_duration: float = 0.5

func _ready() -> void:
	show_popup()

func show_popup() -> void:
	print("show_popup")
	_tween_show_panel()
	await get_tree().create_timer(tween_duration).timeout
	_tween_show_card()

func _tween_show_panel() -> void:
	self.get_parent().set_position(Vector2(0, -250))
	self.get_parent().modulate.a = 0
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_parallel(true)
	tween.tween_property(self.get_parent(), "position:y", 0, 0.125)
	tween.tween_property(self.get_parent(), "modulate:a", 1.0, 0.125)

func _tween_show_card() -> void:
	if (not card_prefab): return
	var card_arr = []
	for i in 3:
		var card_instance = card_prefab.instantiate() as CardLevelUp
		card_container.add_child.call_deferred(card_instance)
		await card_instance.ready
		card_arr[i].enable_selection(false)
		card_arr.append(card_instance)
	
	for i in card_arr.size():
		card_arr[i].show_card.call_deferred()
		await get_tree().create_timer(card_arr[i].tween_duration).timeout

	for i in card_arr.size():
		card_arr[i].enable_selection(true)
