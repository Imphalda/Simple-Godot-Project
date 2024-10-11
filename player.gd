extends Area2D
signal hit
signal killed
signal collected
@export var speed = 100
var screen_size
var player_body

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_body = $CollisionShape2D
	hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	var on_floor = false
	
	#Gravity
	if !on_floor:
		velocity += Vector2.DOWN * speed * delta * 20
	
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
		velocity.x -= speed/20
		if !velocity.y:
			$AnimatedSprite2D.animation = "walk"
	
	if Input.is_action_pressed("move_right"):
		velocity.x += speed/20
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
	#hit.emit(_body)
	#$CollisionShape2D.set_deferred("disabled", true)
	if _body.is_in_group("mobs"):
		killed.emit()
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
	elif _body.is_in_group("collectable"):
		collected.emit()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
