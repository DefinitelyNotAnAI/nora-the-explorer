extends Node2D
## Day 1 "done checkpoint" wiring: walk into the trigger to scatter placeholder
## items, collect and restore them all, watch the timer run. Reskin, don't rebuild.

@onready var trigger: Area2D = $TriggerArea
@onready var collectibles: Array = [$Collectible1, $Collectible2, $Collectible3]
@onready var restore_target: Area2D = $RestoreTarget
@onready var status_label: Label = $UI/StatusLabel

var restored_count: int = 0

func _ready() -> void:
	for c in collectibles:
		c.visible = false
		c.monitoring = false
	trigger.triggered.connect(_on_trigger_triggered)
	restore_target.item_restored.connect(_on_item_restored)
	status_label.text = "Walk into the red zone to trigger the scatter."

func _on_trigger_triggered() -> void:
	for c in collectibles:
		c.visible = true
		c.monitoring = true
	status_label.text = "Scattered! Collect all 3 and bring them to the green zone."

func _on_item_restored(_item: Node2D) -> void:
	restored_count += 1
	if restored_count >= collectibles.size():
		status_label.text = "All restored! Day 1 checkpoint complete."
		GameTimer.stop()
	else:
		status_label.text = "%d / %d restored." % [restored_count, collectibles.size()]
