extends Area2D

@onready var _animation_player = $GoblinAnimationPlayer
@onready var target = null
@onready var ray = $GoblinRayCast

var tile_size=16
var direction = position.angle()
var velocity = Vector2(randf_range(0.25, 0.75), 0.0)
var chase_speed = randi_range(10, 18)
var start_position = position
var max_range = 200

func _ready():
	ray.add_exception($GoblinArea/GoblinSightCollisionShape)
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

func move_if_not_colliding(new_position):
	ray.target_position = new_position
	ray.force_raycast_update()
	if !ray.is_colliding():
		position = new_position

func move(dir):
	var signs = [ -1, 1 ]
	var direction_sign = signs[randi() % signs.size()]
	direction = randf_range(-PI / 4, PI / 4) * direction_sign
	var new_position = position + velocity.rotated(dir) * direction_sign * tile_size	
	if check_movement_range(new_position):
		move_if_not_colliding(new_position)
	else:
		print("[goblin]: Out of range", new_position)
		move_to(start_position.x, start_position.y)

func chase(area):
	print("[goblin] Chasing: x", area.position.x, " y", area.position.y)
	move_to(area.position.x, area.position.y)

func _on_timer_timeout():
	if target == null:
		move(direction)
	else:
		chase(target)

func _on_goblin_sight_area_entered(area):
	if area.name == "HumanArea":
		print("[goblin] Seeing: ", area.name)
		target = area

func _on_goblin_sight_area_exited(area):
	if area.name == "HumanArea":
		print("[goblin] Lost: ", area.name)
		target = null

func move_to(x, y):
	print("[goblin.move_to] Moving to: x", x, " y", y, " from x", self.global_position.x, " y", self.global_position.y)
	var x_difference = self.global_position.x - x
	var y_difference = self.global_position.y - y
	print("[goblin.move_to] Difference: x", x_difference, " y", y_difference)
	
	if abs(x_difference) > chase_speed:
		print("[goblin.move_to] Target x over speed limit") 
		if x_difference > 0:
			print("[goblin.move_to] Long x distance is negative, subtracting speed") 
			self.global_position.x -= chase_speed
		else:
			print("[goblin.move_to] Long x distance is positive, adding speed") 
			self.global_position.x += chase_speed
	else:
		print("[goblin.move_to] Target x under speed limit, adding difference") 
		self.global_position.x += x_difference

	if abs(y_difference) > chase_speed:
		if y_difference > 0:
			self.global_position.y -= chase_speed
		else:
			self.global_position.y += chase_speed
	else:
		self.global_position.y += y_difference
