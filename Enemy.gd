extends KinematicBody2D
class_name Enemy

var rotationSpeed = 2
var rotationSpeed = 2
var rotationSpeed = 2

func _ready():
	rotationSpeed = rand_range(1, 4)
	+ = rand_range()

func onShot():
	queue_free()
	
func _physics_process(delta):
	rotate(rotationSpeed * delta)
