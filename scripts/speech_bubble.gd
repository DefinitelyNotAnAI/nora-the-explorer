extends Control
## Generic speech bubble UI. Call say() to show text for a duration. Works both
## as a bubble anchored above a character (instance it as a child of that
## character) and as a fixed off-screen bubble for Mom's lines (instance it
## directly under a UI CanvasLayer instead).

@onready var label: Label = $Panel/Label

func _ready() -> void:
	visible = false

func say(text: String, duration: float = 2.5) -> void:
	label.text = text
	visible = true
	await get_tree().create_timer(duration).timeout
	visible = false
