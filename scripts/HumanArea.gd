extends Area2D
signal hit

var HP = 100
var MP = 100

@onready var _animation_player = $HumanAnimationPlayer
@onready var ray = $HumanRayCast

func _process(_delta):
	_animation_player.play("human-idle")

var tile_size=16
var inputs = {
	"ui_right": Vector2.RIGHT,
	"ui_left": Vector2.LEFT,
	"ui_up": Vector2.UP,
	"ui_down": Vector2.DOWN,
}

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	
func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += inputs[dir] * tile_size

func _on_body_entered(body):
	hide()
	hit.emit()
	$HumanCollision.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$HumanCollision.disabled = false


func _on_hit():
	MP -= 10


func _on_goblin_sight_area_entered(area):
	print("I see you")


func _on_goblin_sight_area_exited(area):
	print("I lost you")
