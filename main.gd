extends Node2D

@export var mob_scene: PackedScene

func _on_easy_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $MobSpawnPath/MonSpawnPathFollower
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	add_child(mob)
