extends Node2D
## Day 2/3 sandbox: proves push/reposition, discrimination/inspect, and the
## speech bubble system each work in isolation before any room reskins them.

@onready var pushable: CharacterBody2D = $Pushable1
@onready var hidden_item: Area2D = $HiddenItem
@onready var inspectables: Array = [$Sock1, $Sock2, $Sock3, $Sock4]
@onready var status_label: Label = $UI/StatusLabel
@onready var speech_bubble: Control = $Player/SpeechBubble
@onready var cat_trigger: Area2D = $CatTrigger

var correct_found: int = 0
var correct_total: int = 0

func _ready() -> void:
	hidden_item.visible = false
	hidden_item.monitoring = false
	pushable.revealed.connect(_on_pushable_revealed)

	for item in inspectables:
		if item.is_correct:
			correct_total += 1
		item.inspected.connect(_on_sock_inspected)

	cat_trigger.triggered.connect(_on_cat_trigger)
	_update_status()

func _on_pushable_revealed() -> void:
	hidden_item.visible = true
	hidden_item.monitoring = true

func _on_sock_inspected(is_correct: bool) -> void:
	if is_correct:
		correct_found += 1
	_update_status()

func _on_cat_trigger() -> void:
	speech_bubble.say("Miso!! Get back here!")

func _update_status() -> void:
	status_label.text = "Push the box to reveal the hidden item. Socks: %d/%d correct found." % [correct_found, correct_total]
