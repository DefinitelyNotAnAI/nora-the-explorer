extends Area2D
## Generic collect/restore system, restore half. Player carrying an item into
## this area places it here and marks it restored.

signal item_restored(item: Node2D)

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.has_method("is_carrying") and body.is_carrying():
		var item: Node2D = body.drop_carried()
		item.global_position = global_position
		item.is_restored = true
		item.set_deferred("monitoring", false)
		item_restored.emit(item)
