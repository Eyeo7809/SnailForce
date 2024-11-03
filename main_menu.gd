extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://platformer_lv_1.tscn")


func _on_lvl_select_pressed() -> void:
	$Control/NotHidden.visible = false
	$Control/Hidden.visible = true
	$Title.visible = false
	checkLevels()
	
func checkLevels():
	if G.lvl1 == true:
		$Control/Hidden/Lvl1.visible = true
	
	if G.lvl2 == true:
		$Control/Hidden/Lvl2.visible = true
	
	if G.lvl3 == true:
		$Control/Hidden/Lvl3.visible = true


func _on_lvl_1_pressed() -> void:
	get_tree().change_scene_to_file("res://platformer_lv_1.tscn")


func _on_lvl_2_pressed() -> void:
	get_tree().change_scene_to_file("res://lv_2.tscn")


func _on_lvl_3_pressed() -> void:
	get_tree().change_scene_to_file("res://lv_3.tscn")


func _on_back_pressed() -> void:
	$Control/NotHidden.visible = true
	$Control/Hidden.visible = false
	$Title.visible = true
