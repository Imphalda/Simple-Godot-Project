extends Area2D
@export var points = 10
signal collectable_player_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		$AnimatedSprite2D.play("collected")
		$AnimatedSprite2D.animation_finished.connect(_on_animation_finished)

func _on_animation_finished():
	queue_free()
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
