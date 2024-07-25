extends Control

var option_button

func _ready():
	option_button = $MarginContainer/VBoxContainer/Resolution
	
	option_button.add_item("1920 x 1080")
	option_button.add_item("1600 x 900")
	option_button.add_item("1280 x 720")

func _on_volume_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)

func _on_mute_toggled(toggled_on):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), toggled_on)

func _on_resolution_item_selected(index):
	var selected_text = option_button.get_item_text(index)
	match selected_text:
		"1920 x 1080":
			get_window().size = Vector2(1920, 1080)
		"1600 x 900":
			get_window().size = Vector2(1600, 900)
		"1280 x 720":
			get_window().size = Vector2(1280, 720)


func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
