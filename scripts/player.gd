extends CharacterBody2D

var rocket_scene = preload("res://scenes/rocket.tscn")
var rocket_container

var speed = 300
var left = false
var up = false
var right = false
var down = false

func _ready():
	rocket_container = get_node("RocketContainer")

func check_keys():
	left = Input.is_action_pressed("left")
	right = Input.is_action_pressed("right")
	up = Input.is_action_pressed("up")
	down = Input.is_action_pressed("down")

func move_player():
	velocity *= .95
	if right:
		velocity.x = speed
	elif left:
		velocity.x = -speed
	if up:
		velocity.y = -speed
	elif down:
		velocity.y = speed
		
	if (right or left) and (up or down):
		velocity *= 0.75
	move_and_slide()
	
func clamp_pos():
	var size = get_viewport_rect().size	
	global_position = global_position.clamp(Vector2.ZERO, size)

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta):
	check_keys()
	move_player()
	clamp_pos()
	
func shoot():
	var rocket_instance = rocket_scene.instantiate()
	add_child(rocket_instance)
	rocket_instance.global_position.x += 80
	
