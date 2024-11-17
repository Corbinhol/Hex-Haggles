extends Node
@onready var dialogue_box: Node2D = $"../Dialogue Box"
@onready var shop_menu: Node2D = $"../Shop Menu"
const QueueSystem = preload("res://Scripts/QueueSystem.gd")
var QS = QueueSystem.new();

var test_toggle = false;

func _init_queue_item():
	var current = QS.get_current();
	if current.action == QS.action_types.DIALOGUE:
		if dialogue_box.is_shown == false:
			dialogue_box.appear();
			dialogue_box.start_dialogue(current.text, current.name)
		else:
			dialogue_box.start_dialogue(current.text, current.name)

func _check_queue():
	var current = QS.get_current();
	var next = QS.get_next();
	if current.action == current.action_types.IDLE:
		if next != null:
			QS.shift_queue();
			_init_queue_item();
	if current.action == current.action_types.DIALOGUE:
		if !dialogue_box.is_typing:
			if Input.is_action_just_pressed("Accept"):
				if next != null:
					if next.action == current.action_types.DIALOGUE:
						QS.shift_queue();
						_init_queue_item();
					else:
						dialogue_box.dissapear();
						QS.shift_queue();
						_init_queue_item();
				else:
					print("NOT")
					dialogue_box.dissapear();
					QS.shift_queue();
					_init_queue_item();
	pass

func _ready():
	QS.add_idle()
	QS.add_dialogue("Hello There", "Anna")
	QS.add_dialogue("I would like a potion please.", "Anna")
	pass
func _process(delta: float) -> void:
	_check_queue()
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
