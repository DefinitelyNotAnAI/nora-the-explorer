extends Label
## Attach to a Label to display the running GameTimer clock (timer/scoring system).

func _ready() -> void:
	GameTimer.time_updated.connect(_on_time_updated)
	GameTimer.start()

func _on_time_updated(_elapsed: float) -> void:
	text = GameTimer.format_time()
