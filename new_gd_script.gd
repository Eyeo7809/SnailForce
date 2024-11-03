extends CharacterBody2D

@onready var sprite : AnimatedSprite2D = $ProtagSprite
@export var key : bool = false
@export var keyValue : int = 0
@onready var jump : bool = false
@export var gems = 0

const SPEED = 300.0
const JUMP_VELOCITY = -450.0
var direction : Vector2 = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "jump", "down")
	if direction.x != 0:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	updateAnimation()
	move_and_slide()

#Handles all animation switches
func updateAnimation():
	if velocity.length() == 0:
		sprite.play("Idle")
	
	elif velocity.x != 0 && self.is_on_floor():
		sprite.play("Run")
	
	if Input.is_action_just_pressed("jump") && self.is_on_floor():
		sprite.play("FullJump")
	
	updateFacingDirection()

#Handles facing direction
func updateFacingDirection():
	if direction.x > 0:
		sprite.flip_h = false
	if direction.x < 0:
		sprite.flip_h = true


func _on_key_area_entered(area: Area2D) -> void:
	key = true
	keyValue += 1
	updateScore()
	get_node("/root/PlatformerLv1/Key").queue_free()

func updateScore():
	get_node("/root/PlatformerLv1/HUD/Control/KeyCounter").text = str(keyValue)
	
