extends Area2D

# randi() % n selects a random integer between 0 and n-1.

@onready var _animation_player = $GoblinAnimationPlayer
func _process(_delta):
	_animation_player.play("goblin-idle")

var tile_size=16
var direction = position.angle()
var velocity = Vector2(randf_range(0.5, 3), 0.0)
var start_position = position
var max_range = 300

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func check_movement_range(pos):
	var normalized_pos = pos
	normalized_pos.x = pos.x - start_position.x
	normalized_pos.y = pos.y - start_position.y
	if normalized_pos.x > max_range || normalized_pos.x < max_range * -1:
		return false
	elif normalized_pos.y > max_range || normalized_pos.y < max_range * -1:
		return false
	else:
		return true

func move(dir):
	var signs = [ -1, 1 ]
	var direction_sign = signs[randi() % signs.size()]
	direction = randf_range(-PI / 4, PI / 4) * direction_sign
	var new_position = position + velocity.rotated(dir) * direction_sign * tile_size	
	if check_movement_range(new_position):
		position = new_position
		print("new position:", position)
	else:
		print("out of range position:", new_position)

func see():
	var human = get_node("../HumanArea")
	print("Human postion: ", human.position.x, " ", human.position.y)

func _on_timer_timeout():
	move(direction)
	see()
