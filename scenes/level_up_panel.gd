extends Panel
class_name PanelLevelUp

@export var card_prefab = preload("res://scenes/level_up_card.tscn")
@export var card_container: HBoxContainer
@export var button_ok: Button

var tween_duration: float = 0.5
var is_animation_done: bool = false

func _ready() -> void:
	if (button_ok):
		button_ok.pressed.connect(_on_button_ok)
	show_popup()

func show_popup() -> void:
	print("show_popup")
	is_animation_done = false
	for i in card_container.get_children():
		card_container.remove_child(i)
		i.queue_free()
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
	tween.tween_property(self.get_parent(), "modulate:a", 1, 0.125)

func _tween_show_card() -> void:
	if (not card_prefab): return
	var card_arr = []
	for i in 3:
		var card_instance = card_prefab.instantiate() as CardLevelUp
		card_container.add_child.call_deferred(card_instance)
		await card_instance.ready
		card_arr.append(card_instance)
		card_instance.enable_selection(false)
	
	for i in card_arr.size():
		card_arr[i].show_card.call_deferred()
		await get_tree().create_timer(card_arr[i].tween_duration).timeout

	for i in card_arr.size():
		card_arr[i].enable_selection(true)
	is_animation_done = true

func _tween_hide_panel():
	self.get_parent().modulate.a = 1
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self.get_parent(), "modulate:a", 0, 0.125)

func _on_button_ok() -> void:
	print("_on_button_ok")
	if (not is_animation_done): return
	_tween_hide_panel()
	# TODO Whatever logic you want to put in
