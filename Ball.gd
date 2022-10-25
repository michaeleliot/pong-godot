extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var xDirection = 1
var yDirection = 1
var screen_size # Size of the game window.
export var xSpeed = 200
export var ySpeed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO 
	if position.y == screen_size.y or position.y == 0:
		yDirection = yDirection * -1
	
	velocity.y += xSpeed * yDirection
	velocity.x += ySpeed * xDirection
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func reset(reset_position: Vector2):
	position = reset_position
	xDirection = 1 if randf() > 0.5 else -1
	yDirection = 1 if randf() > 0.5 else -1
	xSpeed = 0
	ySpeed = 0

func start():
	xSpeed = rand_range(200, 300)
	ySpeed = rand_range(200, 300)

func _on_Node_area_entered(_area):
	xDirection = xDirection * -1
