extends CharacterBody2D
## Side-view player with adventure-game depth: moves freely on the room's
## floor polygon (found via the "room_floor" group), with y-position driving
## sprite scale so walking toward the back of the room reads as further away.
## Facing + depth both apply as Visual.scale; swap the placeholder ColorRect
## for real sprite art later and use flip_h instead without touching this.

const SPEED: float = 220.0

var carried_item: Node2D = null
var facing: int = 1
var room_floor: Node = null

@onready var visual: Control = $Visual
@onready var carry_point: Node2D = $Visual/CarryPoint

func _ready() -> void:
	room_floor = get_tree().get_first_node_in_group("room_floor")

func _physics_process(_delta: float) -> void:
	var input_vector := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_vector * SPEED
	move_and_slide()

	if input_vector.x != 0.0:
		facing = int(sign(input_vector.x))

	if room_floor:
		position = room_floor.clamp_to_floor(position)
		var depth_scale: float = room_floor.get_depth_scale(position.y)
		visual.scale = Vector2(facing * depth_scale, depth_scale)

	if carried_item:
		carried_item.global_position = carry_point.global_position

func pick_up(item: Node2D) -> void:
	if carried_item:
		return
	carried_item = item
	item.set_carried(true)

func drop_carried() -> Node2D:
	var item := carried_item
	carried_item = null
	if item:
		item.set_carried(false)
	return item

func is_carrying() -> bool:
	return carried_item != null
