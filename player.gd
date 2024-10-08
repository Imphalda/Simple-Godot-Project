extends Area2D
signal hit
@export var speed = 300
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	#Gravity
	velocity += Vector2.DOWN * speed * delta
	
	"""
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	"""
	if Input.is_action_pressed("move_up"):
		velocity = Vector2.UP * 5.0
		$AnimatedSprite2D.animation = "up"
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
		if !velocity.y:
			$AnimatedSprite2D.animation = "walk"
	
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
		if !velocity.y:
			$AnimatedSprite2D.animation = "walk"
	
	"""
	if velocity.x != 0 and velocity.y != 0:
		velocity
	if velocity.x != 0:
		velocity = velocity * speed
		$AnimatedSprite2D.play(player_types[1])
	else:
		$AnimatedSprite2D.stop()
	"""

	position += velocity * speed * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0



func _on_body_entered(_body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
