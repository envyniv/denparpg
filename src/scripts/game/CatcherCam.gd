extends Spatial

var catchnet = load("res://scenes/CatchNet.tscn")

var mouse_sens    = 0.3
var camera_anglev = 0

onready var cam = $Camera
onready var aimcast = $Camera/RayCast

var target = null

signal available
signal not_available

func _ready() -> void:
  Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
  return

func _input(event) -> void:
  if event is InputEventMouseMotion:
    rotate_y(deg2rad(-event.relative.x * mouse_sens))
    cam.rotate_x(deg2rad(-event.relative.y * mouse_sens))
    cam.rotation.x = clamp(cam.rotation.x, deg2rad(-50), deg2rad(50))
  return

func _process(delta) -> void:
  #realign to pitch 0
  cam.rotation.x += 0 - cam.rotation.x*delta/2
  
  if aimcast.is_colliding():
    #var bullet = get_world().direct_space_state
    target = aimcast.get_collider()
    if target.is_in_group("denpa"):
      emit_signal("available", target)
    else:
      emit_signal("available")

    if Input.is_action_just_pressed("fire"):
      var net = catchnet.instance()
      get_parent().add_child(net)
      
      if target:
        target.colshp.disabled=true
        net.connect("catched", self, "on_net_feedback")
        net.catch(target)
      else:
        net.catch( cam.project_position(
          Vector2(OS.get_window_size().x/2,
          OS.get_window_size().y/2
          ), 30 ) )

  else:
    target = null
    emit_signal("not_available")
  return

func on_net_feedback(t, net) -> void:
  net.disconnect("catched", self, "on_net_feedback")
  if t.is_in_group("denpa"):
    SceneMan.add_caught(t)
    t.nuclearize()
    if SceneMan.data.caught.size() == 8:
      SceneMan.change_scene("catch")
  else:
    t.burst()
  return
