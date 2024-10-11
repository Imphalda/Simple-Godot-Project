extends RigidBody2D
@export var points = 10
signal collectable_player_hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

#func collected(body: Node) -> void:



func _on_player_hit() -> void:
	$AnimatedSprite2D.animation = "Collected"
	$AppleCollision.set_deferred("disabled", true)


func on_animation_finished() -> void:
	hide()


func _on_hud_start_game() -> void:
	show()
	$AppleCollision.disabled = false
	$AnimatedSprite2D.animation = "Default"
	$AnimatedSprite2D.play()
	pass # Replace with function body.

func _on_player_collected() -> void:
	$AnimatedSprite2D.animation = "Collected"
	$AppleCollision.set_deferred("disabled", true)
	pass # Replace with function body.
