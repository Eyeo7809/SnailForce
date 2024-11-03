extends Node2D
@onready var chestInteractable: bool = false
@onready var gemCollected : bool = false
@onready var npcInteractable : bool = false
@onready var chest2Interactable : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	G.lvl2 = true
	$HitTutorial/HitTutLab.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fall_check_body_entered(body: Node2D) -> void:
	if $Protag.gems == 2:
		get_tree().change_scene_to_file("res://lv_3.tscn")
	else:
		$HUD/HiddenLabels/ControllerPlayer.play("onDeath")




func _on_repeat_lv_pressed() -> void:
	get_tree().change_scene_to_file("res://lv_2.tscn")
	$HUD/HiddenLabels.visible = false



func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
	$HUD/HiddenLabels.visible = false


func _on_chest_body_entered(body: Node2D) -> void:
	if $Chest/ChestSpriteOpen.visible == false:
		$Chest/ChestInteract.visible = true
		chestInteractable = true


func _on_chest_body_exited(body: Node2D) -> void:
	chestInteractable = false
	$Chest/ChestInteract.visible = false
	$Chest/NeedKey.visible = false
	


	
func _input(event: InputEvent) -> void:
	
	if chestInteractable == true:
		if event is InputEventKey:
			if event.pressed and event.keycode == KEY_E:
				if $Protag.keyValue >= 1:
					$Chest/ChestSpriteOpen.visible = true
					$Chest/ChestSpriteClosed.visible = false
					$Protag.keyValue -= 1
					$HUD/Control/KeyCounter.text = str($Protag.keyValue)
					$Chest/Gem/GemAnimation.play("gemAnimation")
					$Chest/ChestInteract.visible = false
					$Chest/NeedKey.visible = false
					$Protag.gems += 1
					gemCollected = true
				elif $Protag.keyValue <= 0 and npcInteractable == false:
					$Chest/ChestInteract.visible = false
					$Chest/NeedKey.visible = true
	
	if chest2Interactable == true:
		if event is InputEventKey:
			if event.pressed and event.keycode == KEY_E:
				if $Protag.keyValue >= 1:
					$Chest2/ChestSpriteOpen.visible = true
					$Chest2/ChestSpriteClosed.visible = false
					$Protag.keyValue -= 1
					$HUD/Control/KeyCounter.text = str($Protag.keyValue)
					$Chest2/Gem/GemAnimation.play("gemAnimation")
					$Chest2/ChestInteract.visible = false
					$Chest2/NeedKey.visible = false
					$Protag.gems += 1
					gemCollected = true
				elif $Protag.keyValue <= 0 and npcInteractable == false:
					$Chest2/ChestInteract.visible = false
					$Chest2/NeedKey.visible = true
		


func _on_chest_2_body_entered(body: Node2D) -> void:
	if $Chest2/ChestSpriteOpen.visible == false:
		$Chest2/ChestInteract.visible = true
		chest2Interactable = true


func _on_chest_2_body_exited(body: Node2D) -> void:
	chest2Interactable = false
	$Chest2/ChestInteract.visible = false
	$Chest2/NeedKey.visible = false


func _on_hit_tutorial_body_entered(body: Node2D) -> void:
	$HitTutorial/HitTutLab.visible = true


func _on_hit_tutorial_body_exited(body: Node2D) -> void:
	$HitTutorial.queue_free()
