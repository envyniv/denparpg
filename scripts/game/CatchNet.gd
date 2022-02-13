extends KinematicBody

var netSpd=15
var tar = null
var point = null

signal catched

func catch(target):
  tar=target
  point = target.global_transform.origin

func _process(_delta):
  if point:
    var direction

    if point.distance_to(transform.origin) > 0.05:
      direction = point - transform.origin
      direction = direction.normalized() * netSpd
    else:
      direction = point - transform.origin
      emit_signal("catched", tar)
    #warning-ignore:return_value_discarded
    move_and_slide(direction)
