extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemy_score = 0
var player_score = 0

var winning_score = 3

export var is_game_over = true
var screen_size;

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	screen_size = get_viewport().size
	$PlayerStartPosition.position = Vector2(screen_size.x / 10, screen_size.y / 2)
	$EnemyStartPosition.position = Vector2((screen_size.x * 9) / 10, screen_size.y / 2)
	$BallStartPosition.position = Vector2(screen_size.x / 2, screen_size.y / 2)
	
	$Ball.hide()
	$Ball.reset($BallStartPosition.position)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	if not is_game_over:
		var enemy_should_move = $Ball.xDirection == 1 and $Ball.is_visible()
		$Enemy.update_ai(enemy_should_move, $Ball.position.y)
		
		if $Player.position > $Ball.position:
			enemy_score += 1
			$HUD.update_enemy_score(enemy_score)
			set_to_start_state()
		elif $Enemy.position < $Ball.position:
			player_score += 1
			$HUD.update_player_score(player_score)
			set_to_start_state()
		
		if player_score >= winning_score or enemy_score >= winning_score:
			game_over()
	
	
func reset_game():
	$Player.unlock_movement()
	is_game_over = false
	reset_score()
	set_to_start_state()
	
func set_to_start_state():
	$Ball.show()
	$Ball.reset($BallStartPosition.position)
	reset_paddles()
	$GameBeginTimer.start()
	

func reset_score():
	player_score = 0
	enemy_score = 0
	$HUD.update_enemy_score(enemy_score)
	$HUD.update_player_score(player_score)


func reset_paddles():
	$Player.position = $PlayerStartPosition.position
	$Enemy.position = $EnemyStartPosition.position


func game_over():
	$Player.lock_movement()
	is_game_over = true
	$Ball.reset($BallStartPosition.position)
	$Ball.hide()
	var player_won = player_score > enemy_score
	$HUD.show_game_over_text(player_won)


func _on_GameBeginTimer_timeout():
	$Ball.start()
