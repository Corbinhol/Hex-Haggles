extends Node2D
@onready var move_animation: AnimationPlayer = $"Move Animation"
var is_visible = false

func show_menu():
	is_visible = true
	move_animation.play("Show")
	pass
func hide_menu():
	is_visible = false
	move_animation.play("Hide")
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
