extends Node2D

@export var mob_scene: PackedScene

func _on_easy_mob_timer_timeout():
	print("Mob timeout")
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $FirstMobSpawn/FirstMobSpawnLoc
	mob_spawn_location.progress_ratio = randf()
	
	add_child(mob)
