extends Area2D

var HP = 100
var MP = 100

@onready var _animation_player = $HumanAnimationPlayer
@onready var ray = $HumanRayCast
@onready var speed = 0.15

var tile_size=16
var inputs = {
	"ui_right": Vector2.RIGHT,
	"ui_left": Vector2.LEFT,
	"ui_up": Vector2.UP,
	"ui_down": Vector2.DOWN,
}

func _process(_delta):
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			move(dir)
	if HP < 1:
		get_tree().change_scene_to_file("res://game_over.tscn")

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += inputs[dir] * tile_size * speed
	else:
		print(ray.get_collider())

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	_animation_player.play("human-idle")

func start(pos):
	position = pos
	show()
	$HumanCollision.disabled = false

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "GoblinArea":
		HP -= 10
		print("Human HP: ", HP , " (hit by ", area.name, ")")


func _on_goal_area_entered(area):
	if area == self:
		get_tree().change_scene_to_file("res://game_win.tscn")
