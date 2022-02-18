extends KinematicBody


onready var spr = $Sprite3D
onready var colshp = $CollisionShape
var ballSpd = 5

signal hit

func _process(_delta) -> void:
  var point = Vector3.ZERO
  var direction

  if point.distance_to(transform.origin) > 1:
    direction = Vector3.ZERO - transform.origin
    direction = direction.normalized() * ballSpd
  else:
    direction = Vector3.ZERO - transform.origin
    emit_signal("hit", self)
    burst()
    #warning-ignore:return_value_discarded
  move_and_slide(direction)
  return

func burst() -> void:
  #make particles
  queue_free()
  return
