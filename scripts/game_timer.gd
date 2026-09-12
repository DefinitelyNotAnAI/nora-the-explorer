extends Node
## Autoload singleton: running clock for the timer/scoring system. No fail state,
## just an elapsed-time readout — matches the "lower time = higher score" design.

signal time_updated(elapsed: float)

var elapsed: float = 0.0
var running: bool = false

func start() -> void:
	elapsed = 0.0
	running = true

func stop() -> void:
	running = false

func _process(delta: float) -> void:
	if running:
		elapsed += delta
		time_updated.emit(elapsed)

func format_time() -> String:
	var minutes := int(elapsed) / 60
	var seconds := int(elapsed) % 60
	var hundredths := int((elapsed - floor(elapsed)) * 100)
	return "%02d:%02d.%02d" % [minutes, seconds, hundredths]
