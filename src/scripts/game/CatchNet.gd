extends KinematicBody

var netSpd=15
var tar = null
var point = null

onready var throwsound=$AudioStreamPlayer

onready var spr = $Sprite3D

signal catched

func catch(target) -> void:
  tar=target
  point = target.global_transform.origin
  return

func _ready() -> void:
  spr.rotation_degrees.z=randi() % 361 # random rotation on spawn
  #warning-ignore:return_value_discarded
  connect("catched", self, "on_arrival")
  return

func _process(_delta) -> void:
  if transform.origin!=Vector3.ZERO:
    look_at(Vector3.ZERO, Vector3.UP)
    # look at camera when far away enough so godo-bitch doesn't complain
  if spr:
    spr.rotation_degrees.z-=1
  if point:
    var direction

    if point.distance_to(transform.origin) > 1:
      direction = point - transform.origin
      direction = direction.normalized() * netSpd
    else:
      direction = point - transform.origin
      emit_signal("catched", tar, self)
    #warning-ignore:return_value_discarded
    move_and_slide(direction)
  return

func on_arrival(_throwAway, _theseArgs) -> void:
  if !throwsound.is_playing():
    queue_free()
  else:
    yield(throwsound, "finished")
    queue_free()
  return
