extends CharacterBody2D
## Generic push/reposition system. Player shoves this by walking into it from
## the right direction; moving far enough from its start position fires
## `revealed`, so a room script can unhide whatever was hidden behind it
## (couch, toy bin, etc.) — see design doc Rooms 2 and 4.

signal revealed

const PUSH_SPEED: float = 80.0
const REVEAL_DISTANCE: float = 24.0

@onready var push_detector: Area2D = $PushDetector

var pusher: CharacterBody2D = null
var _start_position: Vector2
var _has_revealed: bool = false

func _ready() -> void:
	_start_position = global_position
	push_detector.body_entered.connect(_on_body_entered)
	push_detector.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		pusher = body

func _on_body_exited(body: Node) -> void:
	if body == pusher:
		pusher = null

func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO
	if pusher and pusher.velocity.length() > 0.0:
		var to_pushable := (global_position - pusher.global_position).normalized()
		var push_alignment := to_pushable.dot(pusher.velocity.normalized())
		if push_alignment > 0.6:
			velocity = pusher.velocity.normalized() * PUSH_SPEED
	move_and_slide()

	if not _has_revealed and global_position.distance_to(_start_position) >= REVEAL_DISTANCE:
		_has_revealed = true
		revealed.emit()
