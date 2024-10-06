extends RigidBody2D
signal collected
@export var points = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("Player"):
	collected.emit()
	hide()
	$CollisionObject2D.set_deferred("disabled", true)
	pass # Replace with function body.
