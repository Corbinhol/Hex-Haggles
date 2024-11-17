extends Node2D
@onready var label: Label = $Dialogue/Node2D/Label
@onready var name_label: Label = $"Name-tag/Node2D/NameLabel"
@onready var text_timer: Timer = $"Text Timer"
@onready var writing_sound: AudioStreamPlayer2D = $"Writing Sound"
@onready var move_animation: AnimationPlayer = $"Move Animation"
@onready var appear_sound: AudioStreamPlayer2D = $"Appear Sound"
@onready var nametag_move: AnimationPlayer = $"Name-tag/Nametag Move"
@onready var arrow_move: AnimationPlayer = $Arrow/Move
@onready var arrow_appear: AnimationPlayer = $Arrow/Appear


const char_interval = .05;
const max_characters = 90;
var target_text = "";
var pos = 1;
var is_typing = false;
var is_shown = false;

func appear():
	move_animation.play("Move Up")
	appear_sound.play()
	is_shown = true;
func dissapear():
	move_animation.play("Hide")
	appear_sound.play()
	is_shown = false
func _update_label():
	label.text = target_text.substr(0, pos)
func _reset():
	target_text = "";
	pos = 1;
	is_typing = false;
	label.text = "";

func hide_nametag():
	nametag_move.play("Hide")
	
func show_nametag():
	nametag_move.play("Show")

#Adds New lines to the right place at every dialogue, so the box knows when to go next
func _format_string(string):
	var lastSpace = 0;
	var lastIndentation = 0;
	var currentPos = 0;
	var count = 0;
	var editedString = string;
	for i in string:
		if i == " ":
			lastSpace = currentPos;	
		if count >= max_characters:
			if lastSpace != 0:
				editedString = editedString.erase(lastSpace, 1)
				editedString = editedString.insert(lastSpace, "\n");
				count = currentPos - lastSpace
		currentPos += 1;
		count += 1;
	return editedString

func start_dialogue(text, name):
	_reset();
	target_text = _format_string(text);
	name_label.text = name;
	is_typing = true;
	visible = true
	text_timer.start(char_interval)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	_reset();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_typing and !writing_sound.playing:
		writing_sound.play()
	elif !is_typing:
		writing_sound.stop()



func _on_text_timer_timeout() -> void:
	if is_typing:
		pos += 1;
		_update_label();
		
		if label.text == target_text or pos == max_characters * 2:
			arrow_appear.play("Appear")
			is_typing = false;
			text_timer.stop();
	pass # Replace with function body.
