extends CharacterBody2D
@export var health = 1
@onready var protagPath = str(self.get_parent().get_path()) + "/Protag"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	


func _on_protag_hit() -> void:
	$BeeSprite.play("Hit")
	print(str(health))
	velocity = Vector2(3000 * get_node(protagPath).facing, 0)
	move_and_slide()


func _on_bee_sprite_animation_finished() -> void:
	if health <= 0:
		queue_free()
	else:
		$BeeSprite.play("Fly")
