extends Node
@onready var dialogue_box: Node2D = $"../Dialogue Box"
@onready var shop_menu: Node2D = $"../Shop Menu"

const QueueSystem = preload("res://Scripts/QueueSystem.gd")
var QS = QueueSystem.new();
var test_toggle = false;

func _ready():
	dialogue_box.start_dialogue("In a quiet village nestled at the edge of an enchanted forest, a young boy named Elias stumbled upon an ancient, moss-covered stone while chasing a firefly. Curious, he touched the stone, and a soft glow enveloped him. Suddenly, he could hear the whispers of the trees and feel the heartbeat of the earth beneath his feet.", "Anna")
	pass
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Debug_1"):
		if !test_toggle:
			dialogue_box.hide_nametag();
			shop_menu.show_menu();
			test_toggle = true
		else:
			dialogue_box.show_nametag();
			shop_menu.hide_menu();
			test_toggle = false
	pass
