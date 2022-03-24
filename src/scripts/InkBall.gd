extends KinematicBody


var point = Vector3.ZERO
var color : int

onready var spr = $Sprite3D
onready var colshp = $CollisionShape
onready var particles = $Particles
var ballSpd = 5

signal hit

func _ready() -> void:
  spr.modulate=SceneMan.colors[color]
  return

func _process(_delta) -> void:
  
  var direction

  if point is Vector3:
    if point.distance_to(transform.origin) > 1:
      direction = point - transform.origin
      direction = direction.normalized() * ballSpd
    else:
      direction = point - transform.origin
      emit_signal("hit", self)
      burst(false)
      #warning-ignore:return_value_discarded
    move_and_slide(direction)
  return

func burst(p=true) -> void:
  #make particles
  point=null
  colshp.disabled=true
  spr.hide()
  if p:
    particles.draw_pass_1.material.albedo_color = spr.modulate+Color(0.3, 0.3, 0.3)
    particles.emitting=true
    yield(get_tree().create_timer(3), "timeout")

  queue_free()
  return
