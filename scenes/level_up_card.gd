extends Panel
class_name CardLevelUp

# short duration = game with fast level up for urgency
# long duration = game with slower level up for more impact
var tween_duration: float = 0.25 

# enable when tween animation is done
var can_select: bool = false

func _ready() -> void:
	self.modulate.a = 0
	can_select = false

func enable_selection(val: bool) -> void:
	can_select = val

func set_card_info() -> void:
	# TODO Implement your own info
	pass

func show_card() -> void:
	_tween_show_card()

func _tween_show_card() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 1.0, 0.125)
