extends Area2D
## Generic collect/restore system, collectible half. Walking into it picks it up
## (if the player isn't already carrying something); restore_target.gd places it.

signal collected

var is_carried: bool = false
var is_restored: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if is_restored or is_carried:
		return
	if body.has_method("pick_up") and not body.is_carrying():
		body.pick_up(self)
		collected.emit()

func set_carried(value: bool) -> void:
	is_carried = value
	set_deferred("monitoring", not value)
