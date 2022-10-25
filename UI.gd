extends CanvasLayer

signal start_game

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size = get_viewport().size
	var player_rect_size = $PlayerScore.rect_size
	$EnemyScore.margin_left = (screen_size.x * 3) / 4
	$PlayerScore.margin_left = screen_size.x / 4 - player_rect_size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_enemy_score(score):
	$EnemyScore.text = str(score)


func update_player_score(score):
	$PlayerScore.text = str(score)


func show_game_over_text(player_won: bool):
	show_message("You Win!" if player_won else "You Lose!")


func show_message(text):
	print("End Timer Started")
	$EndLabel.text = text	
	$EndLabel.show()
	$EndTimer.start()


func _on_Button_pressed():
	$StartButton.hide()
	emit_signal("start_game")


func _on_EndTimer_timeout():
	print("End Timer Ended")
	$EndLabel.hide()
	$StartButton.show()
