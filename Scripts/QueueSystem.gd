class_name QueueSystem extends Node
const QueueItem = preload("res://Scripts/QueueItem.gd")
const action_types = QueueItem.action_types

var queue = {};

func add_to_queue(item):
	queue[queue.size()] = item
	
func _remove_from_queue(pos):
	queue.erase(pos);
	if pos == 0 and queue.get(1) == null:
		add_idle();
	else:
		var out_queue = {};
		var count = 0;
		for i in queue:
			if queue.get(i) != null:
				out_queue[count] = queue[i];
			count += 1
		queue = out_queue
	pass

func get_current():
	return queue.get(0);
	
func get_next():
	return queue.get(1);
	
func shift_queue():
	_remove_from_queue(0)

func create(action : int = action_types.WAIT):
	var item = QueueItem.new();
	item.action = action
	return item;

func add_idle():
	var idleItem = create(action_types.IDLE);
	add_to_queue(idleItem)

func add_dialogue(textIn = "Lorem ipsum dolor sit amet", name = "David"):
	var dialogueItem = create(action_types.DIALOGUE);
	dialogueItem.text = textIn
	dialogueItem.name = name
	add_to_queue(dialogueItem)
