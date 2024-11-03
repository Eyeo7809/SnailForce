extends CharacterBody2D

@onready var sprite : AnimatedSprite2D = $ProtagSprite
@export var key : bool = false
@export var keyValue : int = 0
@onready var jump : bool = false
@export var gems = 0
@onready var run : bool = false
@onready var attack : bool = false

signal hit
var facing = 1

var SPEED = G.speed
const JUMP_VELOCITY = -450.0
var direction : Vector2 = Vector2.ZERO

func getSpeed():
	return self.SPEED

func _ready():
	sprite.play("Idle")

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
	if sprite.animation != "AttackUp" and sprite.animation != "AttackDown":
		move_and_slide()

#Handles all animation switches
func updateAnimation():
	
	if velocity.length() == 0 and sprite.animation != "AttackUp" and sprite.animation != "AttackDown":
		run = false
		sprite.play("Idle")
	
	elif velocity.x != 0 && self.is_on_floor():
		sprite.play("Run")
		run = true
	
	if Input.is_action_just_pressed("jump") && self.is_on_floor():
		run = false
		sprite.play("FullJump")
		$Jump.play()
	
	if Input.is_action_just_pressed("Attack") and run == false:
		$AtkBox.process_mode = PROCESS_MODE_INHERIT
		var int = randi_range(1, 2)
		if int == 1:
			sprite.play("AttackDown")
			$Sword2.play()
		if int == 2:
			sprite.play("AttackUp")
			$Sword2.play()

	updateFacingDirection()

#Handles facing direction
func updateFacingDirection():
	
	
	if direction.x < 0 and facing == 1:
		self.scale.x *= -1
		facing = -1
	
	if direction.x > 0 and facing == -1:
		self.scale.x *= -1
		facing = 1
	


func updateScore():
	var pathToScore = str(self.get_parent().get_path()) + "/HUD/Control/KeyCounter"
	get_node(pathToScore).text = str(keyValue)


func _on_footsteps_timer_timeout() -> void:
	if run == true:
		$Footsteps.play()
	elif run == false:
		$Footsteps.stop()


func _on_protag_sprite_animation_finished() -> void:
	$AtkBox.process_mode = PROCESS_MODE_DISABLED
	sprite.play("Idle")


func _on_atk_box_body_entered(body: Node2D) -> void:
	print("HIT")
	if body.is_in_group("Mobs"):
		print("HIT")
		body.health -= 1
		var pathToSprite = str(body.get_path()) + "/BeeSprite"
		get_node(pathToSprite).play("Hit")
		print(str(body.health))
		body.velocity = Vector2(3000 * facing, 0)
		move_and_slide()
		body.queue_free()


func _on_key_body_entered(body: Node2D) -> void:
	print("Entered")
	key = true
	keyValue += 1
	updateScore()
	var pathToKey = str(self.get_parent().get_path()) + "/Key"
	get_node(pathToKey).queue_free()


func _on_key_2_body_entered(body: Node2D) -> void:
	print("Entered")
	key = true
	keyValue += 1
	updateScore()
	var pathToKey = str(self.get_parent().get_path()) + "/Key2"
	get_node(pathToKey).queue_free()
	pass # Replace with function body.
