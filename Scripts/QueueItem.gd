class_name QueueItem extends Node
enum action_types {IDLE, DIALOGUE, MENU, WAIT, CHOICE, CUTSCENE, NPC_ENTER, NPC_LEAVE}
var action = null
var text = null;
var options = []
var waittime = null;
