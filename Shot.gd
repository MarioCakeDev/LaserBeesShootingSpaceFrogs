extends KinematicBody2D
class_name Shot

export var speed = 1000

var destroyed = false

var velocity: Vector2 = Vector2()

func _physics_process(delta):
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if not collision:
		return
	if collision.collider.has_method("onShot"):
		collision.collider.onShot()
	
	destroy()

func fly():
	velocity = Vector2(cos(rotation), sin(rotation)) * speed
	yield(get_tree().create_timer(2), "timeout")
	destroy()

func destroy():
	if not destroyed:
		queue_free()
