extends Area2D
## Generic trigger system. Fires once per level attempt (resets on replay):
## passively when the player enters (Rooms 1-2 style), or on demand via fire()
## for cat-initiated/scripted sequences (Rooms 3-6 style).

signal triggered

var _has_fired: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if _has_fired:
		return
	if body.is_in_group("player"):
		fire()

func fire() -> void:
	if _has_fired:
		return
	_has_fired = true
	triggered.emit()

func reset() -> void:
	_has_fired = false
