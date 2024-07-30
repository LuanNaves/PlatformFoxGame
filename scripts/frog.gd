extends CharacterBody2D

const SPEED = 50.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var player = $"../../Player/Player"
var chase = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animated_sprite.play("idle")
	
func _physics_process(delta):
	# Add the gravity to the frog.
	if not is_on_floor():
		velocity.y += gravity * delta
	if chase == true:
		if animated_sprite.animation != "death":
			animated_sprite.play("jump")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
		velocity.x = direction.x * SPEED
	else:
		if animated_sprite.animation != "death":
			animated_sprite.play("idle")
			velocity.x = 0
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "Player":	
		chase = false

func _on_player_death_body_entered(body):
	if body.name == "Player":
		death()

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		body.health -= 1
		death()
		
func death():
	chase = false
	animated_sprite.play("death") 
	await animated_sprite.animation_finished
	self.queue_free()
