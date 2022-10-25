extends Area2D

# Declare member variables here. Examples:
export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var can_move = false
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_move:
		var velocity = Vector2.ZERO # The player's movement vector.
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1

		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		
		position += velocity * delta
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y - $ColorRect.rect_size.y)

func lock_movement():
	can_move = false

func unlock_movement():
	can_move = true
