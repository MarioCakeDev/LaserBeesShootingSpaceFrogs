extends Node2D
class_name Shot

export var speed = 1000

var destroyed = false

var velocity: Vector2 = Vector2()

func _physics_process(delta):
	position += velocity * delta

func fly():
	velocity = Vector2(cos(rotation), sin(rotation)) * speed
	yield(get_tree().create_timer(2), "timeout")
	destroy()

func destroy():
	if not destroyed:
		queue_free()
