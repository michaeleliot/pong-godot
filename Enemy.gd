extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 4
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func update_ai(should_move: bool, ball_y: int):
	var height = $ColorRect.rect_size.y
	if should_move:
		if position.y > ball_y:
			position.y = clamp(position.y - speed, 0, screen_size.y - height) 
		else:
			position.y = clamp(position.y + speed, 0, screen_size.y - height)

