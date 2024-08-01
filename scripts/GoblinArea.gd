extends Area2D

# randi() % n selects a random integer between 0 and n-1.

@onready var _animation_player = $GoblinAnimationPlayer
@onready var target = null

#func _process(_delta):

var tile_size=16
var direction = position.angle()
var velocity = Vector2(randf_range(0.5, 1.5), 0.0)
var chase_speed = 32
var start_position = position
var max_range = 200

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	_animation_player.play("goblin-idle")

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
	else:
		print("[goblin]: Out of range", new_position)
		move_to(start_position.x, start_position.y)

func chase(area):
	if area != self:
		print("[goblin] Chasing: x", area.position.x, " y", area.position.y)
		move_to(area.position.x, area.position.y)

func _on_timer_timeout():
	if target == null:
		move(direction)
	else:
		chase(target)

func _on_goblin_sight_area_entered(area):
	print("[goblin] Seeing: ", area.name)
	if area != self:
		target = area

func _on_goblin_sight_area_exited(area):
	print("[goblin] Lost: ", area.name)
	target = null

func move_to(x, y):
	print("[goblin.move_to] Moving to: x", x, " y", y, " from x", self.position.x, " y", self.position.y)
	var x_difference = x - self.position.x
	var y_difference = y - self.position.y
	print("[goblin.move_to] Difference: x", x_difference, " y", y_difference)
	
	if abs(x_difference) > chase_speed:
		print("[goblin.move_to] Target x over speed limit") 
		if x_difference < 0:
			print("[goblin.move_to] Long x distance is negative, subtracting speed") 
			self.position.x -= chase_speed
		else:
			print("[goblin.move_to] Long x distance is positive, adding speed") 
			self.position.x += chase_speed
	else:
		print("[goblin.move_to] Target x under speed limit, adding difference") 
		self.position.x += x_difference

	if abs(y_difference) > chase_speed:
		if y_difference < 0:
			self.position.y -= chase_speed
		else:
			self.position.y += chase_speed
	else:
		self.position.y += y_difference
