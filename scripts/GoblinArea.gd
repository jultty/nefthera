extends Area2D

@onready var _animation_player = $GoblinAnimationPlayer
func _process(_delta):
	_animation_player.play("goblin-idle")

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
	

func move(dir):
	position += inputs[dir] * tile_size
