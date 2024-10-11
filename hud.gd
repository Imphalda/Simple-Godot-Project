extends CanvasLayer

# Tells Main the button was pressed
signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	# Wait for MessageTimer to run out
	await $MessageTimer.timeout
	
	$ScoreLabel.text = "0"
	$Message.text = "Dodge the Creeps!!"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	score += int($ScoreLabel.text)
	$ScoreLabel.text = str(score)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	$Message.hide() #Replace with function body.
	

func _on_collectable_player_hit(points) -> void:
	update_score(points)
	pass # Replace with function body.
