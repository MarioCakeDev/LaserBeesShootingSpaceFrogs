extends KinematicBody2D

var velocity: Vector2 = Vector2()
export var speed: float = 500

var createShot = load("res://Shot.tscn")

var actionsPressed = []
var shootTimer = 0.2

var startScale = 0

func _ready():
	startScale = $BeeBody.scale.x

func _physics_process(delta):
	shootTimer -= delta
			
	move_and_slide(velocity)
	
func onReleased_left():
	velocity.x = 0
	
func onReleased_right():
	velocity.x = 0
	
func onReleased_up():
	velocity.y = 0
	
func onReleased_down():
	velocity.y = 0	

func on_left():
	velocity.x = -speed
	$BeeBody.scale.x = -startScale
	
func on_right():
	velocity.x = speed
	$BeeBody.scale.x = startScale
	
func on_up():
	velocity.y = -speed
	
func on_down():
	velocity.y = speed

func shoot(shootPosition: Vector2):
	if shootTimer > 0:
		return
	shootTimer = 0.2
	
	var offset = $BeeBody/ShotStart.position
	if shootPosition.x > position.x:
		$BeeBody.scale.x = startScale
	else:
		$BeeBody.scale.x = -startScale
		offset.x *= -1;
		
		
	var shootDirection: Vector2 = shootPosition - (offset + position)
	shootDirection = shootDirection.normalized()	
		
	var shot: Shot = createShot.instance()
	
	shot.rotation = shootDirection.angle()
	shot.position = offset + position
	
	$"..".add_child(shot)
	shot.fly()
	
	
func _input(event):	
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
	   shoot(event.position)
	
	if event is InputEventKey:
		actOnPressed(event, "left")
		actOnPressed(event, "right")
		actOnPressed(event, "up")
		actOnPressed(event, "down")
		
		actOnReleased(event, "left", "right")
		actOnReleased(event, "right", "left")
		actOnReleased(event, "up", "down")
		actOnReleased(event, "down", "up")
		
func actOnPressed(event, action: String):
	if event.is_action_pressed(action):
		if not actionsPressed.has(action):
			actionsPressed.push_back(action)
		call("on_" + action)

func actOnReleased(event, actionReleased: String, actionDown: String):
	if event.is_action_released(actionReleased):
		if actionsPressed.has(actionReleased):
			var pos = actionsPressed.find(actionReleased)
			actionsPressed.remove(pos)
		if actionsPressed.has(actionDown):
			call("on_" + actionDown)
		else:
			call("onReleased_" + actionReleased)
		
