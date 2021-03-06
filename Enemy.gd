extends KinematicBody2D
class_name Enemy

var rotationSpeed = 2
var velocity: Vector2 = Vector2.DOWN * 100

func onShot():
	$Death.play()
	position.x = -10000
	yield(get_tree().create_timer($Death.stream.get_length()), "timeout")
	queue_free()
	
func _physics_process(delta):
	rotate(rotationSpeed * delta)
	move_and_slide(velocity)
