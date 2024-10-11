extends CharacterBody2D
var screen_size
var player_body
var score
signal hit
signal killed
signal collected

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_body = $CollisionShape2D
	hide()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

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
	#$CollisionShape2D.disabled = false


func _on_apple_body_entered(body: Node2D) -> void:
	get_parent().get_node("Collectibles").queue_free()
	score += 20
