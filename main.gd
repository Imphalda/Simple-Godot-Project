extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$Hud.show_game_over()

func start_game():
	
	pass
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Hud.update_score(score)
	$Hud.show_message("Ready...")
	get_tree().call_group("mobs", "queue_free")


func _on_mob_timer_timeout() -> void:
	#New instance of Mob scene
	var mob = mob_scene.instantiate()
	
	#Choose a random location on Path2D
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	#Set mobs direction along the path direction
	var direction = mob_spawn_location.rotation + PI / 2
	
	#Set mob position randomly
	mob.position = mob_spawn_location.position
	
	#Add randomness to direction
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	#Pick velocity between 150 and 250
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	#Spawn the mob, add it to the Main scene (as if we were just dropping it in)
	add_child(mob)

func _on_score_timer_timeout() -> void:
	score+= 1
	$Hud.update_score(score)

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()


func _on_floor_collison_body_entered(body: Node) -> void:
	$Player.on_floor = true
