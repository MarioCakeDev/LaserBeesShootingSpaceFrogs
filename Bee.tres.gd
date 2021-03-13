extends Node2D

var velocity: Vector2 = Vector2()
export var speed: float = 500

var actionsPressed = []

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	position += velocity * delta
	
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
	
func on_right():
	velocity.x = speed
	
func on_up():
	velocity.y = -speed
	
func on_down():
	velocity.y = speed	

func _input(event):
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
		
