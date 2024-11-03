extends Node2D
@onready var chestInteractable: bool = false
@onready var gemCollected : bool = false
@onready var npcInteractable : bool = false

func _ready() -> void:
	G.lvl1 = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fall_check_body_entered(body: Node2D) -> void:
	if $Protag.gems == 1:
		get_tree().change_scene_to_file("res://lv_2.tscn")
	else:
		$HUD/HiddenLabels/ControllerPlayer.play("onDeath")




func _on_repeat_lv_pressed() -> void:
	get_tree().change_scene_to_file("res://platformer_lv_1.tscn")
	$HUD/HiddenLabels.visible = false



func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
	$HUD/HiddenLabels.visible = false


func _on_chest_body_entered(body: Node2D) -> void:
	if gemCollected == false:
		$Chest/ChestInteract.visible = true
		chestInteractable = true


func _on_chest_body_exited(body: Node2D) -> void:
	chestInteractable = false
	$Chest/ChestInteract.visible = false
	$Chest/NeedKey.visible = false
	


	
func _input(event: InputEvent) -> void:
	
	if npcInteractable == true:
		if event is InputEventKey:
			if event.pressed and event.keycode == KEY_E:
				$NPC/CharacterInteract.visible = false
				$NPC/Lore.visible = true
	
	if chestInteractable == true:
		if event is InputEventKey:
			if event.pressed and event.keycode == KEY_E:
				if $Protag.keyValue >= 1:
					$Chest/ChestSpriteOpen.visible = true
					$Chest/ChestSpriteClosed.visible = false
					$Protag.keyValue -= 1
					get_node("/root/PlatformerLv1/HUD/Control/KeyCounter").text = str($Protag.keyValue)
					$Chest/Gem/GemAnimation.play("gemAnimation")
					$Chest/ChestInteract.visible = false
					$Chest/NeedKey.visible = false
					$Protag.gems += 1
					gemCollected = true
				elif $Protag.keyValue <= 0 and npcInteractable == false:
					$Chest/ChestInteract.visible = false
					$Chest/NeedKey.visible = true


	


func _on_npc_body_entered(body: Node2D) -> void:
	$NPC/CharacterInteract.visible = true
	npcInteractable = true


func _on_npc_body_exited(body: Node2D) -> void:
	$NPC/CharacterInteract.visible = false
	$NPC/Lore.visible = false
	npcInteractable = false
