extends Area2D
## Generic discrimination/search system. Walking into an inspectable item checks
## it against is_correct; wrong ones hide themselves (a reject-pile animation is
## room-specific flavor layered on top, e.g. Miso pouncing the tossed sock),
## correct ones are simply kept. See design doc Room 3.

signal inspected(is_correct: bool)

@export var is_correct: bool = false

var _has_been_inspected: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if _has_been_inspected or not body.is_in_group("player"):
		return
	_has_been_inspected = true
	inspected.emit(is_correct)
	set_deferred("monitoring", false)
	if not is_correct:
		visible = false
